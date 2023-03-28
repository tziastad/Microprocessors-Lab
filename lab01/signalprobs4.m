function s=signalprobs4(input1sp,input2sp,varargin)
  input3sp=(varargin{1});
  input4sp=(varargin{2});
  %input5sp=(varargin{3});
  sp2XOR(input1sp,input2sp)
  
  spXOR(input1sp, input2sp, input3sp,input4sp,varargin);
   
end

 
 function s=sp2XOR(input1sp, input2sp)
 switchingActivity=1;
  printf("XOR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s=(1-input1sp)*input2sp + input1sp*(1-input2sp);
  switchingActivity=2*s*(1-s);
endfunction


 function s=spXOR(input1sp, input2sp, input3sp,input4sp,varargin)
  
##  s= (1-input1sp)*(1-input2sp)*input3sp + (1-input1sp)*input2sp*(1-input3sp) + ...
##  input1sp*(1-input2sp)*(1-input3sp) + input1sp*input2sp*input3sp;

##  s1=sp2XOR(input1sp,input2sp);
##  s2=sp2XOR(s1,input3sp);
##  s3=sp2XOR(s2,input4sp);
##  s4=sp2XOR(s3,input5sp);
##  printf("XOR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp);
##  printf("s=%d \n",s4);

##   s=1.0;
##   printf("AND Gate\n")
  for i = 1:length (varargin)
    matrix=cell2mat(varargin{i});  
   endfor
   
  s1=sp2XOR(input1sp,input2sp);
  s2=sp2XOR(s1,input3sp);
  s=sp2XOR(s2,input4sp);
  ##printf("s=%d \n",s);
  for i=1:rows(matrix)
   for j=3:columns(matrix)
    s=sp2XOR(s,matrix(i,j));
   endfor
  endfor
  
  printf("s=%d \n",s);
endfunction
