module core_model
  import riscv_pkg::*;
(
  input  logic clk_i,
  input  logic rstn_i,
  input  logic  [XLEN-1:0] addr_i,
  output logic  [XLEN-1:0] data_o,
  output logic  [XLEN-1:0] pc_o,
  output logic  [XLEN-1:0] instr_o,
  output logic  [     4:0] reg_addr_o,
  output logic  [XLEN-1:0] reg_data_o,
  output logic             stall_o
);

logic  [XLEN-1:0]    pc_FtoDec           ;          
logic  [XLEN-1:0]    instr_FtoDec        ;
logic                pc_en               ;  
logic                stall               ;//load-use hazard  
logic                stall_ExToMem       ;
logic                flush               ;//control hazard

logic  [XLEN-1:0]    pc_DecToEx          ;          
logic  [XLEN-1:0]    instr_pc_DecToEx    ;    
operation_e          operation_DecToEx   ;   
logic  [XLEN-1:0]    rs1_DecToEx         ;       
logic  [XLEN-1:0]    rs2_DecToEx         ;
logic  [     4:0]    rs1D_idx            ;
logic  [     4:0]    rs2D_idx            ;
logic  [     4:0]    rd_addr_DecToEx     ;     
logic                rd_wrt_ena_DecToEx  ;  
logic                mem_wr_ena_DecToEx  ;  
logic  [     4:0]    shamt_data_DecToEx  ;  
logic  [XLEN-1:0]    imm_DecToEx         ;         

logic  [XLEN-1:0]    pc_ExToMem          ;
logic  [XLEN-1:0]    instr_ExToMem       ;
operation_e          operation_ExToMem   ;
rd_port_t            rd_port_ExToMem     ;
logic                mem_wrt_ena_ExToMem ;
logic  [XLEN-1:0]    mem_wrt_addr_ExToMem;
logic  [XLEN-1:0]    mem_wrt_data_ExToMem;


rd_port_t         rd_port_memToWb;
logic  [XLEN-1:0] next_pc;
logic             next_pc_enable;

assign reg_addr_o = (rd_port_memToWb.valid) ? rd_port_memToWb.addr : '0;
assign reg_data_o = rd_port_memToWb.data;

//forwarding signals

forwarding_e forwardA;
forwarding_e forwardB;

logic  [XLEN-1:0] rs1_final;
logic  [XLEN-1:0] rs2_final;


fetch i_fetch(
  .clk_i            (clk_i         ),
  .rstn_i           (rstn_i        ),
  .next_pc_i        (next_pc       ),
  .pc_en_i          (pc_en         ),
  .next_pc_enable_i (next_pc_enable),
  .pcF_o            (pc_FtoDec     ),
  .instrF_o         (instr_FtoDec  )
);

decode i_decode(
  .clk_i          (clk_i             ),
  .rstn_i         (rstn_i            ),
  .flush_i        (flush             ),
  .pcD_i          (pc_FtoDec         ),
  .instrD_i       (instr_FtoDec      ),
  .rdWB_port_i    (rd_port_memToWb   ),
  .pcD_o          (pc_DecToEx        ),
  .instrD_o       (instr_pc_DecToEx  ),
  .operationD_o   (operation_DecToEx ),
  .rs1D_o         (rs1_DecToEx       ),
  .rs2D_o         (rs2_DecToEx       ),
  .rs1D_idx_o     (rs1D_idx          ),
  .rs2D_idx_o     (rs2D_idx          ),   
  .rdD_addr_o     (rd_addr_DecToEx   ), 
  .rdD_wrt_ena_o  (rd_wrt_ena_DecToEx),
  .memD_wr_ena_o  (mem_wr_ena_DecToEx),
  .shamt_dataD_o  (shamt_data_DecToEx),
  .immD_o         (imm_DecToEx       )
);

