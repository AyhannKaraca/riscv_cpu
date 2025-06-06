module execute
  import riscv_pkg::*;
(
    input  logic               clk_i,
    input  logic               rstn_i,
    input  logic               flush_i,
    input  logic               flushD_E_i,//db
    input  logic               stallE_i,
    input  logic  [XLEN-1:0]   pcE_i,
    input  logic  [XLEN-1:0]   instrE_i,
    input  operation_e         operationE_i,
    input  logic  [XLEN-1:0]   rs1E_i,
    input  logic  [XLEN-1:0]   rs2E_i,
    input  logic  [     4:0]   rdE_addr_i,
    input  logic               rdE_wrt_ena_i,
    input  logic               memE_wrt_ena_i,
    input  logic  [     4:0]   shamt_dataE_i,
    input  logic  [XLEN-1:0]   immE_i,
    output logic  [XLEN-1:0]   pcE_o,
    output logic  [XLEN-1:0]   instrE_o,
    output operation_e         operationE_o,
    output rd_port_t           rdE_port_o,
    output logic               memE_wrt_ena_o,
    output logic  [XLEN-1:0]   memE_wrt_addr_o,
    output logic  [XLEN-1:0]   memE_wrt_data_o,
    output logic               stallE_o,
    output logic               flushD_E_o, //db
    output logic               flushE_o, //db
    output logic               next_pc_ena_o,
    output logic  [XLEN-1:0]   next_pc_o
);

  function automatic logic [31:0] clz(input logic [31:0] val);
    clz = 0;
    for (int i = 31; i >= 0; i--) begin
      if (val[i]) break;
      clz++;
    end
  endfunction

  function automatic logic [31:0] ctz(input logic [31:0] val);
    ctz = 0;
    for (int i = 0; i < 32; i++) begin
      if (val[i]) break;
      ctz++;
   end
  endfunction

  function automatic logic [31:0] cpop(input logic [31:0] val);
    cpop = 0;
    for (int i = 0; i < 32; i++) begin
      if (val[i]) cpop++;
    end
  endfunction

    logic  [XLEN-1:0] mem_wrt_addr_d;
    logic  [XLEN-1:0] mem_wrt_data_d;
    logic             memE_wrt_ena_d;
    logic             next_pc_ena_d;
    logic  [XLEN-1:0] next_pc_d;
    rd_port_t         rd_port_d;

    assign mem_wrt_addr_d  = rs1E_i + immE_i;
    assign mem_wrt_data_d  = rs2E_i;
    assign rd_port_d.addr  = rdE_addr_i;
    assign rd_port_d.valid = (flush_i) ? 0 : rdE_wrt_ena_i;
    assign memE_wrt_ena_d  = (flush_i) ? 0 : memE_wrt_ena_i;

    always_comb begin : execute_block
      next_pc_ena_d  = 0;
      next_pc_d      = 0;
      rd_port_d.data = 0;

      case(operationE_i)
        LUI: begin
          rd_port_d.data = immE_i;
        end 
        AUIPC: begin
          rd_port_d.data =  immE_i + pcE_i;
        end
        JAL: begin
          if(!flush_i)begin
            next_pc_ena_d = 1'b1;
            next_pc_d = immE_i + pcE_i;
            rd_port_d.data = pcE_i + 4;
          end
        end
        JALR: begin
          if(!flush_i)begin
            next_pc_ena_d = 1'b1;
            next_pc_d = immE_i + rs1E_i;
            rd_port_d.data = pcE_i + 4;
          end
        end
        BEQ:
          if ((rs1E_i == rs2E_i) && (!flush_i)) begin
            next_pc_d = immE_i + pcE_i;
            next_pc_ena_d = 1'b1;
          end
        BNE:
          if ((rs1E_i != rs2E_i) && (!flush_i)) begin
            next_pc_d = immE_i + pcE_i;
            next_pc_ena_d = 1'b1;
          end
        BLT:
          if (($signed(rs1E_i) < $signed(rs2E_i)) && (!flush_i)) begin
            next_pc_d = immE_i + pcE_i;
            next_pc_ena_d = 1'b1;
          end
        BGE:
          if (($signed(rs1E_i) >= $signed(rs2E_i)) && (!flush_i)) begin
            next_pc_d = immE_i + pcE_i;
            next_pc_ena_d = 1'b1;
          end
        BLTU: 
          if ((rs1E_i < rs2E_i) && (!flush_i)) begin
            next_pc_d = immE_i + pcE_i;
            next_pc_ena_d = 1'b1;
          end
        BGEU: 
          if ((rs1E_i >= rs2E_i) && (!flush_i)) begin
            next_pc_d = immE_i + pcE_i;
            next_pc_ena_d = 1'b1;
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
          rd_port_d.data = $signed(immE_i) + $signed(rs1E_i);
        end
        SLTI : begin
          if ($signed(rs1E_i) < $signed(immE_i)) rd_port_d.data = 32'b1;
        end
        SLTIU: begin
          if (rs1E_i < immE_i) rd_port_d.data = 32'b1;
        end
        XORI : begin
          rd_port_d.data = rs1E_i ^ immE_i;
        end
        ORI  :begin
          rd_port_d.data = rs1E_i | immE_i;
        end
        ANDI :begin
          rd_port_d.data = rs1E_i & immE_i;
        end
        SLLI: begin
          rd_port_d.data = rs1E_i << shamt_dataE_i;
        end 
        SRLI: begin
          rd_port_d.data = rs1E_i >> shamt_dataE_i;
        end
        SRAI: begin
          rd_port_d.data = $signed(rs1E_i) >>> shamt_dataE_i;
        end
        ADD: begin
          rd_port_d.data = rs1E_i + rs2E_i;
        end
        SUB: begin
          rd_port_d.data = rs1E_i - rs2E_i;
        end
        SLL: begin
          rd_port_d.data = rs1E_i << rs2E_i;
        end
        SLT: begin
          if ($signed(rs1E_i) < $signed(rs2E_i))  rd_port_d.data = 32'b1;
        end
        SLTU: begin
          if (rs1E_i < rs2E_i)  rd_port_d.data = 32'b1;
        end
        XOR: begin
          rd_port_d.data = rs1E_i ^ rs2E_i;  
        end
        SRL: begin
          rd_port_d.data = rs1E_i >> rs2E_i;
        end
        SRA: begin
          rd_port_d.data = $signed(rs1E_i) >>> rs2E_i;
        end
        OR: begin
          rd_port_d.data = rs1E_i | rs2E_i;
        end
        AND: begin
          rd_port_d.data = rs1E_i & rs2E_i;
        end
        CLZ: begin
          rd_port_d.data = clz(rs1E_i);
        end
        CTZ: begin
          rd_port_d.data = ctz(rs1E_i);
        end
        CPOP: begin
          rd_port_d.data = cpop(rs1E_i);
        end
        UNKNOWN: ;
      endcase
    end

    //EX-MEM
    always_ff @(posedge clk_i) begin
      if (!rstn_i) begin
        memE_wrt_ena_o  <= '0;
        memE_wrt_data_o <= '0;
        memE_wrt_addr_o <= '0;
        rdE_port_o      <= '0;
        pcE_o           <= '0;
        instrE_o        <= '0;
        operationE_o    <= UNKNOWN;
        stallE_o        <= '0;
        flushD_E_o      <= '0;
        next_pc_ena_o   <= '0;
        next_pc_o       <= '0;
        
      end else begin
        memE_wrt_ena_o  <= memE_wrt_ena_d;
        memE_wrt_data_o <= mem_wrt_data_d;
        memE_wrt_addr_o <= mem_wrt_addr_d;
        rdE_port_o      <= rd_port_d; 
        pcE_o           <= pcE_i;
        instrE_o        <= instrE_i;
        operationE_o    <= operationE_i;
        stallE_o        <= stallE_i;
        flushD_E_o      <= flushD_E_i;
        flushE_o        <= flush_i;
        next_pc_ena_o   <= next_pc_ena_d; 
        next_pc_o       <= next_pc_d;
      end
    end

endmodule
