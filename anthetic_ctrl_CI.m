%% Exercise 3.2 
clear all;
close all;
clc
N=0; %% first iteration
d=1000; % Confidence interval devation
PI=zeros(1,10000);
while d>0.01
 N=N+1;
U=rand();
PI(N)=2.*((sqrt(1-(U).^2)+sqrt(1-(1-U).^2))); % PI estimator using Antithetic random number
m=mean(PI); % mean of pi
std0=std(PI); %  standard devation of pi
CIL_95=m-(1.96*std0/sqrt(N));
CIU_95=m+(1.96*std0/sqrt(N));
 d=abs(CIU_95-CIL_95); % confidence interval devation
 end
pi=m; %% approximated pi vaue
%%%%%%%% Print
fprintf("\n==================================================\n")
fprintf("Exercise 3.2 \n") 
fprintf("The approximated value of π using Antithetic random number :");
disp(pi)
fprintf(" Number of Iterations :");
disp(N)
