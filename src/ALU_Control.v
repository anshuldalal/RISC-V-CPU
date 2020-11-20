module ALU_Control
(
    input       [9:0] funct_i,  //   funct7 = funct_i[9:3], funct3 = funct_i[2:0]
    input       [1:0] ALUOp_i,  //   00 for addi
    output reg  [2:0] ALUCtrl_o
);
    
always@(*)begin

  case(ALUOp_i)

    2'b11 : begin   // immediate ?????????????  // should be removed
               case(funct_i[2:0])
                    3'000 : ALUCtrl_o = 3'b;    // ADDI                          
                    3'001 : ALUCtrl_o = 3'b;    // SLLI
                    3'100 : ALUCtrl_o = 3'b;    // XORI
                    3'101 : ALUCtrl_o = (funct_i[9:3] == 0) ? 3'b : 3'b ;    // SRLI : SRAI
                    3'110 : ALUCtrl_o = 3'b;    // ORI
                    3'111 : ALUCtrl_o = 3'b;    // ANDI
                    default         : ALUCtrl_o = 3'b001;
               endcase
            end
            
    2'b10 : begin   // R-Type and I - Type too ????????????????? 
                case(funct_i)
                    10'b0000000_000 : ALUCtrl_o = 3'b001;    // ADD                          
                    10'b0100000_000 : ALUCtrl_o = 3'b010;    // SUB
                    10'b0000000_001 : ALUCtrl_o = 3'b;       // SLL
                    10'b0000000_100 : ALUCtrl_o = 3'b;       // XOR
                    10'b0000000_101 : ALUCtrl_o = 3'b;    // SRL
                    10'b0100000_101 : ALUCtrl_o = 3'b;       // SRA
                    10'b0000000_110 : ALUCtrl_o = 3'b;    // OR
                    10'b0000000_111 : ALUCtrl_o = 3'b;       // AND
                    default         : ALUCtrl_o = 3'b001;
               endcase
            end

    2'b01 : begin // B-Type Branch 
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
