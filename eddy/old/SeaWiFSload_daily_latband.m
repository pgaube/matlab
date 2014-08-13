%This script will load SeaWiFS level 3
%mapped chlorophill ocean color data and
%subset into selected Lat by Lon box.
%Copyright Peter 7/17/07

years=[1998];  %selected years of data to load
days=[1:365];
numyears=length(years);
numdays=length(days);               
loN=[0:8640]/24;
lon=loN(2:2:8639);
laT=[2160:-1:-2160]/24;
lat=laT(2:2:4320);
r = find(lat>-23 & lat <-22);
c = find(lon>0 & lon< 365);
lat=lat(r);
lon = lon(c);
sCHL=nan(length(lat),length(lon));
blank = nan*ones(2160,4320);
slope=5.8138e-05; inter=-2;
path='/Users/gaube/Documents/OSU/data/chl/hdf/';    %set this path to the directory containg the SeaWiFS data   
band = nan(1,length(lon));
t = nan(1,2);
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
            time=cat(2,years(i),days(k));
            data = eval(['hdfread(' char(39) path filename char(39) ',' char(39) 'l3m_data' char(39) ',' char(39) 'Index' char(39) ',' ' ' '{[1.0 1.0 ],[1.0 1.0 ],[2160.0 4320.0 ]}' ')']);
            data = double(data); 
            data(data==65535) = NaN;  %create land mask
            data = 10.^((slope*data)+inter); %convert data to values of mg/m^3
            data = flipdim(data,1);
            sCHL = data(r,c);
            flag = find(isnan(sCHL));
            sCHL(flag) = 0;
            sCHL = sum(sCHL,1)./length(lat);
            band = cat(1,band,sCHL);
            t = cat(1,t,time);
            clear data sCHL
        end
    end
end

t(1,:)=[];
band(1,:)=[];
band(band==0)=nan;
clear data C base inter slope LAt LOn R STEP c days fcheck filename filename2 i XRAD w k laT level loN LON numdays l numyears path r step years blank day flag jday month year ans
