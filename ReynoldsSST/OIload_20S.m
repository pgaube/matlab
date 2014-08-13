%loads NetCDF data using the mexcdf.m comand

%Set range of dates
%
% Use the following for match up with CLS SSH
%

startyear = 2008;
startmonth = 1;
startday = 01;  %must be mid-week day from aviso SSH -3
endyear = 2008;
endmonth = 10;
endday = 31;


%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:endjd];

%construct date vector for mid-week day
mid_week_jdays=[startjd+6:7:endjd];



%Set path and region
path = '/Volumes/matlab/data/ReynoldsSST/netcdf/';
load /Volumes/matlab/matlab/domains/SEP_lat_lon
max_lat=-20.125;
min_lat=-20.125;
max_lon=max(lon);
min_lon=min(lon);

%create sst matrix to save jdays
sstw=nan(1,368,length(jdays));

q=1;
e=1;
u=1;
for m=1:length(jdays)
    [yea,mon,day]=jd2jdate(jdays(m));
    dates(m)=(yea*10000)+(mon*100)+day;
    proccesing_file=dates(m)
    if dates(m)>=20060101
        fname = ['sst4-navy-amsr-eot.' num2str(dates(m)) '.nc'];
        fnameg = ['sst4-navy-amsr-eot.' num2str(dates(m)) '.nc.gz'];
    else
        fname = ['sst4-path-amsr-eot.' num2str(dates(m)) '.nc'];
        fnameg = ['sst4-path-amsr-eot.' num2str(dates(m)) '.nc.gz'];
    end
    if exist([path fname])
        %Read nc file and find num var
        file=[path fname];
        %eval(['!gunzip ' path fnameg]);
        [ncid] = mexnc('OPEN',file,'write');
        [nvars] = mexnc('INQ_NVARS',ncid);
        %eval(['!gzip ' file]);

        %Load SST data into a latxlon  matrix
        sst = mexnc('GET_VAR_DOUBLE',ncid,4);
        sst(sst<-900)=nan;
        sst = (sst*.01)';

        %Get lat and lon vectors
        if m==1
            LAT = mexnc('GET_VAR_DOUBLE',ncid,2);
            LON = mexnc('GET_VAR_DOUBLE',ncid,3);
            r=find(LAT==max_lat);
            c=find(LON>=min_lon&LON<=max_lon);
            lat=LAT(r);
            lon=LON(c);
            lon=ones(length(lat),1)*lon';
            lat=lat*ones(1,length(lon(1,:)));
        end
        
        sst=sst(r,c);
        else
            sst=nan(1,368);
            missing_file(q,:)=fnameg
            q=q+1;
        end
        sstw(1,:,u)=sst;
        u=u+1;
      
end

sst_20S=squeeze(sstw)';

clear r path nvars ncid min_* max_* m fname* file c d LAT LON mon yea day ...
    tmp proccesing_file