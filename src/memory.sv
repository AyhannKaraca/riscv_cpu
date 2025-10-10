module memory
import riscv_pkg::*;
#(
  parameter DMemInitFile  = "dmem.mem" 
)(
    // ====
    input  logic  [XLEN-1:0] tb_addr_i,
    output logic  [XLEN-1:0] tb_data_o,
    output logic             tb_mem_wrt_o,
    output logic             tb_mem_read_o,

    //TB_UPDATE
    input  logic             tb_update_i,
    output logic             tb_update_o,
    // ====

    input  logic             clk_i,
    input  logic             rstn_i,


    input  logic  [XLEN-1:0] pcM_i,
    input  logic  [XLEN-1:0] instrM_i,

    input  alu_ctrl_e        operationM_i,
    
    input  logic  [XLEN-1:0] rdM_data_i,
    input  logic  [     4:0] rdM_addr_i,
    input  logic             rdM_wr_ena_i,

    input  logic             memM_wrt_ena_i,
    input  logic  [XLEN-1:0] memM_addr_i,
    input  logic  [XLEN-1:0] memM_wrt_data_i,

    output logic  [XLEN-1:0] pcM_o,
    output logic  [XLEN-1:0] instrM_o,

    output logic  [XLEN-1:0] memM_addr_o,
    output logic  [XLEN-1:0] memM_data_o,

    output logic  [XLEN-1:0] rdM_data_o,
    output logic  [     4:0] rdM_addr_o,
    output logic             rdM_wr_ena_o
);

    localparam int MEM_SIZE = 4096;
    logic [31:0]     dmem [MEM_SIZE-1:0];
    initial $readmemh(DMemInitFile, dmem);
    
    logic  [XLEN-1:0] memM_data_d;

    logic  [XLEN-1:0] rdM_data_d;
    logic  [     4:0] rdM_addr_d;
    logic             rdM_wr_ena_d;

    //=====
    logic [XLEN-1:0] tb_data_d;
    logic            tb_mem_wrt_d;
    logic            tb_mem_read_d;
    logic            tb_update_d;
    assign tb_data_d     = dmem[tb_addr_i[$clog2(MEM_SIZE)-1:0]];
    assign tb_mem_wrt_d  = (operationM_i inside {SB, SH, SW}) ? 1 : 0;
    assign tb_mem_read_d = (operationM_i inside {LB, LH, LBU, LHU, LW}) ? 1 : 0;
    assign tb_update_d   = (instrM_i == '0) ? 0 :  tb_update_i;
    
    //=====
    assign memM_data_d =(memM_wrt_ena_i) ? memM_wrt_data_i : dmem[memM_addr_i[$clog2(MEM_SIZE)-1:0]];

    assign rdM_addr_d   = rdM_addr_i;
    assign rdM_wr_ena_d = rdM_wr_ena_i;

    always_comb begin : load_execute
        rdM_data_d = rdM_data_i;
        case(operationM_i)
          LB:  begin
            rdM_data_d = {{24'(signed'({dmem[memM_addr_i[$clog2(MEM_SIZE)-1:0]][7]}))}, dmem[memM_addr_i[$clog2(MEM_SIZE)-1:0]][7:0]};
          end 
          LH  : begin
            rdM_data_d = {{16'(signed'({dmem[memM_addr_i[$clog2(MEM_SIZE)-1:0]][15]}))}, dmem[memM_addr_i[$clog2(MEM_SIZE)-1:0]][15:0]};
          end
          LW  : begin
            rdM_data_d = dmem[memM_addr_i[$clog2(MEM_SIZE)-1:0]];
          end 
          LBU : begin
            rdM_data_d = {{24'b0}, dmem[memM_addr_i[$clog2(MEM_SIZE)-1:0]][7:0]};
          end
          LHU : begin
            rdM_data_d = {{16'b0}, dmem[memM_addr_i[$clog2(MEM_SIZE)-1:0]][15:0]};
          end
          default : ;
        endcase
    end

    always_ff @(posedge clk_i) begin
        if (!rstn_i) begin
            for(int i = 0; i<MEM_SIZE; ++i)begin
                dmem[i] <= '0;  
            end
        end else if (memM_wrt_ena_i) begin
          case(operationM_i)
            SB :         dmem[memM_addr_i[$clog2(MEM_SIZE)-1:0]][7:0]    <= memM_wrt_data_i[ 7:0];
            SH :         dmem[memM_addr_i[$clog2(MEM_SIZE)-1:0]][15:0]   <= memM_wrt_data_i[15:0];
            SW :         dmem[memM_addr_i[$clog2(MEM_SIZE)-1:0]]         <= memM_wrt_data_i;
            default:     dmem[0] <= '0; 
          endcase
        end
      end
    
      //MEM-WB
    always_ff @(posedge clk_i) begin
        if (!rstn_i) begin
            pcM_o           <= 'h8000_0000;
            instrM_o        <= 'h00000013;
            memM_addr_o     <= '0;
            memM_data_o     <= '0;
            rdM_data_o      <= '0;
            rdM_addr_o      <= '0;
            rdM_wr_ena_o    <= 0;
            tb_update_o     <= 0;
            //=====
            tb_data_o       <= '0;    
            tb_mem_wrt_o    <= '0; 
            tb_mem_read_o   <= '0;
            tb_update_o     <= '0;  
            //=====
        end else begin
            pcM_o           <= pcM_i;
            instrM_o        <= instrM_i;
            memM_addr_o     <= memM_addr_i;
            memM_data_o     <= memM_data_d;
            rdM_data_o      <= rdM_data_d;
            rdM_addr_o      <= rdM_addr_d;
            rdM_wr_ena_o    <= rdM_wr_ena_d;
            tb_update_o     <= tb_update_d;
            //=====
            tb_data_o       <= tb_data_d;      
            tb_mem_wrt_o    <= tb_mem_wrt_d; 
            tb_mem_read_o   <= tb_mem_read_d;
            tb_update_o     <= tb_update_d;  
            //=====
        end
    end
endmodule
