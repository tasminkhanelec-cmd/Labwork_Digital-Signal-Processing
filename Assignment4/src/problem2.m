clc; 
clear all; 
close all; 
fs = 2000; 
ts = 1 / fs; 
t = 0:ts:10; 
%LHS 
x = 4*sin(240*pi*t); 
Et = sum(x.^2) 
%RHS => FFT 
X = fft(x, length(t)); %N-point FFT 
Ef = sum(X.*conj(X)) / length(t)