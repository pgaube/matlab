syms 
syms A L r g f x y ua uo vo C tx ty rho B
r=sqrt(x^2+y^2);
h=A*exp(-r^2/(2*L^2));

u=-(g/f)*diff(h,y);
v=(g/f)*diff(h,x);

tx=C*(ua^2-2*u*ua);
ty=C*(-v*ua);

dtxdy=diff(tx,y);
dtydx=diff(ty,x);

dvdx=diff(v,x);
dudy=diff(u,y);

zeta=dvdx-dudy;
dzdy=diff(zeta,y);
dzdx=diff(zeta,x);


lin=(dtydx-dtxdy)/f;
nlin=((ty*dzdx)-(tx*dzdy))/f^2;
bet=B*tx/f^2;


ratio_n_to_l=nlin/lin

%Test magntidue
A=.2
g=10
C=10^-3
ua=7
L=100*1000
f=1e-4
rho=1020
B=1e-11
%[f,B]=f_cor(30)

x=1000*[-200:10:200];
y=1000*[-200:10:200];
[lon,lat]=meshgrid(x,y);
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
hh=exp((-dist.^2)/(L^2));
wlo=(3*A*g*C*ua/L^2/f^2/rho);

wl=wlo*(1-(dist.^2/3/L^2)).*hh.*100*60*60*24;
figure(1)
clf
subplot(131)
pcolor(double(wl));shading flat;axis image
colorbar

wno=(4*C*A*g*ua*ua/rho/f/f/f/L/L/L);

wn=wno*(lat/L)*(1-(dist.^2/4/L^2)).*hh.*100*60*60*24;

subplot(132)
pcolor(double(wn));shading flat;axis image
colorbar

wbo=(B*C*ua*ua/rho/f/f);

wb=wbo*(1-(2*A*lat*g/f/L/L)*hh).*100*60*60*24;

subplot(133)
pcolor(double(wb));shading flat;axis image
colorbar

l_over_n=wlo/wno
L_over_B=wlo/wbo

%Now martins
ro=.2/f/L;


W=ro*ua*C/rho.*100*60*60*24;
