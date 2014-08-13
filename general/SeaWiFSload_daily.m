%This script will load SeaWiFS level 3
%mapped chlorophill ocean color data and
%subset into selected Lat by Lon box.
%Copyright Peter Gaube 5/25/2008

years=[2008];  %selected years of data to load
days=[1:365];
numyears=length(years);
numdays=length(days);               
loN=[0:8640]/24;
lon=loN(2:2:8639);
laT=[2160:-1:-2160]/24;
lat=laT(2:2:4320);
c=find(lat>=-15 & lat<=15); 
r=find(lon>=120 & lon<=290);
lat=lat(c);
lon=lon(r);
blank = nan*ones(2160,4320);
slope=5.8138e-5; inter=-2; base=10;
path='/Volumes/matlab/data/chl/hdf/';    %set this path to the directory
                                         %containg the SeaWiFS data   


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
            [month,day,year] = jul2date(days(k),years(i));
            jday = date2jd(year,month,day)+.5;
            jday=int2str(jday)
            eval(['!bzip2 -d ' path filename '.bz2']);
            data = eval(['hdfread(' char(39) path filename char(39) ',' char(39) 'l3m_data' ...
                         char(39) ',' char(39) 'Index' char(39) ',' ' ' '{[1.0 1.0 ],[1.0 1.0 ],[2160.0 4320.0 ]}' ')']);
            data = [data(:,2160:4320),data(:,1:2159)];
            data = data(c,r);
            data = double(data); 
            data(data==65535) = NaN;  %create land mask
            data = base.^((slope*data)+inter); %convert data to values of mg/m^3
            %data = flipdim(data,1);
            sCHL=data;
            %sCHL = biggrid(data);
            eval(['!bzip2 ' path filename]);
	    eval(['save /Volumes/matlab/data/chl/tropac/mat/SC' jday ...
                  ' sCHL lat lon filename2'])
            clear data
            
            else
		sCHL = nan*sCHL;
                eval(['save /Volumes/matlab/data/chl/tropac/mat/NAN' ...
                      filename2 ' sCHL lat lon filename2'])
            clear data
           end
    end
end
clear data C base inter slope LAt LOn R STEP c days fcheck filename filename2 i XRAD w k laT level loN LON numdays l numyears path r step years
