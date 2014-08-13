%Set range of dates
START_YR = 2002;
START_MO = 07;
START_DY = 03;
END_YR= 2008;
END_MO = 01;
END_DY = 23;


%construct date variables
START_JD=date2jd(START_YR,START_MO,START_DY)+.5;
END_JD=date2jd(END_YR,END_MO,END_DY)+.5;
jdays = START_JD:7:END_JD;
jdays=jdays(2:length(jdays)-1);

WHEAD='/Volumes/matlab/data/QuickScat/mat/QSCAT_21_25km_';
SHEAD='/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_';
load([SHEAD,num2str(jdays(1))],'lat','lon')
lat=lat(41:600,:);
lon=lon(41:600,:);
	
raw_crl=single(nan(length(lat(:,1)),length(lon(1,:)),length(jdays)));
mask_crl=raw_crl;
var_raw=raw_crl(:,:,1);
var_mask=var_raw;

for m=1:length(jdays)
	fprintf('\r Jdays %3u of %3u \r',m,length(jdays))
	sfname=[SHEAD,num2str(jdays(m))];
	load(sfname,'mask','ssh')
	mask=mask(41:600,:);
	ssh=ssh(41:600,:);
	wfname=[WHEAD,num2str(jdays(m))];
	load(wfname,'hp66_crl_21')
	raw_crl(:,:,m)=single(ssh);
	tmp=single(ssh.*mask);
	res_crl=ssh-(ssh.*mask);
	mask_crl(:,:,m)=single(tmp-res_crl);
	%raw_crl(:,:,m)=single(hp66_crl_21);
	%mask_crl(:,:,m)=single(hp66_crl_21.*mask);	
end	

for m=1:length(lat(:,1))
	for n=1:length(lon(1,:))
	var_raw(m,n)=pvar(squeeze(raw_crl(m,n,:)));
	var_mask(m,n)=pvar(squeeze(mask_crl(m,n,:)));
	end
end
