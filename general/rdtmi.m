function [gmt,sst,wind11,wind37,vapor,cloud,rain]=rdtmi(lyr,varargin)

%this subroutine will read the TMI daily byte maps.
%input arguments are in two forms:
%rdtmi(lyear,julian_day)
%rdtmi(lyear,month,dayofmonth)
%output arguments
%[gmt,sst,wind11,wind37,vapor,cloud,rain]
%gmt is gmt time in hours
%sst = sea surface temperature in deg C
%wind11 = wind speed derived using 11 GHz channel in m/s
%wind37 = wind speed derived using 37 GHz channel in m/s
%vapor = atmospheric water vapor in mm
%cloud = liquid cloud water in mm
%rain  = rain rate in mm/hr
%you do not have to read all of them in, but 
%you must assign a name to all variables before
%the one you want.  for example if you only want time and sst:
%[gmt,sst]=rdtmi(2000,1,10); 
% but if you want sst and vapor 
%[fooy,sst,fooy,fooy,vapor]=rdtmi(2000,1,10);
%please read the description file on www.remss.com
%for infomation on the various fields, or contact RSS support:
% http://www.remss.com/support


%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%you must change the following to the correct directory
%this assumes that you have a similar directory structure
%as the download directory, you will have to edit 
%fname variable farther down if it isn't.
%Do not add any file names here, just the directory.
file_directory='//Users/gaube/Documents/NSU/APPTIV_PB/data/raw_data/sst/';


xscale=[.1,.15 .2 .2 .3 .01 .1];
xoffset=[0 -3 0 0 0 0 0];

argin=cat(2,varargin{:});
isv=size(argin,2);
if isv==1
   jday=argin;
   for im=1:12
      last_day_month=eomday(lyr,im);
      if last_day_month>=jday,
         id=jday;break;
      end;
      jday=jday-last_day_month;
   end;
else
   im=argin(1);
   id=argin(2);
end;
   
syr=num2str(lyr,'%4.4i');sdy=num2str(id,'%2.2i');smn=num2str(im,'%2.2i');
fname=strcat(file_directory,syr,smn,sdy,'tm');
if ~exist(fname)
   fname=strcat(file_directory,syr,smn,sdy,'rt');
end;
if exist(fname)
   fid=fopen(fname,'r');
   for iasc=1:2
      for ivar=1:7
         dat=fread(fid,[1440 320],'uchar');
         ia=find(dat<=250);
         dat(ia)=dat(ia)*xscale(ivar)+xoffset(ivar);
         dat_tmi(:,:,ivar,iasc)=dat;
      end;
   end;
   gmt   =dat_tmi(:,:,1,:);
   sst   =dat_tmi(:,:,2,:);
   wind11=dat_tmi(:,:,3,:);
   wind37=dat_tmi(:,:,4,:);
   vapor =dat_tmi(:,:,5,:);
   cloud =dat_tmi(:,:,6,:);
   rain  =dat_tmi(:,:,7,:);
   fclose(fid);
else
   gmt=[];sst=[];wind11=[];wind37=[];vapor=[];cloud=[];rain=[];
end;



