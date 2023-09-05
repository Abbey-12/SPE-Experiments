clear all;
close all;
clc
N=1; %% first iteration
d=1000;
PI=zeros(1,10000);
n=10000;% number of runs
m=zeros(1,10000);

while d>1e-9
 N=N+1; 
  sum=0;
for j=1:n
U=(j-1)./n+(1/n).*rand();
sum=sum+sqrt(1-((U+j-1)./n).^2)+sqrt(1-((j-U)./n).^2); %% PI estimator using Antithetic random number
end 
PI(N)=2*sum./n;
m(N)=mean(PI); % mean of pi 
d=abs(m(N)-m(N-1)); % confidence interval devation
 mean_pi=m(N);
end
pi=mean_pi;  % approximated pi vaue

%%%%%%%% Print
fprintf("\n==================================================\n")
fprintf("Exercise 3.3 \n") 
fprintf("The approximated value of π using stratification number of digit controling rule :");
disp(pi)
fprintf("The number of Iterations :");
disp(N)