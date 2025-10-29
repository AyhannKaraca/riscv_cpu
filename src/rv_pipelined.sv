module rv_pipelined
import riscv_pkg::*;
#(
  parameter IMemInitFile  = "imem.mem",
  parameter DMemInitFile  = "dmem.mem" 
)(
  input  logic             clk_i,       // system clock
  input  logic             rstn_i,      // system reset
  input  logic  [XLEN-1:0] addr_i,      
  output logic  [XLEN-1:0] data_o,     
  output logic             update_o,    // retire signal
  output logic  [XLEN-1:0] pc_o,        // retired program counter
  output logic  [XLEN-1:0] instr_o,     // retired instruction
  output logic  [     4:0] reg_addr_o,  // retired register address
  output logic  [XLEN-1:0] reg_data_o,  // retired register data
  output logic  [XLEN-1:0] mem_addr_o,  // retired memory address
  output logic  [XLEN-1:0] mem_data_o,  // retired memory data
  output logic             mem_wrt_o,   // retired memory write enable signal
  output logic             mem_read_o   // retired memory readed signal
);

//F-D
logic  [XLEN-1:0] true_pc;
logic             btb_update;
logic  [XLEN-1:0] pcF_D;
logic  [XLEN-1:0] instrF_D;

//D-E
logic  [XLEN-1:0] rdWB_data;   
logic  [4:0     ] rdWB_addr;   
logic             rdWB_wr_ena;
logic  [XLEN-1:0] pcD_E;
logic  [XLEN-1:0] instrD_E;
alu_ctrl_e        operationD_E;
logic  [XLEN-1:0] rs1D_E_data;
logic  [XLEN-1:0] rs2D_E_data;
logic  [     4:0] rdD_E_addr;
logic             rdD_E_wr_ena;
logic             memD_E_wr_ena;
logic  [     4:0] shamtD_E_data;
logic  [XLEN-1:0] immD_E;
logic  [     4:0] rs1D_E_addr;
logic  [     4:0] rs2D_E_addr;

//E-M
logic  [XLEN-1:0] pcE_M;
logic  [XLEN-1:0] instrE_M;
alu_ctrl_e        operationE_M;
logic  [XLEN-1:0] rdE_M_data;
logic  [     4:0] rdE_M_addr;
logic             rdE_M_wr_ena;
logic             memE_M_wr_ena;
logic  [XLEN-1:0] memE_M_addr;
logic  [XLEN-1:0] memE_M_wr_data;

//E-H
logic  [     4:0] rs1E_H_addr;
logic  [     4:0] rs2E_H_addr;
logic  [     1:0] forwardA;
logic  [     1:0] forwardB;

//STALL-FLUSH SIGNALS
logic             stallFD; 
logic             flushE; 
logic             flushD; 

//TB UPDATE
logic             updateFD; 
logic             updateDE; 
logic             updateEM;

logic             isCompressed;

logic             hitF;
logic  [XLEN-1:0] pc_q;
logic  [XLEN-1:0] target_addr;

logic             bTakenF;
logic             bTakenD;

logic             wrong_branch;
logic  [XLEN-1:0] btb_target;

assign reg_addr_o = rdWB_addr;
assign reg_data_o = rdWB_data;


logic [31:0] AWADDR;
logic        AWVALID;
logic        AWREADY;
logic [31:0] WDATA;
logic [3:0]  WSTRB;
logic        WVALID;
logic        WREADY;
logic [1:0]  BRESP;
logic        BVALID;
logic        BREADY;
logic [31:0] ARADDR;
logic        ARVALID;
logic        ARREADY;
logic [31:0] RDATA;
logic [1:0]  RRESP;
logic        RVALID;
logic        RREADY;

logic        mem_done;
logic        stallE;
logic        stallM;
logic        start_wrt;
logic        start_read;

logic [31:0] wrt_data;
logic [31:0] wrt_addr;

logic stallWB;