execute i_execute(
  .clk_i           (clk_i               ),
  .rstn_i          (rstn_i              ),
  .flush_i         (flush               ),
  .stallE_i        (stall               ),
  .pcE_i           (pc_DecToEx          ),
  .immE_i          (imm_DecToEx         ),
  .instrE_i        (instr_pc_DecToEx    ),
  .rdE_addr_i      (rd_addr_DecToEx     ),
  .operationE_i    (operation_DecToEx   ),
  .rdE_wrt_ena_i   (rd_wrt_ena_DecToEx  ),
  .memE_wrt_ena_i  (mem_wr_ena_DecToEx  ),
  .shamt_dataE_i   (shamt_data_DecToEx  ),
  .rs1E_i          (rs1_final           ),
  .rs2E_i          (rs2_final           ),
  .rdE_port_o      (rd_port_ExToMem     ),
  .operationE_o    (operation_ExToMem   ),
  .memE_wrt_ena_o  (mem_wrt_ena_ExToMem ),
  .memE_wrt_addr_o (mem_wrt_addr_ExToMem),
  .memE_wrt_data_o (mem_wrt_data_ExToMem),
  .pcE_o           (pc_ExToMem          ),
  .instrE_o        (instr_ExToMem       ),
  .stallE_o        (stall_ExToMem       ),
  .next_pc_ena_o   (next_pc_enable      ),
  .next_pc_o       (next_pc             )
);

memory i_memory(
  .clk_i          (clk_i               ),
  .rstn_i         (rstn_i              ), 
  .stallM_i       (stall_ExToMem       ), 
  .pcM_i          (pc_ExToMem          ),
  .instrM_i       (instr_ExToMem       ),
  .operationM_i   (operation_ExToMem   ),
  .rdM_port_i     (rd_port_ExToMem     ),
  .memM_wrt_ena_i (mem_wrt_ena_ExToMem ),
  .memM_wrt_addr_i(mem_wrt_addr_ExToMem),
  .memM_wrt_data_i(mem_wrt_data_ExToMem),
  .addrM_i        (addr_i              ),
  .pcM_o          (pc_o                ),
  .instrM_o       (instr_o             ),
  .rdM_port_o     (rd_port_memToWb     ),
  .dataM_o        (data_o              ), //
  .stallM_o       (stall_o             )
);

hazard_unit i_hazard_unit(
  .rs1D_i       (rs1D_idx             ),
  .rs2D_i       (rs2D_idx             ),
  .rdE_i        (rd_port_ExToMem.addr ),
  .rdM_i        (rd_port_memToWb.addr ),
  .rs1_f_d_i    (instr_FtoDec[19:15]  ),
  .rs2_f_d_i    (instr_FtoDec[24:20]  ),
  .rd_d_e_i     (rd_addr_DecToEx      ),
  .opF_i        (instr_FtoDec[6:0]    ),
  .rdE_wr_ena_i (rd_port_ExToMem.valid),
  .rdM_wr_ena_i (rd_port_memToWb.valid),
  .branch_tkn_i (next_pc_enable       ),
  .opE_i        (operation_DecToEx    ),
  .pc_en_o      (pc_en                ),
  .stallH_o     (stall                ),
  .flush_o      (flush                ),
  .forwardA_o   (forwardA             ),
  .forwardB_o   (forwardB             )
);

always_comb begin :data_forwarding_rs1
  case(forwardA)
    NO_FRWD: rs1_final = rs1_DecToEx;
    EX_FRWD: rs1_final = rd_port_ExToMem.data;
    MEM_FRWD: rs1_final = rd_port_memToWb.data;
  default: rs1_final = rs1_DecToEx;
  endcase
end

always_comb begin :data_forwarding_rs2
  case(forwardB)
    NO_FRWD: rs2_final = rs2_DecToEx;
    EX_FRWD: rs2_final = rd_port_ExToMem.data;
    MEM_FRWD: rs2_final = rd_port_memToWb.data;
  default: rs2_final = rs2_DecToEx;
  endcase
end
endmodule
