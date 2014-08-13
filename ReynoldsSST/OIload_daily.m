%construct date vector
startjd=2452459;
endjd=2455197;
jdays=[startjd:endjd];

%{
%construct date vector for mid-week day
startjd=2450821
endjd=2454832
jdays=startjd:endjd;
%}

%Set path and region
save_path = '/matlab/data/ReynoldsSST/mat/'
path ='/matlab/data/ReynoldsSST/netcdf_v2/'

STEP=.25;
LON=[0.125:STEP:359.875];
LAT=[-89.875:STEP:89.875];
lon=ones(length(LAT),1)*LON;
lat=LAT'*ones(1,length(lon(1,:)));

q=1;
e=1;
u=1;

for m=1:length(jdays)
    [yea,mon,day]=jd2jdate(jdays(m));
    dates(m)=(yea*10000)+(mon*100)+day;
    proccesing_file=dates(m)
    fname = ['amsr-avhrr-v2.' num2str(dates(m)) '.nc'];
    fnameg = ['amsr-avhrr-v2.' num2str(dates(m)) '.nc.gz'];

    if exist([path fnameg]) & ~exist([path fname])
    	eval(['!gunzip -f ' path fnameg]);
    end
    if exist([path fname])
        %Read nc file and find num var
        file=[path fname];
        sst_id = netcdf.open(file, 'NC_NOWRITE');
        

        %Load SST data into a latxlon  matrix
       	sst = double(squeeze(netcdf.getvar(sst_id,...
       	    		 netcdf.inqvarid(sst_id,'sst'))));	
        sst(sst<-900)=nan;
        sst_oi = .01*(sst)';
 		%gradt=sqrt(dfdx(lon,sst_oi).^2+dfdy(sst_oi).^2).*1e5;
        %lp=linx_smooth2d_f(sst_oi,20,10);
        %filtered_sst_oi=sst_oi-lp;
        if exist([save_path 'OI_25_D_' num2str(jdays(m)) '.mat'])
        eval(['save -append ' save_path 'OI_25_D_' num2str(jdays(m)) ...
	      ' sst_oi lat lon jdays']);
	    else
	    eval(['save ' save_path 'OI_25_D_' num2str(jdays(m)) ...
	      ' sst_oi lat lon jdays']);
	    end  
   end
end
