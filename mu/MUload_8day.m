%loads MLD depth maps from FLNM
%http://orca.science.oregonstate.edu/1080.by.2160.monthly.hdf.mld.merge.php

clear all
close all
jdays=[2450823:2454489];



%Set path and region
mpath = '/data/seawifs/mike_hdf/';
save_path = '/matlab/data/mu/mat/';

%make 9 km grid
lat=linspace(89.9583,-89.9583,1080);
lon=linspace(0.0417,359.9583,2160);
[lon,lat]=meshgrid(lon,lat);
j=[1:640];
i=[1:1440];
dy=.25;
dx=.25;
glat= -80+dy/2+(j-1)*dy;
glon= 0+dx/2+(i-1)*dx;
[glon,glat]=meshgrid(glon,glat);

%create mld matrix to save jdays
w=1;
q=1;
e=1;
ss=1;
for m=1:length(jdays)
    [yea,mon,day]=jd2jdate(jdays(m));
    dates(m)=(yea*1000)+julian(mon,day,yea,yea);
    caldates(m) = (10000*yea)+(100*mon)+day;
    %    dates(m)=(yea*10000)+(mon*100)+day;
    mfname = ['growth.' num2str(dates(m)) '.hdf'];
    %if exist([mpath mfname '.gz'])
    if exist([mpath mfname])
    fprintf('proccesing_file %u \n',dates(m))
        %Read chl hdf file
        file=[mpath mfname];
        %eval(['!gunzip ' file '.gz'])
        data = eval(['hdfread(' char(39) mpath mfname char(39) ',' char(39)...
                     	 '/growth' char(39) ');']);            
       	data = single([data(:,1081:2160),data(:,1:1080)]);
		data(data<-1) = NaN;  %create land mask
		data(data>2) = NaN;  %create land mask
        tmp=interp2(lon,lat,data,glon,glat,'linear');
       	
       	%{
       	figure(1)
        clf
        pmap(glon,glat,tmp)
        colormap(chelle)
        caxis([0 2])
        drawnow
        %}
        mu_day=	flipud(cat(1,nan(40,1440),tmp,nan(40,1440)));    
        fname=[save_path 'MU_25_8D_' num2str(jdays(m))];
        eval(['save ' fname ...
                       ' mu_day jdays']);
                       
     end   
end

