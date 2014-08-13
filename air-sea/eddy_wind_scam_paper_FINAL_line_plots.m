clear all
% 
load midlat_comps bp26_sst*
x=1000*[-400:10:400];
y=1000*[-400:10:400];
sst_x=1000*100*linspace(-2,2,65);
sst_y=sst_x;
[lon,lat]=meshgrid(x,y);
[sst_lon,sst_lat]=meshgrid(sst_x,sst_y);

real_lat=30+(lat./1000./111.11);
real_lon=30+(lon./1000./111.11);

a=[.03:.005:.35]; %m
L=1e3*[70 90 140]; %m
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=linspace(.001,1.5,length(a));
wind_speed=7; %ms
ff=f_cor(30);
g = 9.81; %ms^-2

sst=smoothn(double(bp26_sst_S_c.mean),5); %deg c
sst=sst./max(abs(sst(:)));
sst=interp2(sst_x,sst_y,sst,lon,lat,'linear');
wind_dir=180;

% 
% for n=1:length(L)
% for m=1:length(a)
% h=a(m)*exp((-dist.^2)/(2*L(n)^2));
% 
% 
% [u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
% u = (-g./ff).*dfdy_m(h,10000);
% v = (g./ff).*dfdx_m(h,10000);
% u_rel=u_w-u;
% v_rel=v_w-v;
% [tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
% dtydx=dfdx_m(tau_y,10000);
% dtxdy=dfdy_m(tau_x,10000);
% dvdx=dfdx_m(v,10000);
% dudy=dfdy_m(u,10000);
% crl_tau=dtydx-dtxdy;
% w_ek_e=1./(1020*(ff)).*crl_tau.*8640000;
% 
% 
% max_cur_pump(n,m)=max(abs(w_ek_e(:)));
% end
% end
% 
% 
% for m=1:length(a)
% sst=sst./max(abs(sst(:)));
% sst=scale_sst(m).*sst;
% 
% 
% %sst westerly
% dtdx=dfdx_m(sst,10000);
% dtdy=dfdy_m(sst,10000);
% dtdn = single(-sind(wind_dir).*dtdx + cosd(wind_dir).*dtdy);
% dtds = single(cosd(wind_dir).*dtdx + sind(wind_dir).*dtdy);
% 
% w_ek_esst=(.01.*dtdn+(.01*.2).*dtds).*8640000./(1020*ff);
% % figure(1)
% % clf
% % pcolor(double(w_ek_esst));shading flat;axis image
% % caxis([-2 2])
% % title(num2str(scale_sst(m)))
% 
% max_sst_pump(m)=max(abs(w_ek_esst(:)));
% end
% 
% 
% 
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 15 10])
% plot(100*a',max_cur_pump(1,:),'k','linewidth',5)
% hold on
% plot(100*a',max_cur_pump(2,:),'k--','linewidth',5)
% plot(100*a',max_cur_pump(3,:),'k*','linewidth',5)
% axis([3 35 0 35])
% legend('70 km','90 km','140 km','location','northwest')
% ylabel('cm per day','fontsize',45)
% xlabel({'Gaussian eddy amplitude (cm)'},'fontsize',45)
% title({'Maximum Magnitude of ','Current-Induced Ekman Pumping'},'fontsize',45)
% set(gca,'fontsize',35,'linewidth',1)
% print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_line_plot
% 
% % !open /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_line_plot.png
% 
% % 
% % return
% % 
% % 
% figure(2)
% clf
% set(gcf,'PaperPosition',[1 1 15 10])
% plot(scale_sst',max_sst_pump(1,:),'k','linewidth',5)
% ylabel('cm per day','fontsize',45)
% xlabel({'SST anomaly magnitude (^\circ C)'},'fontsize',45)
% title({'Maximum Magnitude of ','SST-Induced Ekman Pumping'},'fontsize',45)
% set(gca,'fontsize',35,'xtick',[0:.25:1.5],'linewidth',1)
% axis([0 1.5 0 20])
% print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_sst_line_plot
% % !open /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_sst_line_plot.png
% 
% 

%Do scale
clear max_cur_pump
L=1e3*[30:5:200]; %m
a=[.07 .15 .25];
for n=1:length(L)
for m=1:length(a)
h=a(m)*exp((-dist.^2)/(2*L(n)^2));


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
w_ek_e=1./(1020*(ff)).*crl_tau.*8640000;


max_cur_pump(n,m)=max(abs(w_ek_e(:)));
end
end

figure(3)
clf
set(gcf,'PaperPosition',[1 1 15 10])
plot(1e-3*L',max_cur_pump(:,1),'k','linewidth',5)
hold on
plot(1e-3*L',max_cur_pump(:,2),'k--','linewidth',5)
plot(1e-3*L',max_cur_pump(:,3),'k*','linewidth',5)
axis([40 200 0 70])
legend('3 cm','15 cm','25 cm','location','northeast')
ylabel('cm per day','fontsize',45)
xlabel({'Gaussian eddy radius scale L (km)'},'fontsize',45)
title({'Maximum Magnitude of ','Current-Induced Ekman Pumping'},'fontsize',45)
set(gca,'fontsize',35,'xtick',[50:50:200],'linewidth',1)
print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_line_plot_scale
% !open /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_line_plot_scale.png
