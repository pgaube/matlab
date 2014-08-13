clear all

load midlat_comps bp26_sst*
x=1000*[-400:10:400];
y=1000*[-400:10:400];
sst_x=1000*100*linspace(-2,2,65);
sst_y=sst_x;
[lon,lat]=meshgrid(x,y);
[sst_lon,sst_lat]=meshgrid(sst_x,sst_y);

real_lat=(lat./1000./111.11);
real_lon=(lon./1000./111.11);

a=[.22 .1 .03]; %m
L=96e3; %m
alpha=0.48;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=[1.3 .6 .25];
wind_speed=10; %ms
wind_dir=0;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
ff=f_cor(-30);
g = 9.81; %ms^-2

sst=smoothn(double(bp26_sst_N_cc.mean),5); %deg c
sst=sst./max(sst(:));
int_sst=interp2(sst_lon,sst_lat,sst,lon,lat);

for m=1:length(a)

h=a(m)*exp((-dist.^2)/(L^2));
sst=scale_sst(m)*int_sst;

%sst
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir).*dtdx + cosd(wind_dir).*dtdy);
dtds = single(cosd(wind_dir).*dtdx + sind(wind_dir).*dtdy);
theta=cart2pol(u_w,v_w);
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
[tau_x,tau_y] = wind2stress_comp(u_w+u_sst,v_w+v_sst);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
crl_tau=dtydx-dtxdy;
w_ek_sst=1./(1020*(ff)).*crl_tau.*8640000;
%w_ek_sst=(-.01.*dtdn+(-.01*.2).*dtds).*8640000./(1020*ff);
wek_sst=max(w_ek_sst(:))

%crlg
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
w_ek=1./(1020*(ff+crl)).*crl_tau.*8640000;
wek_c=max(w_ek(:))

%total
u_rel=u_w+u_sst-u;
v_rel=v_w+v_sst-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
crl_tau=dtydx-dtxdy;
w_ek_tot=1./(1020*ff+crl).*crl_tau.*8640000;


w_ek_sst=interp2(zgrid(real_lon,real_lat,0,0,double(w_ek_sst),L/1000),'linear');
w_ek_tot=interp2(zgrid(real_lon,real_lat,0,0,double(w_ek_tot),L/1000),'linear');
w_ek=interp2(zgrid(real_lon,real_lat,0,0,double(w_ek),L/1000),'linear');

eval(['cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-20,20,2,-100,100,',...
char(39),'W_E^ from eddy SST anomaly',char(39),',',char(39),...
'/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/sh/c_wek_sst_scam_',...
num2str(a(m)),char(39),')'])

eval(['cplot_comps_cont_2_2_bwr(w_ek,w_ek,-20,20,2,-100,100,',...
char(39),'W_E^ from Gaussian eddy currents',char(39),',',char(39),...
'/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/sh/c_wek_cur_scam_',...
num2str(a(m)),char(39),')'])

eval(['cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-20,20,2,-100,100,',...
char(39),'Total W_E',char(39),',',char(39),...
'/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/sh/c_wek_tot_scam_',...
num2str(a(m)),char(39),')'])

%{
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-20,20,1,-100,100,'W_E^ from Gaussian eddy currents','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/sh//c_wek_cur_scam_big')
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-50,50,1,-100,100,'W_E^ from Gaussian eddy currents','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/sh//c_wek_cur_50_50_scam_big')
cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-20,20,1,-100,100,'Total W_E','/Users/gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/sh/c_wek_tot_scam_big')
%}
end
