function [extract lon lat time] = xtracto_3D_bdap(xpos,ypos,tpos,dtype);
% Example script to get the large chunks of data via SWFSC/ERD THREDDS server
%
% INPUTS:  xpos = [xmin xmax] = longitude in 0 to 360 E lon, or -180 to 180 E lon
%          ypos = [ymin ymax] = latitude -90 to 90 N lat
%          tpos = [tpos tmax] = time, in matlab days  
%          dtype = data ID Code (data types listed below)
% 
% OUTPUT:
%
%  Extract = 4 dimensional array
%            index 1 = time dimension of output array
%            index 2 = depth dimension of output array
%            index 3 = latitude dimension of output array
%            index 4 = longitude dimension of output array
%
%  lon = longitude vector (basis of column 4)
%  lat = latitude vector (basis of col 3)
%  time = time vector (basis for column 1)
% 
%
% Sample Calls:
%
% to extract Seawifs 8-day Primary Productivity 
% [extract] = xtracto_3D_bdap(xpos,ypos,tpos,'41');
%
%  to extract pathfinder SST 8-day mean data 
%  [extract] = xtracto_3D_bdap(xpos,ypos,tpos,'18');
%
% %
% see the following link to get data codes and full data set information
% http://coastwatch.pfel.noaa.gov/coastwatch/CWBrowserWW360.jsp?get=griddata
%
% V0.1  17 Aug 2006.
% CoastWatch/DGF
% v1.0 DGF  22 Feb 2007 - Cleaned up code and help
% v1.1 DGF  27 Feb 2007 - More cleaning
% v1.2 DGF  9 June 2007 - tweaked the dataid handling to pass
%                         through CWBrowser requests 
% v1.3 DGF 13 May 2011  - adjusted script to handle adjustment to coastwatch server


% make sure data type input is a string and not a number
if ~isstr(dtype)
  datatype = num2str(dtype);
else
  datatype = dtype;
end

if length(datatype)==11 | length(datatype)==12
  datasetname = datatype;
