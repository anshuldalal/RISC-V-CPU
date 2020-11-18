module ALU 
(  
  input       [31:0]  data1_i, data2_i,
  //input       [ : ]   shamt,
  input       [2:0]   ALUCtrl_i,
  output reg  [31:0]  data_o,
  output reg          Zero_o
);
  
parameter ADD = 3'b001;
parameter SUB = 3'b010;
parameter SLL = 3'b010;
parameter XOR = 3'b101;
parameter SLR = 3'b010;
parameter SRA = 3'b010;
parameter OR  = 3'b100;
parameter AND = 3'b011;
parameter BLT = 3'b110;
parameter BGE  = 3'b100;


always@(*)begin
  
  case(ALUCtrl_i)
    
      ADD     :  data_o = data1_i + data2_i;
      SUB     :  begin 
                    // Zero_o   = (data1_i - data2_i)?0:1;
                    data_o = data1_i - data2_i; 
                 end
      SLL     :  data_o = data1_i << data2_i;
      XOR     :  data_o = data1_i ^ data2_i;
      SLR     :  data_o = data1_i >> data2_i;
      SRA     :  data_o = data1_i  data2_i;
      OR      :  data_o = data1_i | data2_i;
      AND     :  data_o = data1_i & data2_i;
      BLT     :  begin 
                    // signed
                    // Zero_o   = (data1_i - data2_i)?0:1;
                    data_o = data1_i - data2_i; 
                 end
      BGE     :  begin 
                    // signed
                    // Zero_o   = (data1_i - data2_i)?0:1;
                    data_o = data1_i - data2_i; 
                 end
      default : data_o = data1_i;
    
  endcase

end
  
endmodule
