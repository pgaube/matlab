clear all
load bwr.pal
x=[-2:.01:2];
y=[-2:.01:2];
load ../air-sea/midlat_comps bp26_sst_N_cc
dist_x=linspace(-2,2,65);
sst=smoothn(double(bp26_sst_N_cc.mean),3);
sst = griddata(dist_x,dist_x',sst,x,y','cubic');
sst=sst./(max(abs(sst(:))));


[lon,lat]=meshgrid(x,y);

a=.2; %m
alpha=.32;
a_sst=1;
L=.8; %deg
xo=0; 
yo=0;

wind_speed=10; %ms
wind_dir=0:10:360;

comp_wek=nan(length(x),length(x),length(wind_dir));

[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
dist=sqrt((lon-xo).^2+(lat-yo).^2);
ff=f_cor(-30);
sst=a_sst*sst;
g = 9.81; %ms^-2

%figure(1)
%pcolor(sst);shading flat;colorbar
%title('SST')

for m=1:length(u_w)
%first do just SST
wind_dir(m)
theta=cart2pol(u_w(m),v_w(m))
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
tau_x_sst=wind2stress(u_w(m)+u_sst);
tau_y_sst=wind2stress(v_w(m)+v_sst);
crl_tau_sst=dfdx_abs(tau_y_sst,.01)-dfdy(tau_x_sst,.01);
w_ek_sst=1./(1020*ff).*crl_tau_sst.*8640000;

%now do just crlg
h=a*exp((-dist.^2)/(L^2));
u = (-g./ff).*dfdy(h,.01);
v = (g./ff).*dfdx_abs(h,.01);
crl=dfdx_abs(v,.01)-dfdy(u,.01);
spd_o=sqrt(u.^2+v.^2);
u_rel=u_w(m)-u;
v_rel=v_w(m)-v;
crl_rel=dfdx_abs(v_rel,.01)-dfdy(u_rel,.01);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
strm=sqrt(tau_x.^2+tau_y.^2);
dtdx=dfdx_abs(tau_y,.01);
dtdy=dfdy(tau_x,.01);
ndtdx=dfdx_abs(tau_x,.01);
ndtdy=dfdy(tau_y,.01);
dtds =  cos(deg2rad(wind_dir(m))).*tau_x + sin(deg2rad(wind_dir(m))).*tau_y;
dtdn = -sin(deg2rad(wind_dir(m))).*tau_x + cos(deg2rad(wind_dir(m))).*tau_y;
crl_tau=dtdx-dtdy;
w_ek=1./(1020*ff).*crl_tau.*8640000;
comp_wek(:,:,m)=w_ek;

%now both
u_rel=u_w(m)+u_sst-u;
v_rel=v_w(m)+u_sst-v;
crl_rel_tot=dfdx_abs(v_rel,.01)-dfdy(u_rel,.01);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau_tot=dfdx_abs(tau_y,.01)-dfdy(tau_x,.01);
w_ek_tot=1./(1020*ff).*crl_tau_tot.*8640000;

figure(3)
clf
subplot(321)
compass(u_w(m),v_w(m))
title('Wind Direction')

subplot(322)
pcolor(x,y,w_ek);shading flat;axis image
title('dt_x/dy-dt_y/dx')
ylabel(['max w_E = ',num2str(max(w_ek(:)))])


subplot(323)
pcolor(x,y,dtdy);shading flat;caxis([-1e-7 1e-7]);axis image
title('dT_x/dy')

subplot(324)
pcolor(x,y,dtdx);shading flat;caxis([-1e-7 1e-7]);axis image
title('dT_y/dx')

subplot(325)
pcolor(x,y,dtds);shading flat;caxis([-1e-7 1e-7]);axis image
title('dT/ds')

subplot(326)
pcolor(x,y,dtdn);shading flat;caxis([-1e-7 1e-7]);axis image
title('dT/dn')
drawnow
%{
eval(['print -dpng -r100 frames/test_tau/frame_',num2str(m)])



figure(4)
clf
subplot(221)
compass(u_w(m),v_w(m))
%quiver(u_rel(1:20:end,1:20:end),v_rel(1:20:end,1:20:end))
title('Wind Direction')
text(-25,10,['amp=',num2str(a),'m'])
text(-25,6,['\alpha=',num2str(alpha)])
text(-25,2,['speed=',num2str(wind_speed),'ms^{-1}'])
text(-25,-2,['SST=',num2str(a_sst),'^\circ C'])
text(-25,-6,['W_{max}=',num2str(max(w_ek_tot(:))),'^\circ C'])


subplot(222)
pcolor(x,y,w_ek_tot);shading flat;colorbar
title('W_E from current and SST')
axis image
caxis([-10 10])

subplot(223)
pcolor(x,y,w_ek);shading flat;colorbar
title('W_E from current')
axis image
hold on
contour(x,y,h,[0:.01:1],'k')
caxis([-10 10])

subplot(224)
pcolor(x,y,w_ek_sst);shading flat;colorbar
title('W_E from SST')
axis image
hold on
contour(x,y,sst,[2:-.2:.2],'k-')
contour(x,y,sst,[-.2:-.2:-2],'k--')
caxis([-10 10])
colormap(bwr)
drawnow
eval(['print -dpng -r100 frames/test_wek/frame_',num2str(m)])
%}
end
