%%%%%%%%%% Exercise 1
clear all;
close all;
clc

% Import the data
data_ex1= readtable("data_ex1.csv");
data_ex1=table2array(data_ex1);
n=length(data_ex1);

%%%%% Bootstrap method 

r0=25;
gamma1=0.95;
gamma2=0.99;
R1=ceil((2*r0)/(1-gamma1))-1;
R2=ceil((2*r0)/(1-gamma2))-1;
dataex1r=zeros(n,1);
bstrmean=zeros(R1,1);
%% 95% confidence interval  bootstrap  
for i=1:R1
    dataex1r1=randsample(data_ex1,n,true);
    bstrmean(i)=bstrpmean(dataex1r1);
 end
bstrmean_sorted1=sort(bstrmean);
% bootstrap mean 
bstrmeancl1=[bstrmean_sorted1(r0),bstrmean_sorted1(R1+1-r0)];

%% 99% confidence interval  bootstrap  
bstr_mean=zeros(R2,1);
dataex1r2=zeros(n,1);
for i=1:R2
    dataex1r2=randsample(data_ex1,n,true);
   bstr_mean(i)=bstrpmean(dataex1r2);
 end
bstrmean_sorted2=sort( bstr_mean);
bstrmeancl2=[bstrmean_sorted2(r0),bstrmean_sorted2(R2+1-r0)];


%% Asymptotic mean confidence interval
mean=bstrpmean(data_ex1);
sigma=bstrpstdev(data_ex1);
CI95=norminv([0.025,0.975],mean,sigma/sqrt(n));
CI99=norminv([0.005,0.995],mean,sigma/sqrt(n));

%%% log transformed data mean confidence interval
log_data=log(data_ex1);
mean_log=bstrpmean(log_data);
sigma_log=bstrpstdev(log_data);
CI95_logdata=norminv([0.025,0.975],mean_log,sigma_log/sqrt(n));
CI99_logdata=norminv([0.005,0.995],mean_log,sigma_log/sqrt(n));

fprintf("\n==================================================\n")
fprintf("Exercise 1\n")
fprintf(" confidence interval of bootstrap mean : \n")
fprintf(" 95%% confidence interval of mean:  ")
disp(bstrmeancl1);
fprintf(" 99%% confidence interval of mean : ")
disp(bstrmeancl2);
fprintf(" Asymptotic mean confidence interval :\n")
fprintf("95%%  confidence interval of mean :");
disp(CI95);
fprintf("99 %%  confidence interval of mean :");
disp(CI99);
fprintf(" confidence interval of mean of logdata :\n ")
fprintf(" 95 %% confidence interval of mean of logdata : ")
disp(CI95_logdata)
fprintf("99 %% confidence interval of mean of logdata :");
disp(CI99_logdata)






