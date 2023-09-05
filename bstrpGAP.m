function GAP= bstrpGAP(x)
som=0;
for i=1:length(x)
  som=som+x(i);
end
M=som/length(x);
moy=0;
for i=1:length(x)
    moy=moy+abs(x(i)-M);
end
GAP=moy/(2*M*length(x));

