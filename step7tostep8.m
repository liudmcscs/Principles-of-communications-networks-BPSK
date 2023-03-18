clear;
clc;
times=0;
berr=0:0.01:10;
xx=0:0.01:10;
for kk=0:0.01:10
    times=times+1;
    Eb_db=kk;
    if(0<=kk&&kk<=4)
        length=10000;
    elseif(5<=kk&&kk<=8)
        length=100000;
    elseif(9<=kk&&kk<=10)
        length=1000000;
    end        
m = randi([0 1],1,length);
kk
fc=1000000;
f=1000;
Ts=1/(fc*2);
Tb=1/f;
Eb=10^(Eb_db/10);
t=0:Ts:Tb-Ts;
N0=1;
size_n=(2*fc/f);
x1=m;
for i=1:1:length
if(m(i)==1)
    x1(i)=sqrt(Eb)+trapz(  randn(1,size_n)*sqrt(N0/2)*f,t  );
elseif(m(i)==0)
    x1(i)=-sqrt(Eb)+trapz( randn(1,size_n)*sqrt(N0/2)*f , t  );
end
end
des=x1;
for i=1:1:length
if(x1(i)>0)
    des(i)=1;
elseif(x1(i)<0)
    des(i)=0;
end
end
[number,ratio] = biterr(des,m);
berr(times)=ratio;
xx(times)=Eb_db/N0;
end
figure(1);plot(xx,berr);
semilogy(xx,berr);
axis([0 10 0.000001 0.1]);
xlabel('Eb/N0 (dB)');  
ylabel('BER')  
title('Bit error rate for BPSK(berr)'); 



 
