%
clear all

load midlat_comps bp26_sst*
x=1000*[-400:10:400];
y=1000*[-400:10:400];
sst_x=1000*100*linspace(-2,2,65);
sst_y=sst_x;
[lon,lat]=meshgrid(x,y);
[sst_lon,sst_lat]=meshgrid(sst_x,sst_y);

real_lat=30+(lat./1000./111.11);
real_lon=30+(lon./1000./111.11);

a=[.20 .1 .03]; %m
L=90e3; %m
Ls=L;
alpha=0.48;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=[1.3 .6 .25];
wind_speed=7; %ms
[ff,bb]=f_cor(30);
g = 9.81; %ms^-2
%
h=a(1)*exp((-dist.^2)/(2*L^2));


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
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);

w_ek_l=(1/1020)*(1./(ff)).*crl_tau.*8640000;
w_ek_n=(1/1020)*(1./(ff).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
w_ek_b=-(1/1020)*(1./(ff).^2)*(tau_x.*bb).*8640000;

w_ek_n=interp2(zgrid(real_lon,real_lat,30,30,double(w_ek_n),Ls/1000),3);
w_ek_l=interp2(zgrid(real_lon,real_lat,30,30,double(w_ek_l),Ls/1000),3);
w_ek_b=interp2(zgrid(real_lon,real_lat,30,30,double(w_ek_b),Ls/1000),3);
vel=interp2(zgrid(real_lon,real_lat,30,30,double(sqrt(u.^2+v.^2)),Ls/1000),3);

pcomps_raw2(w_ek_l,w_ek_l,[-10 10],-100,2,100,'',2,1)
print -depsc /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/sh/linear_wek

pcomps_raw2(w_ek_n,w_ek_n,[-10 10],-100,2,100,'',2,1)
print -depsc /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/sh/nonlinear_with_zeta_wek


return
zgrid_grid;
xi=interp2(xi,3);
yi=interp2(yi,3);
ddist=sqrt(xi.^2+yi.^2);
ri=linspace(0,2,length(xi(:,1)));
[azav_l,azav_n,azav_b,azav_v]=deal(nan(size(ri)));
for m=1:length(ri)-1
	ii=find(ddist>=ri(m) & ddist<ri(m+1));
	tt=nan*xi;
	tt(ii)=1;
% 	figure(1)
% 	clf
% 	pcolor(tt);shading flat;axis image;drawnow
	azav_l(m)=pmean(w_ek_l(ii));
	azav_n(m)=pmean(w_ek_n(ii));
	azav_b(m)=pmean(w_ek_b(ii));
	azav_v(m)=pmean(vel(ii));
end	
T_c=2*pi*100*1000*ri./azav_v/60/60/24;

%}

azav_l=smooth1d_loess(azav_l,ri,.5,ri);
azav_n=smooth1d_loess(azav_n,ri,.5,ri);
azav_b=smooth1d_loess(azav_b,ri,.5,ri);
T_c=smooth1d_loess(T_c,ri,.5,ri);

nazav_l=azav_l.*T_c./100;
nazav_n=azav_n.*T_c./100;
nazav_b=azav_b.*T_c./100;


figure(1)
clf
set(gcf,'PaperPosition',[1 1 15 10])
XXX=L/1e3*[ri;ri;ri];
YYY=[azav_l;azav_n;azav_b];
[ax,h1,h2]=plotyy(XXX',YYY',100*ri,T_c);
set(h1(1),'color','k','linewidth',3)
set(h1(2),'color','b','linewidth',3)
set(h1(3),'color','g','linewidth',3)
set(h2,'color',[.5 .5 .5],'linewidth',3)
set(ax(2),'ycolor',[.5 .5 .5])
set(ax,'fontsize',20,'fontweight','bold','LineWidth',3,'TickLength',[.01 .01],'layer','top')
legend('W_c','W_\zeta','W_{\beta}','rotational period','location','northwest')
ylabel('upwelling velocity (cm per day)','fontsize',25)
xlabel({'distance from eddy centroid (km)'},'fontsize',25)
title({'Azimuthal average'},'fontsize',25)
set(ax,'xlim',[0 115])
axes(ax(1));
line([0 200],[0 0],'color',[.5 .5 .5],'linewidth',1)
axes(ax(2))
ylabel('rotational period (days)','fontsize',25)
set(ax(2),'ylim',[10 40],'ytick',[10:5:80],'xlim',[0 115])
set(ax(1),'ylim',[-3 40],'ytick',[-5:5:40],'xlim',[0 115])

print -dpng -r300 figs/azav_terms_with_zeta_scale.png
%!open figs/azav_terms_scale.eps
return
%}
%now vary L
clear w_ek_l w_ek_n w_ek_b

L=50e3:1e3:150e3;
for m=1:length(L)
h=a(1)*exp((-dist.^2)/(L(m)^2));
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

