
module heilstonesequene();


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
    cpuinst.regfileinst.R[0]=0;
    cpuinst.regfileinst.R[1]=0;
    cpuinst.regfileinst.R[2]=0;
    cpuinst.regfileinst.R[3]=0;     
    
    
    i=0;  cpuinst.raminst.mem[0]={cpuinst.OP_SHORT_TO_REG, R0, 8'b00000001};     // 0:R0=n
    i=i+1; cpuinst.raminst.mem[i]={cpuinst.OP_MOV, R5, R0,4'b0000};              // 1:R5=R0;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_STORE_TO_MEM, R0, 8'b00010100};     // 2:mem[20]=R0;
    i=i+1; cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R1, 8'b00000001};    // 3:R1=1;
    i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R2, 8'b00001111};   // 4:R2=15;
  
    i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_XOR, R3,R0,R1};                   // 5:R3 will be 0 if R0 is 1 to check while condition
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R3, 8'b00001000};              // 6:BNZ while n!=1 jump stin 8
    //else
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R1, 8'b00011110};              // 7:vges apo while, jump sthn 30
    
    //if n is odd
    i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_LSL, R4,R0,R2};                   // 8:R0<<15, if n is odd==> R4!= 0
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R4, 8'b00001100};              // 9: BNZ an einai odd jump stin 12
    
    //else, otan n den einai odd 
    i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_LSR, R0, R0,R1};                  // 10: R0=R0/2
    i=i+1; cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R1, 8'b00001111};             // 11:BNZ jump stin 14
    
    // otan n is odd kane ayta
      i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R0,R0,R0};                 // 12:R0=2*R0;
      i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R0,R0,R5};                 // 13:R0=3*R0;
      i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R0,R0,R1};                 // 14:R0=3*R0+1;
    
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_STORE_TO_MEM, R0, 8'b00010100};     // 15:mem[20]=R0;
    i=i+1; cpuinst.raminst.mem[i]={cpuinst.OP_MOV, R5, R0,4'b0000};              // 16:R5=R0;
    i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_XOR, R3,R0,R1};                   // 17:R3 will be 0 if R0 is 1 to check while condition
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R3, 8'b00001000};              // 18:BNZ
    //else
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R1, 8'b00011110};              // 19:vges apo while, jump sthn 30
    
    

    
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
