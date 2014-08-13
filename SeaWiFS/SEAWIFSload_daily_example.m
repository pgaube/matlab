%   Author:      Peter Gaube
%   Time-stamp:  27-Jul-2010
%   E-mail:      pgaube@coas.oregonstate.edu
%
%
% loads SeaWiFS CHL data
% calls the following subfunctions
%function [year, month, day, hour, minute, second] = jd2jdate(jday)
%function julday = julian(month,day,year,year0)
%function jd = date2jd(varargin)
%
clear all
close all
jdays=[2450821:2454489]; %set dates




%Set path
path = '/home/mckenzie/data2/data/seawifs/hdf/'; %change to data dir
save_path = '/home/mckenzie/data2/data/seawifs/mat/'; %%change to output dir

%make 9 km grid
loN=[0:8640]/24;
LON=loN(2:2:8640);
laT=[2160:-1:-2160]/24;
LAT=laT(2:2:4320); 
lat=single(LAT);
lon=single(LON);
[lon,lat]=meshgrid(lon,lat);

%create chl matrix
chl_week=nan(length(lat(:,1)),length(lon(1,:)));
w=1;
q=1;
e=1;
for m=1:length(jdays)
    [yea,mon,day]=jd2jdate(jdays(m));
    dates(m)=(yea*1000)+julian(mon,day,yea,yea);
    caldates(m) = (10000*yea)+(100*mon)+day;
    %    dates(m)=(yea*10000)+(mon*100)+day;
    fprintf('proccesing_file %u \n',dates(m))
    fname = ['S' num2str(dates(m)) '.L3m_DAY_CHL_chlor_a_9km'];
   	fnameg = ['S' num2str(dates(m)) '.L3m_DAY_CHL_chlor_a_9km.bz2']; %change if they change data compression to .gz
    %fnameg = ['S' num2str(dates(m)) '.L3m_DAY_CHL_chlor_a_9km.gz']
    if exist([path fnameg])
        eval(['!bunzip2 ' path fnameg]);
        %eval(['!gunzip2 ' path fnameg]);%change if they change data compression to .gz
    end
    if exist([path fname])
        
        %Read hdf file
        file=[path fname];
        data = eval(['hdfread(' char(39) path fname char(39) ',' char(39)...
                     	 'l3m_data' char(39) ');']);            
       	data = single([data(:,2161:4320),data(:,1:2160)]);
		data(data<-3000) = NaN;  %create land mask
       	chl_day = data;
        tmp=biggrid(log10(chl_day),9,25);
        gchl_day=10.^tmp;
        fname=[save_path 'SCHL_9_D_' num2str(jdays(m))];
        %eval(['save ' fname ...
        %                ' chl_day lat lon jdays']); %write to matlab standard output binary
        
     end   
end
