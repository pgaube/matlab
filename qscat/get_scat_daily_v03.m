function [mingmt,windspd,winddir,scatflag,radrain]=get_scat_daily_v03(filename)
%this subroutine will read the RSS scatterometer daily bytemaps.
%reads version-3a files released October 2006
%
%input argument is the full path file name:
%   get_scat_daily_v03(filename)
%
%output arguments:
%   [mingmt,windspd,winddir,scatflag,radrain]
%   mingmt is gmt time in minutes of day
%   windspd in m/s	(10 meter surface wind)
%   winddir in degrees 	(oceanographic convention, blowing North = 0)
%   scatflag		(0=no rain, 1=rain)
%   radrain   in km*mm/hr  (-999.0 = no collocation available)
%                       (  -1.0 = adjacent cells had rain, but not this cell)
%                       (   0.0 = radiometer data exist and show no rain)
%				(   0.5 - 31.0 = columnar rain rate in km*mm/hr)
%
%  The center of the first cell of the 1440 column and 720 row map is at 0.125 E longitude and -89.875 latitude.
%  The center of the second cell is 0.375 E longitude, -89.875 latitude.
% 		XLAT=0.25*ILAT-90.125
%		XLON=0.25*ILON-0.125
%
%please read the description file on www.remss.com
%for infomation on the various fields, or contact RSS support:
% http://www.remss.com/support
%
%

xscale=[6.,.2,1.5];

if (exist(filename)==2)
    fid=fopen(filename,'r');
    for iasc=1:2
        for ivar=1:4
            dat=fread(fid,[1440 720],'uchar');
            switch ivar
                case 1
                    dat =dat*xscale(ivar);
                    mingmt(:,:,iasc)=dat;
                case 2
                    dat=dat*xscale(ivar);
                    windspd(:,:,iasc)=dat;
                case 3
                    dat=dat*xscale(ivar);
                    winddir(:,:,iasc)=dat;
                case 4
                    scatflag(:,:,iasc) = dat-2*fix(dat/2); % bit 1
                    rad_flag = fix((dat-4*fix(dat/4))/2); % bit 2
                    temp=fix(dat/4); % bits 3-8
                    
                    temp2 = -999*ones(size(dat));
                    
                    for i=1:prod(size(temp2)),
                        if rad_flag(i)==1
                            if temp(i)==0
                                temp2(i)=0;
                            elseif temp(i)==1
                                temp2(i)=-1;
                            else
                                temp2(i)=temp(i)/2-0.5;
                            end
                        end
                        
                    end  % i loop
                    
                    radrain(:,:,iasc)=temp2;
                    
            end   % switch
        end	  % ivar loop
    end    % iasc loop
    fclose(fid);
    
    index = find(mingmt > 1440);
    windspd(index) = -999.;
    winddir(index) = -999.;
    scatflag(index)= -999.;
    radrain (index)= -999.;
    
else
    mingmt=[];windspd=[];winddir=[];scatflag=[];radrain=[];
end    % file exists



