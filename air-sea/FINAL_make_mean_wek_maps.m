% clear all
% close all
% 
% 
% jdays=[2451388:7:2455147];%[2451556:7:2454797];
% lj=length(jdays);
% 
% asave_path='~/data/eddy/V5/mat/';
% asave_head='AVISO_25_W_';
% qsave_path='~/data/QuickScat/ULTI_mat2/';
% qsave_head='QSCAT_30_25km_';
% osave_path='~/data/ReynoldsSST/mat/';
% osave_head='OI_25_30_';
% 
% 
% load([asave_path asave_head num2str(jdays(300))],'lon','lat')
% slat=lat;
% slon=lon;
% load([osave_path osave_head num2str(jdays(300))],'lon','lat')
% olat=lat;
% olon=lon;
% load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')
% 
% 
% [rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
% [ro,co]=imap(min(lat(:)),max(lat(:)),1,1,olat,olon);
% 
% 
% wek_sst=single(nan(length(lat(:,1)),1440,lj));
% wek_crlg=wek_sst;
% wek=wek_crlg;
% 
% 
% ff=f_cor(lat);
% ff=(8640000./(1020.*ff));
% 
% 
% load coupco_map_crlstr beta_*
% ddo=1;
% 
% for m=1:lj
% 	fprintf('\r    loading %03u of %03u\r',m,lj)
% 	load([qsave_path qsave_head num2str(jdays(m))],'hp_*','wek')
% 
% 	
% 	if exist('hp_wek_sst_week_dtdn')
% 	wek_sst(:,:,m)=single(hp_wek_sst_week_dtdn);
% 	end
% 	
% 	wek_crlg(:,:,m)=single(hp_wek_crlg_week);
%     
%     wek(:,:,m)=single(wek);
% 	clear hp_
% end
% 
% 
% mean_hp_ratio=nanmean(abs(wek_sst)./abs(wek_crlg),3);
% median_hp_ratio=nanmedian(abs(wek_sst)./abs(wek_crlg),3);
% mean_wek_sst=nanmean(abs(wek_sst),3);
% mean_wek_crlg=nanmean(abs(wek_crlg),3);
% median_wek_sst=nanmedian(abs(wek_sst),3);
% median_wek_crlg=nanmedian(abs(wek_crlg),3);
% median_wek=nanmedian(abs(wek),3);
% sm_mean_hp_ratio=smoothn(mean_hp_ratio,20);
% sm_median_hp_ratio=smoothn(median_hp_ratio,10);
% 
% mask=ones(size(median_hp_ratio));
% mask(find(isnan(median_hp_ratio)))=nan;
% sm_median_hp_ratio=smoothn(median_hp_ratio,10).*mask;
% sm_mean_hp_ratio=smoothn(mean_hp_ratio,10).*mask;
% 
% save sst_wek_maps median_* mean_* lat lon sm_*
% % 
% 
% 
% % load sst_wek_maps lat lon
% 
% % % % [r,c]=imap(-60,60,0,360,lat,lon);
% % % % 
% % % % lat=lat(r,c);
% % % % lon=lon(r,c);
% % % % figure(1)
% % % % clf
% % % % pmap(lon,lat,nan(length(lat(:,1)),length(lon(1,:))))
% % % % hold on
% % % % curs = {'SP',...
% % % % 		'AGR',...
% % % % 		'HAW',...
% % % % 		'EIO',...
% % % % 		'CAR',...
% % % % 		'AGU'};
% % % % 
% % % % 
% % % % 
% % % % for m=1:length(curs)
% % % %     cd ~/data/eddy/V5/
% % % % 	eval(['subset_tracks_orgin_v5(',char(39),'~/matlab/domains/',char(39),',',char(39),curs{m},'_lat_lon',char(39),')'])
% % % % 	cd ~/matlab/air-sea
% % % % 
% % % % 	load(['~/data/eddy/V5/',curs{m},'_lat_lon_orgin_tracks'])
% % % %     jdays=track_jday;
% % % %     prevent overlap over boundary
% % % %     fd=find(x>359);
% % % %     x(fd)=nan;
% % % %     [jdays,is]=sort(jdays);
% % % %     x=x(is);
% % % %     y=y(is);
% % % %     id=id(is);
% % % %     k=k(is);
% % % %     cyc=cyc(is);
% % % %     ujd=unique(jdays);
% % % %     for qq=1:length(ujd)
% % % % 		dd=find(jdays==ujd(qq) & k==1);
% % % % 		uid=unique(id(dd));
% % % % 		for m=1:length(uid);
% % % % 			ii=find(id==uid(m));
% % % % 			if cyc(ii(1))>=1
% % % % 				m_plot(x(ii),y(ii),'r','linewidth',.1)
% % % % 			else
% % % % 				m_plot(x(ii),y(ii),'b','linewidth',.1)
% % % % 			end
% % % % 		end
% % % %     end
% % % % end
% % % % draw_air_sea_regions
% % % % print -dpng -r300 ~/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/air_sea_tracks
% % % % return
% % % % 
load sst_wek_maps
mask=ones(size(median_hp_ratio));
mask(find(isnan(median_hp_ratio)))=nan;

load sst_wek_maps_from_mean_coupco_dtdn_only lat lon mean_* median_*
sm_mean_hp_ratio=smoothn(mean_wek_sst./mean_wek_crlg,10).*mask;
% 

% [r,c]=imap(-45,45,0,360,lat,lon);
% mask=nan*lat;
% mask(abs(lat)>10)=1;
% ff=abs(f_cor(lat));
% fo=f_cor(30);
% 
% figure(1)
% clf
% pmap(lon(r,c),lat(r,c),mean_sm_wspd(r,c))
% caxis([3 10])
% hold on
% m_contour(lon(r,c),lat(r,c),mean_sm_wspd(r,c),[5:10],'k')
% % draw_air_sea_regions
% colorbar
% print -dpng -r300 figs/mean_sm_wspd
% load sst_wek_maps lat lon
% return

[r,c]=imap(-60,60,0,360,lat,lon);
% mask=nan*lat;
mask(abs(lat)<10)=nan;
ff=abs(f_cor(lat));
fo=f_cor(30);


% figure(1)
% clf
% pmap(lon(r,c),lat(r,c),mean_wek_crlg(r,c).*mask(r,c))
% caxis([0 8])
% draw_air_sea_regions
% 
% print -dpng -r300 figs/paper_wek_median_crlg
load sst_wek_maps lat lon
%
figure(2)
clf
pmap(lon(r,c),lat(r,c),(ff(r,c)./fo).*mean_wek_crlg(r,c).*mask(r,c))
caxis([0 10])
draw_air_sea_regions
print -dpng -r300 figs/paper_wek_median_crlg_ff
load sst_wek_maps lat lon

% figure(2)
% clf
% pmap(lon(r,c),lat(r,c),(ff(r,c)./fo).*median_wek(r,c).*mask(r,c))
% caxis([0 8])
% draw_air_sea_regions
% print -dpng -r300 figs/paper_wek_medianff
% load sst_wek_maps lat lon


% figure(1)
% clf
% pmap(lon(r,c),lat(r,c),median_wek_sst(r,c).*mask(r,c))
% caxis([0 8])
% draw_air_sea_regions
% print -dpng -r300 figs/paper_wek_median_sst
% load sst_wek_maps lat lon

figure(2)
clf
pmap(lon(r,c),lat(r,c),(ff(r,c)./fo).*mean_wek_sst(r,c).*mask(r,c))
caxis([0 10])
draw_air_sea_regions
print -dpng -r300 figs/paper_wek_median_sst_ff
load sst_wek_maps lat lon

figure(2)
clf
pmap(lon(r,c),lat(r,c),log10(mean_wek_sst(r,c)./mean_wek_crlg(r,c)).*mask(r,c))
m_contour(lon(r,c),lat(r,c),sm_mean_hp_ratio(r,c).*mask(r,c),[1 1],'color','k','linewidth',2)
caxis([-2 log10(pi)])
draw_air_sea_regions
print -dpng -r300 figs/paper_median_rat

% load sst_wek_maps lat lon
% figure(2)
% clf
% pmap(lon(r,c),lat(r,c),((mean_wek_sst(r,c)./mean_wek_crlg(r,c)).*mask(r,c)))
% %m_contour(lon(r,c),lat(r,c),sm_mean_hp_ratio(r,c).*mask(r,c),[1 1],'color','k','linewidth',2)
% caxis([0 1])
% draw_air_sea_regions
% print -dpng -r300 figs/paper_mean_rat
% 
% %
load gradt_steady
[r,c]=imap(-60,60,0,360,lat,lon);
figure(1)
clf
pmap(lon(r,c),lat(r,c),1e5*mean_gradt(r,c))
hold on
load sst_wek_maps lat lon
[r,c]=imap(-60,60,0,360,lat,lon);
m_contour(lon(r,c),lat(r,c),sm_mean_hp_ratio(r,c).*mask(r,c),[1 1],'color','k','linewidth',2)
caxis([0 3])
draw_air_sea_regions
print -dpng -r300 figs/paper_mean_gradt


