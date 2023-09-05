%%% Exercise 3

clear all;
close all;
clc
N=0; %% first iteration
d=1000; % confidence Interval devation
PI=zeros(1,10000);
while d>0.009 %% stoping rule to control Monte carlo Simulation based on confidence interval devation
 N=N+1;
U=rand();
PI(N)=4*(sqrt(1-U.^2)); %% pi estimator  formula
if N==1
    d=1000;
else
m=mean(PI); % mean of pi
std0=std(PI); %  standard devation of pi
CIL_95=m-(1.96*std0/sqrt(N));
CIU_95=m+(1.96*std0/sqrt(N));
 d=abs(CIU_95-CIL_95); % confidence interval devation
end
end
Pi=m; %% approximated pi vaue
%%%%%%%% Print
fprintf("\n==================================================\n")
fprintf("Exercise 3 \n") 
fprintf("The aproximated value of π :");
disp(pi)
