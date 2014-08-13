
ff=f_cor(lat);
ff=(8640000./(1020.*ff));
alpha=0.32;
nf=f_cor(lat)./f_cor(30);
rm=f_cor(lat)./f_cor(20);
load coupco_maps_month_oct_24 sm_alpha_n
ddo=1;
jdays=[2452459:7:2455147];
lj=length(jdays);

%%%
lj=291
%%%
wek_th=100
sst_th=30

qsave_head='QSCAT_30_25km_';
fsave_path='~/data/QuickScat/ULTI_mat4/';


load([fsave_path qsave_head num2str(jdays(100))],'lon','lat')



for m=1:lj
    fprintf('\r    loading %03u of %03u\r',m,lj)
    
    load([fsave_path qsave_head num2str(jdays(m))],'hp_wek_crlg_week','hp_wek_sst_week_cross')
    
    [yea,mon,day]=jd2jdate(jdays(m));
    
    hp_wek_crlg_week(find(abs(rm.*hp_wek_crlg_week)>wek_th))=nan;
    hp_wek_sst_week_cross(find(abs(rm.*hp_wek_sst_week_cross)>sst_th))=nan;
    
    wek_sst(:,:,m)=hp_wek_sst_week_cross;
    wek_crlg(:,:,m)=hp_wek_crlg_week;
    
    clear hp_*
end
mean_hp_ratio=nanmean(abs(wek_sst)./abs(wek_crlg),3);
median_hp_ratio=nanmedian(abs(wek_sst)./abs(wek_crlg),3);
mean_wek_sst=nanmean(abs(wek_sst),3);
mean_wek_crlg=nanmean(abs(wek_crlg),3);
sm_mean_hp_ratio=smoothn(mean_hp_ratio,20);
sm_median_hp_ratio=smoothn(median_hp_ratio,10);

save -append sst_wek_maps_from_mean_coupco_dtdn_only median_* mean_* lat lon sm_*


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


