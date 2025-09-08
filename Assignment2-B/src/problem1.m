clc; 
clear all; 
close all; 
ID = 4; %Student ID = 1906055 
P = 5 + ID; 
n = 1:P; 
step = 1.*(n>=0); 
%Function Generation 
%General triangular function from convolution 
[y,n_y] = cnvl(step,n,step,n); 
[sig_1,n1] = shift(y,n_y,-1); 
[sig_2,n2] = shift(y,n_y,-2*P-1); 
n_x = -50:50; 
% x1(n) 
x1 = zeros(1,length(n_x)); 
x1(find(n_x>=n1(1) & n_x<=n1(end))) = sig_1; 
% x2(n) 
x2 = zeros(1,length(n_x)); 
x2(find(n_x>=n2(1) & n_x<=n2(end))) = sig_2; 
%Plotting 
figure(1) 
subplot(3,1,1) 
stem(n_x,x1); 
title('x1(n) Signal Plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,2) 
stem(n_x,x2); 
title('x2(n) Signal Plot') 
xlabel('Sample Number') 
ylabel('Magnitude')