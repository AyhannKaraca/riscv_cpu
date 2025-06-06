module memory
  import riscv_pkg::*;
(
    input  logic             clk_i,
    input  logic             rstn_i,
    input  logic             stallM_i,
    input  logic             flushD_E_M_i,
    input  logic             flushE_M_i,
    input  logic  [XLEN-1:0] pcM_i,
    input  logic  [XLEN-1:0] instrM_i,
    input  operation_e       operationM_i,
    input  rd_port_t         rdM_port_i,
    input  logic  [XLEN-1:0] addrM_i, //
    input  logic             memM_wrt_ena_i,
    input  logic  [XLEN-1:0] memM_wrt_addr_i,
    input  logic  [XLEN-1:0] memM_wrt_data_i,
    output logic  [XLEN-1:0] pcM_o,
    output logic  [XLEN-1:0] instrM_o,
    output logic  [XLEN-1:0] memM_wrt_addr_o,
    output logic  [XLEN-1:0] memM_wrt_data_o,
    output rd_port_t         rdM_port_o,
    output logic  [XLEN-1:0] dataM_o,//
    output logic             stallM_o,//
    output logic             flushD_E_M_o,//
    output logic             flushE_M_o//
);

    parameter int MEM_SIZE = 2048;
    logic [31:0]     dmem [MEM_SIZE-1:0];
    rd_port_t        rd_port_d;

    assign rd_port_d.addr = rdM_port_i.addr;
    assign rd_port_d.valid = rdM_port_i.valid;
    assign dataM_o = dmem[addrM_i];

    always_comb begin : load_execute
        rd_port_d.data = rdM_port_i.data;
        case(operationM_i)
          LB:  begin
            rd_port_d.data = {{24'(signed'({dmem[memM_wrt_addr_i[$clog2(MEM_SIZE)-1:0]][7]}))}, dmem[memM_wrt_addr_i[$clog2(MEM_SIZE)-1:0]][7:0]};
          end 
          LH  : begin
            rd_port_d.data = {{16'(signed'({dmem[memM_wrt_addr_i[$clog2(MEM_SIZE*2)-1:1]][15]}))}, dmem[memM_wrt_addr_i[$clog2(MEM_SIZE*2)-1:1]][15:0]};
          end
          LW  : begin
            rd_port_d.data = dmem[memM_wrt_addr_i[$clog2(MEM_SIZE*4)-1:2]];
          end 
          LBU : begin
            rd_port_d.data = {{24'b0}, dmem[memM_wrt_addr_i[$clog2(MEM_SIZE)-1:0]][7:0]};
          end
          LHU : begin
            rd_port_d.data = {{16'b0}, dmem[memM_wrt_addr_i[$clog2(MEM_SIZE*2)-1:1]][15:0]};
          end
          default : ;
        endcase
    end

    always_ff @(posedge clk_i) begin
        if (!rstn_i) begin
            for(int i = 0; i<MEM_SIZE; ++i)begin
                dmem[i] = '0; //There is an issue about verilator 
            end
        end else if (memM_wrt_ena_i) begin
          case(operationM_i)
            SB :         dmem[memM_wrt_addr_i[$clog2(MEM_SIZE)-1:0]][7:0]   <= memM_wrt_data_i[ 7:0];
            SH :         dmem[memM_wrt_addr_i[$clog2(MEM_SIZE*2)-1:1]][15:0] <= memM_wrt_data_i[15:0];
            SW :         dmem[memM_wrt_addr_i[$clog2(MEM_SIZE*4)-1:2]] <= memM_wrt_data_i;
            default:     dmem[0] <= '0;
          endcase
        end
      end
    
      //MEM-WB
    always_ff @(posedge clk_i) begin
        if (!rstn_i) begin
            pcM_o           <= '0;
            instrM_o        <= '0;
            rdM_port_o      <= '0;
            stallM_o        <= '0;
            memM_wrt_addr_o <= '0;
            memM_wrt_data_o <= '0;
            flushD_E_M_o    <= '0;
            flushE_M_o      <= '0;
        end else begin
            pcM_o           <= pcM_i;
            instrM_o        <= instrM_i;
            rdM_port_o      <= rd_port_d;
            stallM_o        <= stallM_i;
            flushD_E_M_o    <= flushD_E_M_i;
            flushE_M_o      <= flushE_M_i;
            memM_wrt_addr_o <= memM_wrt_addr_i;
            memM_wrt_data_o <= memM_wrt_data_i; 
        end
    end
endmodule
