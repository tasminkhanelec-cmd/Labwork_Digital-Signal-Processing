clc; 
clear all; 
close all; 
%Generating Transfer Function => H(z) 
b_h = [0.0102 0.0408 0.0613 0.0408 0.0102]; 
a_h = [1 -1.9684 1.7359 -0.7245 0.1204]; 
%generating Input => X(z) 
w = input('Please Enter the value of w: '); %Variable Phase 
b_x = [1 -cos(w)]; 
a_x = [1 -2*cos(w) 1]; 
%Generating Output => Y(z)=X(z)*H(z) 
b_y = conv(b_x,b_h); 
a_y = conv(a_x,a_h); 
%Plotting 
n = 50; 
figure(1) 
impz(b_y,a_y,n); 
figure(2) 
zplane(b_y,a_y); 
title('Pole-Zero Plot of Output Function')