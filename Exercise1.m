clear all;
close all;
clc
N1=2;
N2=5;
r1=2;
r2=5;
% p= 0.2;
 
N=5000;% total number of simulation
p=linspace(0,1,50); % different probabilty values
pf1=zeros(1,length(p)); % probability of failure for case 1 (2x2)
pf2=zeros(1,length(p)); % probability of failure for case 2 (5x5)

CI1=zeros(length(p),3);  % 95 %confidence interval for case 1
CI2=zeros(length(p),3);  % 95 %confidence interval for case 2

y1=zeros(N,length(p)); % failur for each iteration of case 1
y2=zeros(N,length(p)); % failur for each iteration of case 2

mean1=zeros(1,length(p)); % mean of failur for case1
std1=zeros(1,length(p)); % standard deviation of failur for case1

mean2=zeros(1,length(p)); %mean of failur for case2
std2=zeros(1,length(p)); % standard deviation of failur for case1

k1=zeros(length(p),r1); % number of successful nodes at each stage for case1
k2=zeros(length(p),r2); % number of successful nodes at each stage for case2

k1_std=zeros(length(p),r1); % case1 standared devation of number of successful nodes
k2_std=zeros(length(p),r2); % case2 standared devation of number of successful nodes

k1_CI=zeros(length(p),r1+2); % case1 95% confidence interval number of successful nodes
k2_CI=zeros(length(p),r2+5); % case2 95% confidence interval number of successful nodes



%%% iteration of for each probability value
for j=1:length(p)
%%%% for N number of simulatiuon
for i=1:N

[y1(i,j),k1(j,:)]=flood_sim(N1,r1,p(j));
[y2(i,j),k2(j,:)]=flood_sim(N2,r2,p(j));

end


%%% average successful nodes for each probability value
k1(j)=round(mean(k1(j,:)));
k2(j)=round(mean(k2(j,:)));

k1_std(j)=std(k1(j,:));
k2_std(j)=std(k2(j,:));

%% case1 95% confidence interval successful nodes
k1_CI(j,1)=k1(1)-(1.96.*k1_std(1)/(sqrt(length(p))));
k1_CI(j,2)=k1(1)+(1.96.*k1_std(1)/(sqrt(length(p))));
k1_CI(j,3)=k1(2)-(1.96.*k1_std(2)/(sqrt(length(p))));
k1_CI(j,4)=k1(2)+(1.96.*k1_std(2)/(sqrt(length(p))));

%% case2 95% confidence interval successful nodes
k2_CI(j,1)=k2(1)-(1.96.*k1_std(1)/(sqrt(length(p))));
k2_CI(j,2)=k2(1)+(1.96.*k1_std(1)/(sqrt(length(p))));
k2_CI(j,3)=k2(2)-(1.96.*k1_std(2)/(sqrt(length(p))));
k2_CI(j,4)=k2(2)+(1.96.*k1_std(2)/(sqrt(length(p))));
 k2_CI(j,5)=k2(3)-(1.96.*k1_std(3)/(sqrt(length(p))));
k2_CI(j,6)=k2(3)+(1.96.*k1_std(3)/(sqrt(length(p))));
k2_CI(j,7)=k2(4)-(1.96.*k1_std(4)/(sqrt(length(p))));
k2_CI(j,8)=k2(4)+(1.96.*k1_std(4)/(sqrt(length(p))));
k2_CI(j,9)=k2(5)-(1.96.*k1_std(5)/(sqrt(length(p))));
k2_CI(j,10)=k2(5)+(1.96.*k1_std(5)/(sqrt(length(p))));

%%%%% average probability of failur
pf1(j)=mean(y1(:,j));  % case1 average probability of failur
pf2(j)=mean(y2(:,j));  % case2 average probability of failur

%%% 95% confidence interval of failur  for case 1

mean1(j)=mean(y1(:,j));
std1(j)=std(y1(:,j));

mean2(j)=mean(y2(:,j));
std2(j)=std(y2(:,j));
 CI1(j,1)=mean1(j)-(1.96*std1(j)/(sqrt(length(p))));
 CI1(j,2)=mean1(j)+(1.96*std1(j)/(sqrt(length(p))));
 CI1(j,3)= abs(CI1(j,1)-CI1(j,2));

 %%% 95% confidence interval of failur for case 2
 CI2(j,1)=mean2(j)-(1.96*std2(j)/(sqrt(length(p))));
 CI2(j,2)=mean2(j)+(1.96*std2(j)/(sqrt(length(p))));
 CI2(j,3)= abs(CI2(j,1)-CI2(j,2));
end



%%% Import data
theoryexflooding = readtable("theory_ex_flooding.csv");
flooding=table2array(theoryexflooding);
f1=flooding(:,2);
f3=flooding(:,3);
f=flooding(:,1);
%%%% MC and theoretical curve plot
figure(1)
subplot(221)
 plot(f,f1,'green');
 hold on 
 plot(f,f3,'red');
 hold off
 title('Theoretical')
 legend('2x2','5x5')
subplot(222)
plot(p,pf1,'green');
hold on
plot(p,pf2,'red');
hold off
title('Monte carilo simulated')
legend('2x2','5x5')
subplot(223)
errorbar(mean1,CI1(:,3))
title('2x2 errorplot ')
xlabel('probability')
ylabel('probability  of error at D')
subplot(224)
errorbar(mean2,CI2(:,3))
title('5x5 errorplot ')
xlabel('probability  ')
ylabel('probability  of error at D')

%%% average successful node plot
figure(2)
%% case 1 average successful node plot
subplot(211)
plot(p,k1(:,1))
hold on
plot(p,k1(:,2))
hold off

title(' case1 average successful nodes of each stage')
legend('stag1','stage2')
%% case 2 average successful node plot
subplot(212)
plot(p,k2(:,1))
hold on 
plot(p,k2(:,2))
hold on
plot(p,k2(:,3))
hold on
plot(p,k2(:,4))
hold on
plot(p,k2(:,5))
hold off

title(' case2 average successful nodes of each stage')
legend('stag1','stage2','stage3','stage4','stage5')

 






function [X,k]= flood_sim(N,r,p)


for j=1:r
  k=zeros(1,r);
  
   K_n=0;    
    for i=1:N
        u=rand();
       if u<=p
         K_n= K_n+1;
       end
    end
        k(j)=N-K_n;
        p=p^k(j);
end
  K=sum(k);
u1=rand();
 if u1<=p^K 
     X=1;
 else 
     X=0;
 end

end

