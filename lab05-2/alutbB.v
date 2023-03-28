module MCPU_AlutbB();

parameter CMD_SIZE=2;
parameter WORD_SIZE=8;

reg [CMD_SIZE-1:0] opcode;
reg [WORD_SIZE-1:0] r1;
reg [WORD_SIZE-1:0] r2;
wire [WORD_SIZE-1:0] out;
reg is_correct;
reg [WORD_SIZE-1:0] res;
reg flag;
wire OVERFLOW;

MCPU_Alu #(.CMD_SIZE(CMD_SIZE), .WORD_SIZE(WORD_SIZE)) aluinst (opcode, r1, r2, out, OVERFLOW);
initial res=0;
// Testbench code goes here
always begin 
  #2 r1<=8'b00000100;
  #2 r1<=8'b00000001;
  #2 r1<=8'b00000111;
  #2 r1<=8'b00001000;
end
always begin 
  #2 r2<=8'b00000100;
  #2 r2<=8'b00000001;
  #2 r2<=8'b00000111;
  #2 r2<=8'b00001000;
end

always #2 opcode[0] = $random;
always #2 opcode[1] = $random;


always @(opcode,r1,r2) begin
    if((opcode==2'b00))begin
      #1;
      res<=r1&r2;
      
      if(out==res)begin
        is_correct<=1;
      end
      else begin 
        is_correct<=0;
      end
    end
    else if(opcode==2'b01)begin
      #1;
      res<=r1|r2;
      
      if(out==res)begin	
        is_correct<=1;
      end
      
      else begin 
        is_correct<=0;
      end
      end
    else if((opcode==2'b10))begin
      #1;
      res<=r1^r2;
      
      if(out==res)begin
        is_correct<=1;
      end
      else begin 
        is_correct<=0;
      end
    end 
    else if(opcode==2'b11)begin
      #1;
      {flag,res}<=r1+r2;
      
      if({OVERFLOW,out}=={flag,res})begin
        is_correct<=1;
      end
      else begin
        is_correct<=0;
    end
  end
end



initial begin
  $display("@%0dns default is selected, opcode %b",$time,opcode);
end


endmodule


