clear all
load ~/matlab/domains/maurtitus_lat_lon.mat
dlat=lat;dlon=lon;
load ~/data/gsm/mat/GSM_SAM_9_D_2454745 lat lon
% [r,c]=imap(min(dlat)-5,max(dlat)+5,min(dlon)-5,max(dlon)+5,lat,lon);
[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);

jdays=2454741:2454748;

chl=nan(length(r),length(c),length(jdays));

for m=1:length(jdays)
    load(['~/data/gsm/mat/GSM_SAM_9_D_',num2str(jdays(m))],'chl_day');
    chl(:,:,m)=chl_day(r,c);
    clear chl_day
end
glat=lat(r,c);glon=lon(r,c);

save mau_chl_merged chl glon glat jdays
return
clf
pmap(lon(r,c),lat(r,c),log10(nanmean(chl,3)),'gumby')
caxis([-1.3 -.7])
cc=colorbar;
title('Merged log_{10}(CHL) October 1-8, 2008')
print -dpng -r300 figs/oct_1_8_avg_chl

for m=1:length(jdays)
    clf
    pmap(lon(r,c),lat(r,c),log10(chl(:,:,m)),'gumby')
    caxis([-1.3 -.7])
    cc=colorbar;
    title(['Merged log_{10}(CHL) October ',num2str(m),', 2008'])
    eval(['print -dpng -r300 figs/oct_',num2str(m),'_chl'])
end