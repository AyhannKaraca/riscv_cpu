module decode
  import riscv_pkg::*;
(
    input  logic             clk_i,
    input  logic             rstn_i,

    //TB_UPDATE
    input  logic             tb_update_i,
    output logic             tb_update_o,

    input  logic  [XLEN-1:0] pcD_i,
    input  logic  [XLEN-1:0] instrD_i,
    //WB PORTS
    input  logic  [XLEN-1:0] rdD_data_i,     
    input  logic  [4:0     ] rdD_addr_i,     
    input  logic             rdD_wr_ena_i, 
    //LOAD-USE STALL
    input  logic             flushE_i,

    output logic  [XLEN-1:0] pcD_o,
    output logic  [XLEN-1:0] instrD_o,
    //FOR HAZARD DET
    output logic  [     4:0] rs1D_addr_o,
    output logic  [     4:0] rs2D_addr_o,

    output alu_ctrl_e        operationD_o,
    output logic  [XLEN-1:0] rs1D_data_o,
    output logic  [XLEN-1:0] rs2D_data_o,
    //WB
    output logic  [     4:0] rdD_addr_o,
    output logic             rdD_wr_ena_o,

    output logic             memD_wr_ena_o,
    output logic  [     4:0] shamtD_data_o,
    output logic  [XLEN-1:0] immD_o,

    output logic             isCompressed_o,
    
    input  logic             bTakenD_i,
    output logic             bTakenD_o,

    input  logic             stallE_i
);
    logic [XLEN-1:0] rf   [31:0];
    alu_ctrl_e       operation_d;
    logic [XLEN-1:0] rs1_data;      // source register 1 data
    logic [XLEN-1:0] rs2_data;      // source register 2 data
    logic            rd_wr_enable;  // register file write enable
    logic [     4:0] rdD_addr_d;
    logic            mem_wr_ena_d;
    logic [     4:0] shamt_data;
    logic [XLEN-1:0] imm_data;      // immediate data
    logic [XLEN-1:0] decomp_instr;      

    decomp_unit decomp(
      .comp_instr_i(instrD_i[15:0]),
      .decomp_instr_o(decomp_instr)
    );
    logic isCompressed_d;
    assign  isCompressed_d = (instrD_i[1:0] != 2'b11);
    logic [XLEN-1:0] instrD_d;
    assign instrD_d = (instrD_i[1:0] != 2'b11) ? decomp_instr : instrD_i;

    always_comb begin : decode_block
      imm_data     = 32'b0;
      shamt_data   = 5'b0;
      rs1_data     = 32'b0;
      rs2_data     = 32'b0;
      rd_wr_enable = 1'b0;
      mem_wr_ena_d = 1'b0;
      operation_d  = UNKNOWN;
      rdD_addr_d   = instrD_d[11:7];
      case(instrD_d[6:0])
        OpcodeLui: begin
            rd_wr_enable ='b1;
            operation_d = LUI;
            imm_data = {instrD_d[31:12], 12'b0};
        end
        OpcodeAuipc: begin
            rd_wr_enable ='b1;
            operation_d = AUIPC;
            imm_data = {instrD_d[31:12], 12'b0};
        end
        OpcodeJal: begin
            rd_wr_enable ='b1;
            operation_d = JAL;
            imm_data = {{12'(signed'(instrD_d[31]))}, instrD_d[19:12], instrD_d[20], instrD_d[30:21], 1'b0};
        end
        OpcodeJalr: begin 
            if (instrD_d[14:12] == F3_JALR) begin
              rd_wr_enable ='b1;
              operation_d = JALR;
              rs1_data = rf[instrD_d[19:15]];
              imm_data = {{21'(signed'(instrD_d[31]))}, instrD_d[30:20]};
            end
        end
        OpcodeBranch: begin
          if (instrD_d[14:12] inside {F3_BEQ, F3_BNE, F3_BLT, F3_BGE, F3_BLTU, F3_BGEU}) begin
            rs1_data = rf[instrD_d[19:15]];
            rs2_data = rf[instrD_d[24:20]];
            imm_data = {{19'(signed'(instrD_d[31]))}, instrD_d[31], instrD_d[7], instrD_d[30:25], instrD_d[11:8], 1'b0};
            rdD_addr_d = 0;
          end
          case (instrD_d[14:12])
            F3_BEQ:     operation_d = BEQ;
            F3_BNE:     operation_d = BNE;
            F3_BLT:     operation_d = BLT;
            F3_BGE:     operation_d = BGE;
            F3_BLTU:    operation_d = BLTU;
            F3_BGEU:    operation_d = BGEU;
          endcase
        end
        OpcodeLoad: begin
          rs1_data = rf[instrD_d[19:15]];
          imm_data = {{20'(signed'(instrD_d[31]))}, instrD_d[31:20]};
          case (instrD_d[14:12])
            F3_LB: begin
                operation_d = LB;
                rd_wr_enable ='b1;
            end
            F3_LH: begin
                operation_d = LH;
                rd_wr_enable ='b1;
            end
            F3_LW: begin
                operation_d = LW;
                rd_wr_enable ='b1;
            end
            F3_LBU: begin
                operation_d = LBU;
                rd_wr_enable ='b1;
            end
            F3_LHU: begin
                operation_d = LHU;
                rd_wr_enable ='b1;
            end
          endcase
        end
        OpcodeStore: begin
          rs1_data = rf[instrD_d[19:15]];
          rs2_data = rf[instrD_d[24:20]];
          imm_data = {{20'(signed'(instrD_d[31]))}, instrD_d[31:25], instrD_d[11:7]};
          rdD_addr_d = 0;
          case (instrD_d[14:12])
            F3_SB: begin
              operation_d = SB;
              mem_wr_ena_d = 'b1;
            end
            F3_SH: begin
              operation_d = SH;
              mem_wr_ena_d = 'b1;
            end
            F3_SW: begin
              operation_d = SW;
              mem_wr_ena_d = 'b1;
            end
          endcase
        end
        OpcodeOpImm: begin
          case(instrD_d[14:12])
            F3_ADDI, F3_SLTI, F3_SLTIU, F3_XORI, F3_ORI, F3_ANDI: begin
              rs1_data = rf[instrD_d[19:15]];
              imm_data = {{20'(signed'(instrD_d[31]))}, instrD_d[31:20]};
              case (instrD_d[14:12])
                F3_ADDI: begin
                    operation_d = ADDI;
                    rd_wr_enable ='b1;
                end
                F3_SLTI: begin
                    operation_d = SLTI;
                    rd_wr_enable ='b1;
                end
                F3_SLTIU: begin
                    operation_d = SLTIU;
                    rd_wr_enable ='b1;
                end
                F3_XORI: begin
                    operation_d = XORI;
                    rd_wr_enable ='b1;
                end
                F3_ORI: begin
                    operation_d = ORI;
                    rd_wr_enable ='b1;
                end
                F3_ANDI: begin
                    operation_d = ANDI;
                    rd_wr_enable ='b1;
                end
              endcase
            end
            F3_SLLI: begin
              case(instrD_d[31:25])
                F7_SLLI:begin
                  rd_wr_enable = 1'b1;
                  shamt_data = instrD_d[24:20];
                  rs1_data = rf[instrD_d[19:15]];
                  operation_d = SLLI;
                end
              endcase
            end
            F3_SRLI :
              if (instrD_d[31:25] == F7_SRLI) begin
                rd_wr_enable ='b1;
                shamt_data = instrD_d[24:20];
                rs1_data = rf[instrD_d[19:15]];
                operation_d = SRLI;
              end else if (instrD_d[31:25] == F7_SRAI) begin
                rd_wr_enable ='b1;
                shamt_data = instrD_d[24:20];
                rs1_data = rf[instrD_d[19:15]];
                operation_d = SRAI;
              end
          endcase
        end
        OpcodeOp:
          case(instrD_d[14:12])
            F3_ADD:
              if (instrD_d[31:25] == F7_ADD) begin
                rd_wr_enable ='b1;
                rs1_data = rf[instrD_d[19:15]];
                rs2_data = rf[instrD_d[24:20]];
                operation_d = ADD;
              end else if (instrD_d[31:25] == F7_SUB) begin
                rd_wr_enable ='b1;
                rs1_data = rf[instrD_d[19:15]];
                rs2_data = rf[instrD_d[24:20]];
                operation_d = SUB;
              end
            F3_SLL :
              if (instrD_d[31:25] == F7_SLL) begin
                rd_wr_enable ='b1;
                rs1_data = rf[instrD_d[19:15]];
                rs2_data = rf[instrD_d[24:20]];
                operation_d = SLL;
              end
            F3_SLT :
              if (instrD_d[31:25] == F7_SLT) begin
                rd_wr_enable ='b1;
                rs1_data = rf[instrD_d[19:15]];
                rs2_data = rf[instrD_d[24:20]];
                operation_d = SLT;
              end
            F3_SLTU:
              if (instrD_d[31:25] == F7_SLTU) begin
                rd_wr_enable ='b1;
                rs1_data = rf[instrD_d[19:15]];
                rs2_data = rf[instrD_d[24:20]];
                operation_d = SLTU;
              end
            F3_XOR :
              if (instrD_d[31:25] == F7_XOR) begin
                rd_wr_enable ='b1;
                rs1_data = rf[instrD_d[19:15]];
                rs2_data = rf[instrD_d[24:20]];
                operation_d = XOR;
              end
            F3_SRL :
              if (instrD_d[31:25] == F7_SRL) begin
                rd_wr_enable ='b1;
                rs1_data = rf[instrD_d[19:15]];
                rs2_data = rf[instrD_d[24:20]];
                operation_d = SRL;
              end else if (instrD_d[31:25] == F7_SRA) begin
                rd_wr_enable ='b1;
                rs1_data = rf[instrD_d[19:15]];
                rs2_data = rf[instrD_d[24:20]];
                operation_d = SRA;
              end
            F3_OR  :
              if (instrD_d[31:25] == F7_OR) begin
                rd_wr_enable ='b1;
                rs1_data = rf[instrD_d[19:15]];
                rs2_data = rf[instrD_d[24:20]];
                operation_d = OR;
              end
            F3_AND :
              if (instrD_d[31:25] == F7_AND) begin
                rd_wr_enable ='b1;
                rs1_data = rf[instrD_d[19:15]];
                rs2_data = rf[instrD_d[24:20]];
                operation_d = AND;
              end
          endcase 
      endcase
    end
    
    //WB
    always_ff @(negedge clk_i) begin
      if (!rstn_i) begin
        for (int i=0; i<32; ++i) begin
          rf[i] <= '0;
        end
      end else if (rdD_wr_ena_i && rdD_addr_i != '0) begin
        rf[rdD_addr_i] <= rdD_data_i;
      end
    end
    logic tb_update_d;
    assign tb_update_d = (!stallE_i) ? ((flushE_i) ? 0 : 1) : tb_update_o;
    
    //ID-EX
    always_ff @(posedge clk_i) begin
        if (!rstn_i) begin
          pcD_o            <= 'h8000_0000;;
          instrD_o         <= 'h00000013;;
          operationD_o     <= UNKNOWN;
          rs1D_data_o      <= 'b0;
          rs2D_data_o      <= 'b0;
          rdD_addr_o       <= 'b0;
          rdD_wr_ena_o     <= 'b0;
          memD_wr_ena_o    <= 'b0;
          shamtD_data_o    <= 'b0;
          immD_o           <= 'b0;
          rs1D_addr_o      <= '0;
          rs2D_addr_o      <= '0;
          tb_update_o      <= 0;
          isCompressed_o   <= 0;
          bTakenD_o        <= 0;
        end else if(stallE_i) begin
          tb_update_o      <=  0;
        end else if(!flushE_i) begin
          bTakenD_o        <= bTakenD_i;
          pcD_o            <= pcD_i;
          instrD_o         <= instrD_i;
          operationD_o     <= operation_d;
          rs1D_data_o      <= rs1_data;
          rs2D_data_o      <= rs2_data;
          rdD_addr_o       <= rdD_addr_d;
          rdD_wr_ena_o     <= rd_wr_enable;
          memD_wr_ena_o    <= mem_wr_ena_d;
          shamtD_data_o    <= shamt_data;
          immD_o           <= imm_data;
          rs1D_addr_o      <= instrD_d[19:15];
          rs2D_addr_o      <= instrD_d[24:20];
          tb_update_o      <= tb_update_i;
          isCompressed_o   <= isCompressed_d;
        end else begin
          instrD_o         <= 'h00000013;
          rdD_wr_ena_o     <= '0;
          memD_wr_ena_o    <= '0;
          operationD_o     <= UNKNOWN;
          rdD_addr_o       <= '0;
          tb_update_o      <=  0;
          bTakenD_o        <=  0;
          pcD_o            <= pcD_i;
        end
    end
endmodule
