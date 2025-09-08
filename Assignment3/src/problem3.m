clc; 
clear all; 
%Generating Input =  X(z) 
b_x1 = [1]; 
a_x1 = [1 -1/2]; 
b_x2 = [0 1]; 
a_x2 = [1 -3/4]; 
b_1 = conv(b_x1,a_x2); %length(b_1) = {length(b_x1)+length(a_x2)}-1 = 2 
b_2 = conv(b_x2,a_x1); %length(b_2) = {length(b_x2)+length(a_x1)}-1 = 3 
b_1 = [b_1 0];         
%to equalize length(b_2)  
b_x = b_1 - b_2;       
%length(b_x) = {length(b_1)=length(b_2)}-1 = 3 
a_x = conv(a_x1,a_x2); %length(a_x) = {length(a_x1)+length(a_x2)}-1 = 3 
%Generating Output = Y(z)  
b_y = [3]; 
a_y = [1 -1/2]; 
%Generating Transfer Function = H(Z) = Y(z)/X(z) 
b_h = conv(b_y,a_x); %length(b_h) = {length(b_y)+length(a_x)}-1 = 3 
a_h = conv(a_y,b_x); %length(b_1) = {length(b_x2)+length(a_x2)}-1 = 4
%Pole-Zero Plots 
figure(1) 
zplane(b_x,a_x); 
title('Pole Zero Plot of Input Function') 
figure(2) 
zplane(b_y,a_y); 
title('Pole Zero Plot of Output Function') 
figure(3) 
zplane(b_h,a_h); 
title('Pole Zero Plot of Transfer Function') 
%i 
%Finding Stable ROC 
[r,p,c] = residuez(b_h,a_h); 
%defining u(n) and u(n-1) 
n = -20:20; 
u=1.*[n>=0]; 
un1=1.*[-n-1>=0];  
%if r->0, eliminating the pole 
for i=1:length(r) 
if r(i)<1e-10 
p(i)=0; 
end 
end 
%if all poles are inside unit circle |z|=1 
if (max(abs(p))<1) 
c = 1; 
fprintf('Stable ROC: |z|> %.4f \n',max(p)); 
%if all poles are outside unit circle |z|=1 
elseif (min(abs(p)>1)) 
fprintf('Stable ROC: |z|< %.4f \n',min(p)); 
c = 2; 
%if poles are both inside & outside unit circle |z|=1 
else  
left = min(abs(p)); 
right = max(abs(p)); 
for i=1:length(p) 
if(abs(p(i))<1 && abs(p(i))>left) 
left = abs(p(i)); 
elseif(abs(p(i))>1 && abs(p(i))<right ) 
right = abs(p(i)); 
end 
end 
fprintf('Stable ROC: %.4f <|z|< %.4f \n ',left,right); 
c = 3; 
end  
%ii 
%Time Domain Output 
if c==1 
fprintf('Stable when Causal\n'); %RS Sequence 
elseif c==2 
fprintf('Stable when anti-causal\n'); %LS Sequence 
else 
fprintf('Stable when Non-causal\n'); %TS Sequence 
end 
figure(4) 
h_n = zeros(1,length(n)); 
for k=1:length(p) 
h_n = h_n + (r(k))*(p(k)).^n.*u; %RS Sequence 
end 
subplot(311) 
stem(n,h_n); 
title('Time Domain Response for RS sequence'); 
h_n = zeros(1,length(n)); 
for k=1:length(p) 
h_n = h_n - (r(k))*(p(k)).^n.*un1; %LS Sequence 
end 
subplot(312) 
stem(n,h_n); 
title('Time Domain Response for LS sequence'); 
h_n = zeros(1,length(n)); 
for k=1:length(p) 
if p(k)==0 
continue; 
elseif abs(p(k))<1  
h_n = h_n+(r(k))*(p(k)).^n.*u; %RS Sequence 
else  
h_n = h_n - (r(k))*(p(k)).^n.*un1; %LS Sequence 
end 
end 
subplot(313) 
stem(n,h_n); 
title('Time Domain Response for TS sequence');