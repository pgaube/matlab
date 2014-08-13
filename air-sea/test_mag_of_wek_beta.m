clear all

x=1000*[-500:10:500];
y=1000*[-500:10:500];
[lon,lat]=meshgrid(x,y);

real_lat=30+(lat./1000./111.11);
real_lon=30+(lon./1000./111.11);

a=[.14]; %m
L=79e3; %m
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
wind_speed=7; %ms
[ff,bb]=f_cor(30);
g = 9.81; %ms^-2

h=a*exp((-dist.^2)/(2*L^2));

%We currents westerly wind
wind_dir=0;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);

u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
u_rel=u_w-u;
v_rel=v_w-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
dvdx=dfdx_m(v,10000);
dudy=dfdy_m(u,10000);
crl_tau=dtydx-dtxdy;
crl=dvdx-dudy;
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);
wb_e=(1/1020)*(1./(ff+crl).^2).*(tau_x.*bb).*8640000;

%We currents southerly wind
wind_dir=90;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);

u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
u_rel=u_w-u;
v_rel=v_w-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
dvdx=dfdx_m(v,10000);
dudy=dfdy_m(u,10000);
crl_tau=dtydx-dtxdy;
crl=dvdx-dudy;
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);
wb_s=(1/1020)*(1./(ff+crl).^2).*(tau_x.*bb).*8640000;

mag_e=max(abs(wb_e(:)));
mag_s=max(abs(wb_s(:)));

per_dif=100*(mag_s./mag_e)







