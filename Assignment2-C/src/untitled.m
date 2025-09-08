clc
clear
format long
[y,Fs]= audioread('Audioo.mp3');
y=y(:,1) ;
delT=1/Fs;
 
t=0:delT:(length(y)-1)*delT;
x=y';
%plot(t,x);
 
C=xcorr(x);
xx=delT*(1:length(C));
xx2=xx-delT*(length(xx)+1)/2;
plot(xx2,C);
xlim([-0.02 0.02]);
 
for i=1:size(xx2,2)
    if xx2(i)>= 0.0
        break;
    end
end
 
for j=1:size(xx2,2)
    if xx2(j)>= 0.1
        break;
    end
end
 
M=min(C(i:j));
 
D=C; 
for k=i:j
    if D(k)> M
        D(k)=M;
    else
        break;
    end
end
%plot(xx2,C,xx2,D);
%xlim([0 0.05]);
 
H=max(D(i:j));
 
for p=i:j
    if D(p)==H;
        break;
    end
end
 
tH=xx2(p); 
pitch=1/tH;
 
disp('My voice pitch is(Hz):');
disp(ceil(pitch));
