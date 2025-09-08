%sampling the inputs
fs=10000;
ts=0:1/fs:0.1;
ns=ts*fs;
u=1*[ts>=0];
an=4*exp(-6*ts).*sin(400*ts).*u;
bn=2*exp(-6*ts).*sin(400*ts-(pi/10)).*(1-exp(-1000*ts)).*u;

%cross corelation
z=xcorr(bn,an);
nf=-flip(ns);
ncorr=(ns(1)+nf(1)):(ns(end)+nf(end));

%plotting
figure(1);
subplot(3,1,1);
plot(ns/fs,an);
title("a(n) vs time");
subplot(3,1,2);
plot(ns/fs,bn);
title("b(n) vs time");
subplot(3,1,3)
stem(ncorr/fs,z);
title("Cross Correlation vs time");

%delay calculation
[m,i]=max(z);
delay=ncorr(i)/fs;
distance=2;
velocity=distance/delay;
fprintf("The velocity of sound in the plastic medium is %f m/s\n",velocity);

