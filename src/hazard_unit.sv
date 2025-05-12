module hazard_unit 
    import riscv_pkg::*;
(
    input  logic [4:0]      rs1D_i       ,
    input  logic [4:0]      rs2D_i       ,
    input  logic [4:0]      rdE_i        ,
    input  logic [4:0]      rdM_i        ,
    input  logic            rdE_wr_ena_i ,
    input  logic            rdM_wr_ena_i ,
    output forwarding_e     forwardA_o   ,
    output forwarding_e     forwardB_o   
);

always_comb begin : forwarding_block
   forwardA_o = NO_FRWD; 
   forwardB_o = NO_FRWD;

   if((rs1D_i == rdM_i) && (rdM_wr_ena_i) && (rdM_i != '0)) begin
     forwardA_o = MEM_FRWD;
   end
   if((rs1D_i == rdE_i) && (rdE_wr_ena_i) && (rdE_i != '0)) begin
        forwardA_o = EX_FRWD;
   end
   if((rs2D_i == rdM_i) && (rdM_wr_ena_i) && (rdM_i != '0)) begin
        forwardB_o = MEM_FRWD;
   end
   if((rs2D_i == rdE_i) && (rdE_wr_ena_i) && (rdE_i != '0)) begin
        forwardB_o = EX_FRWD;
   end
end





endmodule
