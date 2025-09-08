clc
clear all

N=500;
nr=0:499;
ny=nr;
r=randn(1,N);
y=zeros(size(r));
for n=2:500;
    y(n)=r(n)-0.6*y(n-1);
end
rr=fliplr(r);
nrr=-fliplr(nr);
Ryr=conv(y,rr);
kmin=(ny(1)+nrr(1));
kmax=(ny(length(ny))+nrr(length(nrr)));
k=kmin:kmax;

%plotting
subplot(211)
stem(k,Ryr/Ryr(N));
title("Approximate Impulse Response");
xlim([0 50]);

b=[1 0];
a=[1 0.6];
n=0:499;
x=zeros(size(n));
x(1)=1;
yy=filter(b,a,x);
subplot(212);
stem(n,yy);
title("Actual Impulse Response");
xlim([0 50]);