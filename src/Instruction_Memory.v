module Instruction_Memory
(
    input               clk,
    input               reset,
    input   [31:0]      addr_i,     // Instruction address for Read/Write (PC while reading) 
    input               write_inst_i,
    input   [7:0]       instr_i,    // Write these instructions to instruction-memory
    output  [31:0]      instr_o     // fetched 32-bit instruction
);
    
// Instruction memory
reg     [31:0]     memory  [0:63];  // 32 x 64 Instruction memory
reg     [7:0]      instr_read;
reg     [5:0]      address_read;
reg                flag,flag_next;
reg     [1:0]      counter,counter_next;
reg     [5:0]      instr_wr_address,instr_wr_address_next;

assign  instr_o = memory[addr_i>>2];  // fetched instruction, doubtful about memory-alignment

always@(*)
begin
    if  (instr_i == 8'b1111_1110)      // start of program
        flag_next = 1;
    else if (instr_i == 8'b1111_1111)  // end of program 
        flag_next = 0;
    else 
        flag_next = flag;

    if(flag)
        counter_next = counter + 2'd1; // read next 8 bits of the instruction address
    else 
        counter_next = counter;

    if(counter == 2'b11)
        instr_wr_address_next = instr_wr_address + 6'd1;    // write next instruction
    else 
        instr_wr_address_next = instr_wr_address;
end

integer i;

// Overwriting the instruction memory with new program    
always@(posedge clk or posedge reset)begin
    if(reset)begin
        counter         <= 0;
        instr_read      <= 0;
        flag            <= 0;
        address_read    <= 0;
        instr_wr_address<=0;
    end
    else begin
        flag             <= flag_next;
        counter          <= counter_next;
        instr_wr_address <= instr_wr_address_next;
        address_read     <= instr_wr_address;
        instr_read       <= instr_i;    // 8 bits of instruction
        
        if(flag) begin
          case(counter)
            2'b00:   memory[address_read][31:24] <= (instr_read == 8'b1111_1111)?0:instr_read;
            2'b01:   memory[address_read][23:16] <= (instr_read == 8'b1111_1111)?0:instr_read;
            2'b10:   memory[address_read][15:8]  <= (instr_read == 8'b1111_1111)?0:instr_read;
            2'b11:   memory[address_read][7:0]   <= (instr_read == 8'b1111_1111)?0:instr_read;              
            default: memory[address_read][7:0]   <= (instr_read == 8'b1111_1111)?0:instr_read;
          endcase
        end
    end
end
endmodule
