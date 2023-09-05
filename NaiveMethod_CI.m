%% exercise 3.1 using Confidence interval controling rule
clear all;
close all;
clc
N=0;%% first iteration
r=1;
d=1000; %  confidence interval Devation
pi_value=zeros(1,10000);
cirlce_ponit=0;
rectangle_ponit=0;
while d>0.001
 N=N+1;
 if N==1
    d=1000; 
 else
x=rand();
y=rand();
 k=sqrt(x.^2+y.^2);            % distance  between two points formula
    if k<=r
cirlce_ponit=cirlce_ponit+1;     % number of points in the circle
    end
   rectangle_ponit=rectangle_ponit+1; 
   pi_value(N)=4*cirlce_ponit/rectangle_ponit; % Naive method estimator
  m=mean(pi_value);                            % mean of pi
  std0=std(pi_value);                          %  standard devation of pi
  CIL_95=m-(1.96*std0/sqrt(N));             
  CIU_95=m+(1.96*std0/sqrt(N));
 d=abs(CIU_95-CIL_95);                         % confidence interval devation
 end
end
pi=m;                                  % Estimated  value of PI              
%%%%%%%% Print
fprintf("\n==================================================\n")
fprintf("Exercise 3.1 \n") 
fprintf("The approximated value of π using  naive estimator :");
disp(pi)
fprintf(" Number of Iterations :");
disp(N)