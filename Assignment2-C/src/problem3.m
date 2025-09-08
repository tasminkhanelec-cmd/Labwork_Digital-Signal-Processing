clc
clear all
close all

%audio input
[y,fs]=audioread("DSP audio signal.mp3");
y=y(:,1);
ys=y';

%auto correlation of y
ryy=(xcorr(ys));
Lyy=length(ryy);
n=(Lyy-1)/2;
nyy=-n:n;        
tyy=nyy/fs;

%plotting
subplot(2,1,1)
plot(nyy/fs,ryy);
title("Curve of auto corelation vs time");
subplot(2,1,2)
plot(tyy,ryy);
title("Zoomed into peaks");
xlim([-0.01 0.01]);

%defining searching range
izero=n+1;
range=0.1;
irange=(izero+range*fs);

%searching for second hightest peak
k=1;
for j=izero+1:irange
    if ryy(j)>ryy(j-1) && ryy(j)>ryy(j+1)
        maximas(k)=ryy(j);
        imaximas(k)=j;
        k=k+1;
    end
end

[peak2,imax]=max(maximas);
imax=imaximas(imax);

%pitch calculation
delt=tyy(imax);
pitch=1/delt;
fprintf("\nThe pitch of the input voice is  %f Hz\n",pitch);