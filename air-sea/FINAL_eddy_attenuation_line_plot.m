% % % %as a function of Ua
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
wind_speed=[2:.2:20]; %ms
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
xlabel('background wind speed U_a (m s^{-1})','fontsize',35)
ylabel({'eddy attenuation time scale (days)'},'fontsize',35)
title({'Eddy Attenuation Time Scale'},'fontsize',35)
set(gca,'fontsize',25,'xtick',[5:2.5:30],'linewidth',1)
print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/attenuation_time_scale_wind


% % now as a function of D
clear all
D=[200:10:1000];
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
ff=f_cor(30);
g = 9.81; %ms^-2
h=a*exp((-dist.^2)/(2*L^2));
u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
wind_speed=[7 14 21]; %ms
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
plot(D',atten(1,:),'k','linewidth',3)
hold on
plot(D',atten(2,:),'k--','linewidth',3)
plot(D',atten(3,:),'k*','linewidth',3)
axis([200 1000 0 1000])
legend('7 m s^{-1}','14 m s^{-1}','21 m s^{-1}','location','northwest')
xlabel('vertical eddy scale D (m)','fontsize',35)
ylabel({'eddy attenuation time scale (days)'},'fontsize',35)
title({'Eddy Attenuation Time Scale'},'fontsize',35)
set(gca,'fontsize',25,'xtick',[200:200:1000],'linewidth',1)
print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/attenuation_time_scale_D


