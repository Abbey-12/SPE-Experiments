%%%%%%%%%% Exercise 5 with whole data set

clear all;
close all;
clc

% Import the data
data= readtable("data_ex5.csv");
data=table2array(data);
data(:,2)=zeros;

%%%%% initial guess
mean=[-3 7 -5];% mean
var=[8 3 1]; %%variance 
p=[1/3,1/3,1/3];% prior probability 

%% Algorithm
shift1 = 100000;  % number
shift2= 100000;  % number
precision = 0.00005; 
number_iter = 0;
while shift1 > precision & shift2>precision
  % Expectation 
 data_exp=expectation(data,mean,var,p);
 % Maximization 
[data_gaussian1,data_gaussian2,data_gaussian3,mean_max,var_max,p_max]=maximization(data_exp);

% Calculate the distance/error from the previous set of parameters
shift1 = D_mean(mean, mean_max);
shift2 = D_var(var,var_max);
% Re-assignment
    data=data_exp;
    mean=mean_max;
    var=var_max;
    p=p_max;
% Increment number of iterations by 1 
number_iter =number_iter +1;
end

%%%% pdf using histogram
% histogram(data(:,1),200)
% hold on
histogram(data_gaussian1,200)
hold on
histogram(data_gaussian2,200)
hold on
histogram(data_gaussian3,200)
hold on 
hold off

%%%%%%%%print desired output
fprintf("\n==================================================\n")
fprintf("Exercise 5 with whole number of data set\n")
fprintf("Maximized means\n")
disp(mean_max);
fprintf("Maximized variance"); 
disp(var_max);
fprintf("Maximized prior probability"); 
disp(p_max);




%% Functions
% Probability
 function pr =prob(data, mean, var, p)
    pr = p * normpdf(data, mean, sqrt(var));
 end

 % Expectation
function data = expectation(data, mean, var,p)

for i = 1:size(data)

    p_gauss1 = prob(data(i,1), mean(1), var(1),p(1));
    p_gauss2 = prob(data(i,1), mean(2), var(2),p(2));
    p_gauss3 = prob(data(i,1), mean(3), var(3),p(3));

    if ((p_gauss1 > p_gauss2) & (p_gauss1 > p_gauss3))
        data(i,2) = 1;
    elseif ((p_gauss2 > p_gauss1) & (p_gauss2 > p_gauss3))
        data(i,2) = 2;
    elseif ((p_gauss3 > p_gauss1) & (p_gauss3 > p_gauss2))
        data(i,2) = 3;
    end
end
end

% Maximization
function [data_gaussian1,data_gaussian2,data_gaussian3,mean_max,var_max,p_max]= maximization(data_exp)

data_gaussian1 = data_exp(data_exp(:,2) == 1); 
data_gaussian2 = data_exp(data_exp(:,2) == 2);
data_gaussian3 = data_exp(data_exp(:,2) == 3);

prob_gaussian1 = size(data_gaussian1,1) / size(data_exp,1);
prob_gaussian2 = size(data_gaussian2,1) / size(data_exp,1);
prob_gaussian3 = 1 - prob_gaussian1-prob_gaussian2;

% Calculate probability
p_max = [prob_gaussian1, prob_gaussian2, prob_gaussian3];

% Calculate Means
mean_max = [mean(data_gaussian1(:,1)), mean(data_gaussian2(:,1)),mean(data_gaussian3(:,1))];

% Calculate Variances
var_max = [var(data_gaussian1(:,1)), var(data_gaussian2(:,1)), var(data_gaussian3(:,1))];   
end

% Distance for convergence of means
function D_mean = D_mean(mean,mean_max)
D_mean = abs(mean - mean_max);
end
% Distance for convergence of Variances
function D_var = D_var(var,var_max)
D_var = abs(var - var_max);
end


