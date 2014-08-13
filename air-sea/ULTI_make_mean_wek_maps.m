clear all
% 
% qsave_head='QSCAT_30_25km_';
% fsave_path='~/data/QuickScat/ULTI_mat5/';
% fsave4_path='~/data/QuickScat/ULTI_mat4/';
% 
% asave_head='AVISO_25_W_';
% asave_path='~/data/eddy/V5/mat/';
% 
% jdays=[2452571:7:2455147];
% lj=length(jdays);
% % load([asave_path asave_head num2str(jdays(100))],'lon','lat')
% slat=lat;slon=lon;
% 
% % load([fsave_path qsave_head num2str(jdays(100))],'lon','lat')
% 
% [r,c]=imap(min(lat(:)),max(lat(:)),0,360,slat,slat);
% 
% ff=f_cor(lat);
% ff=(8640000./(1020.*ff));
% alpha=0.32;
% nf=f_cor(lat)./f_cor(30);
% rm=f_cor(lat)./f_cor(20);
% load coupco_maps_month_oct_24 sm_alpha_n
% ddo=1;
% 
% 
% 
% wek_th=500
% sst_th=500
% tt=0;

% [wek_crlg,wek_sst,w_tot]=deal(nan(length(lat(:,1)),length(lat(1,:)),lj));
% 
% for m=1:300%lj
%     fprintf('\r    loading %03u of %03u\r',m,lj)
%     
%     load([fsave_path qsave_head num2str(jdays(m))],'hp_total_wek_est2','hp_total_wek_qscat2')
%     load([fsave4_path qsave_head num2str(jdays(m))],'norm_hp66_dtdn')
%     load([asave_path asave_head num2str(jdays(m))],'mask')
%     
%     [yea,mon,day]=jd2jdate(jdays(m));
%     
%     if exist('hp_total_wek_est2')
%         hp_total_wek_est2(find(abs(rm.*hp_total_wek_est2)>wek_th))=nan;
%         wek_crlg(:,:,m)=hp_total_wek_est2.*mask(r,:);
%     end
%     if exist('hp_total_wek_qscat2')
%         hp_total_wek_qscat2(find(abs(rm.*hp_total_wek_qscat2)>wek_th))=nan;
%         wek_tot(:,:,m)=hp_total_wek_qscat2.*mask(r,:);
%     end
%     if exist('norm_hp66_dtdn')
%         tt=tt+1
%         hp_wek_sst_week_cross=0.008.*norm_hp66_dtdn;
%         hp_wek_sst_week_cross(find(abs(rm.*hp_wek_sst_week_cross)>sst_th))=nan;
%         wek_sst(:,:,m)=hp_wek_sst_week_cross.*mask(r,:);
%         clear norm_hp66_dtdn
%     end
%     
%     
%     clear hp_*
% end
% mean_hp_ratio=nanmean(abs(wek_sst)./abs(wek_crlg),3);
% median_hp_ratio=nanmedian(abs(wek_sst)./abs(wek_crlg),3);
% mean_wek_sst=nanmean(abs(wek_sst),3);
% mean_wek_crlg=nanmean(abs(wek_crlg),3);
% mean_wek_tot=nanmean(abs(wek_tot),3);
% sm_mean_hp_ratio=smoothn(mean_hp_ratio,20);
% sm_median_hp_ratio=smoothn(median_hp_ratio,10);
% 
% save -append sst_wek_maps_from_mean_coupco_dtdn_only median_* mean_* lat lon sm_*
% % 


load sst_wek_maps_from_mean_coupco_dtdn_only
mask=ones(size(median_hp_ratio));
mask(find(isnan(median_hp_ratio)))=nan;



load sst_wek_maps_from_mean_coupco_dtdn_only lat lon mean_* median_*

mean_wek_sst=(.013/.008)*mean_wek_sst;
mask=ones(size(mean_wek_sst));
mask(abs(lat)<10)=nan;
ff=abs(f_cor(lat));
fo=f_cor(30);

sm_mean_hp_ratio=smoothn(mean_wek_sst./mean_wek_crlg,5).*mask;
% sm_mean_hp_ratio_tot=smoothn(mean_wek_tot./(mean_wek_sst+mean_wek_crlg),10).*mask;
[r,c]=imap(-60,60,0,360,lat,lon);



