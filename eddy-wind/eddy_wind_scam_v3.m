load bwr.pal
x=[0:.01:5];
y=[0:.01:5];

[lon,lat]=meshgrid(x,y);

a=.20; %m
L=.75; %deg
xo=2.5; 
yo=2.5;
u_w=5; %ms
v_w=0; %ms
dist=sqrt((lon-xo).^2+(lat-yo).^2);

h=a*exp((-dist.^2)/(L^2));
ff=f_cor(30);
g = 9.81; %ms^-2

u = (-g./ff).*dfdy(h,.01);
v = (g./ff).*dfdx_abs(h,.01);

crl=dfdx_abs(v,.01)-dfdy(u,.01);
spd_o=sqrt(u.^2+v.^2);

u_rel=u_w-u;
v_rel=v_w-v;
crl_rel=dfdx_abs(v_rel,.01)-dfdy(u_rel,.01);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau=dfdx_abs(tau_y,.01)-dfdy(tau_x,.01);
w_ek=1./(1020*ff).*crl_tau.*86400;

max(w_ek(:))
return

dist_x = (x-xo);
dist_y = (y-yo);

dist_xi = (dist_x./L);
dist_yi=(dist_y./L);

xi=[-3:.02:3];
xi=ones(length(xi),1)*xi;
yi=xi';

wek = griddata(dist_xi,dist_yi,w_ek,xi,yi,'nearest');
crl = griddata(dist_xi,dist_yi,crl,xi,yi,'nearest');

figure(1)
clf
pcolor(xi,yi,wek)
colormap(bwr)
caxis([-.20 .20])
shading flat
axis image

cplot_comps_cont_3_3_bwr(wek,wek,-.16,.16,.03,-1,1,'/Users/gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/tmp/wek_wek')
cplot_comps_cont_3_3_bwr(1e5*crl,1e5*crl,-1,1,.1,-1,1,'/Users/gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/tmp/crl_crl')