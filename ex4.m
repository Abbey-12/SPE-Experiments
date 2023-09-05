%%%%%%%%%% Exercise 4

clear all;
close all;
clc
%%%%% Emperical PMF

value =[2 3 4 5 6 7 8 9 10 11 12];
occurrences=[3 4 2 7 10 9 5 13 7 5 3];
n=length(occurrences);
N=sum(occurrences);% total  number of occurrences
pmf=zeros(1,n);%emperical PMF
for i=1:n
pmf(i)=occurrences(i)./N;
end

%%Theortical probability
value1=[2 3 4 5 6 7];
value2=[8 9 10 11 12];
n1=length(value1);
pmf1=zeros(1,n1);
for i=1:n1
    pmf1(i)=value1(i)-1;
end
pmf1=pmf1./36;
n2=length(value2);
pmf2=zeros(1,n2);
for i=1:n2
    pmf2(i)=13-value2(i);
end
pmf2=pmf2./36;
PMF=horzcat(pmf1,pmf2);%Theortical probability

%%%%%chi_squre test
T=0;
for i=1:n
    T=T+((occurrences(i)-(N*PMF(i))).^2)./(N*PMF(i));
end
P=1-chi2cdf(T,10);
%% Emperical PMF & Discrete triangular distribution
subplot(211)
plot(value,pmf);
title('Emperical PMF')
subplot(212)
plot(value,PMF);
title('Discrete triangular distribution')
fprintf("\n==================================================\n")
fprintf("Exercise 4\n")
fprintf(" Emperical PMF:")
disp(pmf)
fprintf(" Discrete triangular distribution :")
disp(PMF)
fprintf(" T :")
disp(T);
fprintf(" probability of chi-square greater than T:")
disp(P)
