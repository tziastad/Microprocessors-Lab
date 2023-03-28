

module heilstoneseqAM();


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
parameter  [cpuinst.OPERAND_SIZE-1:0]  R7  = 7; //4'b0011
parameter  [cpuinst.OPERAND_SIZE-1:0]  R8  = 8; //4'b0011
parameter  [cpuinst.OPERAND_SIZE-1:0]  R9  = 9; //4'b0011
parameter  [cpuinst.OPERAND_SIZE-1:0]  R10  = 10; //4'b0011

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
    //0001000001010010
    i=0;cpuinst.raminst.mem[0]={cpuinst.OP_SHORT_TO_REG, R6, 8'b00010000};      // 0:R6=41;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R7, 8'b01010010};    // 1:R7=78;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R8, 8'b00001000};    // 2:R8=8;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LSL, R6,R6,R8};                    // 3:R6=R6<<8;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R0, R6, R7};                  // 4:R0=R6+R7; R0=0001000000110111
    
   
    i=i+1; cpuinst.raminst.mem[i]={cpuinst.OP_MOV, R5, R0,4'b0000};              // 5:R5=R0;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_STORE_TO_MEM, R0, 8'b00101000};     // 6:mem[40]=R0;
    i=i+1; cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R1, 8'b00000001};    // 7: R1=1;
    i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R2, 8'b00001111};   // 8:R2=15;
  
    i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_XOR, R3,R0,R1};                   // 9:R3 will be 0 if R0 is 1 to check while condition
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R3, 8'b00001100};              // 10:BNZ while n!=1 jump stin 12
    //else
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R1, 8'b00011110};              // 11:vges apo while, jump sthn 30
    
    //if n is odd
    i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_LSL, R4,R0,R2};                   // 12:R0<<15, if n is odd==> R4!= 0
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R4, 8'b00010000};              // 13: BNZ an einai odd jump stin 16
    
    //else, otan n den einai odd 
    i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_LSR, R0, R0,R1};                  // 14: R0=R0/2
    i=i+1; cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R1, 8'b00010011};             // 15:BNZ jump stin 19
    
    // otan n is odd kane auta
      i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R0,R0,R0};                 // 16:R0=2*R0;
      i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R0,R0,R5};                 // 17:R0=3*R0;
      i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R0,R0,R1};                 // 18:R0=3*R0+1;
    
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_STORE_TO_MEM, R0, 8'b00101000};     // 19:mem[40]=R0;
    i=i+1; cpuinst.raminst.mem[i]={cpuinst.OP_MOV, R5, R0,4'b0000};              // 20:R5=R0;
    i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_XOR, R3,R0,R1};                   // 21:R3 will be 0 if R0 is 1 to check while condition
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R3, 8'b00001100};              // 22:BNZ while, jump sto 12
    //else
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R1, 8'b00011110};              // 23:vges apo while, jump sthn 30
    
   

     /*
                                                                               //memory address: instruction
    i=0;  cpuinst.raminst.mem[0]={cpuinst.OP_SHORT_TO_REG, R0, 8'b00000000};   //0: R0=0;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R1, 8'b00000001};   //1: R1=1;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R2, 8'b00000010};   //2: R2=2;
                                                                               //do{
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_MOV, R0, R1, 4'b0000};            //  3: R1=R0;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_MOV, R1, R2, 4'b0000};            //  4: R1=R2;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R2, R0, R1};                 //  5: R2=R0+R1;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_STORE_TO_MEM, R2, 8'b00010100};   //  6:mem[20]=R2;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LOAD_FROM_MEM, R3, 8'b00010100};  //  7:R3=mem[20];
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R0, R0, R0};                 //  8:R0=R0+R0
                                                                               //}
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R2, 8'b00000011};
*/    
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

