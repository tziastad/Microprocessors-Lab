function s=signalprobsmultipleinputs(input1sp,input2sp,varargin)
  input3sp=(varargin{1});
  input4sp=(varargin{2});
  spAND(input1sp, input2sp, input3sp,input4sp,varargin)
  spOR(input1sp, input2sp, input3sp,input4sp,varargin)
  spXOR(input1sp, input2sp, input3sp,input4sp,varargin)
  spNAND(input1sp, input2sp, input3sp,input4sp,varargin)
  spNOR(input1sp, input2sp, input3sp,input4sp,varargin)
   
end

function s=spAND(input1sp, input2sp, input3sp,input4sp,varargin)
 
 s=1.0;
   printf("AND Gate\n")
  for i = 1:length (varargin)
    matrix=cell2mat(varargin{i});  
   endfor
   s=input1sp*input2sp*input3sp*input4sp;
  for i=1:rows(matrix)
   for j=3:columns(matrix)
    s=s.*matrix(i,j);
   endfor
  endfor
endfunction

function spXOR(input1sp, input2sp, input3sp,input4sp,varargin)
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



function s=spOR(input1sp, input2sp, input3sp,input4sp,varargin)
  s=1.0;
  r=1.0;
  printf("OR Gate \n")
  for i = 1:length (varargin)
    matrix=cell2mat(varargin{i});
   endfor
   r=(1-input1sp)*(1-input2sp)*(1-input3sp)*(1-input4sp);
  for i=1:rows(matrix)
   for j=3:columns(matrix)
    r=r.*(1-matrix(i,j));
   endfor
  endfor
  s=1-r;
endfunction


function s=spNAND(input1sp, input2sp, input3sp,input4sp,varargin)
  r=1.0;
  s=1.0;
  printf("NAND Gate\n") 
  for i = 1:length (varargin)
    matrix=cell2mat(varargin{i});
   endfor
   r=input1sp*input2sp*input3sp*input4sp;
  for i=1:rows(matrix)
   for j=3:columns(matrix)
    r=r.*matrix(i,j);
   endfor
  endfor
  s=1-r;
endfunction


function s=spNOR(input1sp, input2sp, input3sp,input4sp,varargin)
  s=1.0;
  printf("NOR Gate \n")
  for i = 1:length (varargin)
    matrix=cell2mat(varargin{i});
   endfor
   s=(1-input1sp)*(1-input2sp)*(1-input3sp)*(1-input4sp);
  for i=1:rows(matrix)
   for j=3:columns(matrix)
    s=s.*(1-matrix(i,j));
   endfor
  endfor
endfunction
