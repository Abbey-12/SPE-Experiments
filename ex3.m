%%%%%%%%%% Exercise 3

clear all;
close all;
clc 

%%% bounded Interval
a=-3*pi/2;
b=3*pi/2;
A=7.56432;
x=linspace(a,b,5000);

X=(b-a).*rand(5000,1) + a;% random number b/n a & b
fx=(exp(-abs(X)/4).*(sin(abs(X))+1))/A; % theortical pdf
Fun=(exp(-abs(x)/4).*(sin(abs(x))+1))/A; 
%% weired distribution rejection sampling
M=0.2; % maximum value
U=(M).*rand(5000,1);% box size
Z=[];
for i=1:5000
  if U(i)< fx(i)
      Z = [Z X(i)];
  end
end
%% empirical PDF plot
 subplot(211)
 histogram(Z,100)
 title(' Empirical PDF')
 %% theortical PDF plot
 subplot(212)
plot(x,Fun,'r')
title('Theortical PDF')
   

