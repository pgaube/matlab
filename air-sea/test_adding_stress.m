clear all

load midlat_comps bp26_sst*
x=1000*[-200:10:200];
y=1000*[-200:10:200];
sst_x=1000*100*linspace(-2,2,65);
sst_y=sst_x;
[lon,lat]=meshgrid(x,y);
[sst_lon,sst_lat]=meshgrid(sst_x,sst_y);



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

for m=1

h=a(m)*exp((-dist.^2)/(L^2));
sst=scale_sst(m)*int_sst;

%sst
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir).*dtdx + cosd(wind_dir).*dtdy);
dtds = single(cosd(wind_dir).*dtdx + sind(wind_dir).*dtdy);
theta=cart2pol(u_w,v_w);
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
[tau_x_sst,tau_y_sst] = wind2stress_comp(u_w+u_sst,v_w+v_sst);
dtydx_sst=dfdx_m(tau_y_sst,10000);
dtxdy_sst=dfdy_m(tau_x_sst,10000);
crl_tau_sst=dtydx_sst-dtxdy_sst;
w_ek_sst=1./(1020*(ff)).*crl_tau_sst.*8640000;
crl_tau_sst2=(-.01.*dtdn+(-.01*.2).*dtds);
%w_ek_sst=(-.01.*dtdn+(-.01*.2).*dtds).*8640000./(1020*ff);


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
crl_taug=dtydx-dtxdy;
crl=dvdx-dudy;
w_ek=1./(1020*(ff+crl)).*crl_taug.*8640000;


%total
tau_xt=tau_x+tau_x_sst;
tau_yt=tau_y+tau_y_sst;
u_rel=u_w+u_sst-u;
v_rel=v_w+v_sst-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
crl_tau=dtydx-dtxdy;
dtydxt=dfdx_m(tau_yt,10000);
dtxdyt=dfdy_m(tau_xt,10000);
crl_taut=dtydxt-dtxdyt;
w_ek_tot=1./(1020*ff+crl).*crl_tau.*8640000;
w_ek_test=1./(1020*ff+crl).*(crl_taut).*8640000;


%w_ek_sst=zgrid(lon,lat,xo,yo,double(w_ek_sst),L);
%w_ek_tot=zgrid(lon,lat,xo,yo,double(w_ek_tot),L);
%w_ek=zgrid(lon,lat,xo,yo,double(w_ek),L);
return
end