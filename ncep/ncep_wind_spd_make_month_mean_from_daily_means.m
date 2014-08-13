tic
%makes monthly mean maps of NCEP/NCAR wind speed, swind speed squared and
%cubed

%define vars
years = [1999:2007];
path = '/Volumes/matlab/data/NCEP/';

days(1) = 31;
days(2) = days(1)+28;
days(3) = days(2)+31;
days(4) = days(3)+30;
days(5) = days(4)+31;
days(6) = days(5)+30;
days(7) = days(6)+31;
days(8) = days(7)+31;
days(9) = days(8)+30;
days(10) = days(9)+31;
days(11) = days(10)+30;
days(12) = days(11)+31;

%start loops
%load files
for i = years
    g = 1;
    k = 1:365;
    fname_u = ['uwnd.10m.gauss.',int2str(i),'.nc'];
    u = load_ncep_nc(path,fname_u);
    fname_v = ['vwnd.10m.gauss.',int2str(i),'.nc'];
    v = load_ncep_nc(path,fname_v);
    wind_spd=sqrt((u.^2)+(v.^2));
    wind_spd_s=wind_spd.^2;
    wind_spd_c=wind_spd.^3;
    clear u v
    fname2 = ['wind_spd_',int2str(i)];
    fname2s = ['wind_spd_squared_',int2str(i)];
    fname2c = ['wind_spd_cubed_',int2str(i)];
    
    %make daily means
%     for j = 1:4:length(wind_spd(1,1,:))
%         tmp = wind_spd(:,:,j:j+3);
%         tmps = wind_spd_s(:,:,j:j+3);
%         tmpc = wind_spd_c(:,:,j:j+3);
%         wind_spd(:,:,k(g)) = mean(tmp,3);
%         wind_spd_s(:,:,k(g)) = mean(tmps,3);
%         wind_spd_c(:,:,k(g)) = mean(tmpc,3);
%         if g==365
%             g=1;
%         end
%         g=g+1;
%     end
%    clear tmp tmps tmpc
    %make monthly means
    for p = 1:12
        if p==1
           mtmp = wind_spd(:,:,1:days(1));
           mtmps = wind_spd_s(:,:,1:days(1));
           mtmpc = wind_spd_c(:,:,1:days(1));
        else
           mtmp = wind_spd(:,:,days(p-1)+1:days(p));
           mtmps = wind_spd_s(:,:,days(p-1)+1:days(p));
           mtmpc = wind_spd_c(:,:,days(p-1)+1:days(p));
        end
        m(:,:,p) = mean(mtmp,3);
        ms(:,:,p) = mean(mtmps,3);
        mc(:,:,p) = mean(mtmpc,3);
    end
    clear wind_spd wind_spd_s wind_spd_c
    eval([fname2 '= m;']);
    eval([fname2s '= ms;']);
    eval([fname2c '= mc;']);
    clear mtmp mtmps mtmpc m ms mc
    
end

for i = 1:12
        x = cat(3,wind_spd_1999(:,:,i),wind_spd_2000(:,:,i),wind_spd_2001(:,:,i),wind_spd_2002(:,:,i),wind_spd_2003(:,:,i),wind_spd_2004(:,:,i),wind_spd_2005(:,:,i),wind_spd_2006(:,:,i));
        xs = cat(3,wind_spd_squared_1999(:,:,i),wind_spd_squared_2000(:,:,i),wind_spd_squared_2001(:,:,i),wind_spd_squared_2002(:,:,i),wind_spd_squared_2003(:,:,i),wind_spd_squared_2004(:,:,i),wind_spd_squared_2005(:,:,i),wind_spd_squared_2006(:,:,i));
        xc = cat(3,wind_spd_cubed_1999(:,:,i),wind_spd_cubed_2000(:,:,i),wind_spd_cubed_2001(:,:,i),wind_spd_cubed_2002(:,:,i),wind_spd_cubed_2003(:,:,i),wind_spd_cubed_2004(:,:,i),wind_spd_cubed_2005(:,:,i),wind_spd_cubed_2006(:,:,i));
        ncep_subset_wind_spd(:,:,i) = mean(x,3);
        ncep_subset_wind_spd_squared(:,:,i) = mean(xs,3);
        ncep_subset_wind_spd_cubed(:,:,i) = mean(xc,3);        
end

load ncep_lat_lon
clear i j years days p path fname fname2 fname2s fname2c wind_spd* wind_spd_s* wind_spd_c* g k fname_u fname_v x xs xc
toc
