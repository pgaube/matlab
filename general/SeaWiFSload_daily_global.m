%This script will load SeaWiFS level 3
%mapped chlorophill ocean color data and
%subset into selected Lat by Lon box.
%Copyright Peter 7/17/07

years=[2006];  %selected years of data to load
days=[315:365];
numyears=length(years);
numdays=length(days);               
loN=[0:8640]/24;
lon=loN(2:2:8639);
laT=[2160:-1:-2160]/24;
lat=laT(2:2:4320);
sCHL=nan(length(lat),length(lon));
blank = nan*ones(2160,4320);
slope=5.8138e-05; inter=-2;
path='/Volumes/matlab/data/chl/hdf/';    %set this path to the directory containg the SeaWiFS data   
LON=[0+.25:.5:360-.25];
LAT=[-90+.25:.5:90-.25];
for i=1:numyears;
    for k=1:numdays;
        if days(k) < 10
            filename = ['S',int2str(years(i)),'00',int2str(days(k)),'.L3m_DAY_CHLO_9'];
            filename2 = [int2str(years(i)),'00',int2str(days(k))];
            fcheck = [path,'S',int2str(years(i)),'00',int2str(days(k)),'.L3m_DAY_CHLO_9'];
        end 
        if days(k) > 9 & days(k) < 100;
                filename = ['S',int2str(years(i)),'0',int2str(days(k)),'.L3m_DAY_CHLO_9'];
                filename2 = [int2str(years(i)),'0',int2str(days(k))];
                fcheck = [path,'S',int2str(years(i)),'0',int2str(days(k)),'.L3m_DAY_CHLO_9'];
        end
        if days(k) > 99 
             filename = ['S',int2str(years(i)),int2str(days(k)),'.L3m_DAY_CHLO_9'];
             filename2 = [int2str(years(i)),int2str(days(k))];
             fcheck = [path,'S',int2str(years(i)),int2str(days(k)),'.L3m_DAY_CHLO_9'];
        end
        if exist(fcheck)
            filename2
            tic
            [month,day,year] = jul2date(days(k),years(i));
            jday = date2jd(year,month,day)+.5;
            jday=int2str(jday)
            %eval(['!bzip2 -d ' path filename '.bz2']);
            data = eval(['hdfread(' char(39) path filename char(39) ',' char(39) 'l3m_data' char(39) ',' char(39) 'Index' char(39) ',' ' ' '{[1.0 1.0 ],[1.0 1.0 ],[2160.0 4320.0 ]}' ')']);
            data = [data(:,2160:4320),data(:,1:2159)];
            data = double(data); 
            data(data==65535) = NaN;  %create land mask
            data = 10.^((slope*data)+inter); %convert data to values of mg/m^3
            data = flipdim(data,1);
            sCHL=data;
            %sCHL = biggrid(data);
            %eval(['!bzip2 ' path filename]);
            eval(['save /Volumes/matlab/data/chl/mat/SC' jday ' sCHL lat lon filename2'])
            %eval(['!bzip2 /Users/gaube/Documents/OSU/data/chl/mfiles/SC' jday '.mat'])
            clear data
            toc/60
        end
    end
end
clear data C base inter slope LAt LOn R STEP c days fcheck filename filename2 i XRAD w k laT level loN LON numdays l numyears path r step years
