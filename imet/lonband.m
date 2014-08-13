%loads data and take longitudinal band for lon-timeplots

path = '/Volumes/matlab/data/chl/mfiles/';

startjd = 2451850; %1.1.1998
endjd = 2453371; %12.31.2004
primer = [path 'SC' int2str(startjd) '.mat'];
eval(['load ' primer]);
m = find(lat<23 & lat>22);
band = nan(1,length(lon)+1);
time = startjd;

for p = startjd:endjd
    fcheck = [path 'SC' int2str(p) '.mat'];
    if exist(fcheck)
        eval(['load ' fcheck])
        data = sCHL(m,:);
        i = find(isnan(data));
        data(i)=0;
        tmp(1,:) = mean(data,1);
        band = cat(3,band,tmp);
        time = cat(3,time,p);
    end
end


band(band==0)=nan;
band = squeeze(band);
time=squeeze(time);
band = band';

band(1,:)=[];
time(1,:)=[];

lat=lat(m);
clear data endjd startjd fcheck filename2 lon m p path primer sCHL tmp i
        
        

