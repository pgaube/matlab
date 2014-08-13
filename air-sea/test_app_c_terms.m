ra=1
cd=10^-3
ua=7
a=.1
g=9.8
ro=1020
f=f_cor(30)
l=90e3
x=1000*[-400:10:400];
y=1000*[-400:10:400];
[x,y]=meshgrid(x,y);
r=sqrt(x.^2+y.^2);

wo=(3*ra*cd*ua*a*g/ro/f^2/l^2);
% wo=1e-7
w=wo*(1-(y.^2/3/l^2)-(r.^2/3/l^2)).*exp(-r.^2/2/l^2);

clf
pcolor(w*60*60*24*100);shading flat;caxis([-5 5])