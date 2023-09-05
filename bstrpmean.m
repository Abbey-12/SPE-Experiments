function M= bstrpmean(x)
som=0;
for i=1:length(x)
  som=som+x(i);
end
M=som/length(x);
