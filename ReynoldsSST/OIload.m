%loads NetCDF data using the mexcdf.m command

%Set range of dates
%
% Use the following for match up with CLS SSH
%

startyear = 2002;
startmonth = 07;
startday = 03;  %must be mid-week day from aviso SSH -3
endyear = 2008;
endmonth = 1;
endday = 23;
%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:endjd];

%construct date vector for mid-week day
mid_week_jdays=[startjd-3:7:endjd+3];
end_week_jdays = mid_week_jdays+3;



%Set path and region
path = '/Volumes/data2/data/reynolds_sst/netcdf/'
load /Volumes/matlab/matlab/domains/TIMOR_lat_lon
max_lat=max(lat);
min_lat=min(lat);
max_lon=max(lon);
min_lon=min(lon);

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
        %Read nc file and find num var
        eval(['!bunzip2 ' path fnameg]);
        else if exist([path fname])
        %Read nc file and find num var
        file=[path fname];
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
            r=find(LAT>=min_lat&LAT<=max_lat);
            c=find(LON>=min_lon&LON<=max_lon);
            lat=LAT(r);
            lon=LON(c);
            lon=ones(length(lat),1)*lon';
            lat=lat*ones(1,length(lon(1,:)));
            %create sst matrix to save jdays
	    sstw=nan(length(lat(:,1)),length(lon(:,1)),7);
        end
        
        sst=sst(r,c);
        else
            sst=nan(length(lat(:,1)),length(lon(:,1)));
            missing_file(q,:)=fnameg;
            q=q+1;
        end
        sstw(:,:,u)=sst;
        u=u+1;
        if jdays(m)==end_week_jdays(e);
          sst_week(:,:,e)=nanmean(sstw,3);
          %gradt_week(:,:,e)=sqrt((dfdx(lon,lat,sst_week(:,:,e)).^2)+ ...
          %                             (dfdy(sst_week(:,:,e)).^2)).*1e5; 
          sstw=nan*sstw;
          e=e+1
          u=1;
      end
end
end

	  
save tmp_OI_SST
