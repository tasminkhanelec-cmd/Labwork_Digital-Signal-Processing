clc;
clear all;
close all;
%generating a pulse by capacitor charging and discharging
t1=-10:0.001:5;
x1=1-exp(-2*t1);

for i=1:length(x1)
    if x1(i)<0
        x1(i)=0;
    else 
       break;
    end
end
t2=5+0.001:0.001:10;
x2=exp(-2*(t2-5));
x=[x1 x2];
t=[t1 t2];


x0=-x;
xa=x;
figure(1);
subplot(211);
plot(t,x0);
title('0 pulse');
subplot(212);
plot(t,xa);
title('1 pulse');

Tx=input('Press 1 or 0: ');
SNR=-5;

if Tx==1
    px=sum(x.^2)/length(x);
    py=px/(10^(SNR/10));
    n=sqrt(py)*randn(1,length(x));
    y=x+n;
    cc1=xcorr(x,y);
    cc2=xcorr(-x,y);
else
    px=sum(x.^2)/length(x);
    py=px/(10^(SNR/10));
    n=sqrt(py)*randn(1,length(x));
    y=-x+n;
    cc1=xcorr(x,y);
    cc2=xcorr(-x,y);
end

tcc=(1:length(cc1))*0.001;
tcc1=tcc-((length(tcc)+1)/2)*0.001;
figure(2);
plot(tcc1,cc1,tcc1,cc2);
legend('Correlation with 1', 'Correlation with 0');

for i=1:length(tcc1)
    if tcc1(i)==0
        break;
    end
end

if cc1(i)>cc2(i)
    fprintf('The sequence Transmitted is 1');
else
    fprintf('The sequence Transmitted is 0');
end



