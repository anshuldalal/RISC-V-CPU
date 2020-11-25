module ALU 
(  
  input       [31:0]  data1_i, data2_i,
  //input       [ : ]   shamt,
  input       [3:0]   ALUCtrl_i,
  output reg  [31:0]  data_o,
  output reg          branch_flag_o
  output reg          Zero_o
);
  
parameter ADD = 4'b0000;
parameter SUB = 4'b0001;
parameter SLL = 4'b0010;
parameter XOR = 4'b0011;
parameter SRL = 4'b0100;
parameter SRA = 4'b0101;
parameter OR  = 4'b0110;
parameter AND = 4'b0111;
parameter BLT = 4'b1000;
parameter BGE = 4'b1001;
//parameter LUI = 4'b1001;
//parameter JAL = 4'b1001;
  
always@(*)begin
  
  case(ALUCtrl_i)
    
      ADD     :  data_o = data1_i + data2_i;
      SUB     :  begin 
                    Zero_o = (data1_i - data2_i) ? 0 : 1;
                    data_o = data1_i - data2_i; 
                 end
      SLL     :  data_o = data1_i << data2_i;
      XOR     :  data_o = data1_i ^ data2_i;
      SRL     :  data_o = data1_i >> data2_i;
      SRA     :  data_o = $signed($signed(data1_i) >>> data2_i);
      OR      :  data_o = data1_i | data2_i;
      AND     :  data_o = data1_i & data2_i;
      BLT     :  branch_flag_o = ($signed(data1_i) < $signed(data2_i)) 1 ? 0; 
      BGE     :  branch_flag_o = ($signed(data1_i) >= $signed(data2_i)) 1 ? 0;
      LUI     :  data_o 
      JAL     :   
      default :  data_o = data1_i;
    
  endcase

end
  
endmodule
