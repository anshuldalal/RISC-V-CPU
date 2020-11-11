module Data_Memory
(
    input           clk_i,
    input           reset,
    input  [31:0]   addr_i,
    input  [31:0]   data_i,
    input           MemWrite_i, MemRead_i,
    output [31:0]   data_o
);
    
integer i;
reg [7:0] memory [0:31];    // 8 x 32
wire [31:0] op;

// Read, by default on posedges (as soon as addr_i updated)
assign data_o = (MemRead_i) ? op : 32'b0;
assign op = { memory[addr_i + 3], memory[addr_i + 2], memory[addr_i + 1], memory[addr_i]};

// Write   // Write on negedges to avoid write and read on the same cycle
always @(negedge clk_i or posedge reset) 
begin
    if(reset)
        for(i=0;i<32;i=i+1)
            memory[i] <= 0;
     else 
         if(MemWrite_i) begin
            memory[addr_i + 3] <= data_i[31:24];
            memory[addr_i + 2] <= data_i[23:16];
            memory[addr_i + 1] <= data_i[15:8];
            memory[addr_i]     <= data_i[7:0];
        end
end

endmodule
