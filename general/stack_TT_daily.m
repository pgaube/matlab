

years=[1998];  %selected years of data to load
days=[222:226];
numyears=length(years);
numdays=length(days);
path='/Users/gaube/Documents/NSU/APPTIV_PB/data/PAC/TMIsst/mfiles_raw_25km/';    
%load primer
sst = nan*tSST;
for i=1:numyears;
    for k=1:numdays;
        if days(k) < 10
            filename2 = ['TT',int2str(years(i)),'00',int2str(days(k)), '.mat'];
            fcheck = [path,'TT',int2str(years(i)),'00',int2str(days(k)), '.mat'];
        end 
        if days(k) > 9 & days(k) < 100;
            filename2 = ['TT',int2str(years(i)),'0',int2str(days(k)), '.mat'];
            fcheck = [path,'TT',int2str(years(i)),'0',int2str(days(k)), '.mat'];
        end
        if days(k) > 99 
            filename2 = ['TT',int2str(years(i)),int2str(days(k)), '.mat'];
            fcheck = [path,'TT',int2str(years(i)),int2str(days(k)), '.mat'];
        end
        if exist(fcheck)
                eval(['load ' fcheck]);
				sst=cat(3,sst,tSST);
        end
    end
end

