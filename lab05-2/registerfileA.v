
module registerfileA();


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

parameter  [cpuinst.OPERAND_SIZE-1:0]  R3  = 3; //4'b0011
parameter  [cpuinst.OPERAND_SIZE-1:0]  R15  = 15; //4'b1111
parameter  [cpuinst.OPERAND_SIZE-1:0]  R14  = 14; //4'b1110
parameter  [cpuinst.OPERAND_SIZE-1:0]  R13  = 13; //4'b1101

initial
begin

    for(i=0;i<256;i=i+1)
    begin
      cpuinst.raminst.mem[i]=0;
    end
        
    
    cpuinst.raminst.mem[0]={cpuinst.OP_SHORT_TO_REG, R15, 8'b00000111}; //reg_cmd=2 LOAD_FROM_DATA
    cpuinst.raminst.mem[1]={cpuinst.OP_SHORT_TO_REG, R13, 8'b00000011}; //reg_cmd=2 LOAD_FROM_DATA
    cpuinst.raminst.mem[2]={cpuinst.OP_STORE_TO_MEM, R13, 8'b00010100};   //  mem[20]=R13; reg_cmd=3 DO_NOTHING
    cpuinst.raminst.mem[3]={cpuinst.OP_MOV, R3, R13, 4'b0000};            //  R3=R13; reg_cmd=1 MOVE_INTERNAL
    cpuinst.raminst.mem[4]={cpuinst.OP_ADD, R14, R3, R13};  //R14=R3+R13 reg_cmd=0 NORMAL_EX
    

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
