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
ro = 12.23; %Density in [g/cm**3]*10^4

%Alocate space to vairables to save time
wind_spd = nan(94,192,1460);
wind_str = nan(94,192,1460);
u_str = nan(94,192,1460);
v_str = nan(94,192,1460);
cn = nan(94,192,1460);


%start loops
%load files
for i = years
    g = 1;
    k = 1:365;
    fname_u = ['uwnd.10m.gauss.',int2str(i),'.nc'];
    u = load_ncep_nc(path,fname_u);
    fname_v = ['vwnd.10m.gauss.',int2str(i),'.nc'];
    v = load_ncep_nc(path,fname_v);
    wind_spd=sqrt(u.*u+v.*v);
    for m = 1:length(wind_spd(:,1,1))
        for n = 1:length(wind_spd(1,:,1))
            for p = 1:length(wind_spd(1,1,:))
                if wind_spd(m,n,p) > 10
                    cn(m,n,p) = (0.49 + 0.065*wind_spd(m,n,p))*1e-3;
                else if wind_spd(m,n,p) >= 3 & wind_spd(m,n,p) <= 10
                        cn(m,n,p) = 1.14e-3;
                    else if wind_spd(m,n,p) >= 1 & wind_spd(m,n,p) < 3
                            cn(m,n,p) = (0.62 + 1.56/wind_spd(m,n,p))*1e-3;
                        else cn(m,n,p) = 2.18e-3;
                        end
                    end
                end
            end
        end
    end
    wind_str = (ro.*cn.*(wind_spd.^2)).*.1;
    u_str = ro.*cn.*wind_spd.*u.*.1;
    v_str = ro.*cn.*wind_spd.*v.*.1;
    clear cn
    clear u v
    fname_spd = ['wind_spd_',int2str(i)];
    fname_str = ['wind_str_',int2str(i)];
    fname_u_str = ['wind_u_str_',int2str(i)];
    fname_v_str = ['wind_v_str_',int2str(i)];
    
    dtmp = nan(94,192,365);
    dtmps = nan(94,192,365);
    dtmpsu = nan(94,192,365);
    dtmpsv = nan(94,192,365);

    %make daily means
    for j = 1:4:length(wind_spd(1,1,:))
        tmp = wind_spd(:,:,j:j+3);
        tmps = wind_str(:,:,j:j+3);
        tmpsu = u_str(:,:,j:j+3);
        tmpsv = v_str(:,:,j:j+3);
        dtmp(:,:,k(g)) = mean(tmp,3);
        dtmps(:,:,k(g)) = mean(tmps,3);
        dtmpsu(:,:,k(g)) = mean(tmpsu,3);
        dtmpsv(:,:,k(g)) = mean(tmpsv,3);
        if g==365
            g=1;
        end
        g=g+1;
    end
    clear tmp tmpsu tmpsv wind_str u_str v_str
    
    M = nan(94,192,12);
    Ms = nan(94,192,12);
    Msu = nan(94,192,12);
    Msv = nan(94,192,12);

    %make monthly means
    for p = 1:12
        if p==1
           mtmp = dtmp(:,:,1:days(1));
           mtmps = dtmps(:,:,1:days(1));
           mtmpsu = dtmpsu(:,:,1:days(1));
           mtmpsv = dtmpsv(:,:,1:days(1));
        else
           mtmp = dtmp(:,:,days(p-1)+1:days(p));
           mtmps = dtmps(:,:,days(p-1)+1:days(p));
           mtmpsu = dtmpsu(:,:,days(p-1)+1:days(p));
           mtmpsv = dtmpsv(:,:,days(p-1)+1:days(p));
        end
        M(:,:,p) = mean(mtmp,3);
        Ms(:,:,p) = mean(mtmps,3);
        Msu(:,:,p) = mean(mtmpsu,3);
        Msv(:,:,p) = mean(mtmpsv,3);
    end
    clear dtmp  dtmpsu dtmpsv
    eval([fname_spd '= M;']);
    eval([fname_str '= Ms;']);
    eval([fname_u_str '= Msu;']);
    eval([fname_v_str '= Msv;']);
    clear mtmp mtmps M Ms Msu Msv
    
end

%for i = 1:12
%        x = cat(3,wind_spd_1999(:,:,i),wind_spd_2000(:,:,i),wind_spd_2001(:,:,i),wind_spd_2002(:,:,i),wind_spd_2003(:,:,i),wind_spd_2004(:,:,i),wind_spd_2005(:,:,i),wind_spd_2006(:,:,i));
%        ncep_subset_wind_spd(:,:,i) = mean(x,3);
%end
load ncep_lat_lon
clear i j years days p path fname fname2 fname2s fname2c wind_spd_s wind_spd_c g k fname_u ans fname_spd fname_str fname_u_str fname_v_str m mtmpsu mtmpsv fname_v gh i j k p days fname2 fname_u fname3 fname_v n ro dtmps cn Ms M 

wind_str_jan_feb_2003=wind_str_2003(:,:,1:2);
wind_v_str_jan_feb_2003=wind_v_str_2003(:,:,1:2);
wind_u_str_jan_feb_2003=wind_u_str_2003(:,:,1:2);
wind_str_jan_feb_2003=mean(wind_str_jan_feb_2003,3);
wind_u_str_jan_feb_2003=mean(wind_u_str_jan_feb_2003,3);
wind_v_str_jan_feb_2003=mean(wind_v_str_jan_feb_2003,3);

