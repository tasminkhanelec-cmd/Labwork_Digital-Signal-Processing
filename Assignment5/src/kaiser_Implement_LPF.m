clc
clear

f1=250;
f2=750;
f3=980;
fs=4000;
fcut=300; % LOW PASS CUT OFF
t=0:1/10000:1000;
x=sin(2*pi*f1*t)+0.5*sin(2*pi*f2*t)+0.7*cos(2*pi*f3*t);
samp_x=0:(1/fs):100;
samp_y=interp1(t,x,samp_x);
wc=2*pi*(fcut/fs);

%specification
factor=4;
wp=wc-0.1;
ws=wc+0.2;

delp=0.005;
dels=0.05;

del=min(delp,dels);
delw=ws-wp;
A=-20*log10(del);
M=ceil(1+(A-8)/(2.285*delw));

if A<21
    beta=0;
elseif A>=21 && A<=50
    beta=0.5842*(A-21)^0.4+0.07886*(A-21);
else 
    beta=0.1102*(A-8.7);
end

n=0:M-1;
w=kaiser(M,beta);

h1=(wc/(pi))*sinc((wc/(pi))*(n-(M-1)/2));
hp=h1.*w';
f=linspace(-1/2,1/2,size(20*log10(fftshift(abs(fft(h1,factor*M)))),2));
figure(1)
subplot(2,1,1), plot(f,(fftshift(abs(fft(h1,factor*M)))));
subplot(2,1,2), plot(f,(fftshift(abs(fft(hp,factor*M)))));

figure(2)
X=fft(samp_y,factor*M);
subplot(2,1,1), plot(f*fs,(fftshift(abs(X))));
subplot(2,1,2), plot(f*fs,(fftshift(abs(X.*fft(hp,factor*M)))));





