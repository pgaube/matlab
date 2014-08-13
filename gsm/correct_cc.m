startjd=2450884
endjd=2454832
jdays=startjd:7:endjd;
path_in='/Volumes/matlab/data/gsm/mat/GSM_9_21_'
mld_in='/Volumes/matlab/data/mld/mat/MLD_25_30_'
par_in='/Volumes/matlab/data/SeaWiFS/mat/SCHL_9_21_'

a=-0.3467;
b=3.3220;

load([path_in num2str(jdays(1))],'gcar_week','gchl_week','glon','glat')



for m=1:length(jdays)
	fprintf('\r  Sampling -- file %3u of %3u \r',m,length(jdays))
	load([path_in num2str(jdays(m))],'gcar_week','gchl_week','glon','glat')
	load([mld_in num2str(jdays(m))],'mld_week')
	load([par_in num2str(jdays(m))],'gpar_week')
	
	mld_week=cat(1,nan(40,1440),mld_week,nan(40,1440));
	mld_week=flipud(mld_week);
	gpar_week=gpar_week./24; %convert to Ein m^-2 hr^-1

	
	%caclulate kd, the inverse of z_eu based off of chl
	chl=10.^gchl_week;
	z=exp(a*log(chl)+b);
	kd=1./z;
	
	%Calculate Ig and CC_light
	ig = gpar_week.* exp(-kd.*(mld_week./2));
	

	gcc_light = .022+(.045-.022)*exp(-3*ig);
	gcc_week=chl./(10.^gcar_week);
	gcc_nuts = gcc_week-gcc_light;
	mu = 2*(gcc_week./gcc_light).*(1-exp(-3*ig));
	mu(mu>2)=2;
	mu(mu<0)=0;
	if length(find(~isnan(mu)))==0
		return
	end	
	%length(find(~isnan(mu)))
	%eval(['save -append ' path_in num2str(jdays(m)) ' mu gcc_* z ig gpar_week mld_week']);
	eval(['save -append ' path_in num2str(jdays(m)) ' mu']);
	clear mu gcc_* ig z gpar_week mld_week
end	
	
	