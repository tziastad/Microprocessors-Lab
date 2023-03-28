
%%%
%%% N Monte Carlo permutations to be performed
%%%
%%% you run the program as:
%%% MCAND4(10) for 10 permutations
%%% MCAND4(100) for 100 permutations
%%% MCAND4(1000) for 1000 permutations
%%% etc...

function SwitchingActivity=MCNOT(N)
%% for dynamic power computation we need the switching activity
%% lets consider a 2 input AND gate with the following truth table:


%% I1 I2   O
%%  X  0 | 0 
%%  0  X | 0 
%%  1  1 | 1





%% and lets try to find the power consumption of the following workload (remember workload is program)
%%
Workload=[0  ; 1  ; 0; 1; 1; ];

MonteCarloSize=N
for i = 1:MonteCarloSize
    Workload=[Workload; round(mod(rand(),2))];
end
Workload
vectorsNumber=size(Workload, 1);
printf("vectors =%d \n", vectorsNumber);
gateInputsNumber=size(Workload, 2);
printf("gate input =%d \n", gateInputsNumber);
gateOutput=0;

switchesNumber=0;
for i = 1:vectorsNumber    
    NewGateOutput= !(Workload(i,1)) ;
    %NewGateOutput
    NewGateOutput
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

