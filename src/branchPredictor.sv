module branchPredictor #(
    parameter int BTB_ENTRIES    = 64,
    parameter int TARGET_WIDTH   = 32,
    parameter int COUNTER_WIDTH  = 2,           
    parameter int INDEX_WIDTH    = $clog2(BTB_ENTRIES), //6
    parameter int TAG_WIDTH      = 32 - INDEX_WIDTH     //26
  )(
    input  logic                    clk_i,
    input  logic                    rstn_i,
    input  logic [31:0]             fetchPc_i,
    output logic                    fetchHit_o,
    output logic [TARGET_WIDTH-1:0] fetchTarget_o,
    input  logic                    exTaken_i,
    input  logic [31:0]             exPc_i,
    input  logic [TARGET_WIDTH-1:0] exTarget_i
  );

  // Memory layout: [TAG | TARGET | COUNTER | VALID]
  localparam int VALID_BIT     = 0;
  localparam int COUNTER_LSB   = VALID_BIT + 1;
  localparam int COUNTER_MSB   = COUNTER_LSB + COUNTER_WIDTH - 1;
  localparam int TARGET_LSB    = COUNTER_MSB + 1;
  localparam int TARGET_MSB    = TARGET_LSB + TARGET_WIDTH - 1;
  localparam int TAG_LSB       = TARGET_MSB + 1;
  localparam int TAG_MSB       = TAG_LSB + TAG_WIDTH - 1;
  localparam int MEM_WIDTH     = TAG_MSB + 1;

  logic [MEM_WIDTH-1:0] btb_mem [BTB_ENTRIES-1:0];

  logic [INDEX_WIDTH-1:0] fetchIndex, exIndex;
  logic [TAG_WIDTH-1:0] fetchTag, exTag;
  logic [TAG_WIDTH-1:0] fetchTagBtb, exTagBtb;
  logic [COUNTER_WIDTH-1:0] fetchCounter, exCounter;

  logic [MEM_WIDTH-1:0] fetchEntry, exEntry_, exEntryUpdated;
  logic [1:0] count, nextCount;
  logic exHit;

  assign fetchIndex = fetchPc_i[INDEX_WIDTH:1]; 
  assign exIndex    = exPc_i[INDEX_WIDTH:1];

  assign fetchEntry = btb_mem[fetchIndex]; 
  assign exEntry_   = btb_mem[exIndex];    

  assign fetchTag   = fetchPc_i[31:INDEX_WIDTH]; 
  assign exTag      = exPc_i[31:INDEX_WIDTH];    
 
  assign fetchTagBtb = fetchEntry[TAG_MSB:TAG_LSB]; 
  assign exTagBtb    = exEntry_[TAG_MSB:TAG_LSB];   

  assign fetchCounter = fetchEntry[COUNTER_MSB:COUNTER_LSB]; 
  assign exCounter    = exEntry_[COUNTER_MSB:COUNTER_LSB];   

  assign fetchHit_o    = fetchEntry[VALID_BIT] && (fetchTagBtb == fetchTag) && (!fetchCounter[0]); 
  assign fetchTarget_o = fetchEntry[TARGET_MSB:TARGET_LSB]; 
  assign exHit       = exEntry_[VALID_BIT] && (exTagBtb == exTag);
  assign count       = exCounter;

  localparam [1:0]
             sTaken = 2'b10,
             wTaken = 2'b00, //default taken
             wNtaken = 2'b01,
             sNtaken = 2'b11;


  always_comb
  begin
    case (count)
      wTaken:
        nextCount = exTaken_i ? sTaken : wNtaken;
      sTaken:
        nextCount = exTaken_i ? sTaken : wTaken;
      wNtaken:
        nextCount = exTaken_i ? wTaken : sNtaken;
      sNtaken:
        nextCount = exTaken_i ? wNtaken : sNtaken;
      default:
        nextCount = wTaken;
    endcase
  end

  always_comb
  begin
    exEntryUpdated = '0;
    if (exHit)
    begin
      exEntryUpdated = exEntry_;
      exEntryUpdated[COUNTER_MSB:COUNTER_LSB] = nextCount;
    end
    else if (exTaken_i)
    begin
      exEntryUpdated[VALID_BIT]               = 1'b1;
      exEntryUpdated[TAG_MSB:TAG_LSB]         = exTag;
      exEntryUpdated[TARGET_MSB:TARGET_LSB]   = exTarget_i;
      exEntryUpdated[COUNTER_MSB:COUNTER_LSB] = wTaken;
    end
  end

  always_ff @(posedge clk_i) begin
    if (!rstn_i) begin
      for (int i=0; i<BTB_ENTRIES; ++i) begin
        btb_mem[i] <= '0;
      end
    end else begin
      if (exHit | exTaken_i) begin
        btb_mem[exIndex] <= exEntryUpdated;
      end
    end
  end

endmodule
