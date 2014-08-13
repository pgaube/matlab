clear all

load midlat_comps bp26_sst*
x=1000*[-500:10:500];
y=1000*[-500:10:500];
sst_x=1000*100*linspace(-2,2,65);
sst_y=sst_x;
[lon,lat]=meshgrid(x,y);
[sst_lon,sst_lat]=meshgrid(sst_x,sst_y);

real_lat=30+(lat./1000./111.11);
real_lon=30+(lon./1000./111.11);

a=[.10 .1 .03]; %m
L=90e3; %m
Ls=L;
Lt=99e3;
alpha=0.48;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=[0.3 .5 .3];
wind_speed=7; %ms
ff=f_cor(30);
g = 9.81; %ms^-2

sst=smoothn(double(bp26_sst_S_c.mean),5); %deg c
sst=sst./max(abs(sst(:)));
sst=interp2(sst_x,sst_y,sst,lon,lat,'linear');

for m=1%:length(a)
h=a(m)*exp((-dist.^2)/(2*L^2));
sst=scale_sst(m).*sst;

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
dvdx=dfdx_m(v,10000);
dudy=dfdy_m(u,10000);
crl_tau=dtydx-dtxdy;
crl=dvdx-dudy;
w_ek_e=1./(1020*(ff)).*crl_tau.*8640000;
sum_wek.max_wek_c(m)=max(w_ek_e(:))
sum_wek.min_wek_c(m)=min(w_ek_e(:))


%sst westerly
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir).*dtdx + cosd(wind_dir).*dtdy);
dtds = single(cosd(wind_dir).*dtdx + sind(wind_dir).*dtdy);
theta=cart2pol(u_w,v_w);
[u_sst,v_sst]=pol2cart(deg2rad(wind_dir),alpha*sst);
[tau_x,tau_y] = wind2stress_comp(u_w+u_sst,v_w+v_sst);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
crl_tau=dtydx-dtxdy;
% w_ek_esst=1./(1020*(ff)).*crl_tau.*8640000;
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
theta=cart2pol(u_w,v_w);
[u_sst,v_sst]=pol2cart(deg2rad(wind_dir),alpha*sst);
[tau_x,tau_y] = wind2stress_comp(u_w+u_sst,v_w+v_sst);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
crl_tau=dtydx-dtxdy;
% w_ek_nsst=1./(1020*(ff)).*crl_tau.*8640000;
w_ek_nsst=(.01.*dtdn).*8640000./(1020*ff);
sum_wek.max_wek_nsst(m)=max(w_ek_nsst(:))
sum_wek.min_wek_nsst(m)=min(w_ek_nsst(:))

fsst=(zgrid_abs(real_lon,real_lat,30,30,double(sst),Lt/1000));
crl=(zgrid_abs(real_lon,real_lat,30,30,double(crl),Ls/1000));
ssh=(zgrid_abs(real_lon,real_lat,30,30,double(h),Ls/1000));

w_ek_nsst=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_nsst),Lt/1000));
w_ek_esst=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_esst),Lt/1000));
w_ek_e=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_e),Ls/1000));
w_ek_n=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_n),Ls/1000));

pcomps_raw2(1e5*crl,ssh,[-.4 .4],-1,.01,1,' ',1,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/c_crl_scam_',num2str(a(m)),'.png'])

pcomps_raw2(fillnans(fsst),fillnans(fsst),[-.3 .3],-10,.1,10,'',1,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/c_sst_scam_',num2str(a(m)),'.png'])

pcomps_raw2(fillnans(w_ek_nsst),(w_ek_nsst),[-6 6],-100,.5,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/c_wek_nsst_scam_',num2str(a(m)),'.png'])

pcomps_raw2(fillnans(w_ek_esst),(w_ek_esst),[-6 6],-100,.5,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/c_wek_esst_scam_',num2str(a(m)),'.png'])

pcomps_raw2(w_ek_e,w_ek_e,[-6 6],-100,.5,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/c_wek_ecur_scam_',num2str(a(m)),'.png'])

pcomps_raw2(w_ek_n,w_ek_n,[-6 6],-100,.5,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/c_wek_ncur_scam_',num2str(a(m)),'.png'])

end
