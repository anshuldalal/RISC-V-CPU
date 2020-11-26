module HazradDetect
(
    input        ID_EX_MemRead_i,
    input  [4:0] IF_ID_RS_i, 
    input  [4:0] IF_ID_RT_i, 
    input  [4:0] ID_EX_RD_i,
    output       Hazard_o   // stall
);
    // logic to detect load-use data hazard and stall the pipeline
    assign Hazard_o = ((ID_EX_MemRead_i && (ID_EX_RD_i == IF_ID_RS_i || ID_EX_RD_i == IF_ID_RT_i))? 1'b1 : 1'b0);

endmodule
