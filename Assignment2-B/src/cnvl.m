function [y,n] = cnvl(x1,n1,x2,n2) 
k_min = n1(1) + n2(1); 
k_max = n1(end) + n2(end); 
n = k_min:k_max; 
y = conv(x1,x2); 
