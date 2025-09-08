function [y,n]=crosscor(x1,n1,x2,n2)
x2f=flip(x2);
n2f=-flip(n2);
n=(n1(1)+n2f(1)):(n1(end)+n2f(end));
y=conv(x1,x2f);
end

