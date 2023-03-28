module ramcontrollertb();

parameter WORD_SIZE=8;
parameter ADDR_WIDTH=8;
parameter RAM_SIZE=1<<ADDR_WIDTH;

reg we,re;
reg [WORD_SIZE-1:0] datawrite;

reg [ADDR_WIDTH-1:0] addr;
reg [ADDR_WIDTH-1:0] instraddr;


reg [WORD_SIZE-1:0] temp_mem[RAM_SIZE-1:0];
wire [WORD_SIZE-1:0] datard;
wire [WORD_SIZE-1:0] instrrd;
reg is_correct;
//reg [WORD_SIZE-1:0] dataread;
//reg [WORD_SIZE-1:0] instrread;

integer i,j,k;

MCPU_RAMController #(.WORD_SIZE(WORD_SIZE), .ADDR_WIDTH(ADDR_WIDTH), .RAM_SIZE(RAM_SIZE)) raminst(we, datawrite, re, addr, datard, instraddr, instrrd);

initial begin 
  we=1;
  re=0;
  i=0;
  for(i=RAM_SIZE;i>=0;i=i-1) begin
    
      datawrite=$random;
      temp_mem[i]=datawrite;
      raminst.mem[i]=temp_mem[i];
      $display("temp ",temp_mem[i]);
      $display("mem ",raminst.mem[i]);
    #2;
  end
  #5;
  we=0;
  re=1;
  addr=0;
  instraddr=0;
  #2;
  for(j=0;j<RAM_SIZE-1;j=j+1) begin
    #2;
    if(datard==temp_mem[j])begin
       is_correct=1;
  end else begin 
     is_correct=0;
  end
  
  if(instrrd==temp_mem[j])begin
      is_correct=1;
  end else begin 
    is_correct=0;
  end
    
    instraddr=instraddr+1;
    addr=addr+1;
  end
  
  
  #5;
  re=0;
  instraddr=0;
  for(k=0;k<RAM_SIZE-1;k=k+1) begin
  #2;
  if(instrrd==temp_mem[k])begin
      is_correct=1;
  end else begin 
    is_correct=0;
  end
    
    instraddr=instraddr+1;
  end
  
  
end
endmodule
  
