%loads data and take longitudinal band for lon-timeplots

path = '/Volumes/matlab/data/chl/hdf/';

startjd = 2451850-200; %11.2.2000
endjd = startjd+20;%2454027; %10.19.2006   
loN=[0:8640]/24;
lon=loN(2:2:8639);
laT=[2160:-1:-2160]/24;
lat=laT(2:2:4320);
slope=5.8138e-05; inter=-2;
m = find(lat==-20.1250);
n = find(lon==85.1250);
point = nan(length(lat),length(lon));
time = nan;

tic
for p = startjd:endjd
    [year, month, day] = jd2jdate(p);
    jday = julian(month,day,year,year);
    if jday < 10
            fcheck = [path, 'S',int2str(year),'00',int2str(jday),'.L3m_DAY_CHLO_9'];
        end 
        if jday > 9 & jday < 100;
             fcheck = [path, 'S',int2str(year),'0',int2str(jday),'.L3m_DAY_CHLO_9'];
        end
        if jday > 99 
             fcheck = [path, 'S',int2str(year),int2str(jday),'.L3m_DAY_CHLO_9'];
        end
            if exist(fcheck)
                fcheck
                data = eval(['hdfread(' char(39) fcheck char(39) ',' char(39) 'l3m_data' char(39) ',' char(39) 'Index' char(39) ',' ' ' '{[1.0 1.0 ],[1.0 1.0 ],[2160.0 4320.0 ]}' ')']);
                data = [data(:,2160:4320),data(:,1:2159)];
                %data = flipdim(data,1);
                %data = data(m,n);
                data = double(data);
                data(data==65535) = NaN;  %create land mask
                data = 10.^((slope*data)+inter); %convert data to values of mg/m^3
                point = cat(3,point,data);
                time = cat(2,time,p);
            end
end
point(1)=[];
time(1)=[];
toc

        
        

