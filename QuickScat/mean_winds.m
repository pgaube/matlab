out_dir='/matlab/data/QuickScat/mat/'
out_head='QSCAT_30_25km_'
shead='AVISO_25_W_';
sdir='/matlab/data/eddy/V4/mat/'
%Set range of dates



jdays=[2451556:7:2454797];
jdays=jdays(1:300);
%make lat lon
lat = -69.875:0.25:69.875;
lon = 0.125:0.25:359.875;
[lon,lat]=meshgrid(lon,lat);

[year,month,day]=jd2jdate(jdays);

u=nan(length(lat(:,1)),length(lon(1,:)),length(jdays));
v=u;


for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   loading %08u \r',calday(m))
	
	load([out_dir out_head num2str(jdays(m))],'u_week','v_week')
	
	u(:,:,m)=u_week;
	v(:,:,m)=v_week;
end

u_bar=nanmean(u,3);
v_bar=nanmean(v,3);
mean_speed=sqrt(u_bar.^2+v_bar.^2);

mask=nan*u_bar;
ii=find(mean_speed<=10);
mask(ii)=1;

dir_steady = sqrt(nanmean(u,3).^2+nanmean(v,3).^2)./nanmean(sqrt(u.^2+v.^2),3);

save mean_qscat u_bar v_bar dir_steady mean_speed mask
