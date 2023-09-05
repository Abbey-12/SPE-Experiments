clear all;
close all;
clc

%%% length and width of square
a=100;
b=100;

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
d=m; % estimated distance between 2 points in side a square area
fprintf("\n==================================================\n")
fprintf("Exercise 2.3 \n") 
fprintf("Estimated distance betwen any two points in side a square dimension 100X100 :");
disp(m)