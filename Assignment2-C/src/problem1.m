clc
clear all

%input signal
x1=[ 1 1 2 -3 4 2 1 8 2 4];
x2=[ 0 5 4 8 -9 2 3 1 1 7];
n1=-2:7;
n2=-6:3;

%cross corelation
[rx1x2,n]=ccr(x1,n1,x2,n2);

%plotting
stem(n,rx1x2/max(rx1x2));
title("Cross corelation vs n")


