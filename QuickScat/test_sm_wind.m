spath='~/data/QuickScat/new_mat/QSCAT_30_25km_'
apath='~/data/eddy/V5/mat/AVISO_25_W_'
opath='~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_'
%Set range of dates

jdays=[2452571:7:2455147]%[2452424:7:2455159];

[year,month,day]=jd2jdate(jdays);
%loess filter
load([apath num2str(jdays(30))],'lat','lon')
slat=lat;
slon=lon;
load([spath num2str(jdays(30))],'lat','lon')
[rs,cs]=imap(min(lat(:)),max(lat(:)),0,360,slat,slon);
wek_th=15
[dum,bb]=f_cor(lat);
ff=f_cor(lat);
for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
    load([spath num2str(jdays(m))],'sm_u_week','sm_v_week')
	spd=sqrt(sm_u_week.^2+sm_v_week.^2);
    mask=ones(size(spd));
    mask(spd>=wek_th)=nan;
    figure(1)
    clf
    pcolor(lon,lat,spd.*mask);hold on;caxis([5 10])
    quiver(lon(1:10:end,1:10:end),lat(1:10:end,1:10:end),sm_u_week(1:10:end,1:10:end).*mask(1:10:end,1:10:end),sm_v_week(1:10:end,1:10:end).*mask(1:10:end,1:10:end),10,'k');shading flat;axis image
    pause(.3)
end

