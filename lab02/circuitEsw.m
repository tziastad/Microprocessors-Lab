
%2.2
function s=circuitEsw(a,b,c)
    circuit(a,b,c)
end

%2.1
function s=circuit(a,b,c)
   e=sp2AND(a,b);
   f=spNOT(c);
   sp2AND(e,f);
 
end


function s=sp2AND(a,b)
 switchingActivity=1;
  printf("---AND Gate for input probabilities (%f ,%f):\n",a,b)
  s = a*b;
  switchingActivity=2*s*(1-s);
  printf("switching activity is %f\n",switchingActivity);
 endfunction
 
 
 function s=spNOT(c)
  printf("---NOT Gate for input probabilities (%f):\n",c)
  switchingActivity=1;
  s=1-c;
  switchingActivity=2*s*(1-s);
  printf("switching activity is %f\n",switchingActivity);
 endfunction
 
 
 