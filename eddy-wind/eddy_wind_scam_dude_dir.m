clear all

load ../air-sea/midlat_comps

x=1000*[-400:10:400];
y=1000*[-400:10:400];
sst_x=1000*100*linspace(-2,2,65);
sst_y=sst_x;
[lon,lat]=meshgrid(x,y);
[sst_lon,sst_lat]=meshgrid(sst_x,sst_y);

real_lat=(lat./1000./111.11);
real_lon=(lon./1000./111.11);

a=.2;
L=96e3; %m
alpha=0.32;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=.5;
ff=f_cor(30);
g = 9.81; %ms^-2


wind_speed=10; %ms
wind_dir=0:90:360;


[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
sst=smoothn(double(bp26_sst_S_c.mean),5); %deg c
sst=sst./max(sst(:));
int_sst=interp2(sst_lon,sst_lat,sst,lon,lat);
sst=scale_sst*int_sst;
h=a*exp((-dist.^2)/(L^2));


for m=1:length(u_w)
%first do just SST
wind_dir(m)
theta=cart2pol(u_w(m),v_w(m));
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
u_rel=u_w(m)+u_sst;
v_rel=v_w(m)+v_sst;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
crl_tau_sst=dtydx-dtxdy;
w_ek_sst=1./(1020*ff).*crl_tau_sst.*8640000;

%crlg
u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
u_rel=u_w(m)-u;
v_rel=v_w(m)-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
dvdx=dfdx_m(v,10000);
dudy=dfdy_m(u,10000);
crl_tau=dtydx-dtxdy;
crl=dvdx-dudy;
w_ek=1./(1020*(ff+crl)).*crl_tau.*8640000;


%total
u_rel=u_w(m)+u_sst-u;
v_rel=v_w(m)+v_sst-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
crl_tau=dtydx-dtxdy;
w_ek_tot=1./(1020*(ff+crl)).*crl_tau.*8640000;

w_ek_sst=interp2(zgrid(real_lon,real_lat,0,0,double(w_ek_sst),L/1000),'linear');
w_ek=interp2(zgrid(real_lon,real_lat,0,0,double(w_ek),L/1000),'linear');
w_ek_tot=interp2(zgrid(real_lon,real_lat,0,0,double(w_ek_tot),L/1000),'linear');


eval(['cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-30,30,3,-100,100,',char(39),...
'W_E^ from currents and SST anomaly',char(39),',',char(39),...
'/Users/gaube/Documents/OSU/figures/eddy-wind/scam_05_deg_c/wek_dir_scam_tot',num2str(m),char(39),')'])

eval(['cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-30,30,3,-100,100,',char(39),...
'W_E^ from SST anomaly',char(39),',',char(39),...
'/Users/gaube/Documents/OSU/figures/eddy-wind/scam_05_deg_c/wek_dir_scam_sst',num2str(m),char(39),')'])

eval(['cplot_comps_cont_2_2_bwr(w_ek,w_ek,-30,30,3,-100,100,',char(39),...
'W_E^ from Gaussian eddy currents',char(39),',',char(39),...
'/Users/gaube/Documents/OSU/figures/eddy-wind/scam_05_deg_c/wek_dir_scam_cur',num2str(m),char(39),')'])



%}
end

m=1;
wind_dir(m)
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir(m)).*dtdx + cosd(wind_dir(m)).*dtdy);
dtds = single(cosd(wind_dir(m)).*dtdx + sind(wind_dir(m)).*dtdy);
theta=cart2pol(u_w(m),v_w(m));
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
w_ek_sst=(-.01.*dtdn+(-.01*.2).*dtds).*8640000./(1020*ff);

%crlg
u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
u_rel=u_w(m)-u;
v_rel=v_w(m)-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
dvdx=dfdx_m(v,10000);
dudy=dfdy_m(u,10000);
crl_tau=dtydx-dtxdy;
crl=dvdx-dudy;
w_ek=1./(1020*(ff+crl)).*crl_tau.*8640000;


%total
u_rel=u_w(m)+u_sst-u;
v_rel=v_w(m)+v_sst-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
crl_tau=dtydx-dtxdy;
w_ek_tot=1./(1020*(ff+crl)).*crl_tau.*8640000;

cplot_comps_cont_2_2(1e5*crl,h,-2,2,.02,-2,2,'Gaussian eddy geostrophic vorticity','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_1_deg_c/crl_scam')
cplot_comps_cont_2_2(sst,sst,-.5,.5,.1,-2,2,'eddy SST anomaly','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_1_deg_c/sst_scam')
cplot_comps_cont_2_2(sst,h,-.5,.5,.02,-1,1,'eddy SST anomaly','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_1_deg_c/sst_h_scam')
cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-30,30,3,-100,100,'W_E^ from eddy SST anomaly','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_1_deg_c/wek_sst_scam')
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-30,30,3,-100,100,'W_E^ from Gaussian eddy currents','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_1_deg_c/wek_cur_scam')
cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-30,30,3,-100,100,'W_E^ from currents and SST anomaly','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_1_deg_c/wek_tot_scam')