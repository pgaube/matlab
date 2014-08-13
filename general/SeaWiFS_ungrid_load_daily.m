%This script will load SeaWiFS level 3
%mapped chlorophill ocean color data and
%subset into selected Lat by Lon box.
%This data is then compiled into a Lat
%by Lon by num of 8day weeks matix.
%Copyright Peter Gaube 2.24.2004

years=[1998];  %selected years of data to load
days=[1];
numyears=length(years);
numdays=length(days);
step=.0833;    %spacing between data 
                    %point used to create 
                    %latitude and 
                    %longitude vectors
                    %in order to subset
                    %data                   
loN=[step:step:360-step];
laT=[90-step/2:-step:-90+step/2];
c=find(laT>=-10 & laT<=10); 
r=find(loN>=0 & loN<=110);
lon=loN(r); 
lat=laT(c); %subset lat and lon to selected 

slope=.015; inter=-2; base=10;
%level=1;
path='/Users/gaube/Documents/NSU/APPTIV_PB/data/daily/Seachl/';    %set this path to the directory                                                               %containg the SeaWiFS data   
%!cd /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/Seachl/
%!bzip2 -q *
for i=1:numyears;
    for k=1:numdays;
        if days(k) < 10
            filename = ['S',int2str(years(i)),'00',int2str(days(k)),'.L3m_DAY_CHLO_9'];
            filename2 = [int2str(years(i)),'00',int2str(days(k))];
            fcheck = [path,'S',int2str(years(i)),'00',int2str(days(k)),'.L3m_DAY_CHLO_9.bz2'];
        end 
        if days(k) > 9 & days(k) < 100;
                filename = ['S',int2str(years(i)),'0',int2str(days(k)),'.L3m_DAY_CHLO_9'];
                filename2 = [int2str(years(i)),'0',int2str(days(k))];
                fcheck = [path,'S',int2str(years(i)),'0',int2str(days(k)),'.L3m_DAY_CHLO_9.bz2'];
        end
        if days(k) > 99 
             filename = ['S',int2str(years(i)),int2str(days(k)),'.L3m_DAY_CHLO_9'];
             filename2 = [int2str(years(i)),int2str(days(k))];
             fcheck = [path,'S',int2str(years(i)),int2str(days(k)),'.L3m_DAY_CHLO_9.bz2'];
        end
        if exist(fcheck)
            tic
            eval(['!bzip2 -d ' path filename '.bz2']);
            data = eval(['hdfread(' char(39) path filename char(39) ',' char(39) 'l3m_data' char(39) ',' char(39) 'Index' char(39) ',' ' ' '{[1.0 1.0 ],[1.0 1.0 ],[2048.0 4096.0 ]}' ')']);
            data = data(c,r);   %line 65 loads data using hdfread.
                                %line 66 subsets data to lat lon
                                %box defined above
            data = double(data); 
            data(data==255) = NaN;  %create land mask
            data = base*(slope*data)+inter; %convert data to values of mg/m^3
			data = flipdim(data,1);
			%sCHL = data;
			[sCHL,n] = biggrid(data);   %places SeaWiFS onto spacecal grid of 
                                                                    %of TMI
                                                                    %SST data.
            eval(['!bzip2 ' path filename]);
			eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/Seachl/mfiles_raw/SC' filename2 ' sCHL'])
			clear data
            toc/60
			else
			sCHL = nan*sCHL;
			eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/Seachl/mfiles_raw/SC' filename2 ' sCHL'])
            clear data
            toc/60
        end
    end
end
clear data C base inter slope LAt LOn R STEP c days fcheck filename filename2 i XRAD w k laT level loN LON numdays l numyears path r step years
