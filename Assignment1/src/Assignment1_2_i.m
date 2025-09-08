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
plot(ta,ya,'Color','#008000');
xlabel('Number of samples');
ylabel('Weight');
title('Input Audio signal');

%%
%sound(ya,Fs)

%% mu law compresion
mu=255;
ymu=(log(1+mu.*abs(ya))/log(1+mu)).*sign(ya);

%Compressed signal plot
subplot(4,1,2);
plot(ta,ymu,'color','#0072bb');
xlabel('Number of samples');
ylabel('Weight');
title("Compressed Signal");

%uniform quantization of compressed signal
bit=8;
L=2^bit;
delta=(max(ymu)-min(ymu))/(L-1);
for c=1:channel
    for i=1:L
        q(i,c)=min(ymu(:,c))+(i-1)*delta(c);
    end
end
for j=1:length(ymu)
    for k=2:L
        for c=1:channel
            if (ymu(j,c)>=q(k-1,c)) && (ymu(j,c)<q(k,c))
                if ymu(j,c)<((q(k-1,c)+q(k,c))/2)
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
title('Uniform Quantizatization after mu law compression');

%SQNR calculation
errCQ=yq-ymu;
errvarCQ=sum(errCQ.*errCQ)/length(errCQ);
ymuvar=sum(ymu.*ymu)/length(ymu);
for c=1:channel
    SQNR_CQ(c)=10*log10(ymuvar(c)/errvarCQ(c));
    fprintf('SQNR(dB) with mu compressor for channel%d = %f\n',c,SQNR_CQ(c));
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

%compressed and quantized signal plot
subplot(4,1,4);
stairs(ta,yqq,'k');
xlabel('Number of samples');
ylabel('Weight');
title('Uniform Quantizatization without compression');
 
%SQNR calculation
errQ=yq-ymu;
errvarQ=sum(errQ.*errQ)/length(errQ);
yavar=sum(ya.*ya)/length(ya);
for c=1:channel
    SQNR_Q(c)=10*log10(yavar(c)/errvarQ(c));
    fprintf('SQNR(dB) without compression for channel%d = %f\n',c,SQNR_Q(c));
end

%% 
%sound(yqq,Fs)