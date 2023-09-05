clear all;
close all;
clc

%% server working time;

num_sim=100;

p_normal=zeros(1,num_sim);

for sim=1:num_sim

% initial state

u=rand();
if u<0.5
    status=0;
else 
    status=1;
end

% exponential distributed time
N=1000;
T=1;
t_total=zeros(1,N);
x=0;
for i=1:N
    x=x+exprnd(T);
    t_total(1,i)=x;
end
%sampling with interinterval

    t_max=max(t_total);
    t_normal=0;
    t_off=0;
    m=1000; % total number of interval
for i=1:m
    t=t_max*rand();
    count=0;
    for j=1:length(t_total)
        if t_total(j)<=t&& t<t_total(j+1)
           count= count+1;
           modlo=mod(count,2);
        if modlo ~=status
               t_normal=t_normal+1;
        else
               t_off=t_off+1;
        end
       end
   end
    

end 
p_normal(sim)=t_normal/(t_normal+t_off);
end

p_normal=mean(p_normal);
P_off=1-p_normal;
%%%%% maximize the probability of finding
n_imc = 100;
l_array = zeros(1,n_imc);
for sim  = 1:n_imc
    dim =200;
    
    exp_times = exprnd(T,1,dim);
    second_lst = exp_times(dim-2); 
    l_array(sim)=second_lst;
end 

% Plot hist 
[N,X_hist] = hist(l_array,20);
time = X_hist(1);
fprintf("\n==================================================\n")
fprintf("Exercise 4 \n") 
fprintf("The probability of server working normally :");
disp(p_normal)
fprintf("The probability of the server off :");
disp(P_off)
fprintf(" Time to maximize probability of  finding normal:");
disp(time);