fetch #(
  .IMemInitFile(IMemInitFile)
)i_fetch(
  .tb_update_o  (updateFD),
  .clk_i        (clk_i),
  .rstn_i       (rstn_i),
  .hitF_i       (hitF),
  .bTaken_o     (bTakenF),
  .stallFD_i    (stallFD),
  .flushD_i     (flushD),
  .true_pc_i    (true_pc),
  .target_addr_i(target_addr),
  .pcF_o        (pcF_D),
  .instrF_o     (instrF_D),
  .pcq_o        (pc_q)
);

decode i_decode(
  .clk_i          (clk_i),
  .rstn_i         (rstn_i),
  .tb_update_i    (updateFD),
  .tb_update_o    (updateDE),
  .pcD_i          (pcF_D),
  .instrD_i       (instrF_D),
  .rs1D_addr_o    (rs1D_E_addr),
  .rs2D_addr_o    (rs2D_E_addr),
  .rdD_data_i     (rdWB_data),     
  .rdD_addr_i     (rdWB_addr),     
  .rdD_wr_ena_i   (rdWB_wr_ena),  
  .flushE_i       (flushE),
  .pcD_o          (pcD_E),
  .instrD_o       (instrD_E),
  .operationD_o   (operationD_E),
  .rs1D_data_o    (rs1D_E_data),
  .rs2D_data_o    (rs2D_E_data),
  .rdD_addr_o     (rdD_E_addr),
  .rdD_wr_ena_o   (rdD_E_wr_ena),
  .memD_wr_ena_o  (memD_E_wr_ena),
  .shamtD_data_o  (shamtD_E_data),
  .immD_o         (immD_E),
  .isCompressed_o (isCompressed),
  .bTakenD_i      (bTakenF),
  .bTakenD_o      (bTakenD),
  .stallE_i       (stallE)
);

execute i_execute(
  .clk_i          (clk_i),
  .rstn_i         (rstn_i),
  .tb_update_i    (updateDE),
  .tb_update_o    (updateEM),
  .isCompressed_i (isCompressed),
  .pcE_i          (pcD_E),
  .instrE_i       (instrD_E),
  .forwardAE_i    (forwardA),
  .forwardBE_i    (forwardB),
  .rs1E_addr_i    (rs1D_E_addr),
  .rs2E_addr_i    (rs2D_E_addr),
  .rs1E_addr_o    (rs1E_H_addr),
  .rs2E_addr_o    (rs2E_H_addr),
  .forwM_data_i   (rdE_M_data),
  .forwW_data_i   (rdWB_data),
  .operationE_i   (operationD_E),
  .rs1E_data_i    (rs1D_E_data),
  .rs2E_data_i    (rs2D_E_data),
  .rdE_addr_i     (rdD_E_addr),
  .rdE_wrt_ena_i  (rdD_E_wr_ena),
  .memE_wrt_ena_i (memD_E_wr_ena),
  .shamt_dataE_i  (shamtD_E_data),
  .immE_i         (immD_E),
  .pcE_o          (pcE_M),
  .instrE_o       (instrE_M),
  .operationE_o   (operationE_M),
  .rdE_data_o     (rdE_M_data),
  .rdE_addr_o     (rdE_M_addr),
  .rdE_wr_ena_o   (rdE_M_wr_ena),
  //.memE_wr_ena_o  (memE_M_wr_ena),
  .memE_addr_o    (memE_M_addr),
  .memE_wr_data_o (memE_M_wr_data),
  .btb_update_o   (btb_update),
  .btb_target_o   (btb_target),
  .bTakenE_i      (bTakenD),
  .wrong_branch_o (wrong_branch),
  .pcE_target_o   (true_pc),
  .stallM_i       (stallM),
  .start_wrt_o    (start_wrt),
  .start_read_o   (start_read),
  .M_RDATA        (RDATA),
  .M_WSTRB        (WSTRB),      
  .addr_o         (wrt_addr),       
  .wrt_data_o     (wrt_data)    
);

