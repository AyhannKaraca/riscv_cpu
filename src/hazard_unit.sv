module hazard_unit 
    import riscv_pkg::*;
(
    input  logic [4:0]      rs1D_i       ,
    input  logic [4:0]      rs2D_i       ,
    input  logic [4:0]      rdE_i        ,
    input  logic [4:0]      rdM_i        ,
    input  logic [4:0]      rs1_f_d_i    ,//load-use
    input  logic [4:0]      rs2_f_d_i    ,//load-use
    input  logic [4:0]      rd_d_e_i     ,//load-use
    input  logic [6:0]      opF_i        ,//load-use
    input  logic            rdE_wr_ena_i ,
    input  logic            rdM_wr_ena_i ,
    input  logic            branch_tkn_i ,
    input  operation_e      opE_i        ,//load-use
    output logic            pc_en_o      ,//load-use
    output logic            stallH_o     ,//load-use 
    output logic            flush_o      ,//Control hazard 
    output forwarding_e     forwardA_o   ,
    output forwarding_e     forwardB_o   
    );

always_comb begin : forwarding_block
   forwardA_o = NO_FRWD; 
   forwardB_o = NO_FRWD;

   if((rs1D_i == rdM_i) && (rdM_wr_ena_i) && (rdM_i != '0) && !(opE_i inside {LB,LH,LW,LBU,LHU})) begin
     forwardA_o = MEM_FRWD;
   end
   if((rs1D_i == rdE_i) && (rdE_wr_ena_i) && (rdE_i != '0) && !(opE_i inside {LB,LH,LW,LBU,LHU})) begin
        forwardA_o = EX_FRWD;
   end
   if((rs2D_i == rdM_i) && (rdM_wr_ena_i) && (rdM_i != '0) && !(opE_i inside {LB,LH,LW,LBU,LHU})) begin
        forwardB_o = MEM_FRWD;
   end
   if((rs2D_i == rdE_i) && (rdE_wr_ena_i) && (rdE_i != '0) && !(opE_i inside {LB,LH,LW,LBU,LHU})) begin
        forwardB_o = EX_FRWD;
   end
end

always_comb begin : load_use_hazard
    pc_en_o         = 1;
    stallH_o         = 0;
    if ((opE_i inside {LB,LH,LW,LBU,LHU}) && (opF_i != 7'b0000011 && opF_i != 7'b0100011) && ((rd_d_e_i == rs1_f_d_i) || (rd_d_e_i == rs2_f_d_i))) begin
        pc_en_o     = 0;
        stallH_o     = 1;
    end
end

//Control hazard. flush signal generator
assign flush_o = (branch_tkn_i) ? 1'b1 : 1'b0;

endmodule
