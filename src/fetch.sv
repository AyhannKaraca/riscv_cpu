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
  input  logic             stallFD_i, //STALL(LOAD-USE)
  input  logic             flushD_i,  //BRANCH
  input  logic  [XLEN-1:0] next_pc_i,
  input  logic             next_pc_enable_i,
  output logic  [XLEN-1:0] pcF_o,
  output logic  [XLEN-1:0] instrF_o
);
    localparam int MEM_SIZE = 4100;
    logic [XLEN-1:0] imem [MEM_SIZE-1:0];
    initial $readmemh(IMemInitFile, imem);

    logic [XLEN-1:0] pc_d;
    logic [XLEN-1:0] pc_q;
    
    logic  [XLEN-1:0] instrF_d;
    assign instrF_d  = (flushD_i) ? 'h00000013 : imem[pc_q[$clog2(MEM_SIZE*4)-1:2]];

    logic tb_update_d;
    assign tb_update_d = ((flushD_i) | (stallFD_i)) ? 0 : 1;

    always_ff @(posedge clk_i) begin 
      if (!rstn_i) begin
        pcF_o    <= 'h8000_0000;
        instrF_o <= 'h00000013;
        tb_update_o <= 0;
      end else if(!stallFD_i) begin
        pcF_o    <= pc_q;
        instrF_o <= instrF_d;
        tb_update_o <= tb_update_d;
      end
    end

    //IF-ID
    always_ff @(posedge clk_i) begin : pc_change_ff
      if (!rstn_i) begin
        pc_q <= 'h8000_0000;
      end else if(!stallFD_i) begin
        pc_q <= pc_d;
      end 
    end

    always_comb begin : pc_change_comb
      if (next_pc_enable_i) begin
        pc_d = next_pc_i;
      end else begin
        pc_d = pc_q + 4;
      end
    end
endmodule
