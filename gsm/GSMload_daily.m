%loads SeaWiFS CHL data from the gsm algorithum
clear all
% close all
jdays=[2452457:2452666];
jdays=[2453737:2455562];%for overlap with turtles
jdays=[2454190:2455562];%for overlap with turtles and already loaded

%Set path and region
cpath = '~/data/gsm/modisa/';
save_path = '~/data/gsm/mat/';

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
for m=1136:length(jdays)
    [yea,mon,day]=jd2jdate(jdays(m));
    dates(m)=(yea*1000)+julian(mon,day,yea,yea);
    caldates(m) = (10000*yea)+(100*mon)+day;
    %    dates(m)=(yea*10000)+(mon*100)+day;
    fprintf('proccesing_file %u \n',dates(m))
    cfname = ['GSMchl.' num2str(dates(m)) '.L3b_DAY.11.7.hdf'];
    if exist([cpath cfname])
        
        %Read chl hdf file
        file=[cpath cfname];
        data = eval(['hdfread(' char(39) cpath cfname char(39) ',' char(39)...
                     	 'GSM_Chlorophyll' char(39) ');']);            
       	data = single([data(:,2161:4320),data(:,1:2160)]);
		data(data<-1) = NaN;  %create land mask
       	chl_day = data;
        tmp=biggrid(log10(chl_day),9,25);
%         figure(1)
%         clf
%         pmap(glon,glat,tmp)
%         drawnow
        gchl_day=10.^tmp;

        fname=[save_path 'GSM_SAM_9_D_' num2str(jdays(m))];
        eval(['save ' fname ...
                       ' chl_day lat lon gchl_day glon glat jdays']);
     end   
end

