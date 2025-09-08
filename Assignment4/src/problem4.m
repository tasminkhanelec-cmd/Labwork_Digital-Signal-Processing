clc; 
clear all; 
close all; 
%Voice Signal 
[voice,fs] = audioread('1906044_DSP.mp3'); 
voice = voice(1:length(voice),1); 
n1 = 1:length(voice); 
%Car Noise 
[noise,fsw] = audioread("Car.wav"); 
noise_car = resample(noise,fs,fsw); 
noise_car = noise_car(1:length(voice),1); %Matching length with voice signal 
n2 = 1:length(noise_car); 
n = 1:max(length(n1),length(n2)); 
s = zeros(1,length(n)); 
w = s; 
s(find(n>=n1(1) & n<=n1(end))) = voice; 
w(find(n>=n2(1) & n<=n2(end))) = noise_car; 
%PSD of Voice Signal 
S = fft(s); 
PSD_s = S.*conj(S); 
N1 = length(n); 
f = (0:1/N1:1-1/N1)*fs-(fs)/2;

figure(1) 
subplot(211) 
plot(f,fftshift(abs(PSD_s/fs))); 
xlabel("Frequency [Hz]"); 
ylabel("|S(k)|^2"); 
title("PSD of Voice Signal s(n)"); 
%PSD of corrupted signal 
y = s + w; 
sound(y,fs); 
Y = fft(y); 
PSD_y = Y.*conj(Y); 
subplot(212) 
plot(f,fftshift(abs(PSD_y/fs))); 
xlabel("Frequency [Hz]"); 
ylabel("|Y(k)|^2"); 
title("PSD of Corrupted Signal y(n) with Car Noise"); 
%Correlation from PSD 
s_corr = fftshift(ifft(PSD_s,length(PSD_s)*2)); 
y_corr = fftshift(ifft(PSD_y,length(PSD_y)*2)); 
n_corr = (0:length(s_corr)-1)-length(s_corr)/2; 
figure(2) 
subplot(211) 
plot(n_corr,s_corr); 
xlabel("Sample Number"); 
ylabel("Value"); 
title("Correlation of Voice Signal, Rss"); 
subplot(212) 
plot(n_corr,y_corr); 
xlabel("Sample Number"); 
ylabel("Value"); 
title("Correlation of Corrupted Signal with Car Noise, Ryy");