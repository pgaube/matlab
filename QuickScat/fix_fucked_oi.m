%construct date vector for mid-week day
mid_week_jdays=[2452431:7:2454811];


%Set path and region
save_path = '/home/mckenzie/matlab/data/ReynoldsSST/mat/'
path ='/home/mckenzie/matlab/data/ReynoldsSST/netcdf_v2/'

STEP=.25;
LON=[0.125:STEP:359.875];
LAT=[-89.875:STEP:89.875];
lon=ones(length(LAT),1)*LON;
lat=LAT'*ones(1,length(lon(1,:)));

q=1;
e=1;
u=1;
for m=210:length(mid_week_jdays)
	load([save_path 'OI_25_W_' num2str(mid_week_jdays(m))])
	sst_oi=10*sst_oi;
	filtered_sst_oi=10*filtered_sst_oi;
	gradt=10*gradt;
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
