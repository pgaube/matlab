%loads SeaWiFS CHL data
clear all
close all
slope=5.8138e-5; inter=-2; base=10;


%Set range of dates
startyear = 2007;
startmonth = 01;
startday = 1;  %must be mid-week day from aviso SSH -3
endyear = 2007;
endmonth = 12;
endday = 31;


%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:endjd];

%Set path and region
path = '/Volumes/matlab/data/SeaWiFS/hdf/';
load /Volumes/matlab/matlab/domains/reg_lat_lon
max_lat=max(lat);
min_lat=min(lat);
max_lon=max(lon);
min_lon=min(lon);

%make 9 km grid
loN=[0:8640]/24;
LON=loN(2:2:8640);
laT=[2160:-1:-2160]/24;
LAT=laT(2:2:4320); 
r=find(LAT>=min_lat&LAT<=max_lat);
c=find(LON>=min_lon&LON<=max_lon);
lat=LAT(r);
lon=LON(c);
lon=ones(length(lat),1)*lon;
lat=lat'*ones(1,length(lon(1,:)));

%{
%make 25 km grid
LON=[0.125:.25:359.875];
LAT=[-89.875:.25:89.875];
gr=find(LAT>=min_lat&LAT<=max_lat);
gc=find(LON>=min_lon&LON<=max_lon);
grid_lat=LAT(gr);
grid_lon=LON(gc);
grid_lon=ones(length(grid_lat),1)*grid_lon;
grid_lat=grid_lat'*ones(1,length(grid_lon(1,:)));
%}

%create chl matrix to save jdays
%chl_week=nan(length(grid_lat(:,1)),length(grid_lon(1,:)),length(mid_week_jdays));
%chl_week=nan(length(lat(:,1)),length(lon(1,:)),length(mid_week_jdays));
chl_day=nan(length(lat(:,1)),length(lon(1,:)),length(jdays));
%chl_day=nan(length(lat(:,1)),length(lon(1,:)),7);
w=1;
q=1;
e=1;
for m=1:length(jdays)
    [yea,mon,day]=jd2jdate(jdays(m));
    dates(m)=(yea*1000)+julian(mon,day,yea,yea);
    %    dates(m)=(yea*10000)+(mon*100)+day;
    dates(m)
    fname = ['S' num2str(dates(m)) '.L3m_DAY_CHLO_9'];
    fnameg = ['S' num2str(dates(m)) '.L3m_DAY_CHLO_9.bz2'];
    
    if exist([path fnameg])
        
        Read amsre file using ssmi script
        file=[path fname];
        eval(['!bunzip2 ' path fnameg]);
        data = eval(['hdfread(' char(39) path fname char(39) ',' char(39)...
                     'l3m_data' char(39) ');']);

        %eval(['!bzip2 ' file])
        
        %Make Daily composite
        data = [data(:,2160:4320),data(:,1:2159)];
        data = data(r,c);
        data = double(data);
        data(data==65535) = NaN;  %create land mask
        chl = base.^((slope*data)+inter);
        chl(chl>64)=nan;
    elseif exist([path fname])
        
        %Read amsre file using ssmi script
        file=[path fname];
        data = eval(['hdfread(' char(39) path fname char(39) ...
                      ',' char(39) 'l3m_data' char(39) ');']);
         %Make Daily composite
         data = [data(:,2160:4320),data(:,1:2159)];
         data = data(r,c);
         data = double(data);
         data(data==65535) = NaN;  %create land mask
         chl = base.^((slope*data)+inter);
         chl(chl>64)=nan;
    else
        chl=nan(length(lat(:,1)),length(lon(1,:)));
        missing_file(q,:)=fname;
        q=q+1;
    end
    chl_day(:,:,w)=chl;
    %num_good=length(find(~isnan(chl_day(:,:,w))))
    w=w+1;
    clear chl data
end

%!bzip2 /Volumes/matlab/data/SeaWiFS/hdf/*
clear year wind data time sstm sst_day sst1 sst2 rain q r proccesing_file ...
    path mon min* m int* fna* file e day clwm clw_day clw1 clw2 clw cloud ...
    c awvm awv_day awv1 awv2 awv STEP LON LAT max*