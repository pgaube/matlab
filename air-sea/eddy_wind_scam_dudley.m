clear all



load midlat_comps
x=linspace(-2,2,65);
y=x;
[lon_h,lat_h]=meshgrid(x,y);

a=.1; %m
L=1; %deg
xo=0; 
yo=0;
dist=sqrt((lon_h-xo).^2+(lat_h-yo).^2);

h=a*exp((-dist.^2)/(L^2));

[lon,lat]=meshgrid(x,y);
alpha=.32;
wind_speed=10; %ms
wind_dir=0;
comp_wek=nan(length(x),length(x),length(wind_dir));
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
ff=f_cor(30);
g = 9.81; %ms^-2
denom=1020*sqrt(abs(ff));

Az=0.014;
De=pi*sqrt(2*Az./abs(ff));
rho=1000;


sst=smoothn(double(bp26_sst_S_c.mean),5); %deg c
sst=sst./max(abs(sst(:)));
sst=.5*sst;




%sst
dtdx=dfdx_abs(sst,.06);
dtdy=dfdy(sst,.06);
dtdn = single(-sind(wind_dir).*dtdx + cosd(wind_dir).*dtdy);
dtds = single(cosd(wind_dir).*dtdx + sind(wind_dir).*dtdy);
w_ek_sst=(.007.*dtdn+(.007*.2).*dtds).*8640000./(1020*ff);


theta=cart2pol(u_w,v_w);
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
tau_x_sst=wind2stress(u_w+u_sst);
tau_y_sst=wind2stress(v_w+v_sst);
crl_tau_sst=dfdx_abs(tau_y_sst,.06)-dfdy(tau_x_sst,.06);
w_ek_sst=1./(1020*ff).*crl_tau_sst.*8640000;


%crlg
u = (-g./ff).*dfdy(h,.06);
v = (g./ff).*dfdx_abs(h,.06);
crl=dfdx_abs(v,.06)-dfdy(u,.06);
spd_o=sqrt(u.^2+v.^2);
u_rel=u_w-u;
v_rel=v_w-v;
crl_rel=dfdx_abs(v_rel,.06)-dfdy(u_rel,.06);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau=dfdx_abs(tau_y,.06)-dfdy(tau_x,.06);
w_ek=1./(1020*ff).*crl_tau.*8640000;

%drift
strm=sqrt(tau_x.^2+tau_y.^2);
Vo=(sqrt(2)*pi*strm)./(De.*rho.*abs(ff));
theta=cart2pol(u_rel,v_rel);
[u_e,v_e]=pol2cart(theta+(pi/4),Vo);
spdr=sqrt(u_rel.^2+v_rel.^2);
v=.79e-5.*spdr.^2./De./abs(ff)

u_rel=u_w-u_e;
v_rel=v_w-v_e;
crl_drift=dfdx_abs(v_e,.06)-dfdy(u_e,.06);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau_drift=dfdx_abs(tau_y,.06)-dfdy(tau_x,.06);
w_ek_drift=1./(1020*ff).*crl_tau_drift.*8640000;

	
%geo+sst
u_rel=u_w+u_sst-u;
v_rel=v_w+v_sst-v;
crl_rel_tot=dfdx_abs(v_rel,.06)-dfdy(u_rel,.06);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau_tot=dfdx_abs(tau_y,.06)-dfdy(tau_x,.06);
w_ek_gs=1./(1020*ff).*crl_tau_tot.*8640000;

%total
u_rel=u_w+u_sst-u-u_e;
v_rel=v_w+v_sst-v-v_e;
crl_rel_tot=dfdx_abs(v_rel,.06)-dfdy(u_rel,.06);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau_tot=dfdx_abs(tau_y,.06)-dfdy(tau_x,.06);
w_ek_tot=1./(1020*ff).*crl_tau_tot.*8640000;


cplot_comps_cont_2_2(1e5*crl,h,-.5,.5,.01,-1,1,'Gaussian eddy geostrophic vorticity','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/dud/c_crl_scam')
cplot_comps_cont_2_2(1e7*crl_drift,h,-2,2,.01,-2,2,'Gaussian eddy Ekman vorticity','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/dud/c_crle_scam')
cplot_comps_cont_2_2(sst,sst,-.5,.5,.1,-1,1,'Gaussian eddy SST anomaly','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/dud/c_sst_05_scam')
cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-30,30,3,-100,100,'W_E^ from eddy SST anomaly','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/dud/c_wek_sst_scam')
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-10,10,1,-100,100,'W_E^ from Gaussian eddy currents','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/dud//c_wek_cur_scam')
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-50,50,1,-100,100,'W_E^ from Gaussian eddy currents','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/dud//c_wek_cur_50_50_scam')
cplot_comps_cont_2_2_bwr(w_ek_gs,w_ek_gs,-10,10,1,-100,100,'W_E^ from currents and SST anomaly','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/dud/c_wek_gs_scam')
cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-10,10,1,-100,100,'Total W_E','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/dud/c_wek_tot_scam')
cplot_comps_cont_2_2_bwr(w_ek_drift,w_ek_drift,-.5,.5,.05,-100,100,'W_E^ from Ekman currents','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/dud/c_wek_e_scam')

