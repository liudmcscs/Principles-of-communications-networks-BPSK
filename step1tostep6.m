clear;
clc;
length=10000;
m = randi([0 1],1,length);
x1=m;
m0=m;
fc=10^6;
f=1000;
Ts=1/(fc*2);
Tb=1/f;
Eb_db=2;
Eb=10^(Eb_db/10);
t=0:Ts:length*Tb-Ts;
N0=1;
size_n=(2*fc/f);
s=m;
for i=1:1:length
    if (m(i)==1)
        m(i)=1;
    elseif(m(i)==0) 
           m(i)=-1;
    end        
end
m=rectpulse(m,size_n);
s=m.*(sqrt(2/Tb)*cos(2*pi*fc*t));
for l=1:1:length
    w=randn(1,size_n)*sqrt(N0/2)*1/sqrt(Ts/1.265);
    k=(l-1)*size_n;
    for j=1:size_n
        k=k+1;
        x(k)=s(k)+w(j);
    end
end    
co=1:1:size_n;
correlate=x.*(sqrt(2/Tb)*cos(2*pi*fc*t));
for i=1:length   
    area=0;
    ll=(i-1)*size_n;
    for j=1:size_n       
        ll=ll+1;
        co(j)=correlate(ll);
    end    
   for k=1:size_n-1
   area=area+(co(k)+co(k+1))*Ts/2;
   end
   x1(i)=area;
end    
des=x1;
for i=1:1:length
if(x1(i)>0)
    des(i)=1;
elseif(x1(i)<0)
    des(i)=0;
end
end
[number,ratio] = biterr(m0,des);
pe=erfc(sqrt(Eb/N0))/2;