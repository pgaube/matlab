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

a=[.14]; %m
L=90e3; %m
Ls=L;
Lt=99e3;
alpha=0.48;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=[0.3 .5 .3];
wind_speed=7; %ms
[ff,bb]=f_cor(30);
g = 9.81; %ms^-2

sst=smoothn(double(bp26_sst_S_c.mean),5); %deg c
sst=sst./max(abs(sst(:)));
% sst=flipud(interp2(sst_x,sst_y,sst,lon,lat,'linear'));
sst=(interp2(sst_x,sst_y,sst,lon,lat,'linear'));

for m=1%:length(a)
h=a(m)*exp((-dist.^2)/(2*L^2));
sst=scale_sst(m).*sst;

%We currents westerly wind
wind_dir=0;
wind_dir_sst=180;
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
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);
wl_e=1./(1020*(ff+crl)).*crl_tau.*8640000;
wn_e=(1/1020)*(1./(ff+crl).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
wb_e=(1/1020)*(1./(ff+crl).^2).*(tau_x.*bb).*8640000;
w_ek_e=wl_e+wn_e;

sum_wek.max_wek_c(m)=max(w_ek_e(:))
sum_wek.min_wek_c(m)=min(w_ek_e(:))


%sst westerly
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir_sst).*dtdx + cosd(wind_dir_sst).*dtdy);

w_ek_esst=(.013.*dtdn).*8640000./(1020*ff+crl);
sum_wek.max_wek_esst(m)=max(w_ek_esst(:))
sum_wek.min_wek_esst(m)=min(w_ek_esst(:))

%We currents southerly wind
wind_dir=90;
wind_dir_sst=270;
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
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);
wl_n=1./(1020*(ff+crl)).*crl_tau.*8640000;
wn_n=(1/1020)*(1./(ff+crl).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
wb_n=(1/1020)*(1./(ff+crl).^2).*(tau_x.*bb).*8640000;

w_ek_n=wl_n+wn_n;
sum_wek.max_wek_c(m)=max(w_ek_n(:))
sum_wek.min_wek_c(m)=min(w_ek_n(:))

%sst northerly
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir_sst).*dtdx + cosd(wind_dir_sst).*dtdy);

w_ek_nsst=(.013.*dtdn).*8640000./(1020*ff+crl);
sum_wek.max_wek_nsst(m)=max(w_ek_nsst(:))
sum_wek.min_wek_nsst(m)=min(w_ek_nsst(:))

fsst=(zgrid_abs(real_lon,real_lat,30,30,double(sst),Lt/1000));
crl=(zgrid_abs(real_lon,real_lat,30,30,double(crl),Ls/1000));
ssh=(zgrid_abs(real_lon,real_lat,30,30,double(h),Ls/1000));

w_ek_nsst=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_nsst),Lt/1000));
w_ek_esst=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_esst),Lt/1000));
w_ek_e=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_e),Ls/1000));
w_ek_n=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_n),Ls/1000));

w_ek_c_e=(zgrid_abs(real_lon,real_lat,30,30,double(wl_e),Ls/1000));
w_ek_c_n=(zgrid_abs(real_lon,real_lat,30,30,double(wl_n),Ls/1000));
w_ek_z_e=(zgrid_abs(real_lon,real_lat,30,30,double(wn_e),Ls/1000));
w_ek_z_n=(zgrid_abs(real_lon,real_lat,30,30,double(wn_n),Ls/1000));
w_ek_b_e=(zgrid_abs(real_lon,real_lat,30,30,double(wb_e),Ls/1000));
w_ek_b_n=(zgrid_abs(real_lon,real_lat,30,30,double(wb_n),Ls/1000));
a(m)=0.1
% pcomps_raw2(1e5*crl,ssh,[-.4 .4],-1,.01,1,' ',1,30)
% eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/sh_a_crl_scam_',num2str(a(m)),'.png'])
% 
% pcomps_raw2(fillnans(fsst),fillnans(fsst),[-.3 .3],-10,.05,10,'',1,30)
% eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/sh_a_sst_scam_',num2str(a(m)),'.png'])
% % return
pcomps_raw2(fillnans(w_ek_nsst),(w_ek_nsst),[-10 10],-100,1,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/a_wek_nsst_scam_',num2str(a(m)),'.png'])
pcomps_raw2(fillnans(w_ek_esst),(w_ek_esst),[-10 10],-100,1,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/a_wek_esst_scam_',num2str(a(m)),'.png'])

pcomps_raw2(w_ek_e,w_ek_e,[-10 10],-100,1,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/a_wek_ecur_scam_',num2str(a(m)),'.png'])

pcomps_raw2(w_ek_n,w_ek_n,[-10 10],-100,1,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/a_wek_ncur_scam_',num2str(a(m)),'.png'])


pcomps_raw2(w_ek_c_e,w_ek_c_e,[-10 10],-100,1,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/a_wek_e_c_scam_',num2str(a(m)),'.png'])

pcomps_raw2(w_ek_c_n,w_ek_c_n,[-10 10],-100,1,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/a_wek_n_c_scam_',num2str(a(m)),'.png'])

pcomps_raw2(w_ek_z_e,w_ek_z_e,[-10 10],-100,1,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/a_wek_e_z_scam_',num2str(a(m)),'.png'])

pcomps_raw2(w_ek_z_n,w_ek_z_n,[-10 10],-100,1,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/a_wek_n_z_scam_',num2str(a(m)),'.png'])

pcomps_raw2(w_ek_b_e,w_ek_b_e,[-10 10],-100,.01,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/a_wek_e_b_scam_',num2str(a(m)),'.png'])

pcomps_raw2(w_ek_b_n,w_ek_b_n,[-10 10],-100,.01,100,'',2,30)
eval(['print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/a_wek_n_b_scam_',num2str(a(m)),'.png'])

end
