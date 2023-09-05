%%%%% Exercise 2.2
clear all;
close all;
clc
%%% length and width of rectangle
a=100;
b=10;
N=0; % number of trail intialization
D=zeros(5000,1);
I=1000; % intial interval to strat the loop
while I>0.2
   % the first random points
    N=N+1;
    x1=a*rand();
    y1=b*rand();
    % the second random points 
    x2=a*rand();
    y2=b*rand();
   % Distance  between points
    D(N,1)=sqrt((x1-x2)^2 +(y1-y2)^2);

    if N==1   %% continue to second iteration
        I=1000;
    else
     m=mean(D);
     std0=std(D);
     CIL=m-(1.96*std0/(sqrt(N)));
     CIu=m+(1.96*std0/(sqrt(N)));
     I=CIu-CIL;
    end
end
d=m; % estimated distance between 2 points random  in side a square area
%%%%%%%% Print
fprintf("\n==================================================\n")
fprintf("Exercise 2.2\n") 
fprintf("The distance between two random  points :");
disp(d)

