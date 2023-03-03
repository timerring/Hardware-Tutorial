%dft2.m 
function[a,p]=dft2(x)
N=length(x);
n=0:N-1;
k=n;
w=exp(-j*2*pi/N);
nk=n'*k;
wnk=w.^(nk);
xk=x*wnk;
a=abs(xk);
p=angle(xk);