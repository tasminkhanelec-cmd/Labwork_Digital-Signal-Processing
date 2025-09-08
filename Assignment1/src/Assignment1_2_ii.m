clc;
close all;
clear all;

%Audio signal input
[ya,Fs]=audioread("..\data\DSP audio signal.mp3");
ttotal=length(ya)/Fs;
ta=1:length(ya);
[samples,channel]=size(ya);

%Audio signal plot
subplot(4,1,1);
%%
plot(ta,ya,'Color','#008000');
xlabel('Number of samples');
ylabel('Weight');
title('Input Audio signal');
%%
%sound(yin,Fs)

%% A law compresion
A=87.56;
for c=1:channel
    for i=1:length(ya)
        if abs(ya(i,c))>=1/A 
            yA(i,c)=((1+log(A*abs(ya(i,c))))/(1+log(A)))*sign(ya(i,c));
        elseif abs(ya(i,c))<1/A
            yA(i,c)=((A*abs(ya(i,c)))/(1+log(A)))*sign(ya(i,c));
        end
    end
end

%% Compressed signal plot
subplot(4,1,2);
%% 
plot(ta,yA,'color','#0072bb');
xlabel('Number of samples');
ylabel('Weight');
title("Compressed Signal");

%% uniform quantization of compressed signal
bit=8;
L=2^bit;
delta=(max(yA)-min(yA))/(L-1);
for c=1:channel
    for i=1:L
        q(i,c)=min(yA(:,c))+(i-1)*delta(c);
    end
end
for j=1:length(yA)
    for k=2:L
        for c=1:channel
            if (yA(j,c)>=q(k-1,c)) && (yA(j,c)<q(k,c))
                if yA(j,c)<((q(k-1,c)+q(k,c))/2)
                    yq(j,c)=q(k-1,c);
                else
                    yq(j,c)=q(k,c);
                end
            end
        end
    end
end

%compressed and quantized signal plot
subplot(4,1,3);
stairs(ta,yq);
xlabel('Number of samples');
ylabel('Weight');
title('Uniform Quantizatization after A law compression');

%SQNR calculation
errCQ=yq-yA;
errvarCQ=sum(errCQ.*errCQ)/length(errCQ);
ymuvar=sum(yA.*yA)/length(yA);
for c=1:channel
    SQNR_CQ(c)=10*log10(ymuvar(c)/errvarCQ(c));
    fprintf('SQNR(dB) with A law compressor for channel%d = %f\n',c,SQNR_CQ(c));
end

%% 
%sound(yq,Fs);

%% Uniform Quantization without compression
for c=1:channel
    for i=1:L
        qq(i,c)=min(ya(:,c))+(i-1)*delta(c);
    end
end
for j=1:length(ya)
    for k=2:L
        for c=1:channel
            if (ya(j,c)>=qq(k-1,c)) && (ya(j,c)<qq(k,c))
                if ya(j,c)<((qq(k-1,c)+qq(k,c))/2)
                    yqq(j,c)=qq(k-1,c);
                else
                    yqq(j,c)=qq(k,c);
                end
            end
        end
    end
end

%% compressed and quantized signal plot
subplot(4,1,4);
%%
stairs(ta,yqq,'k');
xlabel('Number of samples');
ylabel('Weight');
title('Uniform Quantizatization without compression');
 
%% SQNR calculation
errQ=yq-yA;
errvarQ=sum(errQ.*errQ)/length(errQ);
yavar=sum(ya.*ya)/length(ya);
for c=1:channel
    SQNR_Q(c)=10*log10(yavar(c)/errvarQ(c));
    fprintf('SQNR(dB) without compression for channel%d = %f\n',c,SQNR_Q(c));
end

%%
%sound(yqq,Fs)