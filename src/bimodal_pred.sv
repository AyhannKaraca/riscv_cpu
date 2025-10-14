module bimodal_pred
import riscv_pkg::*;
#(
  parameter PHT_SIZE = 1024,
  parameter BTB_SIZE = 256
)(
  input  logic            clk_i,
  input  logic            rstn_i,
  input  alu_ctrl_e       opE_i,

  input  logic [XLEN-1:0] pcF_i,
  input  logic [XLEN-1:0] pcE_i,
  input  logic [XLEN-1:0] next_pcEX_i,
  input  logic            next_pc_enaEX_i,
  
  output logic            flush_o,
  output logic            branchE_pred_o,
  output logic            branchF_pred_o,
  output logic [XLEN-1:0] branch_addr_o
);

  //00: sNotTaken, 01: wNotTaken, 10: wTaken, 11:sTaken
//=======================================
  logic [1:0] pht_mem [PHT_SIZE-1:0];
  logic br_cntF;
  assign br_cntF = pht_mem[pcF_i[$clog2(PHT_SIZE):1]][1];

  localparam TAG_SIZE  = XLEN - $clog2(BTB_SIZE); // 32 - 8 = 24 bit
  localparam BTB_WIDTH = XLEN + TAG_SIZE; //32 + 24 = 56 bit +1valid?
  logic [BTB_WIDTH-1:0] btb_mem [BTB_SIZE-1:0];

  logic btbF_hit;
  assign btbF_hit = (btb_mem[pcF_i[$clog2(BTB_SIZE):1]][BTB_WIDTH-1:XLEN] == pcF_i[XLEN-1:$clog2(BTB_SIZE)]);

  assign branchF_pred_o = (br_cntF & btbF_hit);                        //fetchde branchF_pred_o = 1 ise pc = branch_addr_o olacak.
  assign branch_addr_o = btb_mem[pcF_i[$clog2(BTB_SIZE):1]][XLEN-1:0];
//=======================================

//=======================================
//FLUSH MECHANISM
  logic [1:0] br_cntE;
  assign br_cntE = pht_mem[pcE_i[$clog2(PHT_SIZE):1]];
  assign flush_o = ((!br_cntE[1] & next_pc_enaEX_i) | (br_cntE[1] & !next_pc_enaEX_i)); // hazard unitteki branch_taken_i ye bağla
//=======================================
  
//=======================================
  //PHT UPDATE
  logic isBranch;
  assign isBranch = (opE_i inside {BEQ,BNE,BLT,BGE,BLTU,BGEU,JAL,JALR});

  always_ff @(posedge clk_i) begin
    if(rstn_i) begin
      ;
    end else begin
      if(isBranch) begin
        if(next_pc_enaEX_i & br_cntE != 2'b11) begin
          pht_mem[pcE_i[$clog2(PHT_SIZE):1]] <= br_cntE + 1;
        end else if(!next_pc_enaEX_i &  br_cntE != 2'b00) begin
          pht_mem[pcE_i[$clog2(PHT_SIZE):1]] <= br_cntE - 1;
        end
      end
    end
  end
//=======================================

//=======================================
  logic btbE_hit;
  assign btbE_hit = (btb_mem[pcE_i[$clog2(BTB_SIZE):1]][BTB_WIDTH-1:XLEN] == pcE_i[XLEN-1:$clog2(BTB_SIZE)]);
  assign branchE_pred_o = (br_cntE[1] & btbE_hit); //for hazard det
  //BTB UPDATE
  always_ff @(posedge clk_i) begin
    if(rstn_i) begin
      ;
    end else begin
      if(next_pc_enaEX_i & isBranch) begin
        btb_mem[pcE_i[$clog2(BTB_SIZE):1]] <= {pcE_i[XLEN-1:$clog2(BTB_SIZE)],next_pcEX_i};
      end
    end
  end  

//=======================================

endmodule
