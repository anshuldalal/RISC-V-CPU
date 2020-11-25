module Immediate_Extend
(    
    input      [11:0] immI_i,immS_i,
    input      [19:0] immU_i,
    input      [19:0] immJ_i,
    input      [1:0]  select_i,
    output reg [31:0] data_o
);
    
// assign data_o = (select_i)? {{20{data1_i[11]}},data1_i} : {{20{data0_i[11]}},data0_i} ; 

always@(*) begin
    case (select_i)
        2'b00 : data_o = { {20{immI_i[11]}}, immI_i };       // I Type
        2'b01 : data_o = { {20{immS_i[11]}}, immS_i };       // S Type
        2'b10 : data_o = { immU_i, 12'b000000000000};        // U Type
        2'b11 : data_o = { {11{immJ_i[19]}}, immJ_i, 1'b0 }; // J Type 
    endcase
end
    
endmodule
