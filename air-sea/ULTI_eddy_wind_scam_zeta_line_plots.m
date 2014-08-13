clear all
% 
x=1000*[-500:10:500];
y=1000*[-500:10:500];

[lon,lat]=meshgrid(x,y);

real_lat=30+(lat./1000./111.11);
real_lon=30+(lon./1000./111.11);

a=[.1]; %m
L=1e3*[30:5:200]; %m
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
wind_speed=7; %ms
[ff,bb]=f_cor(30);
g = 9.81; %ms^-2

wind_dir=0;


%%anticyclones
for n=1:length(L)
h=a*exp((-dist.^2)/(2*L(n)^2));

[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
spd=sqrt(u.^2+v.^2);
u_rel=u_w-u;
v_rel=v_w-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
dvdx=dfdx_m(v,10000);
dudy=dfdy_m(u,10000);
zeta=dvdx-dudy;
crl=zeta;
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);
crl_tau=dtydx-dtxdy;

wl_n=1./(1020*(ff)).*crl_tau.*8640000;
wn_n=(1/1020)*(1./(ff).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
wb_n=(1/1020)*(1./(ff).^2).*(tau_x.*bb).*8640000;
w_ek(:,:,n)=wl_n+wn_n+wb_n;

wl_n=1./(1020*(ff+zeta)).*crl_tau.*8640000;
wn_n=(1/1020)*(1./(ff+zeta).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
wb_n=(1/1020)*(1./(ff+zeta).^2).*(tau_x.*bb).*8640000;
w_ek_z(:,:,n)=wl_n+wn_n+wb_n;

tt=w_ek(:,:,n);
zz=w_ek_z(:,:,n);
ro(n)=max(spd(:))/1000/ff/L(n);
max_cur_pump_a(n)=max(abs(tt(:)));
max_cur_zeta_a(n)=max(abs(zz(:)));
ro_sc_a(n)=max(abs(spd(:)))/ff/L(n);
end

%%cyclones
for n=1:length(L)
h=-a*exp((-dist.^2)/(2*L(n)^2));

[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
spd=sqrt(u.^2+v.^2);
u_rel=u_w-u;
v_rel=v_w-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
dvdx=dfdx_m(v,10000);
dudy=dfdy_m(u,10000);
zeta=dvdx-dudy;
crl=zeta;
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);
crl_tau=dtydx-dtxdy;

wl_n=1./(1020*(ff)).*crl_tau.*8640000;
wn_n=(1/1020)*(1./(ff).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
wb_n=(1/1020)*(1./(ff).^2).*(tau_x.*bb).*8640000;
w_ek(:,:,n)=wl_n+wn_n+wb_n;

wl_n=1./(1020*(ff+zeta)).*crl_tau.*8640000;
wn_n=(1/1020)*(1./(ff+zeta).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
wb_n=(1/1020)*(1./(ff+zeta).^2).*(tau_x.*bb).*8640000;
w_ek_z(:,:,n)=wl_n+wn_n+wb_n;

tt=w_ek(:,:,n);
zz=w_ek_z(:,:,n);
ro(n)=max(spd(:))/1000/ff/L(n);
max_cur_pump_c(n)=max(abs(tt(:)));
max_cur_zeta_c(n)=max(abs(zz(:)));
ro_sc_c(n)=max(abs(spd(:)))/ff/L(n);
end

% %now load midlat tracks and make histos of Ro




figure(3)
clf
set(gcf,'PaperPosition',[1 1 3.75 2.5])
plot(ro_sc_a,max_cur_pump_a,'k','linewidth',3)
hold on
plot(ro_sc_a,max_cur_pump_c,'k','linewidth',3,'color',[.5 .5 .5])
cc=legend('Anticyclones','Cyclones','location','northwest')
set(cc,'box','off')
plot(ro_sc_a,max_cur_zeta_a,'k--','linewidth',1)
plot(ro_sc_c,max_cur_zeta_c,'k--','linewidth',1,'color',[.5 .5 .5])
axis([0 .12 0 120])
% line([.04 .04],[-100 150],'color','k')
ylabel('cm per day','fontsize',45/4)
xlabel({'Rossby number'},'fontsize',45/4)
title({'Maximum Magnitude of ','Current-Induced Ekman Pumping'},'fontsize',45/4)
set(gca,'fontsize',35/4,'linewidth',1)

print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_f_plus_zeta_line_plot
% return
% !open /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_line_plot_scale.png


% per_diff_a=(abs(max_cur_pump_a)-abs(max_cur_zeta_a));
% per_diff_c=(abs(max_cur_pump_c)-abs(max_cur_zeta_c));
% 
% figure(2)
% clf
% set(gcf,'PaperPosition',[1 1 15 10])
% plot(ro_sc_a,per_diff_a,'k','linewidth',4)
% hold on
% plot(ro_sc_c,per_diff_c,'k--','linewidth',4)
% axis([0 .12 -10 10])
% line([.04 .04],[-100 100],'color','k')
% ylabel('cm per day','fontsize',45)
% xlabel({'Rossby number'},'fontsize',45)
% title({'diff'},'fontsize',45)
% set(gca,'fontsize',35,'linewidth',1)
% print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_f_plus_zeta_line_plot_diff
% % !open /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_line_plot_scale.png



load tracks/midlat_tracks

ro=axial_speed./100000./abs(f_cor(y))./scale;
tbins=[0:.01:.25];
[ba,na]=phist(ro,tbins);


pdf_a=100*(na./nansum(na));
cpdf_a=cumsum(pdf_a);

figure(4)
clf
set(gcf,'PaperPosition',[1 1 3.75 1.5])
hold on
stairs(tbins(1:end-1),cpdf_a,'color','k','linewidth',1)
% line([.04 .04],[-100 100],'color','k')
axis([0 .12 10 100])
ylabel('% of observations','fontsize',45/4)
xlabel({'Rossby number'},'fontsize',45/4)
% title('Observed Rossby Numbers','fontsize',45)
set(gca,'fontsize',35/4,'linewidth',1)
box
print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_f_plus_zeta_line_plot_ac_scale
% !open /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_line_plot_scale.png


