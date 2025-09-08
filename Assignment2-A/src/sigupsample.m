function [zup,nup] = sigupsample(x,n,L) 
nup=n(1)*L:n(end)*L; 
zup=zeros(1,length(nup)); 
for i=1:length(x) 
zup(i+((i-1)*(L-1)))=x(i); 
end 
end