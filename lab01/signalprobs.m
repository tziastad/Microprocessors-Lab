%%%
%%%
%%% τρέχετε το πρόγραμμα ως:
%%% signalprobs(input1sp,input2sp)
%%%
%%% Παραδείγματα:
%%% >> signalprobs(0.5,0.5)

%%% AND Gate for input probabilities (0.500000 0.500000):
%%% ans =  0.25000
%%% OR Gate for input probabilities (0.500000 0.500000):
%%% ans =  0.75000
%%% XOR Gate for input probabilities (0.500000 0.500000):
%%% NAND Gate for input probabilities (0.500000 0.500000):
%%% NOR Gate for input probabilities (0.500000 0.500000):
%%%
%%%
%%% >> signalprobs(0,0)
%%% AND Gate for input probabilities (0.00000 0.00000):
%%% ans =  0
%%% OR Gate for input probabilities (0.00000 0.00000):
%%% ans =  0
%%% XOR Gate for input probabilities (0.00000 0.00000):
%%% NAND Gate for input probabilities (0.00000 0.00000):
%%% NOR Gate for input probabilities (0.00000 0.00000):
%%%
%%% >> signalprobs(1,1)
%%% AND Gate for input probabilities (1.00000 1.00000):
%%% ans =  1
%%% OR Gate for input probabilities (1.00000 1.00000):
%%% ans =  1
%%% XOR Gate for input probabilities (1.00000 1.00000):
%%% NAND Gate for input probabilities (1.00000 1.00000):
%%% NOR Gate for input probabilities (1.00000 1.00000):
%%%
%%%
%%%
%%% Οι συναρτήσεις που υπολογίζουν τα signal probabilities 
%%% AND και OR πυλών δύο εισόδων έχουν ήδη υλοποιηθεί παρακάτω.
%%% Οι συναρτήσεις που υπολογίζουν τα signal probabilities 
%%% XOR, NAND και NOR πυλών δύο εισόδων είναι ημιτελής.
%%% (α) Σας ζητείτε να συμπληρώσετε τις υπόλοιπες ημιτελής συναρτήσεις για τον υπολογισμό
%%% των signal probabilities XOR,NAND και NOR 2 εισόδων πυλών.
%%% (β) γράψτε συναρτήσεις για τον υπολογισμό των signal probabilities 
%%% AND, OR, XOR, NAND, NOR πυλών 3 εισόδων
%%% (γ) γράψτε συναρτήσεις για τον υπολογισμό των signal probabilities 
%%% AND, OR, XOR, NAND, NOR πυλών Ν εισόδων


