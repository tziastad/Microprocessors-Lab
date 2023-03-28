
module newinstractionstb();


reg reset, clk;


MCPU cpuinst (clk, reset);


initial begin
  reset=1;
  #10  reset=0;
end

always begin
  #5 clk=0; 
  #5 clk=1; 
end


/********OUR ASSEMBLER*****/

integer file, i;
reg[cpuinst.WORD_SIZE-1:0] memi;
parameter  [cpuinst.OPERAND_SIZE-1:0]  R0  = 0; //4'b0000
parameter  [cpuinst.OPERAND_SIZE-1:0]  R1  = 1; //4'b0001
parameter  [cpuinst.OPERAND_SIZE-1:0]  R2  = 2; //4'b0010
parameter  [cpuinst.OPERAND_SIZE-1:0]  R3  = 3; //4'b0011
parameter  [cpuinst.OPERAND_SIZE-1:0]  R4  = 4; //4'b0011
parameter  [cpuinst.OPERAND_SIZE-1:0]  R5  = 5; //4'b0011
parameter  [cpuinst.OPERAND_SIZE-1:0]  R6  = 6; //4'b0011

initial
begin

    for(i=0;i<256;i=i+1)
    begin
      cpuinst.raminst.mem[i]=0;
    end
    //0001000001010010=4178
    
    i=0;cpuinst.raminst.mem[0]={cpuinst.OP_SHORT_TO_REG, R0, 8'b00010000};      // R0
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R1, 8'b01010010};    // R1
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R2, 8'b00001000};    // R2=8;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LSL, R0,R0,R2};                    // R0=R0<<8;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R4, R0, R1};                  // R4=R0+R1; R4=0001000001010010
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LSL, R5,R4,R2};                    // R5=R4<<8;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LSR, R6,R4,R2};                    // R6=R4>>8;
    
    
    
    
    file = $fopen("program.list","w");
    for(i=0;i<cpuinst.raminst.RAM_SIZE;i=i+1)
    begin
      memi=cpuinst.raminst.mem[i];
      
      $fwrite(file, "%b_%b_%b_%b\n", 
        memi[cpuinst.INSTRUCTION_SIZE-1:cpuinst.INSTRUCTION_SIZE-cpuinst.OPCODE_SIZE],
        memi[cpuinst.OPCODE_SIZE*3-1:2*cpuinst.OPCODE_SIZE],
        memi[cpuinst.OPCODE_SIZE*2-1:cpuinst.OPCODE_SIZE],
        memi[cpuinst.OPCODE_SIZE-1:0]);
    end
    $fclose(file);
end

endmodule