else
  switch lower(dtype)
     % AVHRR HRPT 1.4 km nighttime SST data for West coast
     case {'1','atsstnhday'}
       datasetname = 'TATsstdhday';

     % AVHRR HRPT 1.4 km daytime SST data for West coast
     case {'2','atssdhday'}
       datasetname = 'TATsstnhday';

     % AVHRR HRPT 1,4 km night and day SST 1-day composite
     case {'3','atssta1day','hrpt','avhrr hrpt'}
       datasetname = 'TATssta1day';

     % AVHRR HRPT 1.4 km night and day SST 3-day composite
     case{'4','atssta3day'}
       datasetname = 'TATssta3day';

     % AVHRR HRPT 1.4 km night and day SST 8-day composite
     case{'5','atssta8day'};
       datasetname = 'TATssta8day';

     % AVHRR HRPT 1.4 km night and day SST 14-day composite
     case{'6','atssta14day'}
       datasetname = 'TATssta14day';

     % AVHRR HRPT 1.4km night and day SST monthly composite
     case{'7','atsstamday'}
        datasetname = 'TATsstamday';

     % AVHRR GAC SST 11km 1-day composite
     case{'8','agssta1day'}
       datasetname = 'TAGssta1day';

     % AVHRR GAC SST 11km 3-day composite
     case{'9','agssta3day'}
       datasetname = 'TAGssta3day';

     % AVHRR GAC SST 11km 8-day composite
     case{'10','agssta8day'}
       datasetname = 'TAGssta8day';

     % AVHRR GAC SST 11km 14-day composite
     case{'11','agssta14day'}
       datasetname = 'TAGssta14day';

     % AVHRR GAC SST 11km monthly composite
     case{'12','agsstamday'}
       datasetname = 'TAGsstamday';

     % GOES SST 5.5 km 1-day composite
     case{'13','gassta1day','goes sst','goes','geostationary'}
       datasetname = 'TGAssta1day';

     % GOES SST 5.5 km 3-day composite
     case{'14','gassta3day'};
       datasetname = 'TGAssta3day';

     % GOES SST 5.5 km 8-day composite
     case{'15','gassta8day'}
       datasetname = 'TGAssta8day';

     % GOES SST 5.5 km 14-day composite
     case{'16','gassta14day'}
       datasetname = 'TGAssta14day';

     % Pathfinder v5 5.5km SST 1-day composite
     case{'17','phssta1day'}
       datasetname = 'TPHssta1day';

     % Pathfinder v5 5.5km SST 8-day composite
     case{'18','phssta8day','pathfinder','sst','avhrr','sea surface temperature'}
      datasetname = 'TPHssta8day';

     % Pathfinder v5 5.5km SST monthly composite
     case{'19','phsstmday','monthly sst'}
      datasetname = 'TPHsstamday';

     % MODIS Aqua 2.5 km chla 1-day composite
     case{'20','mbchla1day'}
      datasetname = 'TMBchla1day';

     % MODIS Aqua 2.5 km chla 8-day composite
     case{'21','mbchla8day','chla','chlorophyll','modis chl','modis aqua'};
      datasetname = 'TMBchla8day';

     % MODIS Aqua 2.5 km chla 14-day composite
     case{'22','mbchla14day'}
      datasetname = 'TMBchla14day';
 
     % Jason-1 25km SSH deviation, 10-day composite
     case{'23','j1sshd10day','ssh','ssha','jason','sea surface height'}
       datasetname = 'TJ1sshd10day';

     % Quikscat NRT 25 km zonal wind, 1-day composite
     case{'24','qnux101day'}
       datasetname = 'TQNux101day';

     % Quikscat NRT 25 km meridional wind, 1-day composite
     case{'25','qnuy101day'}
      datasetname = 'TQNux101day';

     % Quikscat NRT 25 km zonal wind, 3-day composite
     case{'26','qnux103day','zonal wind','ux10'}
       datasetname = 'TQNux103day';
     case{'27','qnuy103day','meridional wind','uy10'}
       datasetname = 'TQNuy103day';
     case{'28','qnumod3day','wind speed','wind modulus'}
       datasetname = 'TQNumod3day';
     case{'29','qncurl3day','curl','wind stress curl','curl of wind stress'}
       datasetname = 'TQNcurl3day';
     case{'30','qnux108day'}
       datasetname = 'TQNux108day';
     case{'31','qnuy108day'}
       datasetname = 'TQNuy108day';
     case{'32','qnumod8day'}
       datasetname = 'TQNumod8day';
     case{'33','qncurl8day'}
       datasetname = 'TQNcurl8day';
     case{'34','qnux1014day'}
       datasetname = 'TQNux1014day';
     case{'35','qnuy1014day'}
       datasetname = 'TQNuy1014day';
     case{'36','qnumod14day'}
       datasetname = 'TQNumod14day';
     case{'37','qncurl14day'}
       datasetname = 'TQNcurl14day';
     case{'38','qncurlmday'}
       datasetname = 'TQNcurlmday';
     case{'39','qnux10mday'}
       datasetname = 'TQNux10mday';
     case{'40','qnuy10mday'}
       datasetname = 'TQNux10mday';
 
     % Primary productivity, 8-day, seawifs chl.
     case{'41','ppbfp18day','primary productivity','seawifs productivity'}
       datasetname = 'TPPbfp18day';

     % Primary productivity, monthly, seawifs chl
     case{'42','Tppbfp1mday','monthly productivity'}
       datasetname = 'TPPbfp1mday';

     % GOES frontal index 14-day
     case{'43','gatfnt14day','GOES fronts','frontal index','frontal probability'}
      datasetname = 'TGAtfnt14day';

     % GOES frontal index 14-day
     case{'44','gatfntmday'}
       datasetname = 'TGAtfntmday';
     % Quikscat NRT 4-day Curl of stress
     case{'45','qncurl4day'}
       datasetname = 'TQNcurl4day';
     % Quikscat NRT 4-day zonal wind
     case{'46','qnux104day'}
       datasetname = 'TQNux104day';
     % Quikscat NRT 4-day meridional wind
     case{'47','qnuy104day'}
       datasetname = 'TQNuy104day';
     % AVISO SSH (0.25 degrees) Science Quality
     case{'48','tasshd1day'}
       datasetname = 'TTAsshd1day';
     % Dave Blended SST (modis+amsre+goes+avhrr)
     case{'49','bassta5day'}
       datasetname = 'TBAssta5day';
     % MODIS/Aqua 0.05 degree chlorophyll (oc3)
     case{'50','mhchla8day'}
       datasetname = 'TMHchla8day';
     % MODIS/Aqua 0.05 degree K490
     case{'51','mhk4908day'}
       datasetname = 'TMHk4908day';
     % MODIS/Aqua 0.05 degree SST
     case{'52','mhsstd8day'}
       datasetname = 'TMHsstd8day';
     % MODIS/Aqua 0.05 degree Chlorophyll fluoresence line height
     case{'53','mhcflh8day'}
       datasetname = 'TMHcflh8day';
     % quikscat 3-day Science-quality Curl of wind stress
     case{'54','qscurl3day'};
       datasetname = 'TQScurl3day';
     % quikscat 3-day Science-quality wind modulus
     case{'55','qsumod3day'}
       datasetname = 'TQSumod3day';
     % Quikscat 3-day Science-Quality zonal wind
     case{'56','qsux103day'};
       datasetname = 'TQSux103day';
     % Quikscat 3-day Science Quality meridional wind
     case{'57','qsuy103day'}
       datasetname = 'TQSuy103day';
     % Seawifs 0.1 degree chlrophyll, 8-day
     case{'62','swchla8day'}
       datasetname = 'TSWchla8day';
     % Seawifs 0,1 degree chlorophyll, monthly
     case{'63','swchlamday'}
       datasetname = 'TSWchlamday';
     % MODIS/Aqua NRT chlorophyll a from OSU DB Station
     case{'64','mychlahday'}
       datasetname = 'TMYchlahday';
  
     % MODIS/Aqua NRT chlorophyll a , 1-day composite, from OSU DB Station
     case{'65','mychla1day'}
       datasetname = 'TMYchla1day';

     % MODIS/Aqua NRT chlorophyll a , 3-day composite, from OSU DB Station
     case{'66','mychla3day'}
       datasetname = 'TMYchla3day';

   % Seawifs HRPT daily chl
     case{'67','shchl21day'}
     datasetname = 'TSHchl21day';

     % Seawifs HRPT monthly chl
     case{'68','shchl2mday'}
     datasetname = 'TSHchl2mday';

     % AVISO 7-day zonal geostrophic current
     case{'69','TAugeo1day','ugeo'}
     datasetname = 'TTAugeo1day';

     % AVISO 7-day meridional geostrophic current
     case{'70','TAvgeo1day','vgeo'}
     datasetname = 'TTAvgeo1day';

     % pathfinder climatology
     case{'73','pcsstamday'}
     datasetname = 'CPCsstamday';

     % quikscat 1-day science quality zonal wind
     case{'74','qsux101day'}
     datasetname = 'TQSux101day';

     % quikscat 1-day science quality meridional wind
     case{'75','qsuy101day'}
     datasetname = 'TQSuy101day';

     % quikscat 1-day science quality wind modulus
     case{'76','qsumod1day'}
     datasetname = 'TQSumod1day';

     % quikscat 1-day science quality wind stress curl
     case{'77','qscurl1day'}
     datasetname = 'TQScurl1day';

     % quikscat 1-day science quality zonal wind stress
     case{'78','qstaux1day'}
     datasetname = 'TQtaux1day';

     % quikscat 1-day science quality meridional wind stress
     case{'79','qstauy1day'}
     datasetname = 'TQStauy1day';

     % quikscat 1-day science quality wind stress modulus
     case{'80','qstmod1day'}
     datasetname = 'TQStmod1day';

     % quikscat 7-day science quality. zonal ekman current
     case{'81','qsuekm1day'}
     datasetname = 'TQSuekm7day';

     % quikscat 7-day science quality meridional Ekman current
     case{'82','qsvekm1day'}
     datasetname = 'TQSvekm7day';

     % quikscat 7-day science quality vertical Ekman current
     case{'83','qswekm1day'}
     datasetname = 'TQSwekm7day';

     % Reynolds daily OI SST - AVHRR  + in situ
     case{'89','nassta1day'}
     datasetname = 'TNAssta1day';

     % Reynolds daily OI SST - AVHRR / AMSR-E + insitu
     case{'90','n2ssta1day'}
     datasetname = 'TN2ssta1day';
     
     % Blendomatic 8-day SST
     case{'91','bassta8day'}
     datasetname = 'TBAssta8day';
  end   
