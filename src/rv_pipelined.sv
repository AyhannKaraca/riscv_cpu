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
logic  [XLEN-1:0] next_pc;
logic             next_pc_enable;
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


assign reg_addr_o = rdWB_addr;
assign reg_data_o = rdWB_data;

fetch #(
  .IMemInitFile(IMemInitFile)
)i_fetch(
  .tb_update_o(updateFD),
  .clk_i(clk_i),
  .rstn_i(rstn_i),
  .stallFD_i(stallFD),
  .flushD_i(flushD),
  .next_pc_i(next_pc),
  .next_pc_enable_i(next_pc_enable),
  .pcF_o(pcF_D),
  .instrF_o(instrF_D)
);

decode i_decode(
  .clk_i(clk_i),
  .rstn_i(rstn_i),
  .tb_update_i(updateFD),
  .tb_update_o(updateDE),
  .pcD_i(pcF_D),
  .instrD_i(instrF_D),
  .rs1D_addr_o(rs1D_E_addr),
  .rs2D_addr_o(rs2D_E_addr),
  .rdD_data_i(rdWB_data),     
  .rdD_addr_i(rdWB_addr),     
  .rdD_wr_ena_i(rdWB_wr_ena),  
  .flushE_i(flushE),
  .pcD_o(pcD_E),
  .instrD_o(instrD_E),
  .operationD_o(operationD_E),
  .rs1D_data_o(rs1D_E_data),
  .rs2D_data_o(rs2D_E_data),
  .rdD_addr_o(rdD_E_addr),
  .rdD_wr_ena_o(rdD_E_wr_ena),
  .memD_wr_ena_o(memD_E_wr_ena),
  .shamtD_data_o(shamtD_E_data),
  .immD_o(immD_E)  
);

execute i_execute(
  .clk_i(clk_i),
  .rstn_i(rstn_i),
  .tb_update_i(updateDE),
  .tb_update_o(updateEM),
  .pcE_i(pcD_E),
  .instrE_i(instrD_E),
  .forwardAE_i(forwardA),
  .forwardBE_i(forwardB),
  .rs1E_addr_i(rs1D_E_addr),
  .rs2E_addr_i(rs2D_E_addr),
  .rs1E_addr_o(rs1E_H_addr),
  .rs2E_addr_o(rs2E_H_addr),
  .forwM_data_i(rdE_M_data),
  .forwW_data_i(rdWB_data),
  .operationE_i(operationD_E),
  .rs1E_data_i(rs1D_E_data),
  .rs2E_data_i(rs2D_E_data),
  .rdE_addr_i(rdD_E_addr),
  .rdE_wrt_ena_i(rdD_E_wr_ena),
  .memE_wrt_ena_i(memD_E_wr_ena),
  .shamt_dataE_i(shamtD_E_data),
  .immE_i(immD_E),
  .pcE_o(pcE_M),
  .instrE_o(instrE_M),
  .operationE_o(operationE_M),
  .rdE_data_o     (rdE_M_data),
  .rdE_addr_o     (rdE_M_addr),
  .rdE_wr_ena_o   (rdE_M_wr_ena),
  .memE_wr_ena_o  (memE_M_wr_ena),
  .memE_addr_o    (memE_M_addr),
  .memE_wr_data_o (memE_M_wr_data),
  .next_pc_ena_o(next_pc_enable),
  .next_pc_o(next_pc)
);

memory #(
  .DMemInitFile(DMemInitFile)
)i_memory(
  .tb_addr_i(addr_i),
  .tb_data_o(data_o),
  .tb_mem_wrt_o(mem_wrt_o),
  .tb_mem_read_o(mem_read_o),
  .tb_update_i(updateEM),
  .tb_update_o(update_o),
  .clk_i(clk_i),
  .rstn_i(rstn_i),
  .pcM_i(pcE_M),
  .instrM_i(instrE_M),
  .operationM_i(operationE_M),
  .rdM_data_i     (rdE_M_data),
  .rdM_addr_i     (rdE_M_addr),
  .rdM_wr_ena_i   (rdE_M_wr_ena),
  .memM_wrt_ena_i (memE_M_wr_ena),
  .memM_addr_i    (memE_M_addr),
  .memM_wrt_data_i(memE_M_wr_data),
  .pcM_o          (pc_o),
  .instrM_o       (instr_o),
  .memM_addr_o    (mem_addr_o),
  .memM_data_o    (mem_data_o),
  .rdM_data_o     (rdWB_data  ),
  .rdM_addr_o     (rdWB_addr  ),
  .rdM_wr_ena_o   (rdWB_wr_ena)  
);

hazard_unit i_hazard_unit(
  .rs1E_addr_i(rs1E_H_addr),
  .rs2E_addr_i(rs2E_H_addr),
  .rdM_addr_i(rdE_M_addr),
  .rdW_addr_i(rdWB_addr),
  .rdM_wr_ena_i(rdE_M_wr_ena),
  .rdW_wr_ena_i(rdWB_wr_ena),
  .forwardAE_o(forwardA),
  .forwardBE_o(forwardB),
  .rs1D_addr_i(instrF_D[19:15]),
  .rs2D_addr_i(instrF_D[24:20]),
  .rdE_addr_i(rdD_E_addr),
  .opE_i(operationD_E),
  .stallFD_o(stallFD),
  .branch_taken_i(next_pc_enable),
  .flushE_o(flushE),
  .flushD_o(flushD)
);




endmodule