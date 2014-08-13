%makes monthly mean maps of NCEP/NCAR wind speed, swind speed squared and
%cubed

%define vars
years = [2003];
path = '/Volumes/matlab/data/NCEP/';

%set up constants
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

%Alocate space to vairables to save time
sst = nan(94,192,1460);




%start loops
%load files
for i = years
    g = 1;
    k = 1:365;
    fname_nc = ['skt.sfc.gauss.',int2str(i),'.nc'];
    sst = load_ncep_nc(path,fname_nc);
    fname = ['ncep_ncar_sst_',int2str(i)];
    dtmp = nan(94,192,365);
    
    %make daily means
    for j = 1:4:length(sst(1,1,:))
        tmp = sst(:,:,j:j+3);
        dtmp(:,:,k(g)) = mean(tmp,3);
        if g==365
            g=1;
        end
        g=g+1;
    end
    clear tmp sst
    
    M = nan(94,192,12);
    

    %make monthly means
    for p = 1:12
        if p==1
           mtmp = dtmp(:,:,1:days(1));
        else
           mtmp = dtmp(:,:,days(p-1)+1:days(p));
        end
        M(:,:,p) = mean(mtmp,3);
    end
    clear dtmp  
    eval([fname '= M;']);
    clear mtmp M 
    
end

%for i = 1:12
%        x = cat(3,wind_spd_1999(:,:,i),wind_spd_2000(:,:,i),wind_spd_2001(:,:,i),wind_spd_2002(:,:,i),wind_spd_2003(:,:,i),wind_spd_2004(:,:,i),wind_spd_2005(:,:,i),wind_spd_2006(:,:,i));
%        ncep_subset_wind_spd(:,:,i) = mean(x,3);
%end
load ncep_lat_lon
clear i j years days p path fname fname2 fname2s fname2c wind_spd_s wind_spd_c g k fname_u ans fname_spd fname_str fname_u_str fname_v_str m mtmpsu mtmpsv fname_v gh i j k p days fname2 fname_u fname3 fname_v n ro dtmps cn Ms M 

sst_jan_feb_2003=ncep_ncar_sst_2003(:,:,1:2);
sst_jan_feb_2003=mean(sst_jan_feb_2003,3);

