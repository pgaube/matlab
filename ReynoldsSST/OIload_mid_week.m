
%construct date vector for mid-week day
mid_week_jdays=[2451395:7:2454811];


%Set path and region
save_path = '/Volumes/matlab/data/ReynoldsSST/mat/'
path ='/Volumes/matlab/data/ReynoldsSST/netcdf_v2/'

STEP=.25;
LON=[0.125:STEP:359.875];
LAT=[-89.875:STEP:89.875];
lon=ones(length(LAT),1)*LON;
lat=LAT'*ones(1,length(lon(1,:)));

q=1;
e=1;
u=1;
for m=1:length(mid_week_jdays)
    [yea,mon,day]=jd2jdate(mid_week_jdays(m));
    dates(m)=(yea*10000)+(mon*100)+day;
    proccesing_file=dates(m)
    fname = ['amsr-avhrr-v2.' num2str(dates(m)) '.nc'];
    fnameg = ['amsr-avhrr-v2.' num2str(dates(m)) '.nc.gz'];

    if exist([path fnameg])
    	eval(['!gunzip ' path fnameg]);
    end
    if exist([path fname])
        %Read nc file and find num var
        file=[path fname];
        [ncid] = mexnc('OPEN',file,'write');
        [nvars] = mexnc('INQ_NVARS',ncid);
        
        %Load SST data into a latxlon  matrix
        sst = mexnc('GET_VAR_DOUBLE',ncid,4);
        sst(sst<-900)=nan;
        sst_oi = (sst*.01)';
 		gradt=sqrt(dfdx(lon,sst_oi,.25).^2+dfdy(sst_oi,.25).^2).*1e5;
        lp=linx_smooth2d_f(sst_oi,6,6);
        filtered_sst_oi=sst_oi-lp;
        eval(['save ' save_path 'OI_25_W_' num2str(mid_week_jdays(m)) ...
	      ' gradt filtered_sst_oi sst_oi lat lon mid_week_jdays']);
   end
end
