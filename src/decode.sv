module decode
  import riscv_pkg::*;
(
    input  logic             clk_i,
    input  logic             rstn_i,
    input  logic  [XLEN-1:0] pcD_i,
    input  logic  [XLEN-1:0] instrD_i,
    input  rd_port_t         rdWB_port_i,
    output logic  [XLEN-1:0] pcD_o,
    output logic  [XLEN-1:0] instrD_o,
    output operation_e       operationD_o,
    output logic  [XLEN-1:0] rs1D_o,
    output logic  [XLEN-1:0] rs2D_o,
    output logic  [     4:0] rs1D_idx_o,
    output logic  [     4:0] rs2D_idx_o,
    output logic  [     4:0] rdD_addr_o,
    output logic             rdD_wrt_ena_o,
    output logic             memD_wr_ena_o,
    output logic  [     4:0] shamt_dataD_o,
    output logic  [XLEN-1:0] immD_o
);
    logic [XLEN-1:0] rf   [31:0];
    operation_e      operation_d;
    logic [XLEN-1:0] rs1_data;      // source register 1 data
    logic [XLEN-1:0] rs2_data;      // source register 2 data
    logic [XLEN-1:0] imm_data;      // immediate data
    logic [     4:0] shamt_data;
    logic            rf_wr_enable;  // register file write enable
    logic            mem_wr_ena_d;
    logic [     4:0] rs1_idx_d;
    logic [     4:0] rs2_idx_d;

    assign rs1_idx_d = instrD_i[19:15];
    assign rs2_idx_d = instrD_i[24:20];
    

    always_comb begin : decode_block
      imm_data     = 32'b0;
      shamt_data   = 5'b0;
      rs1_data     = 32'b0;
      rs2_data     = 32'b0;
      rf_wr_enable = 'b0;
      mem_wr_ena_d = 'b0;
      operation_d  = UNKNOWN;
      case(instrD_i[6:0])
        OpcodeLui: begin
            rf_wr_enable ='b1;
            operation_d = LUI;
            imm_data = {instrD_i[31:12] , 12'b0};
        end
        OpcodeAuipc: begin
            rf_wr_enable ='b1;
            operation_d = AUIPC;
            imm_data = {instrD_i[31:12] , 12'b0};
        end
        OpcodeJal: begin
            rf_wr_enable ='b1;
            operation_d = JAL;
            imm_data = {{12'(signed'(instrD_i[31]))}, instrD_i[19:12], instrD_i[20], instrD_i[30:21], 1'b0};
        end
        OpcodeJalr: 
            if (instrD_i[14:12] == F3_JALR) begin
              rf_wr_enable ='b1;
              operation_d = JALR;
              rs1_data = rf[instrD_i[19:15]];
              imm_data = {{21'(signed'(instrD_i[31]))}, instrD_i[30:20]};
            end
        OpcodeBranch: begin
          if (instrD_i[14:12] inside {F3_BEQ, F3_BNE, F3_BLT, F3_BGE, F3_BLTU, F3_BGEU}) begin
            rs1_data = rf[instrD_i[19:15]];
            rs2_data = rf[instrD_i[24:20]];
            imm_data = {{19'(signed'(instrD_i[31]))}, instrD_i[31], instrD_i[7], instrD_i[30:25], instrD_i[11:8], 1'b0};
          end
          case (instrD_i[14:12])
            F3_BEQ:     operation_d = BEQ;
            F3_BNE:     operation_d = BNE;
            F3_BLT:     operation_d = BLT;
            F3_BGE:     operation_d = BGE;
            F3_BLTU:    operation_d = BLTU;
            F3_BGEU:    operation_d = BGEU;
          endcase
        end
        OpcodeLoad: begin
          rs1_data = rf[instrD_i[19:15]];
          imm_data = {{20'(signed'(instrD_i[31]))}, instrD_i[31:20]};
          case (instrD_i[14:12])
            F3_LB: begin
                operation_d = LB;
                rf_wr_enable ='b1;
            end
            F3_LH: begin
                operation_d = LH;
                rf_wr_enable ='b1;
            end
            F3_LW: begin
                operation_d = LW;
                rf_wr_enable ='b1;
            end
            F3_LBU: begin
                operation_d = LBU;
                rf_wr_enable ='b1;
            end
            F3_LHU: begin
                operation_d = LHU;
                rf_wr_enable ='b1;
            end
          endcase
        end
        OpcodeStore: begin
          rs1_data = rf[instrD_i[19:15]];
          rs2_data = rf[instrD_i[24:20]];
          imm_data = {{20'(signed'(instrD_i[31]))}, instrD_i[31:25], instrD_i[11:7]};
          case (instrD_i[14:12])
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
        OpcodeOpImm:
          case(instrD_i[14:12])
            F3_ADDI, F3_SLTI, F3_SLTIU, F3_XORI, F3_ORI, F3_ANDI: begin
              rs1_data = rf[instrD_i[19:15]];
              imm_data = {{20'(signed'(instrD_i[31]))}, instrD_i[31:20]};
              case (instrD_i[14:12])
                F3_ADDI: begin
                    operation_d = ADDI;
                    rf_wr_enable ='b1;
                end
                F3_SLTI: begin
                    operation_d = SLTI;
                    rf_wr_enable ='b1;
                end
                F3_SLTIU: begin
                    operation_d = SLTIU;
                    rf_wr_enable ='b1;
                end
                F3_XORI: begin
                    operation_d = XORI;
                    rf_wr_enable ='b1;
                end
                F3_ORI: begin
                    operation_d = ORI;
                    rf_wr_enable ='b1;
                end
                F3_ANDI: begin
                    operation_d = ANDI;
                    rf_wr_enable ='b1;
                end
              endcase
            end
            F3_SLLI:
              if (instrD_i[31:25] == F7_SLLI) begin
                rf_wr_enable = 1'b1;
                shamt_data = instrD_i[24:20];
                rs1_data = rf[instrD_i[19:15]];
                operation_d = SLLI;
              end
            F3_SRLI :
              if (instrD_i[31:25] == F7_SRLI) begin
                rf_wr_enable ='b1;
                shamt_data = instrD_i[24:20];
                rs1_data = rf[instrD_i[19:15]];
                operation_d = SRLI;
              end else if (instrD_i[31:25] == F7_SRAI) begin
                rf_wr_enable ='b1;
                shamt_data = instrD_i[24:20];
                rs1_data = rf[instrD_i[19:15]];
                operation_d = SRAI;
              end
          endcase
        OpcodeOp:
          case(instrD_i[14:12])
            F3_ADD:
              if (instrD_i[31:25] == F7_ADD) begin
                rf_wr_enable ='b1;
                rs1_data = rf[instrD_i[19:15]];
                rs2_data = rf[instrD_i[24:20]];
                operation_d = ADD;
              end else if (instrD_i[31:25] == F7_SUB) begin
                rf_wr_enable ='b1;
                rs1_data = rf[instrD_i[19:15]];
                rs2_data = rf[instrD_i[24:20]];
                operation_d = SUB;
              end
            F3_SLL :
              if (instrD_i[31:25] == F7_SLL) begin
                rf_wr_enable ='b1;
                rs1_data = rf[instrD_i[19:15]];
                rs2_data = rf[instrD_i[24:20]];
                operation_d = SLL;
              end
            F3_SLT :
              if (instrD_i[31:25] == F7_SLT) begin
                rf_wr_enable ='b1;
                rs1_data = rf[instrD_i[19:15]];
                rs2_data = rf[instrD_i[24:20]];
                operation_d = SLT;
              end
            F3_SLTU:
              if (instrD_i[31:25] == F7_SLTU) begin
                rf_wr_enable ='b1;
                rs1_data = rf[instrD_i[19:15]];
                rs2_data = rf[instrD_i[24:20]];
                operation_d = SLTU;
              end
            F3_XOR :
              if (instrD_i[31:25] == F7_XOR) begin
                rf_wr_enable ='b1;
                rs1_data = rf[instrD_i[19:15]];
                rs2_data = rf[instrD_i[24:20]];
                operation_d = XOR;
              end
            F3_SRL :
            if (instrD_i[31:25] == F7_SRL) begin
              rf_wr_enable ='b1;
                rs1_data = rf[instrD_i[19:15]];
                rs2_data = rf[instrD_i[24:20]];
                operation_d = SRL;
            end else if (instrD_i[31:25] == F7_SRA) begin
              rf_wr_enable ='b1;
                rs1_data = rf[instrD_i[19:15]];
                rs2_data = rf[instrD_i[24:20]];
                operation_d = SRA;
              end
            F3_OR  :
              if (instrD_i[31:25] == F7_OR) begin
                rf_wr_enable ='b1;
                rs1_data = rf[instrD_i[19:15]];
                rs2_data = rf[instrD_i[24:20]];
                operation_d = OR;
              end
            F3_AND :
              if (instrD_i[31:25] == F7_AND) begin
                rf_wr_enable ='b1;
                rs1_data = rf[instrD_i[19:15]];
                rs2_data = rf[instrD_i[24:20]];
                operation_d = AND;
              end
          endcase
      endcase
    end

    always_ff @(negedge clk_i) begin
      if (!rstn_i) begin
        for (int i=0; i<32; ++i) begin
          rf[i] <= '0;
        end
      end else if (rdWB_port_i.valid && rdWB_port_i.addr != '0) begin
        rf[rdWB_port_i.addr] <= rdWB_port_i.data;
      end
    end

    //ID-EX
    always_ff @(posedge clk_i) begin
        if (!rstn_i) begin
            pcD_o            <= 'b0;
            instrD_o         <= 'b0;
            rs1D_o           <= 'b0;
            rs2D_o           <= 'b0;
            immD_o           <= 'b0;
            memD_wr_ena_o    <= 'b0;
            operationD_o     <= UNKNOWN;
            shamt_dataD_o    <= 'b0;
            rdD_wrt_ena_o    <= 'b0;
            rs1D_idx_o       <= 'b0;
            rs2D_idx_o       <= 'b0;
        end else begin
            pcD_o            <= pcD_i;
            instrD_o         <= instrD_i;
            rs1D_o           <= rs1_data;
            rs2D_o           <= rs2_data;
            immD_o           <= imm_data;
            memD_wr_ena_o    <= mem_wr_ena_d;
            operationD_o     <= operation_d;
            shamt_dataD_o    <= shamt_data;
            rdD_addr_o       <= instrD_i[11:7];
            rdD_wrt_ena_o    <= rf_wr_enable;
            rs1D_idx_o       <= rs1_idx_d;
            rs2D_idx_o       <= rs2_idx_d;
        end
    end
endmodule
