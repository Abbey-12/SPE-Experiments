function stdev= bstrpstdev(x)
som=0;
for i=1:length(x)
  som=som+x(i);
end
M=som/length(x);
moy=0;
for i=1:length(x)
    moy =moy+ (x(i)-M)^2;
 end
stdev = sqrt((moy)/length(x));

end