
%% exercise 3.1 using  the number of correct digits of π estimate controling rule
clear all;
close all;
clc
N=1;%% first iteration
r=1;
d=1000;
pi_value=zeros(1,10000);
cirlce_ponit=0;
rectangle_ponit=0;
mean_pi=zeros(1,10000);
while d>1e-9
 N=N+1;
 x=rand();
y=rand();
 k=sqrt(x.^2+y.^2);                % distance between two points 
    if k<=r
cirlce_ponit=cirlce_ponit+1;        % Number of  points in circle
    end
   rectangle_ponit=rectangle_ponit+1;     % number of points in the rectangle
   pi_value(N)=4*cirlce_ponit/rectangle_ponit; % pi estimator
 mean_pi(N)=mean(pi_value);                    % mean of estimated  pi
d=abs(mean_pi(N)-mean_pi(N-1));                % Estimated value devation of  pi value
  m=mean_pi(N);
end
pi=m; % Estimated value of pi
fprintf("\n==================================================\n")
fprintf("Exercise 3.1 \n") 
fprintf("The approximated value of π using number of digit controling  rule :");
disp(pi)
fprintf("Number of Iteration :");
disp(N)