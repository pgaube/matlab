clear all
load bwr.pal
wgrid_grid
x=linspace(-2,2,65);
y=x;
[lon_h,lat_h]=meshgrid(x,y);

a=.15; %m
L=.5; %deg
xo=0; 
yo=0;
dist=sqrt((lon_h-xo).^2+(lat_h-yo).^2);
wind_speed=5.4; %ms

h=a*exp((-dist.^2)/(L^2));

[lon,lat]=meshgrid(x,y);
ff=f_cor(30);
g = 9.81; %ms^-2
denom=1020*sqrt(abs(ff));


u = (-g./ff).*dfdy(h,.0625);
v = (g./ff).*dfdx_abs(h,.0625);



wind_dir=0:360;


for m=1:length(wind_dir)
[u_w,v_w]=pol2cart(degtorad(wind_dir(m)),wind_speed);
u_rel=u_w-u;
v_rel=v_w-v;
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
dx=dfdx_abs(tau_y,.0625);
dy=dfdy(tau_x,.0625);
crl_tau=dfdx_abs(tau_y,.0625)-dfdy(tau_x,.0625);
w_ek=1./(1020*ff).*crl_tau.*8640000;

thet=rad2deg(cart2pol(u_w,v_w))-90; %makes 0 = E
thet=rad2deg(cart2pol(u_w,v_w));
%{
if thet>=0
	thet=-(thet-90);
else
	thet=-thet-90;
end	
%}
ndata=wgrid(double(30*lon), ...
		double(30*lat), ...
		double(xo), ...
		double(yo), ...
		double(w_ek), ...
		double(thet), ...
		double(1000));


figure(1)
clf
subplot(122)
u_rel=.1*u_w-u;
v_rel=.1*v_w-v;
quiver(lon(1:5:end,1:5:end),lat(1:5:end,1:5:end),u_rel(1:5:end,1:5:end),v_rel(1:5:end,1:5:end),.6);axis image
hold on
contour(lon,lat,h,'k')
title(['wind direction is ',num2str(wind_dir(m)),'^\circ  '])
subplot(121)
pcolor(lon,lat,w_ek);shading interp;axis image
hold on
contour(lon,lat,w_ek,[-100:1:-1],'k')
contour(lon,lat,w_ek,[1:5:100],'g')
caxis([-20 20])
title('Ekman pumping')
%{
subplot(132)
pcolor(xi,yi,ndata);shading interp;axis image
hold on
contour(xi,yi,ndata,[-100:1:-1],'k')
contour(xi,yi,ndata,[5 5],'g')
caxis([-20 20])
title('rotated Ekman pumping')
%}
drawnow
colormap(bwr)
eval(['print -dpng -r150 frames/ek_wind_dir_scam_2/frame_',num2str(m)])
end
max(sqrt(u(:).^2+v(:).^2))
max(w_ek(:))