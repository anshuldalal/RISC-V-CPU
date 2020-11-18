module ForwardingUnit
(
    input			    EX_MEM_RegWrite_i, MEM_WB_RegWrite_i,
    input	    [4:0]	ID_EX_RS_i, ID_EX_RT_i, 
    input	    [4:0]   EX_MEM_RD_i, MEM_WB_RD_i,
    output reg	[1:0]	ForwardA_o, ForwardB_o
);

always@(*)begin
    
    ForwardA_o = 2'b00;
    
    // Forwarding from EX stage
    if(EX_MEM_RegWrite_i && (EX_MEM_RD_i != 5'b00000) && (EX_MEM_RD_i == ID_EX_RS_i)) 
            ForwardA_o = 2'b10;
    
    // Forwarding from MEM stage
    else if (MEM_WB_RegWrite_i && (MEM_WB_RD_i != 5'b00000) &&
             ~(EX_MEM_RegWrite_i && (EX_MEM_RD_i != 5'b000000) && (EX_MEM_RD_i == ID_EX_RS_i)) && // conflict of forwarding when RD in EX and MEM stage are same
             MEM_WB_RD_i == ID_EX_RS_i)  
                ForwardA_o = 2'b01;
end

always@(*)begin    
    
    ForwardB_o = 2'b00;
 
    // Forwarding from EX stage   
    if(EX_MEM_RegWrite_i && (EX_MEM_RD_i != 5'b00000) && (EX_MEM_RD_i == ID_EX_RT_i)) 
           ForwardB_o = 2'b10;
    
    // Forwarding from MEM stage
    else if (MEM_WB_RegWrite_i && (MEM_WB_RD_i != 5'b00000) &&
             ~(EX_MEM_RegWrite_i && (EX_MEM_RD_i != 5'b000000) &&  (EX_MEM_RD_i == ID_EX_RS_i)) && // conflict of forwarding when RD in EX and MEM stage are same
             MEM_WB_RD_i == ID_EX_RT_i)  
                ForwardB_o = 2'b01;
end
    
endmodule
