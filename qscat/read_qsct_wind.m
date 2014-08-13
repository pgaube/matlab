%load AMSER bianary data from Schlax using read_schlax_dsc.m from larry

lat = -69.875:0.25:69.875;
lon = 0.125:0.25:359.875;
%r=find(lat>=30&lat<=50);
%c=find(lon>=230&lon<=245);
%r=find(lat>=-54&lat<=10);
%c=find(lon>=230&lon<=292);
%r=find(lat>=-40&lat<=0);
%c=find(lon>=260&lon<=290);
r=find(lat>=-20 &lat<=-5);
c=find(lon>=275 & lon<=285);
lat=lat(r);
lon=lon(c);

p=1;


path = '/Volumes/matlab/data/QuickScat/';
years = [2002:2007];

u=nan(560,1440);
v=nan(560,1440);
tau=nan(560,1440);
div=nan(560,1440);
curl=nan(560,1440);
time = nan(63,2);
U=nan(length(lat),length(lon),63);
V=nan(length(lat),length(lon),63);
TAU=nan(length(lat),length(lon),63);
DIV=nan(length(lat),length(lon),63);
CRL=nan(length(lat),length(lon),63);

for i=1:length(years);
    if years(i)==2002
        months = [6:12]
        else if years(i)==2007
            months=[1:8]
        else months = [1:12]
        end
    end
    for j=1:length(months);
    if months(j)<10
        filename=[path,'wnd.',int2str(years(i)),'0',int2str(months(j))];
    end
    if months(j)>=10
        filename=[path,'wnd.',int2str(years(i)),int2str(months(j))]; 
    end
        if exist(filename)
        [u,v,tau,div,curl] = read_schlax_wind(filename,[1 2 3 8 9]);
        u = u(r,c);
        v = v(r,c);
        tau = tau(r,c);
        div = div(r,c);
        curl = curl(r,c);
        U(:,:,p) = u;
        V(:,:,p) = v;
        TAU(:,:,p) = tau;
        DIV(:,:,p) = div;
        CRL(:,:,p) = curl;
        time(p,:) =[years(i) months(j)]; 
        p=p+1;
        else
        end
    end
end

    