end

% breakup string into components
satid = datasetname(1:3);
param = datasetname(4:7);
duration = datasetname(8:end);

% correct for Bobisms
if strcmp(duration,'hday')
    duration = 'pass';
end

if strcmp(duration,'mday')
    duration = '1month'
end

% default URL for NMFS/SWFSC/ERD  THREDDS server
urlbase='http://coastwatch.pfel.noaa.gov/coastwatch/CWBrowserWW360.jsp';

% get list of available time periods
% First, make bad call to CW page,
bobcallbad = strcat(urlbase,'?get=griddata&dataset=',strcat(satid,param),...
		   '&timeperiod=',duration,...
		   '&centeredTime=')
strbad1=urlread(bobcallbad);

% parse call to get available times
stind = regexp(strbad1,'<span','start');
endind = regexp(strbad1,'</span>','end');
icnt = 1;
for i = 1:length(stind),
  str2 = strbad1(stind(i):endind(i));
  ind = regexp(str2,'\d\d\d\d-\d\d-\d\d','start');
  if ~isempty(ind)
    alldates(icnt,1:19)=str2(ind(1):ind(1)+18);
    icnt = icnt + 1;
  end
end

btime = unique(alldates,'rows')

% convert to matlab days
year=str2num(btime(:,1:4));
month=str2num(btime(:,6:7));
day=str2num(btime(:,9:10));
hour=str2num(btime(:,12:13));
minute=str2num(btime(:,15:16));
second=str2num(btime(:,18:19));
sattime = datenum(year,month,day,hour,minute,second);

