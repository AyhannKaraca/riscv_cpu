module hazard_unit
import riscv_pkg::*;
(
  input  logic  [4:0]   rs1E_addr_i,
  input  logic  [4:0]   rs2E_addr_i,
  input  logic  [4:0]   rdM_addr_i,
  input  logic  [4:0]   rdW_addr_i,
  input  logic          rdM_wr_ena_i,
  input  logic          rdW_wr_ena_i,
  output logic  [1:0]   forwardAE_o,
  output logic  [1:0]   forwardBE_o,
  
  input  logic  [4:0]   rs1D_addr_i,
  input  logic  [4:0]   rs2D_addr_i,
  input  logic  [4:0]   rdE_addr_i,
  input  alu_ctrl_e     opE_i,
  output logic          stallFD_o,
  output logic          flushE_o,
  
  input  logic          wrong_branch_i,//wrong_branch
  output logic          flushD_o
);

logic lw_stall;
assign lw_stall = (opE_i inside {LB,LH,LW,LBU,LHU}) & ((rs1D_addr_i == rdE_addr_i) | (rs2D_addr_i == rdE_addr_i));
assign stallFD_o = lw_stall;
assign flushD_o = wrong_branch_i;
assign flushE_o = lw_stall | wrong_branch_i;

always_comb begin
  if(((rs1E_addr_i == rdM_addr_i) & rdM_wr_ena_i) & rs1E_addr_i != 0) begin
    forwardAE_o = 2'b10; // Forward from Memory stage
  end else if(((rs1E_addr_i == rdW_addr_i) & rdW_wr_ena_i) & rs1E_addr_i != 0) begin
    forwardAE_o = 2'b01; // Forward from Writeback stage
  end else begin
    forwardAE_o = 2'b00; // No forwarding
  end
end

always_comb begin
  if(((rs2E_addr_i == rdM_addr_i) & rdM_wr_ena_i) & rs2E_addr_i != 0) begin
    forwardBE_o = 2'b10; // Forward from Memory stage
  end else if(((rs2E_addr_i == rdW_addr_i) & rdW_wr_ena_i) & rs2E_addr_i != 0) begin
    forwardBE_o = 2'b01; // Forward from Writeback stage
  end else begin
    forwardBE_o = 2'b00; // No forwarding
  end
end

endmodule
