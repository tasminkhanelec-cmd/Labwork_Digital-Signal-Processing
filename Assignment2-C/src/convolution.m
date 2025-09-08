function [yout, nout]= convolution(x1,n1,x2,n2)
nstart=(n1(1)+n2(1));
nend=(n1(end)+n2(end));
nout=nstart:nend;
yout=conv(x1,x2);
end
