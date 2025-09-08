function [y,n]=product_1(x1,n1,x2,n2) 
n = min(n1(1),n2(1)) : max(n1(end),n2(end)); 
x1_i = zeros(1,length(n)); 
x2_i = zeros(1,length(n));  
x1_i(find(n>=n1(1) & n<=n1(end))) = x1; 
x2_i(find(n>=n2(1) & n<=n2(end))) = x2; 
y = x1_i.*x2_i;