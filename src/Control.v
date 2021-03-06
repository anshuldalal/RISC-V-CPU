module Control
(    
    input       [6:0]  Op_i;
    output  reg [1:0]  ALUOp_o;
    output  reg        ALUSrc_o,immSelect_o;
    output  reg        RegWrite_o ,MemRd_o,MemWr_o,MemToReg_o;
);

always@(*)begin
 case(Op_i)

  7'b0010011 : begin // I-Type, Redundant except for ALUSrc_o = 1
                    ALUOp_o = 2'b11;    // all instr of I and R-types have same funct_3
                    ALUSrc_o = 1'b1;
                    RegWrite_o = 1'b1;
                    MemRd_o = 1'b0;
                    MemWr_o = 1'b0;
                    MemToReg_o = 1'b0;
                    immSelect_o = 1'b0;
               end
      
  7'b0110011 : begin // R-Type
                    ALUOp_o = 2'b10;
                    ALUSrc_o = 1'b0;
                    RegWrite_o = 1'b1;
                    MemRd_o = 1'b0;
                    MemWr_o = 1'b0;
                    MemToReg_o = 1'b0;
                    immSelect_o = 1'b0;
               end

  7'b1100011 : begin // B-Type 
                    ALUOp_o = 2'b01;
                    ALUSrc_o = 1'b1;
                    RegWrite_o = 1'b0;
                    MemRd_o = 1'b0;
                    MemWr_o = 1'b0;
                    MemToReg_o = 1'b0;
                    immSelect_o = 1'b0;
               end

  7'b0000011 : begin // Load
                    ALUOp_o = 2'b00;
                    ALUSrc_o = 1'b1;
                    MemRd_o = 1'b1;
                    MemToReg_o = 1'b1;
                    RegWrite_o = 1'b1;
                    MemWr_o = 1'b0;
                    immSelect_o = 1'b0;
               end

  7'b0100011 : begin // Store
                    ALUOp_o = 2'b00;
                    ALUSrc_o = 1'b1;
                    MemWr_o = 1'b1;
                    RegWrite_o = 1'b0;
                    MemRd_o = 1'b0;
                    MemToReg_o = 1'b0;
                    immSelect_o = 1'b1;
                end

  7'b0000011 : begin // LUI
                    ALUOp_o = 2'b00;
                    ALUSrc_o = 1'b1;
                    MemRd_o = 1'b0;
                    MemToReg_o = 1'b0;
                    RegWrite_o = 1'b1;
                    MemWr_o = 1'b0;
      immSelect_o = 1'b0;// extend for jal and lui ?????????????????????????????????????
               end
  
  7'b0000011 : begin // JAL
                    ALUOp_o = 2'b00;
                    ALUSrc_o = 1'b;
                    MemRd_o = 1'b;
                    MemToReg_o = 1'b;
                    RegWrite_o = 1'b;
                    MemWr_o = 1'b;
                    immSelect_o = 1'b;
               end
   
  endcase

end
    
endmodule

