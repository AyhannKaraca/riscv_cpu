module execute
  import riscv_pkg::*;
(
    input  logic               clk_i,
    input  logic               rstn_i,

    //TB_UPDATE
    input  logic               tb_update_i,
    output logic               tb_update_o,

    input  logic               isCompressed_i,

    input  logic  [XLEN-1:0]   pcE_i,
    input  logic  [XLEN-1:0]   instrE_i,
    //FOR HAZARD DET
    input  logic  [     1:0]   forwardAE_i,
    input  logic  [     1:0]   forwardBE_i,
    input  logic  [     4:0]   rs1E_addr_i,
    input  logic  [     4:0]   rs2E_addr_i,
    output logic  [     4:0]   rs1E_addr_o,
    output logic  [     4:0]   rs2E_addr_o,

    //FORWARDED DATA
    input logic  [XLEN-1:0]    forwM_data_i,
    input logic  [XLEN-1:0]    forwW_data_i,

    input  alu_ctrl_e          operationE_i,
    input  logic  [XLEN-1:0]   rs1E_data_i,
    input  logic  [XLEN-1:0]   rs2E_data_i,
    input  logic  [     4:0]   rdE_addr_i,
    input  logic               rdE_wrt_ena_i,
    input  logic               memE_wrt_ena_i,
    input  logic  [     4:0]   shamt_dataE_i,
    input  logic  [XLEN-1:0]   immE_i,

    output logic  [XLEN-1:0]   pcE_o,
    output logic  [XLEN-1:0]   instrE_o,

    //NEEDED FOR LOAD-STORE IN THE MEM STAGE
    output alu_ctrl_e          operationE_o,
    
    //WB SIGNALS
    output logic  [XLEN-1:0]   rdE_data_o,
    output logic  [     4:0]   rdE_addr_o,
    output logic               rdE_wr_ena_o,
    

    //MEM WR SIGNALS
    output logic               memE_wr_ena_o,
    output logic  [XLEN-1:0]   memE_addr_o,
    output logic  [XLEN-1:0]   memE_wr_data_o,

    //BRANCH SIGNALS (COMB)
    output logic               next_pc_ena_o,
    output logic  [XLEN-1:0]   next_pc_o
);

    logic  [XLEN-1:0] mem_addr_d;
    logic  [XLEN-1:0] mem_wrt_data_d;
    logic             memE_wrt_ena_d;
    logic  [XLEN-1:0] rdE_data_d;
    logic  [     4:0] rdE_addr_d;
    logic             rdE_wr_ena_d;

    logic  [XLEN-1:0] rs1_data_d;
    logic  [XLEN-1:0] rs2_data_d;

    always_comb begin
      case(forwardAE_i)
        2'b00: begin
          rs1_data_d = rs1E_data_i;
        end
        2'b01: begin
          rs1_data_d = forwW_data_i;
        end
        2'b10: begin
          rs1_data_d = forwM_data_i;
        end
        default: rs1_data_d = rs1E_data_i;
      endcase
    end

    always_comb begin
      case(forwardBE_i)
        2'b00: begin
          rs2_data_d = rs2E_data_i;
        end
        2'b01: begin
          rs2_data_d = forwW_data_i;
        end
        2'b10: begin
          rs2_data_d = forwM_data_i;
        end
        default: rs2_data_d = rs2E_data_i;
      endcase
    end

    assign rs1E_addr_o = rs1E_addr_i;
    assign rs2E_addr_o = rs2E_addr_i;

    assign mem_addr_d      = rs1_data_d + immE_i;
    assign mem_wrt_data_d  = rs2_data_d;
    assign memE_wrt_ena_d  = memE_wrt_ena_i;

    assign rdE_addr_d      = rdE_addr_i;
    assign rdE_wr_ena_d    = rdE_wrt_ena_i;

    always_comb begin : execute_block
      next_pc_ena_o  = 0;
      next_pc_o      = 0;
      rdE_data_d     = 0;
      case(operationE_i)
        LUI: begin
          rdE_data_d     = immE_i;
        end 
        AUIPC: begin
          rdE_data_d     = immE_i + pcE_i;
        end
        JAL: begin
          next_pc_ena_o = 1'b1;
          next_pc_o = immE_i + pcE_i;
          if(isCompressed_i) begin
            rdE_data_d     = pcE_i + 2; // if isComp is asserted, rdE_data_d should be pcE_i + 2
          end else begin
            rdE_data_d     = pcE_i + 4;
          end
        end
        JALR: begin
          next_pc_ena_o = 1'b1;
          next_pc_o = immE_i + rs1_data_d;
          if(isCompressed_i) begin
            rdE_data_d     = pcE_i + 2; // if isComp is asserted, rdE_data_d should be pcE_i + 2
          end else begin
            rdE_data_d     = pcE_i + 4;
          end
        end
        BEQ:
          if (rs1_data_d == rs2_data_d) begin
            next_pc_o = immE_i + pcE_i;
            next_pc_ena_o = 1'b1;
          end
        BNE:
          if (rs1_data_d != rs2_data_d) begin
            next_pc_o = immE_i + pcE_i;
            next_pc_ena_o = 1'b1;
          end
        BLT:
          if ($signed(rs1_data_d) < $signed(rs2_data_d)) begin
            next_pc_o = immE_i + pcE_i;
            next_pc_ena_o = 1'b1;
          end
        BGE:
          if ($signed(rs1_data_d) >= $signed(rs2_data_d)) begin
            next_pc_o = immE_i + pcE_i;
            next_pc_ena_o = 1'b1;
          end
        BLTU: 
          if (rs1_data_d < rs2_data_d) begin
            next_pc_o = immE_i + pcE_i;
            next_pc_ena_o = 1'b1;
          end
        BGEU: 
          if (rs1_data_d >= rs2_data_d) begin
            next_pc_o = immE_i + pcE_i;
            next_pc_ena_o = 1'b1;
          end  
        LB  : ;
        LH  : ;
        LW  : ;
        LBU : ;
        LHU : ;
        SB  : ;
        SH  : ;
        SW  : ; 
        ADDI : begin
          rdE_data_d     = $signed(immE_i) + $signed(rs1_data_d);
        end
        SLTI : begin
          if ($signed(rs1_data_d) < $signed(immE_i)) rdE_data_d = 32'b1;
        end
        SLTIU: begin
          if (rs1_data_d < immE_i) rdE_data_d = 32'b1;
        end
        XORI : begin
          rdE_data_d     = rs1_data_d ^ immE_i;
        end
        ORI  :begin
          rdE_data_d     = rs1_data_d | immE_i;
        end
        ANDI :begin
          rdE_data_d     = rs1_data_d & immE_i;
        end
        SLLI: begin
          rdE_data_d     = rs1_data_d << shamt_dataE_i;
        end 
        SRLI: begin
          rdE_data_d     = rs1_data_d >> shamt_dataE_i;
        end
        SRAI: begin
          rdE_data_d     = $signed(rs1_data_d) >>> shamt_dataE_i;
        end
        ADD: begin
          rdE_data_d     = rs1_data_d + rs2_data_d;
        end
        SUB: begin
          rdE_data_d     = rs1_data_d - rs2_data_d;
        end
        SLL: begin
          rdE_data_d     = rs1_data_d << rs2_data_d[4:0];
        end
        SLT: begin
          if ($signed(rs1_data_d) < $signed(rs2_data_d))  rdE_data_d     = 32'b1;
        end
        SLTU: begin
          if (rs1_data_d < rs2_data_d)  rdE_data_d     = 32'b1;
        end
        XOR: begin
          rdE_data_d     = rs1_data_d ^ rs2_data_d;  
        end
        SRL: begin
          rdE_data_d     = rs1_data_d >> rs2_data_d[4:0];
        end
        SRA: begin
          rdE_data_d     = $signed(rs1_data_d) >>> rs2_data_d;
        end
        OR: begin
          rdE_data_d     = rs1_data_d | rs2_data_d;
        end
        AND: begin
          rdE_data_d     = rs1_data_d & rs2_data_d;
        end
        UNKNOWN: ;
      endcase
    end

    //EX-MEM
    always_ff @(posedge clk_i) begin
      if (!rstn_i) begin
        pcE_o           <= 'h8000_0000;
        instrE_o        <= 'h00000013;
        operationE_o    <= UNKNOWN;
        rdE_data_o      <= '0;
        rdE_addr_o      <= '0;
        rdE_wr_ena_o    <= '0;
        memE_wr_ena_o   <= '0;
        memE_addr_o     <= '0;
        memE_wr_data_o  <= '0;
        tb_update_o     <= 0;
      end else begin
        pcE_o           <= pcE_i;
        instrE_o        <= instrE_i;
        operationE_o    <= operationE_i;
        rdE_data_o      <= rdE_data_d;
        rdE_addr_o      <= rdE_addr_i;
        rdE_wr_ena_o    <= rdE_wrt_ena_i;
        memE_wr_ena_o   <= memE_wrt_ena_d;
        memE_addr_o     <= mem_addr_d;
        memE_wr_data_o  <= mem_wrt_data_d;
        tb_update_o     <= tb_update_i;
      end
    end

endmodule