memory i_memory(
  .tb_addr_i      (addr_i),
  .tb_data_o      (data_o),
  .tb_mem_wrt_o   (mem_wrt_o),
  .tb_mem_read_o  (mem_read_o),
  .tb_update_i    (updateEM),
  .tb_update_o    (update_o),
  .clk_i          (clk_i),
  .rstn_i         (rstn_i),
  .pcM_i          (pcE_M),
  .instrM_i       (instrE_M),
  .operationM_i   (operationE_M),
  .rdM_data_i     (rdE_M_data),
  .rdM_addr_i     (rdE_M_addr),
  .rdM_wr_ena_i   (rdE_M_wr_ena),
  //.memM_wrt_ena_i (memE_M_wr_ena),
  .memM_addr_i    (memE_M_addr),
  .memM_wrt_data_i(memE_M_wr_data),
  .pcM_o          (pc_o),
  .instrM_o       (instr_o),
  .memM_addr_o    (mem_addr_o),
  .memM_data_o    (mem_data_o),
  .rdM_data_o     (rdWB_data  ),
  .rdM_addr_o     (rdWB_addr  ),
  .rdM_wr_ena_o   (rdWB_wr_ena),
  .stallWB_i(stallWB)  
);

hazard_unit i_hazard_unit(
  .rs1E_addr_i    (rs1E_H_addr),
  .rs2E_addr_i    (rs2E_H_addr),
  .rdM_addr_i     (rdE_M_addr),
  .rdW_addr_i     (rdWB_addr),
  .rdM_wr_ena_i   (rdE_M_wr_ena),
  .rdW_wr_ena_i   (rdWB_wr_ena),
  .forwardAE_o    (forwardA),
  .forwardBE_o    (forwardB),
  .rs1D_addr_i    (instrF_D[19:15]),
  .rs2D_addr_i    (instrF_D[24:20]),
  .rdE_addr_i     (rdD_E_addr),
  .opE_i          (operationD_E),
  .stallFD_o      (stallFD),
  .flushE_o       (flushE),
  .wrong_branch_i (wrong_branch),
  .flushD_o        (flushD),
  .mem_done_i      (mem_done),
  .stallE_o        (stallE),
  .stallM_o        (stallM),
  .stallWB_o       (stallWB)
);

branchPredictor#(
  .B_PRED_ACTIVE(1)
) i_branchPredictor(
  .clk_i         (clk_i),
  .rstn_i        (rstn_i),
  .fetchPc_i     (pc_q),
  .fetchHit_o    (hitF),
  .fetchTarget_o (target_addr),
  .exTaken_i     (btb_update),
  .exPc_i        (pcD_E),
  .exTarget_i    (btb_target)  
);

axi4_lite_master i_axi4_lite_master(
  .ACLK       (clk_i),
  .ARESETN    (rstn_i),
  .START_READ (start_read),
  .START_WRITE(start_wrt),
  .address    (wrt_addr),
  .W_data     (wrt_data),
  .M_ARREADY  (ARREADY),
  .M_RRESP    (RRESP),
  .M_RVALID   (RVALID),
  .M_AWREADY  (AWREADY),
  .M_WREADY   (WREADY),
  .M_BRESP    (BRESP),
  .M_BVALID   (BVALID),
  .M_ARADDR   (ARADDR),
  .M_ARVALID  (ARVALID),
  .M_RREADY   (RREADY),
  .M_AWADDR   (AWADDR),
  .M_AWVALID  (AWVALID),
  .M_WDATA    (WDATA),
  .M_WVALID   (WVALID),
  .M_BREADY   (BREADY),
  .mem_done_o (mem_done)
);

axi4lite_slave_mem i_axi4lite_slave_mem(
  .ACLK     (clk_i),
  .ARESETN  (rstn_i),
  .S_ARADDR (ARADDR),
  .S_ARVALID(ARVALID),
  .S_RREADY (RREADY),
  .S_AWADDR (AWADDR),
  .S_AWVALID(AWVALID),
  .S_WDATA  (WDATA),
  .S_WSTRB  (WSTRB),
  .S_WVALID (WVALID),
  .S_BREADY (BREADY),	
  .S_ARREADY(ARREADY),
  .S_RDATA  (RDATA),
  .S_RRESP  (RRESP),
  .S_RVALID (RVALID),
  .S_AWREADY(AWREADY),
  .S_WREADY (WREADY),
  .S_BRESP  (BRESP),
  .S_BVALID (BVALID)
);


endmodule
