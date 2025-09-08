clc
clear all
close all

%Analog signal generation
R=55;
Fs=1500*R;
y=@(t) sin(2*pi*20*R*t)+sin(2*pi*60*R*t)+sin(2*pi*120*R*t);
t=0:0.000001:0.001;

%Analogn signal plot
subplot (4,2,1)
plot(t,y(t),'Color','#008000');
xlabel('Time');
ylabel('Stength');
title('Original signal')

%Sampling the signal
ts=0:1/Fs:0.001;
ys=y(ts);
ysvar=sum(ys.*ys)/length(ys);

%sampled points plot
subplot(4,2,2)
stem(ts*Fs,ys,'Color','#008000');
xlabel('Number of samples');
ylabel('Stength');
title('Sampled signal');

%Quantization
for bit=3:8
    count=bit-2;
    L=2.^bit;
    i=1:L;
    delta=(max(ys)-min(ys))/(L-1);
    q=min(ys)+(i-1)*delta;
    for j=1:length(ys)
        for k=2:L
            if (ys(j)>=q(k-1)) && (ys(j)<=q(k))
                if ys(j)<((q(k-1)+q(k))/2)
                    yq(j)=q(k-1);
                else
                    yq(j)=q(k);
                end
            end
        end
    end
    err=yq-ys;
    errvar=sum(err.*err)/length(err);
    SQNR_Exp(count)=10*log10(ysvar/errvar);
    SQNR_Theory(count)=4.77+(10*log10(ysvar/max(ys)^2))+6*bit;
    
    %bit wise plot
    subplot(4,2,bit)
    stairs(ts*Fs,yq)'
    xlabel('Number of samples');
    ylabel('Stength');
    title(['Quantization for ',num2str(bit),'bit']);
end

%% SQNR plot 
bit=3:8;
plot(bit,SQNR_Exp,'-d');
hold on
plot(bit,SQNR_Theory,'-d');
legend('From Experiment','From Theory')
title("Plot of SQNR in dB")
xlabel('Bit number')
ylabel('SQNR(dB)')
xticks(bit)
