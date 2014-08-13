clear all
% 
x=1000*[-400:10:400];
y=1000*[-400:10:400];
[lon,lat]=meshgrid(x,y);

real_lat=30+(lat./1000./111.11);
real_lon=30+(lon./1000./111.11);

a=[.1]; %m
L=1e3*[30:5:200]; %m
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=linspace(0.3,.8,length(a));
wind_speed=7; %ms
ff=f_cor(30);
g = 9.81; %ms^-2

wind_dir=180;

% 
% %%Do scale
% for n=1:length(L)
% h=a*exp((-dist.^2)/(2*L(n)^2));
% 
% 
% [u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
% u = (-g./ff).*dfdy_m(h,10000);
% v = (g./ff).*dfdx_m(h,10000);
% spd=sqrt(u.^2+v.^2);
% u_rel=u_w-u;
% v_rel=v_w-v;
% [tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
% dtydx=dfdx_m(tau_y,10000);
% dtxdy=dfdy_m(tau_x,10000);
% dvdx=dfdx_m(v,10000);
% dudy=dfdy_m(u,10000);
% zeta=dvdx-dudy;
% crl_tau=dtydx-dtxdy;
% w_ek(:,:,n)=1./(1020*(ff)).*crl_tau.*8640000;
% w_ek_z(:,:,n)=1./(1020*(ff+zeta)).*crl_tau.*8640000;
% 
% 
% tt=w_ek(:,:,n);
% zz=w_ek_z(:,:,n);
% ro(n)=max(spd(:))/1000/ff/L(n);
% max_cur_pump_a(n)=max(abs(tt(:)));
% max_cur_zeta_a(n)=max(abs(zz(:)));
% ro_sc_a(n)=max(abs(spd(:)))/ff/L(n);
% end
% 
% %%Do scale
% for n=1:length(L)
% h=-a*exp((-dist.^2)/(2*L(n)^2));
% 
% 
% [u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
% u = (-g./ff).*dfdy_m(h,10000);
% v = (g./ff).*dfdx_m(h,10000);
% spd=sqrt(u.^2+v.^2);
% u_rel=u_w-u;
% v_rel=v_w-v;
% [tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
% dtydx=dfdx_m(tau_y,10000);
% dtxdy=dfdy_m(tau_x,10000);
% dvdx=dfdx_m(v,10000);
% dudy=dfdy_m(u,10000);
% zeta=dvdx-dudy;
% crl_tau=dtydx-dtxdy;
% w_ek(:,:,n)=1./(1020*(ff)).*crl_tau.*8640000;
% w_ek_z(:,:,n)=1./(1020*(ff+zeta)).*crl_tau.*8640000;
% 
% 
% tt=w_ek(:,:,n);
% zz=w_ek_z(:,:,n);
% ro(n)=max(spd(:))/1000/ff/L(n);
% max_cur_pump_c(n)=max(abs(tt(:)));
% max_cur_zeta_c(n)=max(abs(zz(:)));
% ro_sc_c(n)=max(abs(spd(:)))/ff/L(n);
% end

% % %now load midlat tracks and make histos of Ro



load tracks/midlat_tracks

ro=axial_speed./100000./abs(f_cor(y))./scale;
tbins=[0:.01:.25];
[ba,na]=phist(ro(cyc==1),tbins);
[bc,nc]=phist(ro(cyc==-1),tbins);
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 15 10])
% plot(ro_sc_a,max_cur_pump_a,'k','linewidth',3)
% hold on
% plot(ro_sc_a,max_cur_zeta_a,'r','linewidth',3)
% hold on
% plot(ro_sc_c,max_cur_zeta_c,'b','linewidth',3)
% axis([0 .12 0 80])
% ylabel('cm per day','fontsize',35)
% xlabel({'Rossby number'},'fontsize',35)
% title({'Maximum Magnitude of Current-Induced Ekman Pumping', 'Gaussian Anticyclones with Variable Scale L and Amp=10cm'},'fontsize',35)
% set(gca,'fontsize',25,'linewidth',1)
% print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_f_plus_zeta_line_plot
% % !open /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_line_plot_scale.png
% 

pdf_c=100*(nc./nansum(nc));
cpdf_c=cumsum(pdf_c);

pdf_a=100*(na./nansum(na));
cpdf_a=cumsum(pdf_a);

figure(4)
clf
set(gcf,'PaperPosition',[1 1 15 10])
stairs(tbins(1:end-1),cpdf_c,'color','b','linewidth',3)
hold on
stairs(tbins(1:end-1),cpdf_a,'color','r','linewidth',3)

axis([0 .12 10 100])
ylabel('% of observations','fontsize',35)
xlabel({'Rossby number'},'fontsize',35)
title('Observed Rossby Numbers','fontsize',35)
set(gca,'fontsize',25,'linewidth',1)
print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_f_plus_zeta_line_plot_ac_scale
% !open /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_line_plot_scale.png

