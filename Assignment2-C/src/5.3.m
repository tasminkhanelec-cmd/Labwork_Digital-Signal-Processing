clear all

x0=[1 1 1 1 1];
x1=-x0;
seq=[1 1 0 1 1];
n=rand(1,length(x0))-0.5;
y=zeros(length(seq),length(x0));
rcorr=zeros(length(seq),2*length(x0)-1);
det=zeros(1,length(seq));

for i=1:length(seq)
    if(seq(i)==0)
        y(i,:)=x0+n;
    else 
        y(i,:)=x1+n;
    end
end

for i=1:length(seq)
    rcorr(i,:)=conv(y(i,:),flip(x0));
    if (abs(max(rcorr(i,:)))<abs(min(rcorr(i,:))))
        det(i)=1;
    else
        det(i)=0;
    end
end
fprintf('Original Sequence: ');
seq
fprintf('\nRecieved sequence: ');
det