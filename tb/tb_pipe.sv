module tb_pipe
  import riscv_pkg::*;
();

  parameter IMemInitFile = "imem.mem";
  parameter DMemInitFile = "dmem.mem";

// Signal Declerations
  logic                       clk;
  logic                       rstn;
  logic [riscv_pkg::XLEN-1:0] addr;
  logic                       update;
  logic [riscv_pkg::XLEN-1:0] data;
  logic [riscv_pkg::XLEN-1:0] pc;
  logic [riscv_pkg::XLEN-1:0] instr;
  logic [                4:0] reg_addr;
  logic [riscv_pkg::XLEN-1:0] reg_data;
  logic [riscv_pkg::XLEN-1:0] mem_addr;
  logic [riscv_pkg::XLEN-1:0] mem_data;
  logic                       mem_wrt;
  logic                       mem_read;

  real instr_cnt;
  real clock_cycle_cnt;
  real cpi;


  // DUT
  rv_pipelined 
    #(.IMemInitFile(IMemInitFile),
      .DMemInitFile(DMemInitFile))
  DUT (
    .clk_i(clk),
    .rstn_i(rstn),
    .addr_i(addr),
    .update_o(update),
    .data_o(data),
    .pc_o(pc),
    .instr_o(instr),
    .reg_addr_o(reg_addr),
    .reg_data_o(reg_data),
    .mem_addr_o(mem_addr),
    .mem_data_o(mem_data),
    .mem_wrt_o(mem_wrt),
    .mem_read_o(mem_read)
  );

  initial begin
    forever begin
      clk = 0;
      #1;
      clk = 1;
      #1;
    end
  end

  integer file_pointer;
  initial begin
    rstn = 0;
    instr_cnt = 0;
    clock_cycle_cnt = 0;
    #4;
    rstn = 1;
    file_pointer = $fopen("model.log", "w");
    while(instr != 0) begin
      if(update) begin
        instr_cnt = instr_cnt + 1;
        if(instr[6:0] == OpcodeStore) begin
          case(instr[14:12])
            3'b000: $fdisplay(file_pointer, "0x%8h (0x%8h) mem 0x%8h 0x%h", pc, instr, mem_addr, mem_data[7:0]);
            3'b001: $fdisplay(file_pointer, "0x%8h (0x%8h) mem 0x%8h 0x%h", pc, instr, mem_addr, mem_data[15:0]);
            3'b010: $fdisplay(file_pointer, "0x%8h (0x%8h) mem 0x%8h 0x%8h", pc, instr, mem_addr, mem_data);
          endcase
        end else if(instr[6:0] == OpcodeLoad) begin
          if(reg_addr>9)begin
              $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d 0x%8h mem 0x%8h", pc, instr, reg_addr, reg_data, mem_addr);
          end else begin
              $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d  0x%8h mem 0x%8h", pc, instr, reg_addr, reg_data, mem_addr);
          end
        end else begin
          if ((reg_addr == 0) | (instr[6:0] == OpcodeBranch)) begin
            $fdisplay(file_pointer, "0x%8h (0x%8h)", pc, instr);
          end else begin
            if (reg_addr>9) begin
              $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d 0x%8h", pc, instr, reg_addr, reg_data); 
            end else begin
              $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d  0x%8h", pc, instr, reg_addr, reg_data);
            end
          end
        end
      end
      clock_cycle_cnt = clock_cycle_cnt + 1;
      #2;
    end
    cpi = clock_cycle_cnt/instr_cnt;
    $fdisplay(file_pointer, "============================================");
    $fdisplay(file_pointer, "CPI: %f", cpi);
    $fdisplay(file_pointer, "============================================");
    $finish;
  end
endmodule
