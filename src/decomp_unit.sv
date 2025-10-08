module decomp_unit
import riscv_pkg::*;
(
    input  logic [    15:0] comp_instr_i,
    output logic [XLEN-1:0] decomp_instr_o
);

always_comb begin
    decomp_instr_o = 32'b0;
    case ({comp_instr_i[15:13], comp_instr_i[1:0]})
        /* c.addi4spn ---------------------------------------------------------------------*/
        5'b00000: begin
					decomp_instr_o = {2'b00, comp_instr_i[10:7], comp_instr_i[12:11], comp_instr_i[5], comp_instr_i[6], 2'b00, 5'd2, 3'b000, 2'b01, comp_instr_i[4:2], 7'b0010011};
					if(comp_instr_i == '0) begin
						decomp_instr_o = '0;
					end
        end
        /* c.lw ---------------------------------------------------------------------------*/
        5'b01000: decomp_instr_o = {5'b00000, comp_instr_i[5], comp_instr_i[12:10], comp_instr_i[6], 2'b00, 2'b01, comp_instr_i[9:7], 3'b010, 2'b01, comp_instr_i[4:2], 7'b0000011};
        /* c.sw ---------------------------------------------------------------------------*/
        5'b11000: decomp_instr_o = {5'b00000, comp_instr_i[5], comp_instr_i[12], 2'b01, comp_instr_i[4:2], 2'b01, comp_instr_i[9:7], 3'b010, comp_instr_i[11:10], comp_instr_i[6], 2'b00, 7'b0100011};
        5'b00001: begin
            /* c.nop ----------------------------------------------------------------------*/
            if (comp_instr_i[12:2] == 11'b0)
                decomp_instr_o = {25'b0, 7'b0010011};
                /* c.addi --------------------------------------------------------------------*/
            else decomp_instr_o = {{7{comp_instr_i[12]}}, comp_instr_i[6:2], comp_instr_i[11:7], 3'b000, comp_instr_i[11:7], 7'b0010011};
        end
        /* c.jal --------------------------------------------------------------------------*/
        5'b00101: decomp_instr_o = {comp_instr_i[12], comp_instr_i[8], comp_instr_i[10:9], comp_instr_i[6], comp_instr_i[7], comp_instr_i[2], comp_instr_i[11], comp_instr_i[5:3], comp_instr_i[12], {8{comp_instr_i[12]}}, 5'd1, 7'b1101111};
        /* c.li ---------------------------------------------------------------------------*/
        5'b01001: decomp_instr_o = {{7{comp_instr_i[12]}}, comp_instr_i[6:2], 5'd0, 3'b000, comp_instr_i[11:7], 7'b0010011};
        5'b01101: begin
            /* c.addi16sp ------------------------------------------------------------------*/
            if (comp_instr_i[11:7] == 5'd2)
                decomp_instr_o = {{3{comp_instr_i[12]}}, comp_instr_i[4], comp_instr_i[3], comp_instr_i[5], comp_instr_i[2], comp_instr_i[6], 4'b0000, 5'd2, 3'b000, 5'd2, 7'b0010011};
                /* c.lui -----------------------------------------------------------------------*/
            else decomp_instr_o = {{15{comp_instr_i[12]}}, comp_instr_i[6:2], comp_instr_i[11:7], 7'b0110111};
        end
        5'b10001: begin
            /* c.sub --------------------------------------------------------------------*/
            if (comp_instr_i[12:10] == 3'b011 && comp_instr_i[6:5] == 2'b00)
                decomp_instr_o = {7'b0100000, 2'b01, comp_instr_i[4:2], 2'b01, comp_instr_i[9:7], 3'b000, 2'b01, comp_instr_i[9:7], 7'b0110011};
                /* c.xor --------------------------------------------------------------------*/
            else if (comp_instr_i[12:10] == 3'b011 && comp_instr_i[6:5] == 2'b01)
                decomp_instr_o = {7'b0000000, 2'b01, comp_instr_i[4:2], 2'b01, comp_instr_i[9:7], 3'b100, 2'b01, comp_instr_i[9:7], 7'b0110011};
                /* c.or --------------------------------------------------------------------*/
            else if (comp_instr_i[12:10] == 3'b011 && comp_instr_i[6:5] == 2'b10)
                decomp_instr_o = {7'b0000000, 2'b01, comp_instr_i[4:2], 2'b01, comp_instr_i[9:7], 3'b110, 2'b01, comp_instr_i[9:7], 7'b0110011};
                /* c.and --------------------------------------------------------------------*/
            else if (comp_instr_i[12:10] == 3'b011 && comp_instr_i[6:5] == 2'b11)
                decomp_instr_o = {7'b0000000, 2'b01, comp_instr_i[4:2], 2'b01, comp_instr_i[9:7], 3'b111, 2'b01, comp_instr_i[9:7], 7'b0110011};
                /* c.andi --------------------------------------------------------------------*/
            else if (comp_instr_i[11:10] == 2'b10)
                decomp_instr_o = {{7{comp_instr_i[12]}}, comp_instr_i[6:2], 2'b01, comp_instr_i[9:7], 3'b111, 2'b01, comp_instr_i[9:7], 7'b0010011};
                /* c.srli --------------------------------------------------------------------*/
            else if (comp_instr_i[11:10] == 2'b00)
                decomp_instr_o = {7'b0000000, comp_instr_i[6:2], 2'b01, comp_instr_i[9:7], 3'b101, 2'b01, comp_instr_i[9:7], 7'b0010011};
                /* c.srai --------------------------------------------------------------------*/
            else
                decomp_instr_o = {7'b0100000, comp_instr_i[6:2], 2'b01, comp_instr_i[9:7], 3'b101, 2'b01, comp_instr_i[9:7], 7'b0010011};
        end
        /* c.j -----------------------------------------------------------------------*/
        5'b10101: decomp_instr_o = {comp_instr_i[12], comp_instr_i[8], comp_instr_i[10:9], comp_instr_i[6], comp_instr_i[7], comp_instr_i[2], comp_instr_i[11], comp_instr_i[5:3], comp_instr_i[12], {8{comp_instr_i[12]}}, 5'd0, 7'b1101111};
        /* c.beqz --------------------------------------------------------------------*/
        5'b11001: decomp_instr_o = {{4{comp_instr_i[12]}}, comp_instr_i[6], comp_instr_i[5], comp_instr_i[2], 5'd0, 2'b01, comp_instr_i[9:7], 3'b000, comp_instr_i[11], comp_instr_i[10], comp_instr_i[4], comp_instr_i[3], comp_instr_i[12], 7'b1100011};
        /* c.bnez --------------------------------------------------------------------*/
        5'b11101: decomp_instr_o = {{4{comp_instr_i[12]}}, comp_instr_i[6], comp_instr_i[5], comp_instr_i[2], 5'd0, 2'b01, comp_instr_i[9:7], 3'b001, comp_instr_i[11], comp_instr_i[10], comp_instr_i[4], comp_instr_i[3], comp_instr_i[12], 7'b1100011};
        /* c.slli --------------------------------------------------------------------*/
        5'b00010: decomp_instr_o = {7'b0000000, comp_instr_i[6:2], comp_instr_i[11:7], 3'b001, comp_instr_i[11:7], 7'b0010011};
        /* c.lwsp --------------------------------------------------------------------*/
        5'b01010: decomp_instr_o = {4'b0000, comp_instr_i[3:2], comp_instr_i[12], comp_instr_i[6:4], 2'b0, 5'd2, 3'b010, comp_instr_i[11:7], 7'b0000011};
        /* c.swsp --------------------------------------------------------------------*/
        5'b11010: decomp_instr_o = {4'b0000, comp_instr_i[8:7], comp_instr_i[12], comp_instr_i[6:2], 5'd2, 3'b010, comp_instr_i[11:9], 2'b00, 7'b0100011};
        5'b10010: begin
            if (comp_instr_i[6:2] == 5'd0) begin
                /* c.jalr --------------------------------------------------------------------*/
                if (comp_instr_i[12] && comp_instr_i[11:7] != 5'b0)
                    decomp_instr_o = {12'b0, comp_instr_i[11:7], 3'b000, 5'd1, 7'b1100111};
                    /* c.jr --------------------------------------------------------------------*/
                else decomp_instr_o = {12'b0, comp_instr_i[11:7], 3'b000, 5'd0, 7'b1100111};
            end 
            else if (comp_instr_i[11:7] != 5'b0) begin
                /* c.mv --------------------------------------------------------------------*/
                if (comp_instr_i[12] == 1'b0)
                    decomp_instr_o = {7'b0000000, comp_instr_i[6:2], 5'd0, 3'b000, comp_instr_i[11:7], 7'b0110011};
                    /* c.add --------------------------------------------------------------------*/
                else decomp_instr_o = {7'b0000000, comp_instr_i[6:2], comp_instr_i[11:7], 3'b000, comp_instr_i[11:7], 7'b0110011};
            end
        end
    endcase
end
endmodule
