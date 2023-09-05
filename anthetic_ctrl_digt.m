clear all;
close all;
clc
N=1; %% first iteration
d=1000;
PI=zeros(1,1000);
m=zeros(1,1000);
while d>1e-9
 N=N+1;
U=rand();
PI(N)=2.*((sqrt(1-(U).^2)+sqrt(1-(1-U).^2))); % PI estimator using Antithetic random number
m(N)=mean(PI); % mean of pi
 d=abs(m(N)-m(N-1)); % Estimated  value of  pi devation
  mean_pi=m(N);
end
pi=mean_pi; %% approximated pi vaue
%%%%%%%% Print
fprintf("\n==================================================\n")
fprintf("Exercise 3.2 \n") 
fprintf("The approximated value of π using number of digit controling  rule :");
 disp(pi)
fprintf("Number of Iterations :");
disp(N)