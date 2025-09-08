clc;
clear all;
close all;

n = -10:50;
ID = 5; %Student ID = 1906055

coef1 = 1/(6.5-ID);
coef2 = 1/(7.5-ID);
coef3 = 5/(ID-1.5);
coef4 = 1/(ID-1.5);

%System 1
a_c1 = [1 coef1 coef2];
b_c1 = 4;

%System 2
a_c2 = [1 coef3 coef4];
b_c2 = [1 0 0 1];

%% 4_a

delta =1.*(n==0);
h1 = filter(b_c1,a_c1,delta);
h2 = filter(b_c2,a_c2,delta);

%Plotting
subplot(2,1,1)
stem(n,h1);
title('Plot of Impulse Response h(n) of System1')
xlabel('Sample Number')
ylabel('Magnitude')

subplot(2,1,2)
stem(n,h2);
title('Plot of Impulse Response h(n) of System2')
xlabel('Sample Number')
ylabel('Magnitude')

%% 4_b

step = 1.*(n>=0);
u1 = filter(b_c1,a_c1,step);
u2 = filter(b_c2,a_c2,step);

%Plotting
subplot(2,1,1)
stem(n,u1);
title('Plot of Step Response of System1')
xlabel('Sample Number')
ylabel('Magnitude')

subplot(2,1,2)
stem(n,u2);
title('Plot of step Response of System2')
xlabel('Sample Number')
ylabel('Magnitude')

%% 4_c
u = 1.*(n>=0); %Taking Step Input
x_c = 2.*exp(-n).*cos(4*n).*u;

y_c1 = filter(b_c1,a_c1,x_c);
y_c2 = filter(b_c2,a_c2,x_c);

%plotting
subplot(2,1,1)
stem(n,y_c1)
title('Plot of System 1 Response')
xlabel('Sample Number')
ylabel('Magnitude')

subplot(2,1,2)
stem(n,y_c2)
title('Plot of System 2 Response')
xlabel('Sample Number')
ylabel('Magnitude')

%% 4_d
P = 4;
n_d1 = 1:P;
step_d = 1.*(n_d1>=0);

[x_d1,nx_d1] = cnvl(step_d,n_d1,step_d,n_d1);
[sig_d1,n_d2] = shift(x_d1,nx_d1,0);

x_d = zeros(1,length(n));
x_d(find(n>=n_d2(1) & n<=n_d2(end))) = sig_d1;
y_d1 = filter(b_c1,a_c1,x_d);
y_d2 = filter(b_c2,a_c2,x_d);

% Plotting
subplot(2,1,1)
stem(n,y_d1)
title('Plot of System 1 Response')
xlabel('Sample Number')
ylabel('Magnitude')

subplot(2,1,2)
stem(n,y_d2)
title('Plot of System 2 Response')
xlabel('Sample Number')
ylabel('Magnitude')