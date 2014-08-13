%
clear all

x=1000*[-400:10:400];
y=1000*[-400:10:400];
[lon,lat]=meshgrid(x,y);

real_lat=30+(lat./1000./111.11);
real_lon=30+(lon./1000./111.11);

a=[.20]; %m
L=90e3; %m
Ls=L;
rhoa=1;
cd=1e-3;
rho=1020;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
wind_speed=7; %ms
[ff,bb]=f_cor(30);
g = 9.81; %ms^-2
%
h=a(1)*exp((-dist.^2)/(2*L^2));


%We currents westerly wind
wind_dir=180;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
%%fuck matlabs wind direction!
u_w=-u_w;
%%%
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

w_ek_l=(1/1020)*(1./(ff)).*crl_tau.*8640000;
w_ek_n=(1/1020)*(1./(ff).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
w_ek_b=-(1/1020)*(1./(ff).^2)*(tau_x.*bb).*8640000;
% wc=3*rhoa*cd*a*g*wind_speed/rho/ff^2/L^2*60*60*24*100
% w_ek_l=(1-(dist.^2./.3/L^2)).*exp(-dist.^2./(2*L^2));

w_ek_n=interp2(zgrid(real_lon,real_lat,30,30,double(w_ek_n),Ls/1000),3);
w_ek_l=interp2(zgrid(real_lon,real_lat,30,30,double(w_ek_l),Ls/1000),3);
w_ek_b=interp2(zgrid(real_lon,real_lat,30,30,double(w_ek_b),Ls/1000),3);

pcomps_raw2(w_ek_l,w_ek_l,[-10 10],-100,2,100,'',2,1)
print -depsc /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/nh/wek_c

pcomps_raw2(w_ek_n,w_ek_n,[-10 10],-100,2,100,'',2,1)
print -depsc /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/nh/wek_zeta

pcomps_raw2(w_ek_b,w_ek_b,[-10 10],-100,2,100,'',2,1)
print -depsc /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/nh/wek_beta

pcomps_raw2(w_ek_n+w_ek_l+w_ek_b,w_ek_n+w_ek_l+w_ek_b,[-10 10],-100,2,100,'',2,1)
print -depsc /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/nh/wek_total