% handle case of -180 to 180 longitude input
ind=find(xpos<0);
if ~isempty(ind)
  xpos(ind)=xpos(ind)+360;
  longconv = 1;
else
  longconv = 0;
end

% define spatial bounding box
xmax = max(xpos);
xmin = min(xpos);
ymax = max(ypos);
ymin = min(ypos);

% find time points within time bounds.
tmax = max(tpos);
tmin = min(tpos);

% special case tmin = tmax
if (tmin == tmax)
  tind=find(abs(sattime-tmin) == min(abs(sattime-tmin)));
else
  tind = find(sattime<=tmax & sattime >= tmin);
end
% if it cannot find any time points in that range lo

if (length(tind)>0)

  % loop on points
  for i = 1:length(tind),

    % get time in year month day etc...
    yrstr = datestr(sattime(tind(i)),'YYYY');
    monstr = datestr(sattime(tind(i)),'mm');
    daystr = datestr(sattime(tind(i)),'dd');
    hourstr = datestr(sattime(tind(i)),'HH');
    minstr = datestr(sattime(tind(i)),'MM');
    secstr = datestr(sattime(tind(i)),'SS');

    % text string for data retrieval call
    bobcall = strcat(urlbase,'?get=griddata&dataset=',strcat(satid,param),...
		   '&minlon=',num2str(xmin),'&maxlon=',num2str(xmax),...
		   '&minlat=',num2str(ymin),'&maxlat=',num2str(ymax),...
		   '&timeperiod=',duration,...
		   '&centeredTime=~',yrstr,'-',monstr,'-',daystr,...
		     'T',hourstr,':', minstr,':',secstr,...
		   '&filetype=.mat')

    % extract data array and import to Matlab depending on structure
    varname = strcat(satid(2:3),param);  
    fileout='tmp.mat';
    urlwrite(bobcall,fileout);
    try
      load('-MAT',fileout);    
      eval(strcat('sstd=',varname,';'));
      
      nx = length(lon);
      ny = length(lat);
      % get array dimensions - note that the order of data returned is not the same

      extract(i,1,1:ny,1:nx) = sstd;
    catch
      extract(i,1,:,:)=nan;
      sprintf('Caught a THREDDS access error. Pausing for half a minute...')
      pause(30)
    end
  end

  % return longitude in users own convention
  if longconv == 1
    ind = find(lon > 180);
    lon(ind) = lon(ind)-360;
  end

  % return time vector
  time = sattime(tind);
else
  extract(1,1,1,1)=nan;
  lon=nan;
  lat=nan;
  time=nan;
end

% fin
