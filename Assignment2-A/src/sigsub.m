function [z,n]=sigsub(x1,n1,x2,n2) 
n=min(n1(1),n2(1)):max(n1(end),n2(end)); 
z1=zeros(1,length(n)); 
z2=z1; 
z1((n>=n1(1)) & (n<=n1(end)))=x1; 
z2((n>=n2(1)) & (n<=n2(end)))=x2; 
z=z1-z2; 
end 