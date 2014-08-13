%place sst data on same temporal grid as
%chloro data 


load primer
STEP=.25;
LON=[.125-180:STEP:180];
LAT=[-39.875:STEP:39.875]; 
c=find(LAT>=-10 & LAT<=10); 
r=find(LON>=0 & LON<=110);
LAT=LAT(c);
LON=LON(r);

step=.0833;    %spacing between data 
                    %point used to create 
                    %latitude and 
                    %longitude vectors
                    %in order to subset
                    %data 
loN=[step:step:360-step];
laT=[90-step/2:-step:-90+step/2];
C=find(laT>=-10 & laT<=10); 
R=find(loN>=0 & loN<=110);
lon=loN(R); 
lat=laT(C); %subset lat and lon to selected 

days=[1:31];
months=[1:12];
years=[1998];
numdays=length(days);
nummonths=length(months);
numyears=length(years);
l = 1;
p = 1;
q = 50;
sst = [];
intmat = [];
slope=.015; inter=-2; base=10;
path='/Users/gaube/Documents/NSU/APPTIV_PB/data/daily/TMIsst/';
g='.gz';
cd /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/TMIsst/
!gzip -q *
cd /Users/gaube/Documents/NSU/APPTIV_PB/APPTIV_matlab/

tic
for i=1:numyears;
    for j=1:nummonths;
        for k=1:numdays;
            fday = julian(months(j),days(k),years(i));
            if days(k)<10 & months(j)<10
                filename=[int2str(years(i)),'0',int2str(months(j)),'0',int2str(days(k)),'tm'];
                fcheck=[path,int2str(years(i)),'0',int2str(months(j)),'0',int2str(days(k)),'tm.gz'];
            end
           
			if days(k)>=10 & months(j)<10
                filename=[int2str(years(i)),'0',int2str(months(j)),int2str(days(k)),'tm'];
                fcheck=[path,int2str(years(i)),'0',int2str(months(j)),int2str(days(k)),'tm.gz'];
            end
            
			if days(k)<10 & months(j)>=10
                filename=[int2str(years(i)),int2str(months(j)),'0',int2str(days(k)),'tm'];
                fcheck=[path,int2str(years(i)),int2str(months(j)),'0',int2str(days(k)),'tm.gz'];
            end
            
			if days(k)>=10 & months(j)>=10
                filename=[int2str(years(i)),int2str(months(j)),int2str(days(k)),'tm'];
                fcheck=[path,int2str(years(i)),int2str(months(j)),int2str(days(k)),'tm.gz'];
            end
					
			if 	fday < 10
				filename2 = [int2str(years(i)),'00',int2str(fday)];
				filename3 = ['S',int2str(years(i)),'00',int2str(fday),'.L3m_DAY_CHLO_9'];
			end 
			if 	fday > 9 & days(k) < 100;
				filename2 = [int2str(years(i)),'0',int2str(fday)];
				filename3 = ['S',int2str(years(i)),'0',int2str(fday),'.L3m_DAY_CHLO_9'];
			end
			if fday > 99 
				filename2 = [int2str(years(i)),int2str(fday)];
				filename3 = ['S',int2str(years(i)),int2str(fday),'.L3m_DAY_CHLO_9'];
			end
			
            if exist(fcheck);
                eval(['!gunzip ' fcheck]);
                eval(['[gmt,sst,wind11,wind37,vapor] = rdtmi(' filename(1:4) ',' filename(5:6) ',' filename(7:8) ');']);
                clear gmt sst wind11 wind37;
                sst=vapor(r,c,1,:);
                sst(sst==255)=NaN; 
                sst(sst==254)=NaN;
                sst(sst==253)=NaN; 
                sst(sst==252)=NaN;
                sst(sst==251)=NaN;
                sst1=sst(:,:,1,1);
                sst2=sst(:,:,1,2);
                sst1=sst1';
                sst2=sst2';
                eval(['!gzip ' path filename]);
                intmat(:,:,1)=sst1; 
                intmat(:,:,2)=sst2;
                    for d=1:length(LAT);
                        for s=1:length(LON);
                            I=find(~isnan(intmat(d,s,:)));
                                if length(I)>0;
                                    sstm(d,s)=mean(intmat(d,s,I));
                                else sstm(d,s)=NaN;
                                end
                        end
                    end
				 [tCLD,n]=biggrid(sstm);
                 eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/TMIcloud/mfile/TC' filename2 ' tCLD n']);
                 toc/60
                 else
				 tCLD = nan*tSST;
                 eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/TMIcloud/mfile/TC' filename2 ' tCLD']);
           		 clear sst
				 toc/60
            end
        end
    end
end
toc/60