function s=signalprobs(input1sp,input2sp,varargin)
 
  printf("number of inputs: %d \n",nargin);
  
  
  if(nargin<=2)
 
   printf("------> 2 inputs gates for input probabilities (%f %f):\n",input1sp,input2sp)
   sp2AND(input1sp,input2sp);
   sp2OR(input1sp,input2sp);
   
    %Οι παρακάτω συναρτήσεις πρέπει να ολοκληρωθούν για το (α)
   sp2XOR(input1sp,input2sp);
   sp2NAND(input1sp, input2sp);
   sp2NOR(input1sp, input2sp) ;
  endif
  
  
  if(nargin==3)
  input3sp=(varargin{1});
   
   printf("------> 3 inputs gates for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp)
   % Οι παρακάτω συναρτήσεις πρέπει να γραφούν εξ'ολοκλήρου για το (β)
   
   sp3AND(input1sp, input2sp, input3sp);
   sp3OR(input1sp, input2sp, input3sp);
   sp3XOR(input1sp, input2sp, input3sp);
   sp3NAND(input1sp, input2sp, input3sp);
   sp3NOR(input1sp, input2sp, input3sp);
  endif
  
   if(nargin>=4)
   input3sp=(varargin{1});
   input4sp=(varargin{2});
   % Οι παρακάτω συναρτήσεις πρέπει να γραφούν εξ'ολοκλήρου για το (γ)
   
   printf("------> N inputs gates\n")
   spAND(input1sp, input2sp, input3sp,input4sp,varargin);
   spOR(input1sp, input2sp, input3sp,input4sp,varargin);
   spXOR(input1sp, input2sp, input3sp, input4sp, varargin);
   spNAND(input1sp, input2sp, input3sp, input4sp, varargin);
   spNOR(input1sp, input2sp, input3sp, input4sp, varargin);
  
  endif
  
end
%

% 2-input AND gate truth table
% 0 0:0
% 0 1:0
% 1 0:0
% 1 1:1
%% signal probability calculator for a 2-input AND gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2AND(input1sp,input2sp)
 switchingActivity=1;
  printf("AND Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = input1sp*input2sp;
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
  endfunction

% 2-input OR gate truth table
% 0 0:0
% 0 1:1
% 1 0:1
% 1 1:1
%% signal probability calculator for a 2-input OR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2OR(input1sp,input2sp)
 switchingActivity=1;
  printf("OR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = 1-(1-input1sp)*(1-input2sp);
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
endfunction


% 2-input XOR gate truth table
% 0 0:0
% 0 1:1
% 1 0:1
% 1 1:0
%% signal probability calculator for a 2-input XOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2XOR(input1sp, input2sp)
 switchingActivity=1;
  printf("XOR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s=(1-input1sp)*input2sp + input1sp*(1-input2sp);
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
endfunction


% 2-input NAND gate truth table
% 0 0:1
% 0 1:1
% 1 0:1
% 1 1:0
%% signal probability calculator for a 2-input XOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2NAND(input1sp, input2sp)
 switchingActivity=1;
  printf("NAND Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  %s=(1-input1sp)*(1-input2sp) + (1-input1sp)*input2sp + input1sp*(1-input2sp);
  s=1-input1sp*input2sp;
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
 endfunction



% 2-input NOR gate truth table
% 0 0:1
% 0 1:0
% 1 0:0
% 1 1:0
%% signal probability calculator for a 2-input NOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2NOR(input1sp, input2sp)
 switchingActivity=1;
  printf("NOR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = (1-input1sp)*(1-input2sp) ;
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
endfunction
 



% 3-input AND gate 
function s=sp3AND(input1sp, input2sp, input3sp)
 switchingActivity=1;
  printf("AND Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp);
  s= input1sp*input2sp*input3sp;
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
 endfunction
 
 

 % 3-input OR gate 
 function s=sp3OR(input1sp, input2sp, input3sp)
  switchingActivity=1;
  printf("OR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp);
##   s= (1-input1sp)*(1-input2sp)*input3sp + ...
##   (1-input1sp)*input2sp*(1-input3sp) + (1-input1sp)*input2sp*input3sp + ...
##  input1sp*(1-input2sp)*(1-input3sp) + input1sp* (1-input2sp)*input3sp + ...
##  input1sp*input2sp*(1-input3sp)+ input1sp*input2sp*input3sp;
  s=1-(1-input1sp)*(1-input2sp)*(1-input3sp);
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
  
 endfunction
 
 
 % 3-input XOR gate 
 function s=sp3XOR(input1sp, input2sp, input3sp)
  switchingActivity=1;
  printf("XOR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp);
  s= (1-input1sp)*(1-input2sp)*input3sp + (1-input1sp)*input2sp*(1-input3sp) + ...
  input1sp*(1-input2sp)*(1-input3sp) + input1sp*input2sp*input3sp;
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
 endfunction
 
 
  % 3-input NAND gate 
 function s=sp3NAND(input1sp, input2sp, input3sp)
  switchingActivity=1;
  printf("NAND Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp);
##  s= (1-input1sp)*(1-input2sp)*(1-input3sp)+(1-input1sp)*(1-input2sp)*input3sp + ...
##  (1-input1sp)*input2sp*(1-input3sp) + (1-input1sp)*input2sp*input3sp + ...
##  input1sp*(1-input2sp)*(1-input3sp) + input1sp* (1-input2sp)*input3sp +...
##  input1sp*input2sp*(1-input3sp);
  s=1-input1sp*input2sp*input3sp;
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
 endfunction
 
 
 
  % 3-input NOR gate 
 function s=sp3NOR(input1sp, input2sp, input3sp)
  switchingActivity=1;
  printf("NOR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp);
  s= (1-input1sp)*(1-input2sp)*(1-input3sp);
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
 endfunction


 
 
 function s=spAND(input1sp, input2sp, input3sp,input4sp,varargin)
 
  s=1.0;
  switchingActivity=1;
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
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
endfunction

function s=spOR(input1sp, input2sp, input3sp,input4sp,varargin)
  s=1.0;
  r=1.0;
  switchingActivity=1;
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
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
endfunction

function s=sp2XOR_without_print(input1sp, input2sp)
 switchingActivity=1;
  
  s=(1-input1sp)*input2sp + input1sp*(1-input2sp);
  switchingActivity=2*s*(1-s);
 
endfunction 

function spXOR(input1sp, input2sp, input3sp,input4sp,varargin)
  switchingActivity=1;
  printf("XOR Gate \n")
  for i = 1:length (varargin)
    matrix=cell2mat(varargin{i});  
   endfor
   
  s1=sp2XOR_without_print(input1sp,input2sp);
  s2=sp2XOR_without_print(s1,input3sp);
  s=sp2XOR_without_print(s2,input4sp);
  for i=1:rows(matrix)
   for j=3:columns(matrix)
    s=sp2XOR_without_print(s,matrix(i,j));
   endfor
  endfor
  
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
endfunction


function s=spNAND(input1sp, input2sp, input3sp,input4sp,varargin)
  r=1.0;
  s=1.0;
  switchingActivity=1;
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
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
endfunction


function s=spNOR(input1sp, input2sp, input3sp,input4sp,varargin)
  s=1.0;
  switchingActivity=1;
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
  switchingActivity=2*s*(1-s);
  printf("signal probability is %f and switching activity is %f\n",s,switchingActivity);
endfunction
