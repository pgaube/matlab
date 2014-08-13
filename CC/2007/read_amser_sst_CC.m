%load AMSER bianary data from Schlax using read_schlax_dsc.m from larry

lat = -69.875:0.25:69.875;
lon = 0.125:0.25:359.875;
r=find(lat>=35&lat<=45);
c=find(lon>=232&lon<=240);
%r=find(lat>=-54&lat<=10);
%c=find(lon>=230&lon<=292);
%r=find(lat>=-40&lat<=0);
%c=find(lon>=260&lon<=290);
%r=find(lat>=-20 &lat<=-5);
%c=find(lon>=275 & lon<=285);
lat=lat(r);
lon=lon(c);

p=1;


path = '/Volumes/matlab/data/AMSER/';
years = [2002:2005];

u=nan(560,1440);
v=nan(560,1440);
tau=nan(560,1440);
div=nan(560,1440);
curl=nan(560,1440);
time = nan(63,2);
U=nan(length(lat),length(lon),50);
V=nan(length(lat),length(lon),50);
TAU=nan(length(lat),length(lon),50);
DIV=nan(length(lat),length(lon),50);
CRL=nan(length(lat),length(lon),50);

for i=1:length(years);
    if years(i)==2002
        months = [6:12]
        else if years(i)==2005
            months=[1:8]
        else months = [1:12]
        end
    end
    for j=1:length(months);
    if months(j)<10
        filename=[path,'dcs.',int2str(years(i)),'0',int2str(months(j))];
    end
    if months(j)>=10
        filename=[path,'dcs.',int2str(years(i)),int2str(months(j))]; 
    end
        if exist(filename)
        [sst,dwgt,cwgt] = read_schlax_dsc(filename,[1 3 4]);
        sst = sst(r,c);
        dwgt = dwgt(r,c);
        cwgt = cwgt(r,c);
        SST(:,:,p) = sst;
        DWGT(:,:,p) = dwgt;
        CWGT(:,:,p) = cwgt;
        time(p,:) =[years(i) months(j)];
        p=p+1;
        else
        end
    end
end
