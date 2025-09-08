clc; 
clear all; 
close all; 
n = -20:50; 
%Taking Bounded Impulse Input 
x_del = 1.*(n==0); 
% Varying A1 & Fixing A2  
A2 = 0.5; 
%% A1 = 0 
A1 = 0; 
a = [1 A1 A2]; %Coefficients of y 
b = [1 0 0 3]; %Coefficients of x 
y = filter(b,a,x_del); 
stem(n,y); 
title(['A1=' num2str(A1) ', A2=0.5']) 
xlabel('Sample Number') 
ylabel('Magnitude')

%% 3_b
clc; 
clear all; 
close all; 
n = -20:50; 
%Taking Bounded Impulse Input 
x_del = 1.*(n==0); 
% Varying A1 & Fixing A2  
A2 = 0.5; 
%% A1 = 0 
A1 = 0; 
a = [1 A1 A2]; %Coefficients of y 
b = [1 0 0 3]; %Coefficients of x 
y = filter(b,a,x_del); 
stem(n,y); 
title(['A1=0.5 A2=' num2str(A2)]) 
xlabel('Sample Number') 
ylabel('Magnitude') 