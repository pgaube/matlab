clear all
m=1;
x=1000*[-500:10:500];
y=1000*[-500:10:500];
[lon,lat]=meshgrid(x,y);

real_lat=40+(lat./1000./111.11);
real_lon=40+(lon./1000./111.11);

a=[.15]; %m
L=100e3; %m
Ls=L;
Lt=100e3;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=[.5];
wind_speed=10; %ms
ff=f_cor(-40);
g = 9.81; %ms^-2


h=a*exp((-dist.^2)/(2*L^2));
sst=scale_sst*exp((-dist.^2)/(2*L^2));


%We currents westerly wind
wind_dir=180;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
u_rel=u_w-u;
v_rel=v_w-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
crl_tau=dtydx-dtxdy;
w_ek_e=1./(1020*(ff)).*crl_tau.*8640000;
sum_wek.max_wek_c(m)=max(w_ek_e(:))
sum_wek.min_wek_c(m)=min(w_ek_e(:))


%sst westerly
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir).*dtdx + cosd(wind_dir).*dtdy);
dtds = single(cosd(wind_dir).*dtdx + sind(wind_dir).*dtdy);
w_ek_esst=(.01.*dtdn+(.01*.2).*dtds).*8640000./(1020*ff);
w_ek_esst=(.01.*dtdn).*8640000./(1020*ff);
sum_wek.max_wek_esst(m)=max(w_ek_esst(:))
sum_wek.min_wek_esst(m)=min(w_ek_esst(:))

%We currents southerly wind
wind_dir=270;
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
w_ek_n=1./(1020*(ff)).*crl_tau.*8640000;
sum_wek.max_wek_c(m)=max(w_ek_n(:))
sum_wek.min_wek_c(m)=min(w_ek_n(:))

%sst northerly
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir).*dtdx + cosd(wind_dir).*dtdy);
dtds = single(cosd(wind_dir).*dtdx + sind(wind_dir).*dtdy);
w_ek_nsst=(.01.*dtdn+(.01*.2).*dtds).*8640000./(1020*ff);
w_ek_nsst=(.01.*dtdn).*8640000./(1020*ff);
sum_wek.max_wek_nsst(m)=max(w_ek_nsst(:))
sum_wek.min_wek_nsst(m)=min(w_ek_nsst(:))

fsst=(zgrid_abs(real_lon,real_lat,40,40,double(sst),Ls/1000));
crl=(zgrid_abs(real_lon,real_lat,40,40,double(crl),Ls/1000));
ssh=(zgrid_abs(real_lon,real_lat,40,40,double(h),Ls/1000));

w_ek_esst=(zgrid_abs(real_lon,real_lat,40,40,double(w_ek_esst),Lt/1000));
w_ek_e=(zgrid_abs(real_lon,real_lat,40,40,double(w_ek_e),Ls/1000));
w_ek_nsst=(zgrid_abs(real_lon,real_lat,40,40,double(w_ek_nsst),Lt/1000));
w_ek_n=(zgrid_abs(real_lon,real_lat,40,40,double(w_ek_n),Ls/1000));

pcomps_raw2(ssh,ssh,[-.15 .15],-1,.02,1,'SSH anomaly ',1,30)
eval(['print -dpng -r300 figs/dud_scam/crl_scam_',num2str(a(m)),'.png'])

pcomps_raw2(fillnans(fsst),fillnans(fsst),[-.5 .5],-10,.1,10,'SST anomaly',1,30)
eval(['print -dpng -r300 figs/dud_scam/sst_scam_',num2str(a(m)),'.png'])


pcomps_raw2(fillnans(w_ek_esst),(w_ek_esst),[-6 6],-100,.5,100,'W_E from eddy SST anomaly',2,30)
eval(['print -dpng -r300 figs/dud_scam/2wek_esst_scam_',num2str(a(m)),'.png'])

pcomps_raw2(w_ek_e,w_ek_e,[-6 6],-100,.5,100,'W_E from Gaussian eddy currents',2,30)
eval(['print -dpng -r300 figs/dud_scam/wek_ecur_scam_',num2str(a(m)),'.png'])


pcomps_raw2(fillnans(w_ek_nsst),(w_ek_nsst),[-6 6],-100,.5,100,'W_E from eddy SST anomaly',2,30)
eval(['print -dpng -r300 figs/dud_scam/wek_nsst_scam_',num2str(a(m)),'.png'])

pcomps_raw2(w_ek_n,w_ek_n,[-6 6],-100,.5,100,'W_E from Gaussian eddy currents',2,30)
eval(['print -dpng -r300 figs/dud_scam/wek_ncur_scam_',num2str(a(m)),'.png'])


