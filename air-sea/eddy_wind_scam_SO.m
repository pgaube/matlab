clear all
load bwr.pal
load /matlab/matlab/domains/SO_lat_lon
f_mid=pmean(lat);
load SO_comps
x=linspace(-2,2,65);
y=x;
[lon,lat]=meshgrid(x,y);
alpha=.32;
wind_speed=8; %ms
wind_dir=180;
comp_wek=nan(length(x),length(x),length(wind_dir));
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
ff=f_cor(f_mid);
g = 9.81; %ms^-2

x_h=linspace(-3,3,49);
y_h=x_h;
[lon_h,lat_h]=meshgrid(x_h,y_h);

%first do cyclones
sst = griddata(lon_h,lat_h,double(SO_sst_c.mean),lon,lat);
sst = smoothn(double(sst),5); %deg c
h = griddata(lon_h,lat_h,double(SO_ssh_c.mean),lon,lat);
h = smoothn(h,3)./100; %m



%sst
theta=cart2pol(u_w,v_w);
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
tau_x_sst=wind2stress(u_w-u_sst);
tau_y_sst=wind2stress(v_w-v_sst);
crl_tau_sst=dfdx_abs(tau_y_sst,.12)-dfdy(tau_x_sst,.12);
w_ek_sst=1./(1020*ff).*crl_tau_sst.*8640000;

%crlg
u = (-g./ff).*dfdy(h,.12);
v = (g./ff).*dfdx_abs(h,.12);
crl=dfdx_abs(v,.12)-dfdy(u,.12);
spd_o=sqrt(u.^2+v.^2);
u_rel=u_w-u;
v_rel=v_w-v;
crl_rel=dfdx_abs(v_rel,.12)-dfdy(u_rel,.12);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau=dfdx_abs(tau_y,.12)-dfdy(tau_x,.12);
w_ek=1./(1020*ff).*crl_tau.*8640000;

%both
u_rel=u_w-(u+u_sst);
v_rel=v_w-(v+v_sst);
crl_rel_tot=dfdx_abs(v_rel,.12)-dfdy(u_rel,.12);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau_tot=dfdx_abs(tau_y,.12)-dfdy(tau_x,.12);
w_ek_tot=1./(1020*ff).*crl_tau_tot.*8640000;

cplot_comps_cont_2_2(1e5*crl,h,-.3,.3,.02,-2,2,'composite geostrophic vorticity','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/c_crl_scam')
cplot_comps_cont_2_2(sst,h,-.4,.4,.02,-2,2,'eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/c_sst_h_scam')
cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-1,1,.2,-100,100,'W_E^ from eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/c_wek_sst_scam')
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-3,3,.5,-100,100,'W_E^ from eddy currents','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/c_wek_cur_scam')
cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-3,3,.5,-100,100,'W_E^ from currents and SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/c_wek_tot_scam')

%next do anticyclones
sst = griddata(lon_h,lat_h,double(SO_sst_a.mean),lon,lat);
sst=smoothn(double(sst),5); %deg c
h = griddata(lon_h,lat_h,double(SO_ssh_a.mean),lon,lat);
h = smoothn(h,3)./100; %m



%sst
theta=cart2pol(u_w,v_w);
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
tau_x_sst=wind2stress(u_w-u_sst);
tau_y_sst=wind2stress(v_w-v_sst);
crl_tau_sst=dfdx_abs(tau_y_sst,.12)-dfdy(tau_x_sst,.12);
w_ek_sst=1./(1020*ff).*crl_tau_sst.*8640000;

%crlg
u = (-g./ff).*dfdy(h,.12);
v = (g./ff).*dfdx_abs(h,.12);
crl=dfdx_abs(v,.12)-dfdy(u,.12);
spd_o=sqrt(u.^2+v.^2);
u_rel=u_w-u;
v_rel=v_w-v;
crl_rel=dfdx_abs(v_rel,.12)-dfdy(u_rel,.12);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau=dfdx_abs(tau_y,.12)-dfdy(tau_x,.12);
w_ek=1./(1020*ff).*crl_tau.*8640000;

%both
u_rel=u_w-(u+u_sst);
v_rel=v_w-(v+v_sst);
crl_rel_tot=dfdx_abs(v_rel,.12)-dfdy(u_rel,.12);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau_tot=dfdx_abs(tau_y,.12)-dfdy(tau_x,.12);
w_ek_tot=1./(1020*ff).*crl_tau_tot.*8640000;

cplot_comps_cont_2_2(1e5*crl,h,-.3,.3,.02,-2,2,'composite geostrophic vorticity','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/a_crl_scam')
cplot_comps_cont_2_2(sst,h,-.4,.4,.02,-2,2,'eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/a_sst_h_scam')
cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-1,1,.2,-100,100,'W_E^ from eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/a_wek_sst_scam')
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-3,3,.5,-100,100,'W_E^ from eddy currents','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/a_wek_cur_scam')
cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-3,3,.5,-100,100,'W_E^ from currents and SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/a_wek_tot_scam')
