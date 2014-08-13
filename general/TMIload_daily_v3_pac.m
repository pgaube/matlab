%place sst data on same temporal grid as
%chloro data 


STEP=.25;
lon=[0:1439]/4+0.125;
lat=[-39.875:STEP:39.875]; 
c=find(lat>=-14.875 & lat<=14.875); 
r=find(lon>=120.125 & lon<=289.875);
lat=lat(c);
lon=lon(r);
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
blank = nan*ones(320,1440);
path='/Users/gaube/Documents/NSU/APPTIV_PB/data/raw_data/sst/';
g='.gz';
cd /Users/gaube/Documents/NSU/APPTIV_PB/data/raw_data/sst
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
			end 
			if 	fday > 9 & days(k) < 100;
				filename2 = [int2str(years(i)),'0',int2str(fday)];
			end
			if fday > 99 
				filename2 = [int2str(years(i)),int2str(fday)];
			end
			
            if exist(fcheck)
            	tic
                eval(['!gunzip ' fcheck]);
                eval(['[gmt,sst] = rdtmi(' filename(1:4) ',' filename(5:6) ',' filename(7:8) ');']);
                clear gmt;
                sst = sst(r,c,1,:);
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
                    for d=1:length(lat);
                        for s=1:length(lon);
                            I=find(~isnan(intmat(d,s,:)));
                                if length(I)>0;
                                    sstm(d,s)=mean(intmat(d,s,I));
                                else sstm(d,s)=NaN;
                                end
                        end
                    end
                    
                 tSST=sstm;   
                 %tSST=smallgrid(sstm);
                 eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/PAC/TMIsst/mfiles_raw_25km/TT' filename2 ' tSST']);
                 toc/60
                 else
				 tSST = nan*tSST;
           		 eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/PAC/TMIsst/mfiles_raw_25km/TT' filename2 ' tSST']);
           		 clear sst
				 toc/60
            end
        end
    end
end
