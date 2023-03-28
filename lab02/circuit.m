

%2.1
function s=circuit(a,b,c)
   e=sp2AND(a,b);
   f=spNOT(c);
   sp2AND(e,f);
 
end


%% I1 I2 I3 | O
%%  0 0 0   | 0
%%  0 0 1   | 0
%%  0 1 0   | 0
%%  0 1 1   | 0
%%  1 0 0   | 0
%%  1 0 1   | 0
%%  1 1 0   | 1
%%  1 1 1   | 0
function s=sp2AND(a,b)
 switchingActivity=1;
  printf("---AND Gate for input probabilities (%f ,%f):\n",a,b)
  s = a*b;
  switchingActivity=2*s*(1-s);
  printf("output %d \n",s);
 endfunction
 
 
 function s=spNOT(c)
  printf("---NOT Gate for input probabilities (%f):\n",c)
  switchingActivity=1;
  s=1-c;
  switchingActivity=2*s*(1-s);
  printf("output %d \n ",s);
 endfunction
 
 
 