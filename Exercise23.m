close all;
clear all;
clc

a=50; % length of square
b=50; % width of square
N=10000; % Number of Monte carlo simulation
D=zeros(1,N);
count1=0; % intionalize for distance less then 25
count2=0; % intialize  for distance D between 25 and 40
count3=0; %  intialize  distance 40 between 50
for i=1:N
      % the first random points
    x1=a.*rand();
    y1=b.*rand();
    % the second random points 
     x2=a.*rand();
     y2=b.*rand();
      % Distance between two random points
     D(i)=sqrt((x1-x2).^2 +(y1-y2).^2);
     if D(i)<25 % the first condition when D<25
        count1=count1+1; % store the probability of filure in first cause
     elseif D(i)>=25 && D(i)<40
         count2=count2+1; % store the probability of filure in the second cuase

  else D(i)>=40 && D(i)<50;
      count3=count3+1;  % store the probability of failure in the 3rd cause
          
     end
end
pd1=count1/N; % probabilty distance between points less than 25
pd2=count2/N; % probabilty distance between pointsgeater than 25 and less than 40
pd3=count3/N; % probabilty distance  points between 40 and 50

ps=0.95*pd1+0.4*pd2+0.25*pd3; %% probabilty of communication sucess
pf=1-ps; %% probabilty of communication fails

%%%%%%%% print
fprintf("\n==================================================\n")
fprintf("Exercise 2.1\n") 
fprintf("probability of communication filure :");
disp(pf)