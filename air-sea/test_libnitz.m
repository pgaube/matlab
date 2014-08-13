clear all

x=1000*[-500:10:500];
y=1000*[-500:10:500];
[lon,lat]=meshgrid(x,y);
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
wind_speed=[1:20]; %ms
[ff,bb]=f_cor(30);
g = 9.81; %ms^-2



h=a*exp((-dist.^2)/(2*L^2));
for m=1:length(wind_speed)
%We currents westerly wind
wind_dir=0;
wind_dir_sst=180;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed(m));

u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
u_rel=u_w-u;
v_rel=v_w-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dvdx=dfdx_m(v,10000);
dudy=dfdy_m(u,10000);
crl=dvdx-dudy;
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);

dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
crl_tau=dtydx-dtxdy;

wl_e=1./(1020*(ff+crl)).*crl_tau.*8640000;
wn_e=(1/1020)*(1./(ff+crl).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
wb_e=(1/1020)*(1./(ff+crl).^2).*(tau_x.*bb).*8640000;
w_ek_e(:,:,m)=wl_e+wn_e;



dtydx=dfdx_m(tau_y./(ff+crl),10000);
dtxdy=dfdy_m(tau_x./(ff+crl),10000);
crl_tau=dtydx-dtxdy;
w_ek_e2(:,:,m)=1./1020.*crl_tau.*8640000;

% load bwr.pal
% 
% figure(1)
% clf
% subplot(211)
% pcolor(w_ek_e);shading flat;axis image
% caxis([-10 10])
% colormap(bwr)
% hold on
% contour(w_ek_e,[-100:2:100],'k')
% 
% subplot(212)
% pcolor(w_ek_e2);shading flat;axis image
% caxis([-10 10])
% hold on
% contour(w_ek_e2,[-100:2:100],'k')
% 
% figure(2)
% pcolor(w_ek_e-w_ek_e2);shading flat;axis image
% colorbar
end

figure(1)
clf
for m=1:length(wind_speed)
tt=w_ek_e(:,:,m);
m1(m)=max(abs(tt(:)));
tt=w_ek_e2(:,:,m);
m2(m)=max(abs(tt(:)));
end
plot(wind_speed,m1);
hold on
plot(wind_speed,m2,'k')

figure(2)
clf
plot(wind_speed,m1-m2);

