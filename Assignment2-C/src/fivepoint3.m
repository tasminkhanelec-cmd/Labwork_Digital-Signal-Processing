clear all

trans=[1 1 0 1 1 0 1 1];
unit=ones(1,length(trans));
uf=-unit;
noise=rand(1,length(unit))-0.5;
y=zeros(length(trans),length(unit));
rcorr=zeros(length(trans),2*length(unit)-1);
rec=zeros(1,length(trans));
%% 
for i=1:length(trans)
    if(trans(i)==0)
        y(i,:)=unit+noise;
    else 
        y(i,:)=uf+noise;
    end
end

for i=1:length(trans)
    rcorr(i,:)=conv(y(i,:),flip(unit));
    if (abs(max(rcorr(i,:)))<abs(min(rcorr(i,:))))
        rec(i)=1;
    else
        rec(i)=0;
    end
end
%% 
n=1:length(trans)
plot(n,rcorr(:,1),'displayName','Correlation');
hold on
plot(n,trans,'DisplayName','Transmitted signal');
hold on
plot(n,rec,'DisplayName','Received Signal');
legend
%% 

fprintf('Original Sequence: ');
trans
fprintf('\nRecieved sequence: ');
rec