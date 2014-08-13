%loads SeaWiFS CHL data
clear all
close all
slope=5.8138e-5; inter=-2; base=10;


%Set range of dates
startyear = 1998;
startmonth = 01;
startday = 07;
endyear= 2008;
endmonth = 01;
endday = 23;

%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd-3:endjd+3];

%construct date vector for mid-week day
mid_week_jdays=[startjd:7:endjd];
end_week_jdays = mid_week_jdays+3;




%Set path and region
path = '/Volumes/data2/data/seawifs/hdf/';
save_path = '/Volumes/data2/data/seawifs/mat/'

%make 9 km grid
loN=[0:8640]/24;
LON=loN(2:2:8640);
laT=[2160:-1:-2160]/24;
LAT=laT(2:2:4320); 
lat=single(LAT);
lon=single(LON);
lon=ones(length(lat),1)*lon;
lat=lat'*ones(1,length(lon(1,:)));
glat=biggrid(lat,9,25);
glon=biggrid(lon,9,25);

%create chl matrix to save jdays
chl_week=nan(length(lat(:,1)),length(lon(1,:)));
chl_day=nan(length(lat(:,1)),length(lon(1,:)),7);
w=1;
q=1;
e=1;
for m=1:length(jdays)
    [yea,mon,day]=jd2jdate(jdays(m));
    dates(m)=(yea*1000)+julian(mon,day,yea,yea);
    caldates(m) = (10000*yea)+(100*mon)+day;
    %    dates(m)=(yea*10000)+(mon*100)+day;
    fprintf('proccesing_file %u \n',dates(m))
    fname = ['S' num2str(dates(m)) '.L3m_DAY_CHLO_9'];
    fnameg = ['S' num2str(dates(m)) '.L3m_DAY_CHLO_9.bz2'];
    if exist([path fnameg])
        eval(['!bunzip2 ' path fnameg]);
    end
    if exist([path fname])
        
        %Read hdf file
        file=[path fname];
        data = eval(['hdfread(' char(39) path fname char(39) ',' char(39)...
                     'l3m_data' char(39) ');']);            

        %        eval(['!gzip ' file]);
        
        %Make Daily composite
        data = single([data(:,2160:4320),data(:,1:2159)]);
		data(data==65535) = NaN;  %create land mask
        chl = base.^((slope*data)+inter);
        chl_day(:,:,w)=chl;
    else
        chl=nan(length(lat(:,1)),length(lon(1,:)));
        missing_file(q,:)=fname
        q=q+1;
    end
        %Make weekly composites
              if jdays(m)==end_week_jdays(e);
                  %fprintf('\n makind week %u \n',e)
                  chl_week=single(nanmean(chl_day,3));
                  gchl_week=biggrid(chl_week,9,25);
                  %figure(1)
                  %clf
                  %pcolor(lon,lat,log10(double(chl_week)));shading flat
                  %pmap(lon,lat,double(chl_week),'logmchl',num2str(dates(m-3)));
                  %drawnow
                  %eval(['print -dpng ' frame_path 'frame_' num2str(ff) '.png'])
                  %eval(['!convert -trim ' frame_path 'frame_' num2str(ff) '.png ' frame_path 'frame_' ...
                  %                              num2str(ff) '.png'])
                  chl_day=nan*chl_day;
                  jt=mid_week_jdays(e);
                  ct=caldates(m-3);
                  eval(['save ' save_path 'SCHL_9_W_' num2str(jt) ...
                        ' gchl_week chl_week lat lon mid_week_jdays jdays caldates jt ct glon glat']);
                  e=e+1;
                  w=1;

                  
              end
              w=w+1;
end
