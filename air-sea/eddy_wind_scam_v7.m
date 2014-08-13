clear all
load bwr.pal
load midlat_comps
x=linspace(-2,2,65);
y=x;
[lon,lat]=meshgrid(x,y);
alpha=.32;
wind_speed=8; %ms
wind_dir=180;
comp_wek=nan(length(x),length(x),length(wind_dir));
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
ff=f_cor(-30);
g = 9.81; %ms^-2
denom=1020*sqrt(abs(ff));

x_h=linspace(-3,3,49);
y_h=x_h;
[lon_h,lat_h]=meshgrid(x_h,y_h);

%first do cyclones
sst=smoothn(double(bp26_sst_N_c.mean),5); %deg c
h = griddata(lon_h,lat_h,double(ssh_c.mean),lon,lat);
h = smoothn(h,10)./100; %m



%sst
dtdx=dfdx_abs(sst,.12);
dtdy=dfdy(sst,.12);
dtdn = single(-sind(wind_dir).*dtdx + cosd(wind_dir).*dtdy);
dtds = single(cosd(wind_dir).*dtdx + sind(wind_dir).*dtdy);
w_ek_sst=(.01.*dtdn+(.01*.2).*dtds).*8640000./(1020*ff);


theta=cart2pol(u_w,v_w);
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
tau_x_sst=wind2stress(u_w-u_sst);
tau_y_sst=wind2stress(v_w-v_sst);
crl_tau_sst=dfdx_abs(tau_y_sst,.12)-dfdy(tau_x_sst,.12);
%w_ek_sst=1./(1020*ff).*crl_tau_sst.*8640000;


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

%drift
u_rel=u_w-u;
v_rel=v_w-v;
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
[theta,mag]=cart2pol(tau_x,tau_y);
[tau_x,tau_y]=pol2cart(theta+(pi/4),mag/denom);
crl_tau_drift=dfdx_abs(tau_y,.12)-dfdy(tau_x,.12);
w_ek_drift=1./(1020*ff).*crl_tau_drift.*8640000;

%both
u_rel=u_w-(u+u_sst);
v_rel=v_w-(v+v_sst);
crl_rel_tot=dfdx_abs(v_rel,.12)-dfdy(u_rel,.12);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau_tot=dfdx_abs(tau_y,.12)-dfdy(tau_x,.12);
w_ek_tot=1./(1020*ff).*crl_tau_tot.*8640000;

cplot_comps_cont_2_2(1e5*crl,h,-.3,.3,.05,-2,2,'composite geostrophic vorticity','/Users/gaube/Documents/OSU/figures/air-sea/scam/c_crl_scam')
cplot_comps_cont_2_2(sst,h,-.4,.4,.02,-2,2,'eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/c_sst_h_scam')
cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-1,1,.2,-100,100,'W_E^ from eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/c_wek_sst_scam')
cplot_comps_cont_2_2_bwr(w_ek_drift,w_ek_drift,-1,1,.2,-100,100,'W_E^ from eddy drift anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/c_wek_drift_scam')
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-4,4,.5,-100,100,'W_E^ from eddy currents','/Users/gaube/Documents/OSU/figures/air-sea/scam//c_wek_cur_scam')
cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-4,4,.5,-100,100,'W_E^ from currents and SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/c_wek_tot_scam')

figure(3)
clf
subplot(131)
pcolor(crl_tau);shading flat
caxis([-2e-8 2e-8])
pcolor(crl_tau);shading flat;axis image
caxis([-2e-8 2e-8])
title('crlg')
subplot(132)
pcolor(crl_tau_drift);shading flat;axis image
caxis([-2e-9 2e-9])
title('crl drift')
subplot(133)
pcolor(crl_tau_tot);shading flat;axis image
caxis([-2e-8 2e-8])
title('crl tot')
return
%next do anticyclones
sst=smoothn(double(bp26_sst_N_cc.mean),5); %deg c
h = griddata(lon_h,lat_h,double(ssh_a.mean),lon,lat);
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

cplot_comps_cont_2_2(1e5*crl,h,-.3,.3,.02,-2,2,'composite geostrophic vorticity','/Users/gaube/Documents/OSU/figures/air-sea/scam/a_crl_scam')
cplot_comps_cont_2_2(sst,h,-.4,.4,.02,-2,2,'eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/a_sst_h_scam')
cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-1,1,.2,-100,100,'W_E^ from eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/a_wek_sst_scam')
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-4,4,.5,-100,100,'W_E^ from eddy currents','/Users/gaube/Documents/OSU/figures/air-sea/scam/a_wek_cur_scam')
cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-4,4,.5,-100,100,'W_E^ from currents and SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/a_wek_tot_scam')
