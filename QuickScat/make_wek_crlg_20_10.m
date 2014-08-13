spath='~/data/QuickScat/new_mat/QSCAT_30_25km_'
fpath='~/data/QuickScat/ULTI_mat/QSCAT_30_25km_'
apath='~/data/eddy/V5/mat/AVISO_25_W_'
opath='~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_'
%Set range of dates

jdays=[2452571:7:2455147];%[2452424:7:2455159];[2452459:7:2455147]

[year,month,day]=jd2jdate(jdays);
%loess filter
load([apath num2str(jdays(30))],'lat','lon')
slat=lat;
slon=lon;
load([spath num2str(jdays(30))],'lat','lon')
[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
wek_th=500
rm=f_cor(lat)./f_cor(20);

ff=f_cor(lat);
ff=(8640000./(1020.*ff));
% [r,c]=imap(-40,-20,60,120,lat,lon);
for m=1:100%:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
	load([opath num2str(jdays(m))],'sm_2010_u','sm_2010_v')
    if exist('sm_2010_u')
    load([apath num2str(jdays(m))],'u','v')
    
	u_rel=sm_2010_u-u(rs,:);
	v_rel=sm_2010_v-v(rs,:);
	[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
	crl_tau=dfdx(lat,tau_y,.25)-dfdy(tau_x,.25);
	tt=ff.*crl_tau;
	[lp,flag]=smooth2d_loess(tt,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
	hp21_wek_crlg_week=tt-lp;
    hp21_wek_crlg(flag==1)=nan;
 	tt=find(abs(rm.*hp21_wek_crlg_week)>wek_th);
    hp21_wek_crlg_week(tt)=nan;

	eval(['save -append ' [opath num2str(jdays(m))] ' hp21_wek_crlg_week'])	
	clear wek sm_2010_u sm_2010_v u v tt hp21_wek_crlg
	end
end

