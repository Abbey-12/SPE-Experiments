function JFI= bstrpJFI(x)
num=0;
for i=1:length(x)
  num=num+x(i);
end
num=(num)^2;
dum=0;
for i=1:length(x)
    dum=dum+(x(i))^2;
end
JFI=num/(length(x)*dum);

