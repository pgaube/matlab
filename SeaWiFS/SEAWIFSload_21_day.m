%loads SeaWiFS CHL data
clear all
close all



%Set range of dates
startyear = 1998;
startmonth = 01;
startday = 07;
endyear= 2008;
endmonth = 12;
endday = 31;

%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:7:endjd];





%Set path and region
path = '/home/mckenzie/data2/data/seawifs/hdf/';
save_path = '/home/mckenzie/data2/data/seawifs/mat/';

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
chl_day=nan(length(lat(:,1)),length(lon(1,:)),21);
q=1;

for m=1:length(jdays)
    for n=-10:10
		[yea,mon,day]=jd2jdate(jdays(m)+n);
    	date=(yea*1000)+julian(mon,day,yea,yea);
    	fprintf('proccesing_file %u \n',date)
    	fname = ['S' num2str(date) '.L3m_DAY_CHL_chlor_a_9km'];
   	    fnameg = ['S' num2str(date) '.L3m_DAY_CHL_chlor_a_9km.bz2'];
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
        	data = single([data(:,2161:4320),data(:,1:2160)]);
			data(data<-3000) = NaN;  %create land mask
       	    chl = data;
        	chl_day(:,:,n+12)=chl;
    	else
        	missing_file(q,:)=fname
        	q=q+1;
    	end
        %Make weekly composites
        if n==10
           tmp=single(nanmean(log10(chl_day),3));
           chl_week=10.^tmp;
           gtmp=biggrid(tmp,9,25);
           gchl_week=10.^gtmp;
           %figure(1)
           %clf
           %pmap(lon,lat,double(chl_week),'logmchl');
           %drawnow
           chl_day=nan*chl_day;
           eval(['save ' save_path 'SCHL_9_21_' num2str(jdays(m)) ...
                 ' gchl_week chl_week lat lon jdays glon glat']);

        end
    end    
end
