clc
clear all
close all

%Analog signal generation
R=55;
Fs=240*R;
y=@(t) sin(2*pi*20*R*t)+sin(2*pi*60*R*t)+sin(2*pi*120*R*t);
t=0:0.000001:0.001;

%Analog signal plot
subplot(4,1,1)
plot(t,y(t),'Color','#008000')
xlabel('Time')
title("Analog Signal")

%Sampling the signal
ts=0:1/Fs:0.001;
ys=y(ts);

%Sampled signal plot
subplot(4,1,2)
stem(ts,ys)
xlabel('Time')
title("Sampled Signal")

%Reconstruction
yr=interp1(ts,ys,t);

%Reconstructed signal plot
subplot(4,1,3)
plot(t,yr,'k')
xlabel('Time')
title("Reconstructed Signal")

%Error calculation
err=(yr-y(t));

%Error plot
subplot(4,1,4)
plot(t,err,'Color','#C41E3A')
xlabel('Time')
title("Error Signal")
