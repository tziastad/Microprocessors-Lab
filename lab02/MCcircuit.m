
function SwitchingActivity = MCcircuit(N)

Workload=[];

MonteCarloSize = N;
for i = 1:MonteCarloSize
    Workload = [Workload; round(mod(rand(),2)), round(mod(rand(),2)),round(mod(rand(),2))];
end
vectorsNumber  =size(Workload, 1); 
gateInputsNumber = size(Workload, 2);
gateOutput=0;

switchesNumber=0;
for i = 1:vectorsNumber    
    NewGateOutput= circuit(Workload(i,1) , Workload(i,2) , Workload(i,3));
    %NewGateOutput
    if (gateOutput==NewGateOutput)
        continue;
    else
        gateOutput=NewGateOutput;
    end
    
    switchesNumber=switchesNumber+1;
end
switchesNumber
vectorsNumber
SwitchingActivity=switchesNumber/vectorsNumber
    

endfunction

%2.1

function d = circuit(a,b,c)
  
  e = sp2AND(a,b);
  f = spNOT(c);
  d = sp2AND(e,f);
  
endfunction
function s = sp2AND(input1sp, input2sp)
  s = input1sp*input2sp;
endfunction

function s = spNOT(input3sp)
  s = 1 - input3sp;
endfunction
 
 













