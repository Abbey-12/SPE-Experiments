%%%%%%%%%% Exercise 2

clear all;
close all;
clc
%%%rejection sampling method that relies on the exponential distribution 
y=exponetial(1,(rand(1,5000)));
U=rand(1,5000);
n=length(U);
fun=exp((-(y-1).^2)/2);
X=zeros(1,n);
Z=zeros(n,1);
for i=1:n
    if U(i)<=fun(i)
        X(i)=y(i);
    end
   
    if U(i)<0.5
        Z(i)=-X(i);
    else 
        Z(i)=X(i);
    end 
end
N1=Z;
figure(1)
subplot(311)
histogram(N1,10)
title('N1')

%%%%%% polar method
U1=rand(1,5000);
U2=rand(1,5000);
V1=(2.*U1)-1;
V2=(2.*U2)-1;
S= V1.^2+V2.^2;
 x=[];
ver=[];
for i=1:5000
    if S(i)<=1
x=[x sqrt(-2*log(S(i))./S(i))*V1(i)];
ver=[ver sqrt(-2*log(S(i))./S(i))*V2(i)];
    end
end
N2=x;

subplot(312)
histogram(N2)
title('N2')

%%%% Guassian random varible using built in funication
N3= normrnd(2,4,1,5000);

subplot(313)
histogram(N3)
title('N3')

%% qqplot
figure(2)
subplot(211)
qqplot(N1,N3);
title('QQ-Plot N1&N3')
subplot(212)
qqplot(N2,N3);
title('QQ-plot N2&N3')


