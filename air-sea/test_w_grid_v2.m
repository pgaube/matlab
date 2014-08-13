clear all
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

z=ddz(lon(25,:))*h';

for m=1:length(lat(:,1))
	v(m,:) = (-g./ff)*(ddz(lon(m,:))*h(m,:)');
	u(:,m) = (g./ff)*(ddz(lat(:,m))*h(:,m));
end
return



wind_dir=45:10:360;


for m=1:length(wind_dir)
[u_w,v_w]=pol2cart(degtorad(wind_dir(m)),wind_speed);
u_rel=u_w-u;
v_rel=v_w-v;
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau=(ddz(lon').*tau_y')'-(ddz(lat).*tau_x);
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
subplot(133)
u_rel=-u;
v_rel=-v;
quiver(u_rel(1:10:end,1:10:end),v_rel(1:10:end,1:10:end),1);axis image
title('wind')
subplot(131)
pcolor(lon,lat,w_ek);shading interp;axis image
title('Ekman pumping')
subplot(132)
pcolor(xi,yi,ndata);shading interp;axis image
title('rotated Ekman pumping')
drawnow
end
max(sqrt(u(:).^2+v(:).^2))
max(w_ek(:))