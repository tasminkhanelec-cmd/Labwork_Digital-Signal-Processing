clc; 
clear all; 
close all; 
[m_voice1,fs_1] = audioread("1906044.aac"); 
[m_voice2,fs_2] = audioread("1906055.ogg"); 

%Converting 2D arrays of voice signals to 1D arrays 
m_voice1 = m_voice1(1:length(m_voice1),1); 
m_voice2 = m_voice2(1:length(m_voice2),1); 

%Downsampling the Audio Signals 
m_voice1 = reshape(m_voice1,[1 length(m_voice1)]); 
m_voice2 = reshape(m_voice2,[1 length(m_voice2)]); 
n_m1 = 1:length(m_voice1); 
n_m2 = 1:length(m_voice2); 
n = 1:max(n_m1(end),n_m2(end)); 
m_1_1 = zeros(1,length(n)); 
m_2_2 = m_1_1; 
m_1_1(find((n>=n_m1(1)) & (n<=n_m1(end)))) = m_voice1; 
m_2_2(find((n>=n_m2(1)) & (n<=n_m2(end)))) = m_voice2; 
fs_lower = 40000; 
to = length(m_1_1)/fs_lower; 
t_lower = [0:1/fs_lower:to-1/fs_lower]; 
t = 0:1/fs_lower:to-1/fs_lower; 
m_1 = interp1(t,m_1_1,t_lower); 
m_2 = interp1(t,m_2_2,t_lower); 
%Modulation 
fc_1 = 5000; 
fc_2 = 10000; 
c_1 = cos(2*pi*fc_1*t_lower); 
c_2 = cos(2*pi*fc_2*t_lower); 
N = length(t); 
f = [0:1/N:1-1/N]*fs_lower-fs_lower/2; 
u_1 = m_1.*c_1; 
u_2 = m_2.*c_2; 
u = u_1 + u_2; 
figure(1) 
subplot(211);  
plot(f,abs(fftshift(fft(m_1,N)))); 
xlabel('Frequency [Hz]'); 
ylabel('DFT Magnitude'); 
title('M1(f)'); 
subplot(212);  
plot(f,abs(fftshift(fft(m_2,N)))); 
xlabel('Frequency [Hz]'); 
ylabel('DFT Magnitude'); 
title('M2(f)'); 
y = abs(fftshift(fft(u))); 
figure(2) 
subplot(211); 
plot(f,abs(y/fs_lower));  
xlabel('Frequency [Hz]'); 
ylabel('DFT Magnitude'); 
title('Summation of Modulated Signals without Noise'); 
SNR = 10; %in dB 
P_x = sum(u.^2) / length(u); 
P_y = P_x/10^(SNR/10); 
n = sqrt(P_y) * randn(1,length(u)); 
u_noise = u + n; 
y_noise = abs(fftshift(fft(u_noise))); 
subplot(212) 
plot(f,abs(y_noise/fs_lower)); 
xlabel('Frequency [Hz]'); 
ylabel('DFT Magnitude'); 
title('Summation of Modulated Signals with Noise'); 
%Receiving end  
BPF_1 = zeros(1,N); 
BPF_2 = BPF_1; 
BPF_1(f>2500 & f<7500) = 1; 
BPF_1(f>-7000 & f<-2500) = 1; 
BPF_2(f>8000 & f<12000) = 1; 
BPF_2(f>-12000 & f<-8000) = 1; 
y_1 = y_noise.*BPF_1; 
y_2 = y_noise.*BPF_2; 

figure(3) 
subplot(211); 
plot(f,abs(y_1/fs_lower)); 
xlabel('Frequency [Hz]'); 
ylabel('DFT Magnitude'); 
title('Spectrum 1 (y_1) after BPF'); 
subplot(212) 
plot(f,abs(y_2/fs_lower)); 
xlabel('Frequency [Hz]'); 
ylabel('DFT Magnitude'); 
title('Spectrum 2 (y_2) after BPF');
%Demodulation 
y_1_1 = ifft(y_1); 
y_2_2 = ifft(y_2); 
r_1 = y_1_1.*c_1; 
r_2 = y_2_2.*c_2; 
y1_f = fft(r_1); 
y2_f = fft(r_2); 
figure(4) 
subplot(211); 
plot(f,abs(y1_f/fs_lower)); 
xlabel('Frequency [Hz]');  
ylabel('DFT Magnitude');  
title('Spectrum 1 (y1) before LPF'); 
subplot(212); 
plot(f,abs(y2_f/fs_lower));  
xlabel('Frequency [Hz]'); 
ylabel('DFT Magnitude'); 
title('Spectrum 2 (y2) before LPF'); 
%LPF Design 
LPF_1 = zeros(1,N); 
LPF_2 = LPF_1; 
LPF_1(abs(f)<1000) = 1; 
LPF_2(abs(f)<2000) = 1; 

%Message Recovery 
m1_r = y1_f.*LPF_1; 
m2_r = y2_f.*LPF_2; 
figure(5) 
subplot(211); 
plot(f,abs(m1_r/fs_lower)); 
xlabel('Frequency [Hz]'); 
ylabel('DFT Magnitude'); 
title('Reconstructed Signal 1'); 
subplot(212); 
plot(f,abs(m2_r/fs_lower)); 
xlabel('Frequency [Hz]'); 
ylabel('DFT Magnitude'); 
title('Reconstructed signal 2'); 
sound(abs(ifft(ifftshift(m1_r))),fs_lower); 
%sound(abs(ifft(ifftshift(m2_r))),fs_lower);
