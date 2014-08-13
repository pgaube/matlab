clear all

x=linspace(-2,2,65);
y=x;
[lon_h,lat_h]=meshgrid(x,y);

r=25:57;
c=25:57;

a=.1; %m
L=1; %deg
xo=0; 
yo=0;
dist=sqrt((lon_h-xo).^2+(lat_h-yo).^2);

h=a*exp((-dist.^2)/(L^2));

[lon,lat]=meshgrid(x,y);
alpha=.32;
wind_speed=6; %ms
wind_dir=0;
comp_wek=nan(length(x),length(x),length(wind_dir));
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
ff=f_cor(y_not);
g = 9.81; %ms^-2
denom=1020*sqrt(abs(ff));


%crlg
u = (-g./ff).*dfdy(h,.0625);
v = (g./ff).*dfdx_abs(h,.0625);
crl=dfdx_abs(v,.0625)-dfdy(u,.0625);
spd_o=sqrt(u.^2+v.^2);


wind_dir=0;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u_rel=u_w-u;
v_rel=v_w-v;
crl_rel=dfdx_abs(v_rel,.0625)-dfdy(u_rel,.0625);
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
crl_tau=dfdx_abs(tau_y,.0625)-dfdy(tau_x,.0625);
w_ek=1./(1020*ff).*crl_tau.*8640000;
w_ek=zgrid_abs(lon,lat,0,0,w_ek,L);
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-3,3,.5,-100,100,'Gaussian anticyclone','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/dir/a_wek_0')

wind_dir=90;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u_rel=u_w-u;
v_rel=v_w-v;
crl_rel=dfdx_abs(v_rel,.0625)-dfdy(u_rel,.0625);
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);;
crl_tau=dfdx_abs(tau_y,.0625)-dfdy(tau_x,.0625);
w_ek=1./(1020*ff).*crl_tau.*8640000;
w_ek=zgrid_abs(lon,lat,0,0,w_ek,L);
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-3,3,.5,-100,100,'Gaussian anticyclone','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/dir/a_wek_90')

wind_dir=45;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u_rel=u_w-u;
v_rel=v_w-v;
crl_rel=dfdx_abs(v_rel,.0625)-dfdy(u_rel,.0625);
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
crl_tau=dfdx_abs(tau_y,.0625)-dfdy(tau_x,.0625);
w_ek=1./(1020*ff).*crl_tau.*8640000;
w_ek=zgrid_abs(lon,lat,0,0,w_ek,L);
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-3,3,.5,-100,100,'Gaussian anticyclone','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/dir/a_wek_45')


%cyclones
h=-a*exp((-dist.^2)/(L^2));

%crlg
u = (-g./ff).*dfdy(h,.0625);
v = (g./ff).*dfdx_abs(h,.0625);



wind_dir=0;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u_rel=u_w-u;
v_rel=v_w-v;
crl_rel=dfdx_abs(v_rel,.0625)-dfdy(u_rel,.0625);
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
crl_tau=dfdx_abs(tau_y,.0625)-dfdy(tau_x,.0625);
w_ek=1./(1020*ff).*crl_tau.*8640000;
w_ek=zgrid_abs(lon,lat,0,0,w_ek,L);
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-3,3,.5,-100,100,'Gaussian cyclones','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/dir/c_wek_0')

wind_dir=90;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u_rel=u_w-u;
v_rel=v_w-v;
crl_rel=dfdx_abs(v_rel,.0625)-dfdy(u_rel,.0625);
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
crl_tau=dfdx_abs(tau_y,.0625)-dfdy(tau_x,.0625);
w_ek=1./(1020*ff).*crl_tau.*8640000;
w_ek=zgrid_abs(lon,lat,0,0,w_ek,L);
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-3,3,.5,-100,100,'Gaussian cyclones','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/dir/c_wek_90')

wind_dir=45;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u_rel=u_w-u;
v_rel=v_w-v;
crl_rel=dfdx_abs(v_rel,.0625)-dfdy(u_rel,.0625);
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
crl_tau=dfdx_abs(tau_y,.0625)-dfdy(tau_x,.0625);
w_ek=1./(1020*ff).*crl_tau.*8640000;
w_ek=zgrid_abs(lon,lat,0,0,w_ek,L);
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-3,3,.5,-100,100,'Gaussian cyclones','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/dir/c_wek_45')
