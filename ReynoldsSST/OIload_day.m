%loads NetCDF data using the mexcdf.m command

%Set range of dates
%
% Use the following for match up with CLS SSH
%

startyear = 2002;
startmonth = 07;
startday = 03;  %must be mid-week day from aviso SSH 
endyear = 2008;
endmonth = 12;
endday = 29;

%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd-3:endjd+3];



%Set path and region
save_path = '/Volumes/data2/data/reynolds_sst/daily_mat/'
path ='/Volumes/data2/data/reynolds_sst/netcdf/'

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
    if dates(m)>=20060101
        fname = ['sst4-navy-amsr-eot.' num2str(dates(m)) '.nc'];
        fnameg = ['sst4-navy-amsr-eot.' num2str(dates(m)) '.nc.bz2'];
    else
        fname = ['sst4-path-amsr-eot.' num2str(dates(m)) '.nc'];
        fnameg = ['sst4-path-amsr-eot.' num2str(dates(m)) '.nc.bz2'];
    end

    if exist([path fnameg])
    	eval(['!bunzip2 ' path fnameg]);
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
 
        %lp=smooth2d_f(sst_oi,20,10);
        %filtered_sst_oi=sst_oi-lp;
        eval(['save ' save_path 'OI_25_D_' num2str(jdays(m)) ...
	      ' sst_oi lat lon jdays']);
   end
end
