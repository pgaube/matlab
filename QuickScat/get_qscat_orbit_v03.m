function [data] = get_qscat_orbit_v03(fname)
%*********************************************************** 
% Matlab program get_qscat_orbit_v03
%**********************************************************
%
% This Matlab code requires the data file name as input
% RSS Level 2B data for the entire orbit are returned
%
% The returned data are:
%
% atime:       a 21 character string, format= YYYY-DDDTHH:MM:SS.sss,  same as in the JPL HDF files
%
% phi_track    the direction of the subtrack velocity vector relative to north
%
% lat:		geodetic latitude
% lon:		east longitude (0-360)
%
% iclass:	indicator of expected quality of the vector retrieval
%		iclass =0 denotes no retrieval was done (either no observations or only one flavor of observation)
%		iclass =1 denotes 2 flavors of observations in wind vector cell
%		iclass =2 denotes 3 flavors of observations in wind vector cell
%		iclass =3 denotes 4 flavors of observations in wind vector cell
%	We suggest using just cases for which (iclass ge 2). However, this will omit all out swath data
%
% numamb:	the number of ambiguites (0 to 4)
% selamb:	the selected ambiguity (0 to 4)
%
% irain_scat:   the rain flag derived from the scatterometer measurements
%					rflag_scat=1 indicates rain
%
% wind_all:	wind speed for the various ambiguities
% dir_all:	wind direction for the various ambiguties (oceanographic convention)
% sos_all:	the normalized rms after-the-fit residual of the observation minus model sigma-nought
%		Large SOSAL values indicate the observations did not fit the geophysical model function.
%		We suggest discarding observations for which SOSAL.GT.1.9.
%
% wind_smooth:  the smoothed version of the selected wind ambiguity,  wind_all(selamb)
% dir_smooth:	the smoothed version of the selected direction ambiguity, dir_all(selamb)
%
% wind_gcm:	general circulation model wind speed used for nudging (either NCEP or ECMWF)
% dir_gcm:	general circulation model wind direction used for nudging (either NCEP or ECMWF)
%
% All wind speeds have a range of [0 - 70.0] m/s and a 0.01 m/s resolution
% All wind directions have 1.5 degree resolution
%
% rad_rain:	TMI or SSMI columar rain rate (rain rate times rain column height, km*mm/hour)
%		rad_rain =-999      no TMI or SSMI rain avaliable
%               rad_rain =   0      no rain
%		rad_rain =  0.1     possible rain
%		rad_rain =  0.2 through 25.4   definite rain and given value is the columnar rain rate (km*mm/hr)
%
%		"no rain"         means no   rain was detected within +/- 50 km and +/- time given in min_diff.
%		"possible rain"   means some rain was detected within +/- 50 km and +/- time given in min_diff.
%		"definite rain"   means rain was detected within      +/- 25 km and +/- time given in min_diff.
%		We suggest discarding observations for which RAD_RAIN.GT.0.15.
%
% min_diff      time difference in minutes between the scatterometer and the radiometer.  A value of 255
%		means no collocation was found.
%
% nudge_ncep	NCEP data field is used(0)/not used(1) in nudging qscat in near real-time mode.
% nudge_ecmwf   ECMWF data field is used(0)/not used(1) in nudging qscat only during reprocessing as
%		it is not timely enough (3-4 day delay) for real time processing.
%
%
% RSS, January 11, 2002:  reads RSS winvec L2B files v03 P. Ashcroft, D.Smith
% change history:

