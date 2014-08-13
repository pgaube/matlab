clear all
% 
% ff=f_cor(30);
% 
% max_crl=.6e-5;%linspace(.5,1.5,100).*1e-5;
% max_cur_pump=linspace(5,30,100)./60./60./24/100;
% 
% D=[250 500 750];
% for m=1:length(D)
% atten(:,m)=D(m)*max_crl./ff./max_cur_pump./60./60./24;
% end
% 
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 15 10])
% plot(max_cur_pump*60*60*24*100',atten(:,1),'k','linewidth',3)
% hold on
% plot(max_cur_pump*60*60*24*100',atten(:,2),'k--','linewidth',3)
% plot(max_cur_pump*60*60*24*100',atten(:,3),'k*','linewidth',3)
% axis([5 30 50 1000])
% legend('250 m','500 m','750 m','location','northeast')
% xlabel('eddy-induced Ekman pumping (cm per day)','fontsize',35)
% ylabel({'eddy attenuation time scale (days)'},'fontsize',35)
% title({'Eddy Attenuation Time Scale'},'fontsize',35)
% set(gca,'fontsize',25)
% print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/attenuation_time_scale
% 
% clear all
% D=[250 500 750];
% x=1000*[-500:10:500];
% y=1000*[-500:10:500];
% [lon,lat]=meshgrid(x,y);
% real_lat=30+(lat./1000./111.11);
% real_lon=30+(lon./1000./111.11);
% a=[.03:.005:.25]; %m
% L=90e3; %m
% xo=0;
% yo=0;
% dist=sqrt((lon-xo).^2+(lat-yo).^2);
% scale_sst=[0.3 .5 .3];
% wind_speed=7; %ms
% ff=f_cor(30);
% g = 9.81; %ms^-2
% 
% 
% for m=1:length(D)
%     for n=1:length(a)
%         h=a(n)*exp((-dist.^2)/(2*L^2));
%         wind_dir=180;
%         [u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
%         u = (-g./ff).*dfdy_m(h,10000);
%         v = (g./ff).*dfdx_m(h,10000);
%         u_rel=u_w-u;
%         v_rel=v_w-v;
%         [tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
%         dtydx=dfdx_m(tau_y,10000);
%         dtxdy=dfdy_m(tau_x,10000);
%         dvdx=dfdx_m(v,10000);
%         dudy=dfdy_m(u,10000);
%         crl_tau=dtydx-dtxdy;
%         crl=dvdx-dudy;
%         w_ek_e=1./(1020*(ff)).*crl_tau;
%         max_cur_pump(n)=max(w_ek_e(:));
%         max_crl(n)=max(abs(crl(:)));
%     end
%     atten(:,m)=D(m)*max_crl./ff./max_cur_pump./60./60./24;
% end
% 
% figure(2)
% clf
% set(gcf,'PaperPosition',[1 1 15 10])
% plot(a*100',atten(:,1),'k','linewidth',3)
% hold on
% plot(a*100',atten(:,2),'k--','linewidth',3)
% plot(a*100',atten(:,3),'k*','linewidth',3)
% return
% axis([5 30 50 1000])
% legend('250 m','500 m','750 m','location','northeast')
% xlabel('eddy-induced Ekman pumping (cm per day)','fontsize',35)
% ylabel({'eddy attenuation time scale (days)'},'fontsize',35)
% title({'Eddy Attenuation Time Scale'},'fontsize',35)
% set(gca,'fontsize',25,'xtick',[5:5:30])
% print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/attenuation_time_scale

clear all
D=[250 500 750];
x=1000*[-500:10:500];
y=1000*[-500:10:500];
[lon,lat]=meshgrid(x,y);
real_lat=30+(lat./1000./111.11);
real_lon=30+(lon./1000./111.11);
a=[.1]; %m
L=90e3; %m
xo=0;
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=[0.3 .5 .3];
wind_speed=[2:.5:20]; %ms
ff=f_cor(30);
g = 9.81; %ms^-2
h=a*exp((-dist.^2)/(2*L^2));
u = (-g./ff).*dfdy_m(h,10000);
        v = (g./ff).*dfdx_m(h,10000);
for m=1:length(D)
    for n=1:length(wind_speed)
        wind_dir=180;
        [u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed(n));
        u_rel=u_w-u;
        v_rel=v_w-v;
        [tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
        dtydx=dfdx_m(tau_y,10000);
        dtxdy=dfdy_m(tau_x,10000);
        dvdx=dfdx_m(v,10000);
        dudy=dfdy_m(u,10000);
        crl_tau=dtydx-dtxdy;
        crl=dvdx-dudy;
        w_ek_e=1./(1020*(ff)).*crl_tau;
        max_cur_pump(n)=max(w_ek_e(:));
        max_crl(n)=max(abs(crl(:)));
    end
    atten(:,m)=D(m)*max_crl./ff./max_cur_pump./60./60./24;
end

figure(2)
clf
set(gcf,'PaperPosition',[1 1 15 10])
plot(wind_speed',atten(:,1),'k','linewidth',3)
hold on
plot(wind_speed',atten(:,2),'k--','linewidth',3)
plot(wind_speed',atten(:,3),'k*','linewidth',3)
axis([5 15 50 1000])
legend('250 m','500 m','750 m','location','northeast')
xlabel('background wind speed (m s^{-1})','fontsize',35)
ylabel({'eddy attenuation time scale (days)'},'fontsize',35)
title({'Eddy Attenuation Time Scale'},'fontsize',35)
set(gca,'fontsize',25,'xtick',[5:2.5:30])
print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/attenuation_time_scale_wind
return

clear all
D=[500];
x=1000*[-500:10:500];
y=1000*[-500:10:500];
[lon,lat]=meshgrid(x,y);
real_lat=30+(lat./1000./111.11);
real_lon=30+(lon./1000./111.11);
a=[.1]; %m
L=90e3; %m
xo=0;
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
wind_speed=[7]; %ms
ff=f_cor(30);
g = 9.81; %ms^-2
h=a*exp((-dist.^2)/(2*L^2));
u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
wind_dir=180;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u_rel=u_w-u;
v_rel=v_w-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
dvdx=dfdx_m(v,10000);
dudy=dfdy_m(u,10000);
crl_tau=dtydx-dtxdy;
crl=dvdx-dudy;
w_ek_e=1./(1020*(ff)).*crl_tau;
max_cur_pump=max(w_ek_e(:));
max_crl=max(abs(crl(:)));
atten=D*max_crl./ff./max_cur_pump./60./60./24

