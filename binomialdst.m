%%%%%%%%Exercise 2.1

%%% Binomial Distribution generator funication 

function  return_array= binomialdst(n,p, size) 
 
 return_array = zeros(size,1) ;
 
for arr =1:size 
ss=0; 
u=rand(1,100); 
for i=1:n 
    if u(i)<p 
      ss=ss+1 ;
    end 
end 
 
  return_array(arr)=ss;     % sum the probability of success  
end  
end