nrows = 1624;
nobs = 76;
fid = fopen(fname,'r');
if fid ~= -1
    buf00 = fread(fid,[21,nrows],'uchar');
    buf0  = fread(fid,[nrows],'uint8');
    buf1 = reshape(fread(fid,[2*nobs*nrows],'uint8'),2,nobs,nrows);
    buf2 = reshape(fread(fid,[2*nobs*nrows],'uint8'),2,nobs,nrows);
    buf3 = fread(fid,[nobs,nrows],'uint8');
    buf4 = fread(fid,[nobs,nrows],'uint8');
    buf5s = reshape(fread(fid,[2*nobs*nrows],'uint8'),2,nobs,nrows);
    buf6s = fread(fid,[nobs,nrows],'uint8');
    buf5 = reshape(fread(fid,[2*4*nobs*nrows],'uint8'),2,4,nobs,nrows);
    buf6 = reshape(fread(fid,[4*nobs*nrows],'uint8'),4,nobs,nrows);
    buf7 = reshape(fread(fid,[4*nobs*nrows],'uint8'),4,nobs,nrows);
    buf8 = reshape(fread(fid,[2*nobs*nrows],'uint8'),2,nobs,nrows);
    buf9  = fread(fid,[nobs,nrows],'uint8');
    buf10 = fread(fid,[nobs,nrows],'uint8');
    buf11 = fread(fid,[nobs,nrows],'uint8');
    nudge_ncep = fread(fid,1,'uint8');
    nudge_ecmwf = fread(fid,1,'uint8');
    fclose(fid);
    
    atime = char(buf00(:,:));
    
    lat = single(squeeze(.01*((buf1(1,:,:)*256 + buf1(2,:,:))-9000)));
    lon = single(squeeze(.01*(buf2(1,:,:)*256 + buf2(2,:,:))));
    
    phi_track = buf0 + 180.5;
    bad = find(buf0==255);
    phi_track(bad)=-999.0;
    phi_track = single(phi_track);
    
    double_iclass = fix(buf3/64);
    double_selamb = fix((buf3-64*double_iclass)/8);
    numamb = int16(buf3-64*double_iclass-8*double_selamb);
    iclass = int16(double_iclass);
    selamb = int16(double_selamb);
    
    irain_scat	= int16(buf4/64);
    
    wind_all    = squeeze(single(.01* (buf5(1,:,:,:)*256 + buf5(2,:,:,:))));
    dir_all		= single(buf6*1.5);
    sos_all		= single(buf7*0.02);
    
    wind_smooth	= squeeze(single(.01* (buf5s(1,:,:)*256 + buf5s(2,:,:))));
    dir_smooth	= single(buf6s*1.5);
    
    wind_gcm	= squeeze(single(.01* (buf8(1,:,:)*256 + buf8(2,:,:))));
    dir_gcm		= single(buf9*1.5);
    
    rad_rain	= single(buf10*0.1);
    bad = find(buf10 == 255);
    rad_rain(bad)= -999.0;
    
    min_diff	= int16(buf11);
    
    
    exists=find((numamb > 0) & (iclass ~= 0));
    temp=zeros(nobs,nrows);
    temp(exists)=1;
    ambexists(1,:,:)=temp;
    
    exists=find((numamb > 1) & (iclass ~= 0));
    temp=zeros(nobs,nrows);
    temp(exists)=1;
    ambexists(2,:,:)=temp;
    
    exists=find((numamb > 2) & (iclass ~= 0));
    temp=zeros(nobs,nrows);
    temp(exists)=1;
    ambexists(3,:,:)=temp;
    
    exists=find((numamb > 3) & (iclass ~= 0));
    temp=zeros(nobs,nrows);
    temp(exists)=1;
    ambexists(4,:,:)=temp;
    
    
    
    bad=find(ambexists == 0);
    wind_all(bad)	= NaN;
    dir_all (bad)	= NaN;
    sos_all (bad)	= NaN;
    
    wind=zeros([nobs,nrows]);
    dir=zeros([nobs,nrows]);
    
    ok=find(selamb == 1);
    if length(ok) > 0
        temp = wind_all(1,:,:);
        wind(ok)= temp(ok);
        temp = dir_all(1,:,:);	
        dir(ok)= temp(ok);
    end
    
    
    ok=find(selamb == 2);
    if length(ok) > 0
        temp = wind_all(2,:,:);
        wind(ok)= temp(ok);
        temp = dir_all(2,:,:);	
        dir(ok)= temp(ok);
    end
    
    ok=find(selamb == 3);
    if length(ok) > 0
        temp = wind_all(3,:,:);
        wind(ok)= temp(ok);
        temp = dir_all(3,:,:);	
        dir(ok)= temp(ok);
    end
    
    
    ok=find(selamb == 4);
    if length(ok) > 0
        temp = wind_all(4,:,:);
        wind(ok)= temp(ok);
        temp = dir_all(4,:,:);	
        dir(ok)= temp(ok);
    end
    
    bad = find((iclass == 0) | (numamb == 0));
    if length(bad) > 0
        lat(bad) 			= NaN;
        lon(bad) 			= NaN;
        wind_smooth(bad)   	= NaN;
        dir_smooth(bad)     = NaN;
        wind_gcm(bad)		= NaN;
        dir_gcm(bad)		= NaN;
        wind(bad)			= NaN;
        dir(bad)			= NaN;
    end
    
    data = struct('atime',atime,'phi_track',phi_track,'lat',lat,'lon',lon,'iclass',iclass,'numamb',numamb,...
        'selamb',selamb,'irain_scat',irain_scat,'wind_all',wind_all,'dir_all',dir_all,'sos_all',sos_all,'wind',...
        wind,'dir',dir,'wind_smooth',wind_smooth,'dir_smooth',dir_smooth,'wind_gcm',wind_gcm,'dir_gcm',dir_gcm,...
        'rad_rain',rad_rain,'min_diff',min_diff,'nudge_ncep',nudge_ncep,'nudge_ecmwf',nudge_ecmwf);
    
else
    data =  -1;
end


