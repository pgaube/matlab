clear all
% % 
% load midlat_comps bp26_sst*
% x=1000*[-400:10:400];
% y=1000*[-400:10:400];
% sst_x=1000*100*linspace(-2,2,65);
% sst_y=sst_x;
% [lon,lat]=meshgrid(x,y);
% [sst_lon,sst_lat]=meshgrid(sst_x,sst_y);
% 
% real_lat=30+(lat./1000./111.11);
% real_lon=30+(lon./1000./111.11);
% 
% a=[.03:.01:.35]; %m
% L=1e3*[70 90 140]; %m
% xo=0; 
% yo=0;
% dist=sqrt((lon-xo).^2+(lat-yo).^2);
% scale_sst=linspace(.001,1.5,length(a));
% wind_speed=7; %ms
% [ff,bb]=f_cor(30);
% g = 9.81; %ms^-2
% 
% sst=smoothn(double(bp26_sst_S_c.mean),5); %deg c
% sst=sst./max(abs(sst(:)));
% sst=interp2(sst_x,sst_y,sst,lon,lat,'linear');
% wind_dir=180;
% 
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
% crl=dvdx-dudy;
% dcdy=dfdy_m(crl,10000);
% dcdx=dfdx_m(crl,10000);
% 
% wl_n=1./(1020*(ff+crl)).*crl_tau.*8640000;
% wn_n=(1/1020)*(1./(ff+crl).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
% wb_n=(1/1020)*(1./(ff+crl).^2).*(tau_x.*bb).*8640000;
% w_ek_e=wl_n+wn_n;
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
% w_ek_esst=(.013.*dtdn).*8640000./(1020*ff+crl);
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
% set(gcf,'PaperPosition',[1 1 3.75 2.5])
% plot(100*a',max_cur_pump(1,:),'k','linewidth',3)
% hold on
% plot(100*a',max_cur_pump(2,:),'k','linewidth',1)
% plot(100*a',max_cur_pump(3,:),'k--','linewidth',1)
% axis([3 35 0 60])
% cc=legend('70 km','90 km','140 km','location','northwest')
% set(cc,'box','off')
% ylabel('cm per day','fontsize',45/4)
% xlabel({'Gaussian eddy amplitude (cm)'},'fontsize',45/4)
% title({'Maximum Magnitude of ','Current-Induced Ekman Pumping'},'fontsize',45/4)
% set(gca,'fontsize',35/4,'linewidth',1)
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
% set(gcf,'PaperPosition',[1 1 3.75 2.4])
% plot(scale_sst',max_sst_pump(1,:),'k','linewidth',3)
% ylabel('cm per day','fontsize',45/4)
% xlabel({'SST anomaly magnitude (^\circC)'},'fontsize',45/4)
% title({'Maximum Magnitude of ','SST-Induced Ekman Pumping'},'fontsize',45/5)
% set(gca,'fontsize',35/4,'xtick',[0:.25:1.5],'linewidth',1)
% axis([0 1.5 0 25])
% print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_sst_line_plot
% % !open /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_sst_line_plot.png
% 
% 
% %Do scale
% clear max_cur_pump
% L=1e3*[30:4:200]; %m
% a=[.07 .15 .25];
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
% crl=dvdx-dudy;
% dcdy=dfdy_m(crl,10000);
% dcdx=dfdx_m(crl,10000);
% wl_n=1./(1020*(ff+crl)).*crl_tau.*8640000;
% wn_n=(1/1020)*(1./(ff+crl).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
% wb_n=(1/1020)*(1./(ff+crl).^2).*(tau_x.*bb).*8640000;
% w_ek_e=wl_n+wn_n;
% 
% max_cur_pump(n,m)=max(abs(w_ek_e(:)));
% end
% end
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 3.75 2.5])
% plot(1e-3*L',max_cur_pump(:,1),'k','linewidth',3)
% hold on
% plot(1e-3*L',max_cur_pump(:,2),'k','linewidth',1)
% plot(1e-3*L',max_cur_pump(:,3),'k--','linewidth',1)
% axis([40 200 0 100])
% cc=legend('3 cm','15 cm','25 cm','location','northeast')
% set(cc,'box','off')
% ylabel('cm per day','fontsize',45/4)
% xlabel({'Gaussian eddy radius scale L (km)'},'fontsize',45/4)
% title({'Maximum Magnitude of ','Current-Induced Ekman Pumping'},'fontsize',45/4)
% set(gca,'fontsize',35/4,'xtick',[50:50:200],'linewidth',1)
% print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_line_plot_scale
% % !open /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/wek_line_plot_scale.png
% 
% return
%%%%
%%Now make hists
%%%%

%histo of midlat scale
load tracks/midlat_tracks

%%%%%
%scale
%%%%%
[na,bins]=hist(scale,15);
figure(1)
clf
set(gcf,'PaperPosition',[1 1 3.75 1.5])
stairs(bins,100*(na./nansum(na)),'k','linewidth',1)
axis tight
axis([40 200 0 30])

set(gca,'xtick',[0:50:250])
set(gca,'fontsize',35/4,'TickLength',[.01 .01],'layer','top','linewidth',1)
xlabel('Observed speed-based eddy radius scale Ls (km)','fontsize',45/4)
ylabel('% of observations','fontsize',45/4)

print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/scale_hist

%%%%%
%amp
%%%%%
[na,bins]=hist(amp,40);
figure(1)
clf
set(gcf,'PaperPosition',[1 1 3.75 1.5])
stairs(bins,100*(na./nansum(na)),'k','linewidth',1)
axis tight

axis([3 35 0 45])
set(gca,'xtick',[0:5:40])
set(gca,'fontsize',35/4,'TickLength',[.01 .01],'layer','top','linewidth',1)
xlabel('Observed eddy amplitude (cm)','fontsize',45/4)
ylabel('% of observations','fontsize',45/4)
print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/amp_hist

%%%%%
%SST
%%%%%
% clear all
% load tracks/midlat_tracks.mat
% [sst_a,sst_c]=comps_output_full_comp(x,y,cyc,k,id,track_jday,scale,'bp26_sst','~/data/ReynoldsSST/mat/OI_25_30_','n');
% save midlat_sst_comps_all sst_a sst_c
% return

load midlat_sst_comps_all
zgrid_grid
dist=sqrt(xi.^2+yi.^2);
mask=nan*dist;
mask(dist<=1)=1;

for m=1:length(sst_a(1,1,:))
    sst_a(:,:,m)=sst_a(:,:,m).*mask;
end

for m=1:length(sst_c(1,1,:))
    sst_c(:,:,m)=sst_c(:,:,m).*mask;
end

% pmean(sst_a(17,17,:))
% pmean(sst_c(17,17,:))
% return

tbins=0:.07:1.7;
[b,na]=phist(sst_a(:),tbins);
[b,nc]=phist(sst_c(:),tbins);
n_sst=na+nc

figure(1)
clf
set(gcf,'PaperPosition',[1 1 3.75 1.5])
stairs(tbins(1:end-1),100*(n_sst./nansum(n_sst)),'k','linewidth',1)
axis tight
axis([0 1.5 0 25])
set(gca,'xtick',[0:.25:1.5])
set(gca,'fontsize',35/4,'TickLength',[.01 .01],'layer','top','linewidth',1)
xlabel('Observed eddy SST anomaly (^\circ C)','fontsize',45/4)
ylabel('% of observations','fontsize',45/4)
print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/sst_hist


