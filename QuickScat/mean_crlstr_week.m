clear all
out_dir='~/data/QuickScat/new_mat/'
out_head='QSCAT_30_25km_'


jdays=[2451388:7:2455147];

%make lat lon
lat = -69.875:0.25:69.875;
lon = 0.125:0.25:359.875;
[lon,lat]=meshgrid(lon,lat);

[year,month,day]=jd2jdate(jdays);

w=nan(length(lat(:,1)),length(lon(1,:)),length(jdays));


for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   loading %08u \r',calday(m))
	
	load([out_dir out_head num2str(jdays(m))],'crlstr_week')
	w(:,:,m)=crlstr_week;
    clear crlstr_week
end

mean_crlstr_week=nanmean(w,3);

save mean_weeky lat lon mean_crlstr_week

load mean_daily mean_crlstr
mask=nan*mean_crlstr;
mask(~isnan(mean_crlstr))=1;

figure(1)
clf
pmap(lon,lat,1e7*mean_crlstr_week.*mask)
colorbar
caxis([-3 3])
load bwr.pal
caxis
colormap(bwr)
hold on
m_contour(lon,lat,1e7*mean_crlstr_week.*mask,[-1 1],'k','linewidth',.5)

print -dpng -r300 mean_weekly_crlstr



wek=mean_crlstr_week.*mask./1020./f_cor(lat)*60*60*24*100;

figure(2)
clf
pmap(lon,lat,wek)
caxis([-50 50])
load bwr.pal
colorbar
caxis
colormap(bwr)
hold on
m_contour(lon,lat,wek,[-5 5],'k','linewidth',.5)
print -dpng -r300 mean_weekly_wek