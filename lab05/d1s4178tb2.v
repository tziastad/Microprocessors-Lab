module d1s4178tb2();
reg tb_a;
reg tb_b;
reg tb_c;
reg d_correct;
reg[0:3] test_vector[0:7];
integer i,j;
  
  
wire tb_d;
  
  
d1s4178 dut(tb_a,tb_b,tb_c,tb_d);
initial begin
  test_vector[0]=4'b0000;
  test_vector[1]=4'b0010;
  test_vector[2]=4'b0100;
  test_vector[3]=4'b0110;
  test_vector[4]=4'b1000;
  test_vector[5]=4'b1010;
  test_vector[6]=4'b1101;
  test_vector[7]=4'b1110;
end
  
initial begin
 
  for(i=0; i<8; i=i+1) begin
    $display("a=%b b=%b c=%b expected_d=%d",test_vector[i][0],test_vector[i][1],test_vector[i][2],test_vector[i][3]);
    for(j=0; j<4; j=j+1)begin
      tb_a=test_vector[i][0];
      tb_b=test_vector[i][1];
      tb_c=test_vector[i][2];
      #2
      if(tb_d==test_vector[i][3])begin
        d_correct<=1'b1;
      end else begin 
        d_correct<=1'b0;
    end
  end
end
             
end
endmodule
