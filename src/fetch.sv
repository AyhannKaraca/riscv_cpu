module fetch
  import riscv_pkg::*;
(
    input  logic             clk_i,
    input  logic             rstn_i,
    input  logic             pc_en_i,
    input  logic  [XLEN-1:0] next_pc_i,
    input  logic             next_pc_enable_i,
    output logic  [XLEN-1:0] pcF_o,
    output logic  [XLEN-1:0] instrF_o
);
    parameter int MEM_SIZE = 2048;
    logic [31:0]     imem [MEM_SIZE-1:0];
    initial $readmemh("./test/test.hex", imem, 0, MEM_SIZE);

    logic [XLEN-1:0] pc_d;
    logic [XLEN-1:0] pc_q;

    assign pcF_o = pc_q;

    //IF-ID
    always_ff @(posedge clk_i) begin : pc_change_ff
      if (!rstn_i) begin
        pc_q <= 'h8000_0000;
      end else if(pc_en_i) begin
        pc_q <= pc_d;
      end
    end

    always_comb begin : pc_change_comb
      if (next_pc_enable_i) begin
        pc_d = next_pc_i;
      end else begin
        pc_d = pc_q + 4;
      end
        instrF_o = imem[pc_q[$clog2(MEM_SIZE*4)-1:2]];
    end
endmodule
