module fetch
import riscv_pkg::*;
#(
  parameter IMemInitFile  = "imem.mem" 
)(
  //=====
  output logic             tb_update_o,
  //=====
  input  logic             clk_i,
  input  logic             rstn_i,
  input  logic             hitF_i,

  output logic             bTaken_o,
  input  logic             stallFD_i, //STALL(LW)
  input  logic             flushD_i,  //WRONG BRANCH

  input  logic  [XLEN-1:0] true_pc_i,

  input  logic  [XLEN-1:0] target_addr_i,//Branch pred addr
  output logic  [XLEN-1:0] pcF_o,
  output logic  [XLEN-1:0] instrF_o,
  output logic  [XLEN-1:0] pcq_o
);
  localparam int MEM_SIZE = 4096;
  logic [15:0] imem [MEM_SIZE*2-1:0];
  initial $readmemh(IMemInitFile, imem);

  logic [XLEN-1:0] pc_d;

  logic [XLEN-1:0] pc_q;
  assign pcq_o = pc_q;

  logic [XLEN-1:0] pc2_q;
  assign pc2_q = pc_q + 2;


  logic  [    15:0] instrLowerF_d;
  logic  [    15:0] instrUpperF_d;

  assign instrLowerF_d  = imem[pc_q[$clog2(MEM_SIZE*2):1]];
  assign instrUpperF_d  = imem[pc2_q[$clog2(MEM_SIZE*2):1]];

  logic  [XLEN-1:0] instrF_d;

  logic tb_update_d;
  assign tb_update_d = (!stallFD_i) ? ((flushD_i) ? 0 : 1) : tb_update_o;

  logic hitF_d;
  assign hitF_d = (flushD_i) ? 0 : hitF_i;

  //IF-ID
  always_ff @(posedge clk_i) begin 
    if (!rstn_i) begin
      pcF_o    <= 'h8000_0000;
      instrF_o <= 'h00000013;
      tb_update_o <= 0;
      bTaken_o    <= 0;
    end else begin
      if(!stallFD_i) begin
        pcF_o    <= pc_q;
        bTaken_o    <= hitF_d;
      end
      instrF_o    <= instrF_d;
      tb_update_o <= tb_update_d;
    end
  end

  
  always_ff @(posedge clk_i) begin
    if (!rstn_i) begin
      pc_q <= 'h8000_0000;
    end else begin
      pc_q <= pc_d;
    end 
  end

  always_comb begin
    if (flushD_i) begin
      pc_d = true_pc_i;
    end else if(stallFD_i) begin
      pc_d = pc_q;
    end else if(hitF_i) begin
      pc_d = target_addr_i;
    end else if(instrLowerF_d[1:0] == 2'b11) begin
      pc_d = pc_q + 4;
    end else begin
      pc_d = pc_q + 2;
    end
  end

  always_comb begin
    if(flushD_i) begin
      instrF_d = 'h00000013;
    end else if(stallFD_i) begin
      instrF_d = instrF_o;
    end else if(instrLowerF_d[1:0] == 2'b11) begin
      instrF_d = {instrUpperF_d,instrLowerF_d};
    end else begin
      instrF_d = {{16'b0},instrLowerF_d};
    end
  end
endmodule
