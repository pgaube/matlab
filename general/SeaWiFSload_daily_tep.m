%This script will load SeaWiFS level 3
%mapped chlorophill ocean color data and
%subset into selected Lat by Lon box.
%Copyright Peter Gaube 9.20.2006

years=[1998:2005];  %selected years of data to load
days=[1:365];
numyears=length(years);
numdays=length(days);               
loN=[0:8640]/24;
lon=loN(2:2:8639);
laT=[2160:-1:-2160]/24;
lat=laT(2:2:4320);
c=find(lat>=0 & lat<=20); 
r=find(lon>=240 & lon<=290);
lat=lat(c);
lon=lon(r);
blank = nan*ones(2160,4320);
slope=.015; inter=-2; base=10;
path='/Users/gaube/Documents/NSU/APPTIV_PB/data/raw_data/chl/';    %set this path to the directory                                                               %containg the SeaWiFS data   


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
            data = eval(['hdfread(' char(39) path filename char(39) ',' char(39) 'l3m_data' char(39) ',' char(39) 'Index' char(39) ',' ' ' '{[1.0 1.0 ],[1.0 1.0 ],[2160.0 4320.0 ]}' ')']);
            data = [data(:,2160:4320),data(:,1:2159)];
            data = data(c,r);
            data = double(data); 
            data(data==255) = NaN;  %create land mask
            data = base*(slope*data)+inter; %convert data to values of mg/m^3
			data = flipdim(data,1);
			sCHL = biggrid(data);
            eval(['!bzip2 ' path filename]);
			eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/TEP/sCHL/mfiles_raw/SC' filename2 ' sCHL'])
            clear data
            toc/60
			else
			sCHL = nan*sCHL;
			eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/TEP/sCHL/mfiles_raw/SC' filename2 ' sCHL'])
            clear data
            toc/60
        end
    end
end
clear data C base inter slope LAt LOn R STEP c days fcheck filename filename2 i XRAD w k laT level loN LON numdays l numyears path r step years
