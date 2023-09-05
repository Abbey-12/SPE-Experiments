%% Exercise 3.3 pi Estimator using Stratified sampling method
clear all;
close all;
clc
N=0; %% first iteration
d=1000;
PI=zeros(1,10000);
n=10000;% number of monte carlo  runs
while d>0.01
 N=N+1; 
 sum=0;
for j=1:n
U=(j-1)./n+(1/n).*rand();
sum=sum+sqrt(1-((U+j-1)./n).^2)+sqrt(1-((j-U)./n).^2); %% PI estimator using Stratified  Method random number
end 
PI(N)=2*sum./n;
m=mean(PI); % mean of pi
std0=std(PI); %  standard devation of pi
CIL_95=m-(1.96*std0/sqrt(N));
CIU_95=m+(1.96*std0/sqrt(N));
 d=abs(CIU_95-CIL_95); % confidence interval devation
end
pi=m;  % approximated pi vaue
%%%%%%%% Print
fprintf("\n==================================================\n")
fprintf("Exercise 3.3 \n") 
fprintf("The approximated value of π using Stratification method:");
disp(pi)
fprintf(" The approximated value of π using  number of correct digits:");
disp(N)

