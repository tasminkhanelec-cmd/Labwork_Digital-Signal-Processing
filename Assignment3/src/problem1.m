clc; 
clear all; 
close all; 
%% problem i 
%Generating Transfer Function 
b = [4 -3];       
a = [4 -3 -1];    
%for zeros 
%for poles 
[r,p,c] = residuez(b,a); 

%time domain expression 
pstr = string(p); 
rstr = string(r); 
m = ''; 
for i=1:length(pstr) 
m = m + rstr(i) + '('+pstr(i)+'^n'+')' + ' + '; 
end 
m=char(m); 
m(find(m=='+',1,'last'):end)=[]; 
m = '{ ' + string(m) + '}*u[n]'; 
disp(m) 

%Pole-Zero Plot 
figure(1) 
zplane(b,a);

%Plotting Causal Impulse Response 
n=-10:20; 
figure(2) 
impz(b,a,n); 
xlabel('Sample Number') 
ylabel('Amplitude') 
title('Causal Impulse Response') 
%% Problem ii 
%Magnitude & Phase Response 
fvtool(b,a); 
%% Problem iii 
%Stabilizing the Unstable System 
bnew=b; 
for j=1:length(p) 
if (abs(p(j))) >= 1 
bnew = conv(bnew,[1,-p(j)]); 
end 
end 
[rnew,pnew,c] = residuez(bnew,a); 
figure(3) 
zplane(bnew,a) 
figure(4) 
impz(bnew,a)

%% 3_1-b
syms x y j k m n 
x = p(1); 
y = p(2); 
j = R(1); 
k = R(2); 
h = (j*x^n + k*y^n); 
m ='('+ string(h) + ')*u[n]'; 
disp(m) 

