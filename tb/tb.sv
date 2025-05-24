module tb ();
    logic [riscv_pkg::XLEN-1:0] addr;
    logic [riscv_pkg::XLEN-1:0] data;
    logic [riscv_pkg::XLEN-1:0] pc;
    logic [riscv_pkg::XLEN-1:0] instr;
    logic [                4:0] reg_addr;
    logic [riscv_pkg::XLEN-1:0] reg_data;
    logic stall;
    logic clk;
    logic rstn;

    core_model i_core_model(
        .clk_i(clk),
        .rstn_i(rstn),
        .addr_i(addr),
        .data_o(data),
        .pc_o(pc),
        .instr_o(instr),
        .reg_addr_o(reg_addr),
        .reg_data_o(reg_data),
        .stall_o(stall)

    );
    integer file_pointer;
    initial begin
        file_pointer = $fopen("model.log", "w");
        #4
        forever begin
            if (rstn) begin
                if (reg_addr == 0) begin
                    if(stall) begin
                        $fdisplay(file_pointer, "0x%8h (0x%8h) --STALL--", pc, instr);
                    end else begin
                        $fdisplay(file_pointer, "0x%8h (0x%8h)", pc, instr);
                    end   
                end else begin
                    if (reg_addr>9) begin
                        if(stall) begin
                            $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d 0x%8h --STALL--", pc, instr, reg_addr, reg_data);
                        end else begin
                            $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d 0x%8h", pc, instr, reg_addr, reg_data);
                        end
                    end else begin
                        if(stall)begin
                            $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d  0x%8h --STALL--", pc, instr, reg_addr, reg_data);
                        end else begin
                            $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d  0x%8h", pc, instr, reg_addr, reg_data);
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
        #4000;//4000;
        for (int i=0; i<10; i++) begin
            addr = i*4;
            $display("data @ mem[0x%8h] = %8h", i, data);
        end
        $finish;
    end

        
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars();
   end
    
endmodule
