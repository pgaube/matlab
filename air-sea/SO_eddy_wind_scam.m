clear all
load bwr.pal
load /matlab/matlab/domains/SO_lat_lon
f_mid=pmean(lat);
r=9:41;
c=9:41;
load SO_comps
x=linspace(-3,3,49);
y=x;
[lon,lat]=meshgrid(x,y);
alpha=.4;
beta=0.02;
wind_speed=10; %ms
wind_dir=180-180;
comp_wek=nan(length(x),length(x),length(wind_dir));
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
ff=f_cor(f_mid);
g = 9.81; %ms^-2


%first do cyclones
sst = double(SO_sst_c.mean(r,c));
sst = smoothn(double(sst),5); %deg c
h = double(SO_ssh_c.mean(r,c));
h = smoothn(h,3)./100; %m
u_w=u_w*ones(size(sst));
v_w=v_w*ones(size(sst));


%sst
%using theta aka Maloney and CHlton
w_theta=rad2deg(cart2pol(u_w,v_w));
u_t=dfdx_abs(sst,.12);
v_t=dfdy(sst,.12);
mag_t_bar=sqrt(u_t.^2+v_t.^2);
t_theta=rad2deg(cart2pol(u_t,v_t));
	
ii=find(w_theta<0);
w_theta(ii)=360+w_theta(ii);
ii=find(t_theta<0);
t_theta(ii)=360+t_theta(ii);
	
tmp_theta=(w_theta-t_theta);
ii=find(tmp_theta<0);
theta_prime=nan*tmp_theta;
theta_prime(ii)=360+(w_theta(ii)-t_theta(ii));
ii=find(tmp_theta>0);
theta_prime(ii)=360-(w_theta(ii)-t_theta(ii));
	
crl_tau_sst_theta=beta*mag_t_bar.*sind(theta_prime);

%now using the wrong way
[u_sst,v_sst]=pol2cart(w_theta,alpha*sst);
tau_x_sst=wind2stress(u_w+u_sst);
tau_y_sst=wind2stress(v_w+v_sst);
crl_tau_sst=dfdx_abs(tau_y_sst,.12)-dfdy(tau_x_sst,.12);

%now using ONeill 2010
dtdn=-sind(w_theta)*u_t+cosd(w_theta)*v_t;
dtds=cosd(w_theta)*u_t+sind(w_theta)*v_t;

dvdn=-sind(w_theta)*u_w+cosd(w_theta)*v_w;
dvds=cosd(w_theta)*u_w+sind(w_theta)*v_w;


w_ek_sst=1./(1020*ff).*crl_tau_sst.*8640000;
w_ek_sst_theta=1./(1020*ff).*crl_tau_sst_theta.*8640000;

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
u_rel=u_w+u_sst-u;
v_rel=v_w+v_sst-v;
crl_rel_tot=dfdx_abs(v_rel,.12)-dfdy(u_rel,.12);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau_tot=dfdx_abs(tau_y,.12)-dfdy(tau_x,.12);
w_ek_tot=1./(1020*ff).*crl_tau_tot.*8640000;

cplot_comps_cont_2_2(1e6*crl,h,-5,5,.02,-2,2,'composite geostrophic vorticity','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/c_crl_scam')
cplot_comps_cont_2_2(sst,h,-.4,.4,.02,-2,2,'eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/c_sst_h_scam')
cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-7,7,1,-100,100,'W_E^ from eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/c_wek_sst_scam')
cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-1,1,.2,-100,100,'W_E^ from eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/c_wek_sst_scam2')
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-7,7,1,-100,100,'W_E^ from eddy currents','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/c_wek_cur_scam')
cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-7,7,1,-100,100,'W_E^ from currents and SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/c_wek_tot_scam')

%next do anticyclones
sst = double(SO_sst_a.mean(r,c));
sst=smoothn(double(sst),5); %deg c
h = double(SO_ssh_a.mean(r,c));
h = smoothn(h,3)./100; %m



%sst
theta=cart2pol(u_w,v_w);
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
tau_x_sst=wind2stress(u_w+u_sst);
tau_y_sst=wind2stress(v_w+v_sst);
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
u_rel=u_w+u_sst-u;
v_rel=v_w+v_sst-v;
crl_rel_tot=dfdx_abs(v_rel,.12)-dfdy(u_rel,.12);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau_tot=dfdx_abs(tau_y,.12)-dfdy(tau_x,.12);
w_ek_tot=1./(1020*ff).*crl_tau_tot.*8640000;

cplot_comps_cont_2_2(1e6*crl,h,-5,5,.02,-2,2,'composite geostrophic vorticity','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/a_crl_scam')
cplot_comps_cont_2_2(sst,h,-.4,.4,.02,-2,2,'eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/a_sst_h_scam')
cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-1,1,.2,-100,100,'W_E^ from eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/a_wek_sst_scam2')
cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-7,7,1,-100,100,'W_E^ from eddy SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/a_wek_sst_scam')
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-7,7,1,-100,100,'W_E^ from eddy currents','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/a_wek_cur_scam')
cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-7,7,1,-100,100,'W_E^ from currents and SST anomaly','/Users/gaube/Documents/OSU/figures/air-sea/scam/SO/a_wek_tot_scam')
