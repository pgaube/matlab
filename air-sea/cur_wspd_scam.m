clear all
m=1;
x=1000*[-500:10:500];
y=1000*[-500:10:500];
[lon,lat]=meshgrid(x,y);

real_lat=40+(lat./1000./111.11);
real_lon=40+(lon./1000./111.11);

a=[.08]; %m
L=100e3; %m
Ls=L;
Lt=100e3;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=[.5];
wind_speed=7; %ms
ff=f_cor(15);
g = 9.81; %ms^-2


h=a*exp((-dist.^2)/(2*L^2));


%We currents westerly wind
wind_dir=190;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
u_rel=u_w-u;
v_rel=v_w-v;
spd_rel=sqrt(u_rel.^2+v_rel.^2);

spd_rel=(zgrid_abs(real_lon,real_lat,40,40,double(spd_rel),Lt/1000));
pcomps_raw2((spd_rel-wind_speed),(spd_rel-wind_speed),[-.15 .15],-1,.02,1,'relative wind speed anomaly',2,30)

print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/CAR_comps/idelized_ac

h=-a*exp((-dist.^2)/(2*L^2));


%We currents westerly wind
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
u_rel=u_w-u;
v_rel=v_w-v;
spd_rel=sqrt(u_rel.^2+v_rel.^2);

spd_rel=(zgrid_abs(real_lon,real_lat,40,40,double(spd_rel),Lt/1000));
pcomps_raw2((spd_rel-wind_speed),(spd_rel-wind_speed),[-.15 .15],-1,.02,1,'relative wind speed anomaly',2,30)

print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/CAR_comps/idelized_cc
