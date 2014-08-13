clear all

load ../regions/new_regions_tight_comps lw_sst_a lw_sst_c lw_ssh_a lw_ssh_c
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
alpha=0.15;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=[1.3 .6 .25];
wind_speed=7; %ms
wind_dir=145;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
ff=f_cor(-30);
g = 9.81; %ms^-2

sst=smoothn(interp2(double(lw_sst_a.median)),25);
ssh=smoothn(interp2(interp2(double(lw_ssh_a.median))),500);
sst=interp2(sst_lon,sst_lat,sst,lon,lat);
ssh=interp2(interp2(sst_lon),interp2(sst_lat),ssh,lon,lat);


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
u = (-g./ff).*dfdy_m(ssh/100,10000);
v = (g./ff).*dfdx_m(ssh/100,10000);
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


cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-1,1,.2,-5,5,['W from SST AC'],...
['~/Documents/OSU/figures/regions/comps/lw2_sst_wek_am']) 

cplot_comps_cont_2_2_bwr(w_ek,w_ek,-10,10,1,-15,15,['W from Cur AC'],...
['~/Documents/OSU/figures/regions/comps/lw2_crl_wek_am']) 


cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-10,10,1,-15,15,['W QuikSCAT AC'],...
['~/Documents/OSU/figures/regions/comps/lw2_wek_am']) 



alpha=0.1;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
wind_speed=8.5; %ms
wind_dir=135;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);


sst=smoothn(interp2(double(lw_sst_c.median)),25);
ssh=smoothn(interp2(interp2(double(lw_ssh_c.median))),500);
sst=interp2(sst_lon,sst_lat,sst,lon,lat);
ssh=interp2(interp2(sst_lon),interp2(sst_lat),ssh,lon,lat);


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
u = (-g./ff).*dfdy_m(ssh/100,10000);
v = (g./ff).*dfdx_m(ssh/100,10000);
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


cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-1,1,.2,-5,5,['W from SST AC'],...
['~/Documents/OSU/figures/regions/comps/lw2_sst_wek_cm']) 

cplot_comps_cont_2_2_bwr(w_ek,w_ek,-10,10,1,-15,15,['W from Cur AC'],...
['~/Documents/OSU/figures/regions/comps/lw2_crl_wek_cm']) 


cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-10,10,1,-15,15,['W total CC'],...
['~/Documents/OSU/figures/regions/comps/lw2_wek_cm']) 
