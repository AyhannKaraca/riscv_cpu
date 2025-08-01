module tb ();
    logic [riscv_pkg::XLEN-1:0] pc;
    logic [riscv_pkg::XLEN-1:0] instr;
    logic [                4:0] reg_addr;
    logic [riscv_pkg::XLEN-1:0] reg_data;
    logic [riscv_pkg::XLEN-1:0] mem_data;
    logic [riscv_pkg::XLEN-1:0] mem_addr;
    logic stall;
    logic flushD;
    logic flushE;
    logic clk;
    logic rstn;

    core_model i_core_model(
        .clk_i(clk),
        .rstn_i(rstn),
        .pc_o(pc),
        .instr_o(instr),
        .reg_addr_o(reg_addr),
        .reg_data_o(reg_data),
        .mem_data_o(mem_data),
        .mem_addr_o(mem_addr),
        .stall_o(stall),
        .flushD_o(flushD),
        .flushE_o(flushE)
    );
    integer file_pointer;
    initial begin
        file_pointer = $fopen("model.log", "w");
        #4
        forever begin
            if (rstn) begin
                if(instr[6:0] == 7'b0100011) begin
                    case(instr[14:12])
                        3'b000: $fdisplay(file_pointer, "0x%8h (0x%8h) mem 0x%8h 0x%h", pc, instr, mem_addr, mem_data[7:0]);
                        3'b001: $fdisplay(file_pointer, "0x%8h (0x%8h) mem 0x%8h 0x%h", pc, instr, mem_addr, mem_data[15:0]);
                        3'b010: $fdisplay(file_pointer, "0x%8h (0x%8h) mem 0x%8h 0x%8h", pc, instr, mem_addr, mem_data);
                    endcase
                end else if(instr[6:0] == 7'b0000011) begin
                    if(reg_addr>9)begin
                        $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d 0x%8h mem 0x%8h", pc, instr, reg_addr, reg_data, mem_addr);
                    end else begin
                        $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d  0x%8h mem 0x%8h", pc, instr, reg_addr, reg_data, mem_addr);
                    end       
                end else begin
                    if (reg_addr == 0) begin
                        if(stall) begin
                            $fdisplay(file_pointer, "0x%8h (0x%8h) --STALL--", pc, instr);
                        end else if(flushD || flushE)
                             $fdisplay(file_pointer, "0x%8h (0x%8h) --FLUSH--", pc, instr);
                        else begin
                            $fdisplay(file_pointer, "0x%8h (0x%8h)", pc, instr);
                        end   
                    end else begin
                        if (reg_addr>9) begin
                            if(stall) begin
                                $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d 0x%8h --STALL--", pc, instr, reg_addr, reg_data);
                            end else if(flushD || flushE)
                                $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d 0x%8h --FLUSH--", pc, instr, reg_addr, reg_data);
                            else begin
                                $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d 0x%8h", pc, instr, reg_addr, reg_data);
                            end
                        end else begin
                            if(stall)begin
                                $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d  0x%8h --STALL--", pc, instr, reg_addr, reg_data);
                            end else if(flushD || flushE)
                                $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d  0x%8h --FLUSH--", pc, instr, reg_addr, reg_data);
                            else begin
                                $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d  0x%8h", pc, instr, reg_addr, reg_data);
                            end 
                        end
                    end
                end
                #2;
            end
        end
    end
    initial forever begin
        clk = 0;
        #1;
        clk = 1;
        #1;
    end
    initial begin
        rstn = 0;
        #4;
        rstn = 1;
        #1000;//4000;
        $finish;
    end

        
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars();
   end
    
endmodule
