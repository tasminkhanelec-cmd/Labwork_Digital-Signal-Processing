clc; 
clear all; 
close all; 
%Poles 
p1 = -0.25 + 0.74*i; 
p2 = conj(p1); 
p3 = -0.18 + 0.4*i; 
p4 = conj(p3); 
p5 = -0.16 + 0.13*i; 
p6 = conj(p5); 
%Zeros 
z1 = 1; 
num1 = conv([1, -z1], [1, -z1]); 
num2 = conv(num1, [1, -z1]); 
num3 = conv(num2, [1, -z1]); 
num4 = conv(num3, [1, -z1]); 
num = conv(num4, [1, -z1]); 
den1 = conv([1, -p1], [1, -p2]); 
den2 = conv(den1, [1, -p3]); 
den3 = conv(den2, [1, -p4]); 
den4 = conv(den2, [1, -p5]); 
den = conv(den2, [1, -p6]);
[h,w] = freqz(num, den); 
plot(w, abs(h)); 
title('Frequency Response'); 
xlabel('\omega'); 
ylabel('Magnitude'); 
xlim([0 3]);

%% ii
%Poles 
p1 = 0.86*exp(deg2rad(22.66)*i); 
p2 = 0.86*exp(-deg2rad(22.66)*i); 
p3 = 0.67*exp(deg2rad(10.48)*i); 
p4 = 0.67*exp(-deg2rad(10.48)*i); 
%Zeros 
z1 = exp(deg2rad(76.35)*i); 
z2 = exp(-deg2rad(76.35)*i); 
z3 = exp(deg2rad(124.45)*i); 
z4 = exp(-deg2rad(124.45)*i);

%% iii

%Poles 
p1 = 0.16 + 0.96*i; 
p2 = conj(p1); 
p3 = 0.35 + 0.81*i; 
p4 = conj(p3); 
p5 = 0.57 + 0.8*i; 
p6 = conj(p5); 
%Zeros 
z1 = 1; 
z2 = -1; 
z3 = 0.08 + 0.99*i; 
z4 = conj(z3); 
z5 = 0.64 + 0.77*i; 
z6 = conj(z5);

%% iv

%Poles 
p1 = 0.98*exp(deg2rad(35)*i); 
p2 = 0.98*exp(-deg2rad(35)*i); 
%Zeros 
z1 = exp(deg2rad(35)*i); 
z2 = exp(-deg2rad(35)*i); 