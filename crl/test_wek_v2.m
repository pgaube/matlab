clear all
load bwr.pal
x=1000*[-200:200];
y=1000*[-200:200];

[lon,lat]=meshgrid(x,y);

a=.2; %m
L=96e3; %m
xo=0; 
yo=0;

wind_speed=10; %ms
wind_dir=0:10:360;

comp_wek=nan(length(x),length(x),length(wind_dir));

[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
dist=sqrt((lon-xo).^2+(lat-yo).^2);
ff=f_cor(-30);
g = 9.81; %ms^-2


for m=1:length(u_w)
wind_dir(m)
theta=cart2pol(u_w(m),v_w(m))

h=a*exp((-dist.^2)/(L^2));
u = (-g./ff).*dfdy_m(h,1000);
v = (g./ff).*dfdx_m(h,1000);
u_rel=u_w(m)-u;
v_rel=v_w(m)-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,1000);
dtxdy=dfdy_m(tau_x,1000);
dtdx=dfdx_m(tau_x,1000);
dtdy=dfdy_m(tau_y,1000);
dtds =  cos(deg2rad(wind_dir(m))).*dtdx + sin(deg2rad(wind_dir(m))).*dtdy;
dtdn = -sin(deg2rad(wind_dir(m))).*dtdx + cos(deg2rad(wind_dir(m))).*dtdy;
crl_tau=dtydx-dtxdy;
w_ek=(1/(1020*ff)).*crl_tau.*60*60*24*100;

figure(3)
clf
subplot(321)
compass(u_w(m),v_w(m))
title('Wind Direction')

subplot(222)
pcolor(x./1e3,y./1e3,w_ek);shading flat;axis image;caxis([-30 30])
hold on
contour(x./1e3,y./1e3,w_ek,[-100:5:-5],'k--')
contour(x./1e3,y./1e3,w_ek,[5:5:100],'k')
title('w_E')
ylabel(['max w_E = ',num2str(max(w_ek(:)))])

subplot(223)
pcolor(x./1e3,y./1e3,dtxdy);shading flat;caxis([-1e-7 1e-7]);axis image
title('dT_x/dy')

subplot(224)
pcolor(x./1e3,y./1e3,dtydx);shading flat;caxis([-1e-7 1e-7]);axis image
title('dT_y/dx')
%{
subplot(325)
pcolor(x./1e3,y./1e3,dtds);shading flat;caxis([-1e-7 1e-7]);axis image
title('dT/ds')

subplot(326)
pcolor(x./1e3,y./1e3,dtdn);shading flat;caxis([-1e-7 1e-7]);axis image
title('dT/dn')
%}
drawnow
eval(['print -dpng -r100 frames/test_tau/frame_',num2str(m)])



end
