clc 
clear all 
close all 
%% basic sequence generation 
u=@(n,n0) [(n-n0)>=0]; 
r=@(n,n0) ((n-n0).*((n-n0)>=0)); 
del=@(n,n0) [(n-n0)==0]; 
n=-10:10; 
%% function generation 
%y1 function values 
y1=4*u(n,2)-4*u(n,-3); 
%y2 function values 
y2=r(n,-2)-r(n,0)+u(n,2); 
%y3 function values 
y3=zeros(1,length(n)); 
for k=0:5 
y3=y3+(2^(-k)*del(n,k)); 
end 
%y4 function values 
y4=[2 0 3 -1 .5 -1]; 
n4=-3:2; 
%% Sl and S2 values 
[s1dual,Fs1]=audioread('DSP audio signal.mp3'); 
[s2dual,Fs2]=audioread('DSP audio signal2.aac'); 
%Dual channel to single channel conversion 
s1(1,:)=s1dual(:,1); 
s2(1,:)=s2dual(:,1); 
n1=1:length(s1); 
n2=1:length(s2); 
%% 
sound(s1dual,Fs1) 
%%  
sound(s2dual,Fs2)

%% problem a 
[ya,n]=sigadd(y1,n,y2,n); 
%plotting 
figure(1) 
subplot(3,1,1) 
stem(n,y1); 
title('y1 Signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,2) 
stem(n,y2); 
title('y2 Signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,3) 
stem(n,ya,'Color','#C41E3A'); 
title('Output signal from addition') 
xlabel('Sample Number') 
ylabel('Magnitude') 

%% problem b 
yb=sigsub(y1,n,y3,n); 
%plotting 
figure(2) 
subplot(3,1,1) 
stem(n,y1); 
title('y1 Signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,2) 
stem(n,y3); 
title('y3 Signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,3) 
stem(n,yb,'Color','#C41E3A'); 
title('Output signal from subtraction') 
xlabel('Sample Number') 
ylabel('Magnitude')

%% problem c 
[yc,nc]=sigfold(y1,n); 
%plotting 
figure(3) 
subplot(2,1,1) 
stem(n,y1); 
title('y1 signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(2,1,2) 
stem(nc,yc,'Color','#C41E3A'); 
title('Output signal from folding') 
xlabel('Sample Number') 
ylabel('Magnitude')

%% problem d 
[yd,nd]=sigupsample(y2,n,2); 
%plotting 
figure(4) 
subplot(2,1,1) 
stem(n,y2); 
title('y2 signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(2,1,2) 
stem(nd,yd,'Color','#C41E3A'); 
title('Output signal from upsampling') 
xlabel('Sample Number') 
ylabel('Magnitude') 

%% problem e 
[s1e,ne]=sigupsample(s1,n1,2); 
%plotting 
figure(5) 
subplot(2,1,1) 
stem(n1,s1); 
title('s1 signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(2,1,2) 
stem(ne,s1e,'Color','#C41E3A'); 
title('Output signal from upsampling') 
xlabel('Sample Number') 
ylabel('Magnitude') 
%%  
sound(s1e,Fs1)

%% problem f 
[s2f,nf]=sigupsample(s2,n2,3); 
%plotting 
figure(6) 
subplot(2,1,1) 
stem(n2,s2); 
title('s2 signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(2,1,2) 
stem(nf,s2f,'Color','#C41E3A'); 
title('Output signal from upsampling') 
xlabel('Sample Number') 
ylabel('Magnitude') 
%% 
sound(s2f,Fs2) 

%% problem g 
[yg,ng]=sigshift(y3,n,5); 
%padding 
nplotg=min(ng(1),n(1)):max(ng(end),n(end)); 
y3plotg=zeros(1,length(nplotg)); 
ygplotg=y3plotg; 
y3plotg(find((nplotg>=n(1))&(nplotg<=n(end))))=y3; 
ygplotg(find((nplotg>=ng(1))&(nplotg<=ng(end))))=yg; 
%plotting 
figure(7) 
subplot(2,1,1) 
stem(nplotg,y3plotg); 
title('y3 signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(2,1,2) 
stem(nplotg,ygplotg,'Color','#C41E3A'); 
title('Output signal from shifting') 
xlabel('Sample Number') 
ylabel('Magnitude')

%% problem h 
[yh1,nh1]=sigshift(y4,n4,1); 
[yh2,nh2]=sigshift(y4,n4,-1); 
[yh,nh]=sigadd(yh1,nh1,yh2,nh2); 
%padding 
n4ploth=min([n4(1),nh1(1),nh2(1)]):max([n4(end),nh1(end),nh2(end)]) 
y4ploth=zeros(1,length(n4ploth)); 
yh1ploth=y4ploth; 
yh2ploth=y4ploth; 
yhploth=y4ploth; 
y4ploth(find((n4ploth>=n4(1))&(n4ploth<=n4(end))))=y4; 
yh1ploth(find((n4ploth>=nh1(1))&(n4ploth<=nh1(end))))=yh1; 
yh2ploth(find((n4ploth>=nh2(1))&(n4ploth<=nh2(end))))=yh2; 
yhploth(find((n4ploth>=nh(1))&(n4ploth<=nh(end))))=yh; 
%plotting 
figure(8) 
subplot(4,1,1) 
stem(n4ploth,y4ploth,'Color','#008000'); 
title('y4 signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(4,1,2) 
stem(n4ploth,yh1ploth); 
title('Right shifted signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(4,1,3) 
stem(n4ploth,yh2ploth); 
title('Left shifted signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(4,1,4) 
stem(n4ploth,yhploth,'Color','#C41E3A'); 
title('Output signal') 
xlabel('Sample Number') 
ylabel('Magnitude')

%% problem i 
[yifold,ni]=sigfold(y3,n); 
[yieven,nploti]=sigadd(y3,n,yifold,ni); 
[yiodd,nploti]=sigsub(y3,n,yifold,ni); 
yieven=yieven/2; 
yiodd=yiodd/2; 
%padding 
y3ploti=zeros(1,length(nploti)); 
y3ploti(find((nploti>=n(1))&(nploti<=n(end))))=y3; 
%plotting 
figure(9) 
subplot(3,1,1) 
stem(nploti,y3ploti,'Color','#008000'); 
title('y3 Signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,2) 
stem(nploti,yieven) 
title('Even Signal') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,3) 
stem(nploti,yiodd) 
title('Odd Signal') 
xlabel('Sample Number') 
ylabel('Magnitude') 

%% problem j 
[yjfold,nj]=sigfold(y4,n4); 
[yjeven,n4plotj]=sigadd(y4,n4,yjfold,nj); 
[yjodd,n4plotj]=sigsub(y4,n4,yjfold,nj); 
yjeven=yjeven/2; 
yjodd=yjodd/2; 
%padding 
y4plotj=zeros(1,length(n4plotj)); 
y4plotj(find((n4plotj>=n4(1))&(n4plotj<=n4(end))))=y4; 
%plotting 
figure(10) 
subplot(3,1,1) 
stem(n4plotj,y4plotj,'Color','#008000'); 
title('y4 Signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,2) 
stem(n4plotj,yjeven) 
title('Even Signal') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,3) 
stem(n4plotj,yjodd) 
title('Odd Signal') 
xlabel('Sample Number') 
ylabel('Magnitude')

%% problem k 
[s2kfold,nk]=sigfold(s2,n2); 
[s2keven,n2plotk]=sigadd(s2,n2,s2kfold,nk); 
[s2kodd,n2plotk]=sigsub(s2,n2,s2kfold,nk); 
s2keven=s2keven/2; 
s2kodd=s2kodd/2; 
%padding 
s2plotk=zeros(1,length(n2plotk)); 
s2plotk(find((n2plotk>=n2(1))&(n2plotk<=n2(end))))=s2; 
%plotting 
figure(11) 
subplot(3,1,1) 
stem(n2plotk,s2plotk,'Color','#008000'); 
title('S2 Signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,2) 
stem(n2plotk,s2keven) 
title('Even Signal') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,3) 
stem(n2plotk,s2kodd) 
title('Odd Signal') 
xlabel('Sample Number') 
ylabel('Magnitude') 
%% 
sound(s2keven,Fs2) 
%% 
sound(s2kodd,Fs2)

%% problem l 
[s1lfold,nl]=sigfold(s1,n1); 
[s1leven,n1plotl]=sigadd(s1,n1,s1lfold,nl); 
[s1lodd,n1plotl]=sigsub(s1,n1,s1lfold,nl); 
s1leven=s1leven/2; 
s1lodd=s1lodd/2; 
%padding 
s1plotl=zeros(1,length(n1plotl)); 
s1plotl(find((n1plotl>=n1(1))&(n1plotl<=n1(end))))=s1; 
%plotting 
figure(12) 
subplot(3,1,1) 
stem(n1plotl,s1plotl,'Color','#008000'); 
title('S2 Signal plot') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,2) 
stem(n1plotl,s1leven) 
title('Even Signal') 
xlabel('Sample Number') 
ylabel('Magnitude') 
subplot(3,1,3) 
stem(n1plotl,s1lodd) 
title('Odd Signal') 
xlabel('Sample Number') 
ylabel('Magnitude') 
%% 
sound(s1leven,Fs1) 
%% 
sound(s1lodd,Fs1)