
%construct date vector for mid-week day
mid_week_jdays=[2452431:7:2454811];


%Set path and region
save_path = '/Volumes/matlab/matlab/data/ReynoldsSST/mat/'
path ='/Volumes/matlab/matlab/data/ReynoldsSST/netcdf_v2/'

STEP=.25;
LON=[0.125:STEP:359.875];
LAT=[-89.875:STEP:89.875];
lon=ones(length(LAT),1)*LON;
lat=LAT'*ones(1,length(lon(1,:)));

q=1;
e=1;
u=1;
for m=1:length(mid_week_jdays)
	tmp_sst=nan(length(lat(:,1)),length(lon(1,:)),21);
	for n=-10:10
    	[yea,mon,day]=jd2jdate(mid_week_jdays(m)+n);
    	dates=(yea*10000)+(mon*100)+day;
    	fname = ['amsr-avhrr-v2.' num2str(dates) '.nc'];
    	fnameg = ['amsr-avhrr-v2.' num2str(dates) '.nc.gz'];

    	if exist([path fnameg])
    		eval(['!gunzip ' path fnameg]);
    	elseif exist([path fname])
        	%Read nc file and find num var
        	file=[path fname];
        	sst = nc_varget(file,'sst');
        	tmp_sst(:,:,n+12)=sst;
    	else
    	
    	end
    	
    end
    sst_oi=nanmean(tmp_sst,3);
    gradt=sqrt(dfdx(lon,sst_oi,.25).^2+dfdy(sst_oi,.25).^2).*1e5;
    lp=linx_smooth2d_f(sst_oi,20,10);
    filtered_sst_oi=sst_oi-lp;
    eval(['save ' save_path 'OI_25_W_' num2str(mid_week_jdays(m)) ...
	      ' gradt filtered_sst_oi sst_oi lat lon mid_week_jdays']);
	clear filtered_sst_oi sst_oi gradt      
	
	%{
	figure(101)
	clf
	pcolor(lon,lat,sst_oi);shading flat
	figure(102)
	clf
	pcolor(lon,lat,filtered_sst_oi);shading flat
	%}
end
