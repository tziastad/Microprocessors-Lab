clear;
N=10; # the experiment event number
r=1; #the circle radius
n=0; # sucessful event number 
for i=1:N
 %tuxaia simeia ston xwro
  x=-r+2*r*rand();
  y=-r+2*r*rand();
  if ((x^2+y^2)<=r^2) % an ta shmeia anikoun mesa son kyklo
    n = n+1; %auksisi twn simeiwn poy anikoun ston kyklo
  end
end
% upologismos tou pi
pi_sim=4*n/N;
printf("With %d inputs pi=%f \n",N,pi_sim);
subplot (5, 1, 1)
plot (N, pi_sim);
xlabel ("experiment event number");
ylabel ("pi sim");
title ("monte carlo pi computation");
grid("on");

clear;
N=100; # the experiment event number
r=1; #the circle radius
n=0; # sucessful event number 
for i=1:N
  x=-r+2*r*rand();
  y=-r+2*r*rand();
  if ((x^2+y^2)<=r^2)
    n = n+1;
  end
end

pi_sim=4*n/N;
printf("With %d inputs pi=%f \n",N,pi_sim);
subplot (5, 1, 2)
plot (N, pi_sim);
xlabel ("experiment event number");
ylabel ("pi sim");
title ("monte carlo pi computation");
grid("on");

clear;
N=1000; # the experiment event number
r=1; #the circle radius
n=0; # sucessful event number 
for i=1:N
  x=-r+2*r*rand();
  y=-r+2*r*rand();
  if ((x^2+y^2)<=r^2)
    n = n+1;
  end
end

pi_sim=4*n/N;
printf("With %d inputs pi=%f \n",N,pi_sim);
subplot (5, 1, 3)
plot (N, pi_sim);
xlabel ("experiment event number");
ylabel ("pi sim");
title ("monte carlo pi computation");
grid("on");

clear;
N=4178; # the experiment event number
r=1; #the circle radius
n=0; # sucessful event number 
for i=1:N
  x=-r+2*r*rand();
  y=-r+2*r*rand();
  if ((x^2+y^2)<=r^2)
    n = n+1;
  end
end
pi_sim=4*n/N;
printf("With %d inputs pi=%f \n",N,pi_sim);
subplot (5, 1, 4)
plot (N, pi_sim);
xlabel ("experiment event number");
ylabel ("pi sim");
title ("monte carlo pi computation");
grid("on");

clear;
N=10000; # the experiment event number
r=1; #the circle radius
n=0; # sucessful event number 
for i=1:N
  x=-r+2*r*rand();
  y=-r+2*r*rand();
  if ((x^2+y^2)<=r^2)
    n = n+1;
  end
end
pi_sim=4*n/N;
printf("With %d inputs pi=%f \n",N,pi_sim);
subplot (5, 1, 5)
plot (N, pi_sim);
xlabel ("experiment event number");
ylabel ("pi sim");
title ("monte carlo pi computation");
grid("on");