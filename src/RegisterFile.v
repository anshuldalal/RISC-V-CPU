module RegisterFile
// Ports
(
    input               clk_i,
    input               reset,
    input   [4:0]       RSaddr_i,
    input   [4:0]       RTaddr_i,
    input   [4:0]       RDaddr_i,
    input   [31:0]      RDdata_i,
    input               RegWrite_i,
    output  [31:0]      RSdata_o, 
    output  [31:0]      RTdata_o
);
    
integer i;    
// Register File
reg     [31:0]      register        [0:31];

// Read Data      // mem[x00] = 0
assign  RSdata_o = (RSaddr_i==0) ? 32'd0 : register[RSaddr_i];
assign  RTdata_o = (RTaddr_i==0) ? 32'd0 : register[RTaddr_i];

// Write Data on negedges to overcome structural hazards
always@(negedge clk_i or posedge reset)begin
    if(reset) begin
        for(i=0;i<32;i=i+1)
            register[i] <= 0;
    end  
    else  begin
        if(RegWrite_i && RDaddr_i != 0)   // can't write @x00
            register[RDaddr_i] <= RDdata_i;
        end
    end      
end
   
endmodule 
