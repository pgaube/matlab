%place sst data on same temporal grid as
%chloro data 


STEP=.25;
LON=[0:1439]/4+0.125;
LAT=[-39.875:STEP:39.875]; 
c=find(LAT>=-9.875 & LAT<=9.875); 
r=find(LON>=180.125 & LON<=289.875);
lat=LAT(c);
lon=LON(r);

days=[1];
months=[1];
years=[1998];
numdays=length(days);
nummonths=length(months);
numyears=length(years);

path = '/Users/gaube/Documents/NSU/APPTIV_PB/data/daily/TMIsst/mfile_raw/';


tic
for i=1:numyears;
    for j=1:nummonths;
        for k=1:numdays;
            fday = julian(months(j),days(k),years(i));
			if 	fday < 10
				filename2 = [int2str(years(i)),'00',int2str(fday)];
				fcheck = [path,'TT',int2str(years(i)),'00',int2str(fday),'.mat'];

			end 
			if 	fday > 9 & days(k) < 100;
				filename2 = [int2str(years(i)),'0',int2str(fday)];
				fcheck = [path,'TT',int2str(years(i)),'0',int2str(fday),'.mat'];

			end
			if fday > 99 
				filename2 = [int2str(years(i)),int2str(fday)];
				fcheck = [path,'TT',int2str(years(i)),int2str(fday),'.mat'];

			end
			
            if exist(fcheck)
                eval(['load ' path 'TT' filename2]);
                 tSST=tSST(c,r);
                 eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/TMIsst/mfile/TT' filename2 ' tSST']);
                 toc/60
                 else
				 tSST = nan*tSST;
                 eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/TMIsst/mfile/TT' filename2 ' tSST']);
				 toc/60
            end
        end
    end
end
toc/60