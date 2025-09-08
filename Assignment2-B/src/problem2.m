clc; 
clear all; 
close all; 
ID = 4; %Student ID = 1906044 
coeff = 4/(ID+8); 
% Assumption: Initially Relaxed LTI 
%% Finding Impulse Response 
n = -10:20; 
x=1.*(n==0);  
for i=1:length(n) 
if n(i)<0 
h(i)=0; 
else 
h(i) = -coeff*h(i-1)+x(i); 
end 
end 
%% Finding Step Response 
n = -10:20; 
x=1.*(n>=0);  
for i=1:length(n) 
if n(i)<0 
u(i)=0; 
else 
u(i) = -coeff*u(i-1)+x(i); 
end 
end 
%Plotting 
subplot(2,1,1) 
stem(n,h); 
title('Plot of Impulse Response of System') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(2,1,2) 
stem(n,u); 
title('Plot of Step Response of System') 
xlabel('Sample Number') 
ylabel('Magnitude') 