tbins=0:.1:2;
midmask=nan*mask;
midmask(abs(lat)>15 & abs(lat)<45)=1;
tt=mean_wek_tot./(mean_wek_sst+mean_wek_crlg);

[n,b]=phist(tt,tbins)

% figure(1)
% clf
% stairs(tbins(1:end-1),b);
% figure(2)
% clf
% stairs(tbins(1:end-1),100*(cumsum(b)./sum(b)),'k','linewidth',2);
% title('CPDF of W_{tot}./(W_{cur}+W_{SST})')
% ylabel('%')
% xlabel('W_{tot}./(W_{cur}+W_{SST})')
% print -dpng -r300 figs/cpdf_w_tot_to_w_cur_plus_w_sst
% 
% tt=mean_wek_sst./mean_wek_crlg;
% 
% [n,b]=phist(tt,tbins)
% figure(1)
% clf
% stairs(tbins(1:end-1),b);
% figure(20)
% clf
% set(gcf,'PaperPosition',[1 1 8.5 3])
% stairs(tbins(1:end-1),100*(cumsum(b)./sum(b)),'k','linewidth',2);
% % title('CPDF of W_{SST}/W_{cur}')
% ylabel('%','fontsize',18)
% xlabel('W_{SST}/W_{cur}','fontsize',18)
% set(gca,'ytick',[0:10:100])
% grid
% print -dpng -r300 figs/cpdf_w_sst_to_w_cur



% figure(2)
% clf
% pmap(lon(r,c),lat(r,c),sm_mean_hp_ratio_tot(r,c).*mask(r,c))
% hold on
% m_contour(lon(r,c),lat(r,c),sm_mean_hp_ratio_tot(r,c).*mask(r,c),[1 1],'color','k','linewidth',2)
% caxis([.5 3])
% colorbar
% title('W_{tot}./(W_{cur}+W_{SST})')
% draw_air_sea_regions
% print -dpng -r300 figs/paper_ratio_cur+sst_tot
% load sst_wek_maps lat lon
% 
% 
% figure(2)
% clf
% pmap(lon(r,c),lat(r,c),(ff(r,c)./fo).*mean_wek_crlg(r,c).*mask(r,c))
% caxis([0 15])
% draw_air_sea_regions
% print -dpng -r300 figs/paper_wek_median_crlg_ff
% load sst_wek_maps lat lon
% 
% figure(2)
% clf
% pmap(lon(r,c),lat(r,c),(ff(r,c)./fo).*mean_wek_tot(r,c).*mask(r,c))
% caxis([0 15])
% draw_air_sea_regions
% print -dpng -r300 figs/paper_wek_median_tot_ff
% load sst_wek_maps lat lon
% 
% figure(2)
% clf
% pmap(lon(r,c),lat(r,c),(ff(r,c)./fo).*mean_wek_sst(r,c).*mask(r,c))
% caxis([0 15])
% draw_air_sea_regions
% print -dpng -r300 figs/paper_wek_median_sst_ff
% load sst_wek_maps lat lon
% % 
figure(2)
clf
pmap(lon(r,c),lat(r,c),smoothn(log10(mean_wek_sst(r,c)./mean_wek_crlg(r,c)),3).*mask(r,c))
m_contour(lon(r,c),lat(r,c),sm_mean_hp_ratio(r,c).*mask(r,c),[1 1],'color','k','linewidth',1)
caxis([log10(.1) log10(5)])
draw_air_sea_regions
print -dpng -r300 figs/paper_median_rat
return
load gradt_steady
[r,c]=imap(-60,60,0,360,lat,lon);
figure(1)
clf
pmap(lon(r,c),lat(r,c),1e5*mean_gradt(r,c))
hold on
load sst_wek_maps lat lon
[r,c]=imap(-60,60,0,360,lat,lon);
% m_contour(lon(r,c),lat(r,c),sm_mean_hp_ratio(r,c).*mask(r,c),[1 1],'color','k','linewidth',2)
caxis([0 4])
draw_air_sea_regions
print -dpng -r300 figs/paper_mean_gradt
load sst_wek_maps lat lon


