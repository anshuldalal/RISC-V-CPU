module ALU_Control
(
    input       [9:0] funct_i,  //  { funct7 (Instr[9:3]), funct3 (Instr[2:0]) }
    input       [1:0] ALUOp_i,  //00 for addi
    output reg  [2:0] ALUCtrl_o
);
    
always@(*)begin

  case(ALUOp_i)

    2'b11 : begin   // immediate ?????????????  
                ALUCtrl_o = 3'b001;//add
            end
            
    2'b10 : begin
        case(funct_i)
            
            10'b0000000_000 : ALUCtrl_o = 3'b001;    // ADD                          
            10'b0100000_000 : ALUCtrl_o = 3'b010;    // SUB
            10'b0000000_001 : ALUCtrl_o = 3'b;       // SLL
            10'b0000000_100 : ALUCtrl_o = 3'b;       // XOR
            10'b0000000_101 : ALUCtrl_o = 3'b011;    // SRL
            10'b0100000_101 : ALUCtrl_o = 3'b;       // SRA
            10'b0000000_110 : ALUCtrl_o = 3'b011;    // OR
            10'b0000000_111 : ALUCtrl_o = 3'b;       // AND
                       
            default        : ALUCtrl_o = 3'b001;
        
        endcase
    end

    2'b01 : begin //beq,ALU do subtraction
               ALUCtrl_o = 3'b010;//sub
            end
    default : begin
                ALUCtrl_o = 3'b001;
              end
endcase

end

endmodule
//not sure how to deal w/ ALUOp to o/p the corresponing code,
//stop by here
