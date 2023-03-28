function s=signalprobs3input(input1sp,input2sp,varargin)
  input3sp=(varargin{1});
  sp2XOR(input1sp,input2sp)
  sp3AND(input1sp, input2sp, input3sp)
  sp3OR(input1sp, input2sp, input3sp)
  sp3XOR(input1sp, input2sp, input3sp)
  sp3NAND(input1sp, input2sp, input3sp)
  sp3NOR(input1sp, input2sp, input3sp)
   
end


% 3-input AND gate 
function s=sp3AND(input1sp, input2sp, input3sp)
  printf("AND Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp);
  s= input1sp*input2sp*input3sp;
 endfunction
 
 

 % 3-input OR gate 
 function s=sp3OR(input1sp, input2sp, input3sp)
  printf("OR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp);
##   s= (1-input1sp)*(1-input2sp)*input3sp + ...
##   (1-input1sp)*input2sp*(1-input3sp) + (1-input1sp)*input2sp*input3sp + ...
##  input1sp*(1-input2sp)*(1-input3sp) + input1sp* (1-input2sp)*input3sp + ...
##  input1sp*input2sp*(1-input3sp)+ input1sp*input2sp*input3sp;
  s=1-(1-input1sp)*(1-input2sp)*(1-input3sp);
 endfunction
 
 function s=sp2XOR(input1sp, input2sp)
 switchingActivity=1;
  printf("XOR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s=(1-input1sp)*input2sp + input1sp*(1-input2sp);
  switchingActivity=2*s*(1-s);
endfunction


 % 3-input XOR gate 
 function s=sp3XOR(input1sp, input2sp, input3sp)
  
##  s= (1-input1sp)*(1-input2sp)*input3sp + (1-input1sp)*input2sp*(1-input3sp) + ...
##  input1sp*(1-input2sp)*(1-input3sp) + input1sp*input2sp*input3sp;

  s1=sp2XOR(input1sp,input2sp);
  s2=sp2XOR(s1,input3sp);
  printf("XOR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp);
  printf("s=%d \n",s2);
 endfunction
 
 
  % 3-input NAND gate 
 function s=sp3NAND(input1sp, input2sp, input3sp)
  printf("NAND Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp);
##  s= (1-input1sp)*(1-input2sp)*(1-input3sp)+(1-input1sp)*(1-input2sp)*input3sp + ...
##  (1-input1sp)*input2sp*(1-input3sp) + (1-input1sp)*input2sp*input3sp + ...
##  input1sp*(1-input2sp)*(1-input3sp) + input1sp* (1-input2sp)*input3sp +...
##  input1sp*input2sp*(1-input3sp);
  s=1-input1sp*input2sp*input3sp;
  
 endfunction
 
 
 
  % 3-input NOR gate 
 function s=sp3NOR(input1sp, input2sp, input3sp)
  printf("NOR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp);
  s= (1-input1sp)*(1-input2sp)*(1-input3sp);
 endfunction