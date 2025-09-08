%% problem 1
clc
clear all
close all

%% building the windows

M=25;
n=-(M-1)/2:(M-1)/2;
Z=512;
titles = {'Rect','Bartlett','Hanning','Hamming','Blackman'};
win = { rectwin(M) , bartlett(M) , hanning(M) , hamming(M) , blackman(M) };

%% plot on a single figure

figure(1)
for i=1:5
    plot(n,win{i},'Linewidth',1.1)
    hold on
end
xlabel('n')
ylabel('w(n)')
title('Family of windows');
legend(titles);

%% magnitude spectrums in dB

for i=1:5
    W=abs(fftshift(fft(win{i},Z)));
    w=linspace(-pi,pi,Z);
    figure(i+1)
    plot(w,20*log10(W))
    title(sprintf('Magnitude response (dB) of %s window', titles{i}))
    xlabel('\omega/\pi')  
    ylabel ('20log|W(e^{i\omega}|') ;
    grid on
end

%% problem 2

clc;
clear;
close all;

n = -1000:1000;
xn = sin(0.32*pi*n)+sin(.37*pi*n)+sin(0.4*pi*n);

%minimum frequency difference 0.03*pi
diff = 0.03*pi;
diff=diff/2;
w = linspace(0,2*pi,1000);
wn= linspace(-pi,pi,1000);

%Windows
N1 = 2;
N2 = 4;
N3 = 6;

%For rectangular
while(1)
    win1 = rectwin(N1)';
    H1 = abs(fft(win1,1000));
    [val,I]=findpeaks(-H1);

    if(numel(I)~=0 && w(I(1))<diff)
        a=3;
        break
    end
    N1 = N1+1;
End



%For bartlett
while(1)
    win2 = bartlett(N2)';
    H2 = abs(fft(win2,1000));
    [val,I]=findpeaks(-H2);
    if(numel(I)~=0 && w(I(1))<diff)
        break
    end
    N2 = N2+1;
end

% for blackman
while(1)
    win3 = blackman(N3)';
    H3 = abs(fft(win3,1000));
    [val,I]=findpeaks(max(H3)-H3);
    if(numel(I)~=0 && w(I(1))<diff)
        break
    end
    N3 = N3+1;
end

%% Output for different window

n1=-ceil(length(win1)/2):floor((length(win1))/2-1);
n2=-ceil(length(win2)/2):floor((length(win2))/2-1);
n3=-ceil(length(win3)/2):floor((length(win3))/2-1);

w1pad=zeros(1,length(xn));
w1pad(find(n>=n1(1) & n<=n1(end)))=win1;
out1=abs(fftshift(fft((xn.*w1pad),1000)));

w2pad=zeros(1,length(xn));
w2pad(find(n>=n2(1) & n<=n2(end)))=win2;
out2=abs(fftshift(fft((xn.*w2pad),1000)));

w3pad=zeros(1,length(xn));
w3pad(find(n>=n3(1) & n<=n3(end)))=win3;
out3=abs(fftshift(fft((xn.*w3pad),1000)));
















%% plotting

figure (1)
subplot(411)
plot(wn/pi,abs(fftshift(fft(xn,1000))))
title('Original signal frequency spectrum')
xlabel('\omega/\pi')
xlim([-1 1])
subplot(412)
plot(wn/pi,out1)
title('Output frequency spectrum for rectangular window')
xlabel('\omega/\pi')
xlim([-1 1])
subplot(413)
plot(wn/pi,out2)
title('Output frequency spectrum for bartlett window')
xlabel('\omega/\pi')
xlim([-1 1])
subplot(414)
plot(wn/pi,out3)
title('Output frequency spectrum for blackman window')
xlabel('\omega/\pi')
xlim([-1 1])

%% more plotting

figure(2)
subplot(321)
plot(n,w1pad,'LineWidth',1.25)
title('Time domain plot for rectangular window')
xlabel('n')
subplot(322)
plot(wn/pi,abs(fftshift(fft(w1pad,1000))),'LineWidth',1.1)
xlabel('\omega/\pi')
title('Frequency spectrum for rectangular window')

subplot(323)
plot(n,w2pad,'LineWidth',1.25)
title('Time domain plot for bartlette window')
xlabel('n')
subplot(324)
plot(wn/pi,abs(fftshift(fft(w2pad,1000))),'LineWidth',1.1)
xlabel('\omega/\pi')
title('Frequency spectrum for bartlett window')

subplot(325)
plot(n,w3pad,'LineWidth',1.25)
title('Time domain plot for blackman window')
xlabel('n')
subplot(326)
plot(wn/pi,abs(fftshift(fft(w3pad,1000))),'LineWidth',1.1)
xlabel('\omega/\pi')
title('Frequency spectrum for blackman window')

%% Problem 3

clc
clearvars
close all

%% origninal signal
y=@(n) sin(0.15*pi*n)+sin(0.35*pi*n)+sin(0.62*pi*n);

%% general parameters
wp=0.22;
ws=0.58;
wc=(wp+ws)/2;
delta=.005; %value taken lower than both the deltas
A=-20*log10(delta);
M=ceil(1+((A-8)/(2.285*(ws-wp))));
L=M-1;
if A<21
beta=0;
elseif A>=21 && A<=50
beta=.5842*(A-21)^.4+.07886*(A-21);
else
beta=.1102*(A-8.7);
end

%% constructing three filters
wnL = 0.2;
wnB = [0.3 0.4];
wnH = 0.6;
b(1,:) = fir1(M,wnL,'low',kaiser(M+1,beta));
b(2,:) = fir1(M,wnB,'bandpass',kaiser(M+1,beta));
b(3,:) = fir1(L,wnH,'high',kaiser(M+1,beta));
freq = [0.15 0.35 0.65];

%% filtering

for i=1:3

    [f(i,:),w(i,:)]=freqz(b(i,:),1);
    w(i,:)=normalize(w(i,:),'range',[-1,1]);
    n(i,:)=0:length(w(i,:))-1;
    f(i,:)=filter(b(i,:),1,y(n(i,:)));

    figure(i)

    subplot(211)

    plot(w(i,:),abs(fftshift(fft(f(i,:)))))
    xlabel('normalized frequency')
    title(sprintf('Isolated frequency %0.2f *pi',freq(i)))

    subplot(212)

    plot(n(i,:),f(i,:))
    title(sprintf('Discrete time domain plot for isolated frequency %0.3f*pi',   freq(i)))
    xlim([0 300]);
    xlabel('Samples')

end

%% plot for original

figure(4)

subplot(211)

plot(w(1,:),abs(fftshift(fft(y(n(1,:))))))
title('Frequency components of the original signal')
xlabel('\omega/\pi') 

subplot(212)

plot(n(1,:),y(n(1,:)))
title('Discrete time domain plot for original signal')
xlim([0 500]);

