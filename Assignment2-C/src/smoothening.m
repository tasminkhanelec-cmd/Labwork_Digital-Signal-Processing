clc
clear all
N=50;
n=1:N;
x=2.*n.*(0.9).^n;
noise=rand(1,N)-0.5;
xnoise=x+noise;
x1=xnoise;

subplot(311)
plot(n,x)
title('Original Signal')
subplot(312)
plot(n,noise)
title('Noise')
subplot(313)
plot(n,xnoise)
title('Distorted signal')

%%
E=3;
z=zeros(1,N-1);
for i=0:(E-1)
    z=[z 0]+x1;
    x1=[0 x1];
end
z=z/E;

%%
subplot(211)
plot(n,x,'DisplayName','Original Signal')
hold on
plot(n,xnoise,'DisplayName','Without MA')
legend
subplot(212)
plot(n,x,'DisplayName','Original Signal')
hold on
plot(n,z(1:length(n)),'.-')
legend


    