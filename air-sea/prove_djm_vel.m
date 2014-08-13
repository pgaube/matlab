clear all

load midlat_comps bp26_sst*
x=1000*[-100:1:100];
y=1000*[-100:1:100];
sst_x=1000*100*linspace(-2,2,65);
sst_y=sst_x;
[lon,lat]=meshgrid(x,y);
[sst_lon,sst_lat]=meshgrid(sst_x,sst_y);



a=[.105]; %m
L=40e3; %m
alpha=0.32;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
wind_speed=5.6; %ms
wind_dir=0;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
ff=f_cor(31);
g = 9.81; %ms^-2

sst=smoothn(double(bp26_sst_N_cc.mean),5); %deg c
sst=sst./max(sst(:));
int_sst=interp2(sst_lon,sst_lat,sst,lon,lat);


h=a*exp((-dist.^2)/(L^2));

%crlg
u = (-g./ff).*dfdy_m(h,1000);
v = (g./ff).*dfdx_m(h,1000);
spd=sqrt(u.^2+v.^2);
u_rel=u_w-u;
v_rel=v_w-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,1000);
dtxdy=dfdy_m(tau_x,1000);
dvdx=dfdx_m(v,1000);
dudy=dfdy_m(u,1000);
crl_tau=dtydx-dtxdy;
crl=dvdx-dudy;
w_ek=1./(1020*(crl+ff)).*crl_tau.*8640000;

figure(1)
clf
[c,m]=contour(lon/1000,lat/1000,100*spd,[10:5:20]);axis equal;axis([-80 80 -80 80])
clabel(c,m)
hold on
ms=round(max(100*spd(:)));
contour(lon/1000,lat/1000,100*spd,[ms ms],'k')
title(['max spd = ',num2str(max(spd(:)))])

figure(2)
clf
[c,m]=contour(lon/1000,lat/1000,w_ek,[-20:20:120]);axis equal;axis([-80 80 -80 80])
clabel(c,m)
title(['max W_E = ',num2str(max(w_ek(:)))])

