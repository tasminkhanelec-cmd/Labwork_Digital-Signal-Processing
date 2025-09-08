clc
clear all
%audio input
[pulseclean, Fs]=audioread("TX signal.wav");
[pulsenoise]=audioread("RX signal.wav");
pulseclean=reshape(pulseclean,[1,length(pulseclean)]);
pulsenoise=reshape(pulsenoise,[1,length(pulsenoise)]);

ns=0:(length(pulseclean)-1);
ts=ns/Fs;

%% problem a
%plotting
figure(1);
subplot(2,1,1);
plot(ts,pulseclean);
title("TX signal vs time");
subplot(2,1,2);
plot(ts,pulsenoise);
title("RX signal vs time");

%% problem b
figure(2);
plot(ts,pulseclean);
xlim([0 0.004]);
title("TX signal vs time (zoomed in)");

%% problem c
%cross co relation
rnc=xcorr(pulsenoise,pulseclean);
Lnc=length(rnc);
n=(Lnc-1)/2;
nnc=-n:n; 

%% plotting
figure(3);
plot(nnc/Fs,rnc);
title("Cross corelation vs time")

%% delay calculation
[max,ind]=max(rnc);
delay=nnc(ind)/Fs;
velocity=305;
distance=0.5*velocity*delay;
fprintf("The distance of the bird is %f meter\n",distance);

%% problem d
SNR=-22;
sigPower=sum(pulseclean.^2)/length(pulseclean);
noisePower=sigPower/(10^(SNR/10));
noisePowerdB=10*log10(noisePower);
fprintf("The Noise Power in dB is %f dB\n",noisePowerdB);