w_ek_l=1./(1020*(ff)).*crl_tau.*8640000;
w_ek_n=(1/1020)*(1./(ff).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
w_ek_b=(1/1020)*((tau_x.*bb)./(ff).^2).*8640000;

mag_l(m)=max(abs(w_ek_l(:)));
mag_n(m)=max(abs(w_ek_n(:)));
mag_b(m)=max(abs(w_ek_b(:)));
end
%
close(1)
figure(1)
clf
set(gcf,'PaperPosition',[1 1 6 12])
set(gca,'fontsize',15,'fontweight','bold','LineWidth',8,'TickLength',[.05 .1],'layer','top')
plot(L/1000,mag_l/100,'k','linewidth',2)
hold on
plot(L/1000,mag_n/100,'b','linewidth',2)
plot(L/1000,mag_b/100,'g','linewidth',2)
legend('linear','nonlinear','beta')
ylabel('m day^{-1}','fontsize',20)
xlabel({'e-folding scale (km) of Gaussian eddy','with 20 cm ampltiude'},'fontsize',20)
title({'Maximum magnitude of Ekman pumping','within Gaussian anticyclone'},'fontsize',20)
set(gca,'xtick',[50:25:150])
axis tight
daspect([30 1 1])
print -depsc figs/mag_wek_terms_scale.eps
!open figs/mag_wek_terms_scale.eps

%}
%now vary amp
clear w_ek_l w_ek_n w_ek_b
aa=.01:.001:.5;
L=100e3;
for m=1:length(aa)
h=aa(m)*exp((-dist.^2)/(L^2));
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

w_ek_l=1./(1020*(ff)).*crl_tau.*8640000;
w_ek_n=(1/1020)*(1./(ff).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
w_ek_b=(1/1020)*((tau_x.*bb)./(ff).^2).*8640000;

mag_l(m)=max(abs(w_ek_l(:)));
mag_n(m)=max(abs(w_ek_n(:)));
mag_b(m)=max(abs(w_ek_b(:)));
end
%}
close(1)
figure(1)
clf
set(gcf,'PaperPosition',[1 1 6 12])
set(gca,'fontsize',15,'fontweight','bold','LineWidth',8,'TickLength',[.05 .1],'layer','top')
plot(100*aa,mag_l/100,'k','linewidth',2)
hold on
plot(100*aa,mag_n/100,'b','linewidth',2)
plot(100*aa,mag_b/100,'g','linewidth',2)
legend('linear','nonlinear','beta','location','northwest')
ylabel('m day^{-1}','fontsize',20)
xlabel({'Amplitude (cm) of Gaussian eddy','with 100 km e-folding scale'},'fontsize',20)
title({'Maximum magnitude of Ekman pumping','within Gaussian anticyclone'},'fontsize',20)
set(gca,'xtick',[10:10:50])
axis tight
daspect([70 1 1])
print -depsc figs/mag_wek_terms_amp.eps
!open figs/mag_wek_terms_amp.eps
return
%
%now vary wind randomly
L=100e3;
a=0;b=359;
ranw = a + (b-a).*rand(1000,1);
h=.20*exp((-dist.^2)/(L^2));
u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
dvdx=dfdx_m(v,10000);
dudy=dfdy_m(u,10000);
crl=dvdx-dudy;
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);

for m=1:length(ranw)
m
wind_dir=ranw(m);
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u_rel=u_w-u;
v_rel=v_w-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
crl_tau=dtydx-dtxdy;

w_ek_l(:,:,m)=1./(1020*(ff)).*crl_tau.*8640000;
w_ek_n(:,:,m)=(1/1020)*(1./(ff).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
w_ek_b(:,:,m)=(1/1020)*((tau_x.*bb)./(ff).^2).*8640000;

end

w_ek_n=interp2(zgrid(real_lon,real_lat,0,0,double(nanmean(w_ek_n,3)),L/1000),'linear');
w_ek_l=interp2(zgrid(real_lon,real_lat,0,0,double(nanmean(w_ek_l,3)),L/1000),'linear');
w_ek_b=interp2(zgrid(real_lon,real_lat,0,0,double(nanmean(w_ek_b,3)),L/1000),'linear');

cplot_comps_cont_2_2_bwr(w_ek_l,w_ek_l,-20,20,2,-100,100,...
'Mean linear W_E','/Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/sh/mean_linear_wek')

cplot_comps_cont_2_2_bwr(w_ek_n,w_ek_n,-20,20,2,-100,100,...
'Mean nonlinear W_E','/Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/sh/mean_nonlinear_wek')

cplot_comps_cont_2_2_bwr(w_ek_b,w_ek_b,-20,20,2,-100,100,...
'Mean Beta W_E','/Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/sh/mean_beta_wek')