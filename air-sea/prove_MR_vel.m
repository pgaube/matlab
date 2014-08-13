clear all

load midlat_comps bp26_sst*
x=1000*[-100:1:100];
y=1000*[-100:1:100];
sst_x=1000*100*linspace(-2,2,65);
sst_y=sst_x;
[lon,lat]=meshgrid(x,y);
[sst_lon,sst_lat]=meshgrid(sst_x,sst_y);



a=[.17]; %m
L=34e3; %m
Lv=24e3; %m
alpha=0.32;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
wind_speed=7; %ms
wind_dir=0;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
ff=f_cor(59);
g = 9.81; %ms^-2

sst=smoothn(double(bp26_sst_N_cc.mean),5); %deg c
sst=sst./max(sst(:));
int_sst=interp2(sst_lon,sst_lat,sst,lon,lat);

v_max=35;
V=v_max*(dist/Lv).*exp(.5*(1-(dist.^2/Lv.^2)));

h=a*exp((-dist.^2)/(L^2));

%crlg
u = (-g./ff).*dfdy_m(h,1000);
v = (g./ff).*dfdx_m(h,1000);
u_rel=u_w-u;
v_rel=v_w-v;

spd=sqrt(u_rel.^2+v_rel.^2);
dir=atan2(v_rel,u_rel);
ax = cos(dir);
ay = sin(dir);
spd2 = spd.*spd;

K = 1e-3*(0.61+0.063*spd);
eep=0.034;
strm=(K./(1+eep)^2).*spd.^2;
tau_x = strm.*ax;
tau_y = strm.*ay;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
spd=sqrt(u.^2+v.^2);

dtydx=dfdx_m(tau_y,1000);
dtxdy=dfdy_m(tau_x,1000);
dvdx=dfdx_m(v,1000);
dudy=dfdy_m(u,1000);
crl_tau=dtydx-dtxdy;
crl=dvdx-dudy;
%w_ek=1./(1020*(ff)).*crl_tau.*8640000;
w_ek=1./(1020*(ff)).*crl_tau.*8640000;

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
hold on
ms=round(max(spd(:)));
contour(lon/1000,lat/1000,w_ek,[ms ms],'k')
title(['max W_E = ',num2str(max(w_ek(:)))])

figure(3)
clf
plot(x,V(101,:))
hold on
plot(x,100*spd(101,:),'k')
