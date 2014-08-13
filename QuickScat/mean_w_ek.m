out_dir='/matlab/data/QuickScat/new_mat/'
out_head='QSCAT_21_25km_'
shead='AVISO_25_W_';
sdir='/matlab/data/eddy/V4/mat/'
%Set range of dates



jdays=[2451395:7:2454811];

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
	
	load([out_dir out_head num2str(jdays(m))],'w_ek')
	load([sdir shead num2str(jdays(m))],'mask')
	mask=mask(41:600,:);
	w(:,:,m)=w_ek.*mask;
end

w_bar.mean=nanmean(w,3);
w_bar.median=nanmedian(w,3);
w_bar.std=nanstd(w,3);

cd /Volumes/matlab/matlab/woa/
load woa05 N lat lon z_n
N=N./1000; %convert from \mu mol to mmol

gw_bar.mean=biggrid(w_bar.mean,25,1);
gw_bar.median=biggrid(w_bar.median,25,1);
gw_bar.std=biggrid(w_bar.std,25,1);

[r,c]=imap(-70,70,0,360,lat,lon);
N_bar.mean=squeeze(nanmean(N(:,:,r,c),1));
N_bar.median=squeeze(nanmedian(N(:,:,r,c),1));
N_bar.std=squeeze(nanstd(N(:,:,r,c),1));

dNdz=(N_bar.mean(1,:,:)-N_bar.mean(14,:,:))./500; %mmol N m^{-1}

k=10^-4; %m^s s^-1

F = gw_bar.mean.*squeeze(N_bar.mean(10,:,:)) - k*dNdz;

figure(1)
pmap(lon(c),lat(r),F);caxis([0 5])
title('Flux of N into upper ocean due to w_E   ')
