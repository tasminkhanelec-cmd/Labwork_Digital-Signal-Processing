clc; 
clear all; 
close all; 
%Generating Transfer Function 
b1=[4 -3]; 
a1=[4 -3 -1]; 
b2=[4 3]; 
a2=[4 -3 1]; 
b3=[1 -1]; 
a3=[1 -13/12 3/8 -1/24]; 
b4=[1 -1]; 
a4=[1 -13/6 7/8 -1/24]; 
syms z h_eq1 h_eq2 h_eq3 h_eq4 
%% problem i 
b_1 = conv(b1,b3); %length(b_1) = {length(b1)+length(b3)}-1 = 3 
a_1 = conv(a1,a3); %length(a_1) = {length(a1)+length(a3)}-1 = 6 
h_eq1=(b_1(1)+b_1(2)*z^-1+b_1(3)*z^-2)/(a_1(1)+a_1(2)*z^-1+a_1(3)*z^-2+a_1(4)*z^
3+a_1(5)*z^-4+a_1(6)*z^-5) 
%% problem ii 
b_2 = conv(b2,b4); %length(b_2) = {length(b2)+length(b4)}-1 = 3 
a_2 = conv(a2,a4); %length(a_2) = {length(a2)+length(a4)}-1 = 6 
h_eq2=(b_2(1)+b_2(2)*z^-1+b_2(3)*z^-2)/(a_2(1)+a_2(2)*z^-1+a_2(3)*z^-2+a_2(4)*z^
3+a_2(5)*z^-4+a_2(6)*z^-5)
%% problem iii 
b_3_1 = conv(b1,a2); %length(b_3_1) = {length(b1)+length(a2)}-1 = 4 
b_3_2 = conv(b2,a1); %length(b_3_2) = {length(b2)+length(a1)}-1 = 4 
b_3 = b_3_1 + b_3_2; %length(b_3) = length(b_3_1)=length(b_3_2) = 4 
a_3 = conv(a1,a2);   
%length(a_3) = {length(a1)+length(a2)}-1 = 5 
h_eq3=(b_3(1)+b_3(2)*z^-1+b_3(3)*z^-2+b_3(4)*z^-3)/(a_3(1)+a_3(2)*z^-1+a_3(3)*z^
2+a_3(4)*z^-3+a_3(5)*z^-4) 
%% problem iv 
b_4_zinv2 = [0 0 4 3]; 
b_4_1 = conv(b1,a2);        
%length(b_4_1) = {length(b1)+length(a2)}-1 = 4 
b_4_2 = conv(b_4_zinv2,a1); %length(b_4_2) = {length(b_4-zinv2)+length(a1)}-1 = 6 
b_4_1 = [b_4_1 0 0];        
%to equalize length(b_4_2) 
b_4 = b_4_1 + b_4_2;        
a_4 = conv(a1,a2);          
%length(b_4) = length(b_4_1)=length(b_4_2) = 6 
%length(a_3) = {length(a1)+length(a2)}-1 = 5 
h_eq4=(b_4(1)+b_4(2)*z^-1+b_4(3)*z^-2+b_4(4)*z^-3+b_4(5)*z^-4+b_4(6)*z^
5)/(a_4(1)+a_4(2)*z^-1+a_4(3)*z^-2+a_4(4)*z^-3+a_4(5)*z^-4)