%loads SeaWiFS CHL data from the gsm algorithum
clear all
close all
jdays=[2450821:2454489];



%Set path and region
cpath = '/data/gsm/chl/';
bpath = '/data/gsm/bbp/';
save_path = '/matlab/data/gsm/mat/';

%make 9 km grid
%lat=linspace(89.9583,-89.9583,2160);
%lon=linspace(0.0417,359.9583,4320);
loN=[0:8640]/24;
LON=loN(2:2:8640);
laT=[2160:-1:-2160]/24;
LAT=laT(2:2:4320); 
lat=single(LAT);
lon=single(LON);
[lon,lat]=meshgrid(lon,lat);
glon=biggrid(lon,9,25);
glat=biggrid(lat,9,25);

%create chl matrix to save jdays
w=1;
q=1;
e=1;
ss=1;
for m=1:length(jdays)
    [yea,mon,day]=jd2jdate(jdays(m));
    dates(m)=(yea*1000)+julian(mon,day,yea,yea);
    caldates(m) = (10000*yea)+(100*mon)+day;
    %    dates(m)=(yea*10000)+(mon*100)+day;
    fprintf('proccesing_file %u \n',dates(m))
    cfname = ['GSMchl.' num2str(dates(m)) '.L3b_DAY.01.5.hdf'];
   	bfname = ['GSMbbp.' num2str(dates(m)) '.L3b_DAY.01.5.hdf'];
    if exist([cpath cfname])
        
        %Read chl hdf file
        file=[cpath cfname];
        data = eval(['hdfread(' char(39) cpath cfname char(39) ',' char(39)...
                     	 'GSM_Chlorophyll' char(39) ');']);            
       	data = single([data(:,2161:4320),data(:,1:2160)]);
		data(data<-1) = NaN;  %create land mask
       	chl_day = data;
        
        
        fname=[save_path 'GSM_9_D_' num2str(jdays(m))];
        eval(['save -append ' fname ...
                       ' chl_day lat lon']);
                       
        
     end   
end

