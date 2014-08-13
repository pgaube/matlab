function [hov,pre_hov,lon,year_day,jdays]=hovmoller_loess(hov_lon,hov_lat,dy)
%function [hov,lon,year_day,jdays]=hovmoller_loess(hov_lon,hov_lat,dy)

	data_dir='/home/mckenzie/data2/data/seawifs/mat/';
	data_head='SCHL_9_D_';
	jdays=[2450821:2454489];
	data_type='chl_day';
	load([data_dir data_head num2str(jdays(1))],'lat','lon');
	dist_n=abs(lat(:,1)-hov_lat+dy);
	dist_s=abs(lat(:,1)-hov_lat-dy);
	dist_w=abs(lon(1,:)-min(hov_lon));
	dist_e=abs(lon(1,:)-max(hov_lon));
	mn=find(dist_n==min(dist_n));
	ms=find(dist_s==min(dist_s));
	r=ms(1):mn(1);
	if length(r)<1
		r=mn(1):ms(1);
	end	
	c=find(dist_w==min(dist_w)):find(dist_e==min(dist_e));
	lon=lon(1,c);
	glon=min(hov_lon):.25:max(hov_lon);
	

%create array
pre_hov=nan(length(r),length(c),length(jdays));

%now sample all files
lj=length(jdays);
for m=12:20%lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	if exist([data_dir data_head num2str(jdays(m)) '.mat'])
		load([data_dir data_head num2str(jdays(m))],data_type);
		eval(['pre_hov(:,:,m)=' data_type '(r,c);'])
	else
		pre_hov(:,:,m)=nan(length(r),length(c));
	end	
end
fprintf('\n')

%calc lat mean
pre_hov=squeeze(nanmean(log10(pre_hov),1))';

dt=35;
%Correct time vectores if subset
final_jdays=[2450821+round(dt/2):7:2454489-round(dt/2)];
ij=find(final_jdays<=jdays(lj));
final_jdays=final_jdays(ij);


ij=find(jdays<=jdays(lj));
jdays=jdays(ij);

%now interp to final hov grid
%[hov,fl]=smooth2d_loess(pre_hov,lon,jdays,2,dt,glon,final_jdays);
%hov(fl~=1)=nan;
hov=nan;

jdays=final_jdays;
lon=glon;

%make year_day vector
[year,mon,day]=jd2jdate(jdays);
for m=1:length(jdays)
	year_day(m)=(year(m)*1000)+julian(mon(m),day(m),year(m),year(m));
end	
