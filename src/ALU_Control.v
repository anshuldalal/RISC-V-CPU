module ALU_Control
(
    input       [9:0] funct_i,  //   funct7 = funct_i[9:3], funct3 = funct_i[2:0]
    input       [1:0] ALUOp_i,  //   00 for addi
    output reg  [3:0] ALUCtrl_o
);
    
always@(*)begin

  case(ALUOp_i)
           
    2'b10, 2'b11 : begin   // R-Type and I - Type too ????????????????? 
                    case(funct_i[2:0])
                        3'000 : begin 
                                if(ALUOp_i==2'b10) // R-Type
                                    ALUCtrl_o = (funct_i[9:3] == 0) ? 4'b0000 : 4'b0001;    // ADD : SUB
                                else ALUCtrl_o = 4'b0000;    // ADDI                         
                        3'001 : ALUCtrl_o = 4'b0010;    // SLL
                        3'100 : ALUCtrl_o = 4'b0011;    // XOR
                            3'101 : ALUCtrl_o = (funct_i[9:3] == 0) ? 4'b0100 : 4'b0101 ;    // SRL : SRA
                        3'110 : ALUCtrl_o = 4'b0110;    // ORI
                        3'111 : ALUCtrl_o = 4'b0111;    // ANDI
                        default : ALUCtrl_o = 4'b0000; // default add ??
                    endcase
                  end
    2'b01       : begin // B-Type Branch 
                   case(funct_i[2:0])
                        3'000 : ALUCtrl_o = 4'b0001;    // BEQ                
                        3'001 : ALUCtrl_o = 4'b0001;    // BNE
                        3'100 : ALUCtrl_o = 4'b1000;    // BLT signed 
                        3'101 : ALUCtrl_o = 4'b1001;    // BGE sgined
                        default : ALUCtrl_o = 4'b0001;
                   endcase
                 end
    default : begin
                ALUCtrl_o = 4'b0000;
              end
  endcase

end

endmodule
//not sure how to deal w/ ALUOp to o/p the corresponing code,
//stop by here
