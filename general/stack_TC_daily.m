years=[1998:2005];  %selected years of data to load
days=[1:365];
numyears=length(years);
numdays=length(days);
path='~/Documents/NSU/APPTIV_PB/data/daily/TMIvap/mfiles_clean/';    
load primer
cloud=nan*tSST;
for i=1:numyears;
    for k=1:numdays;
        if days(k) < 10
            filename2 = ['TV',int2str(years(i)),'00',int2str(days(k)), '.mat'];
            fcheck = [path,'TV',int2str(years(i)),'00',int2str(days(k)), '.mat'];
        end 
        if days(k) > 9 & days(k) < 100;
            filename2 = ['TV',int2str(years(i)),'0',int2str(days(k)), '.mat'];
            fcheck = [path,'TV',int2str(years(i)),'0',int2str(days(k)), '.mat'];
        end
        if days(k) > 99 
            filename2 = ['TV',int2str(years(i)),int2str(days(k)), '.mat'];
            fcheck = [path,'TV',int2str(years(i)),int2str(days(k)), '.mat'];
        end
        if exist(fcheck)
                eval(['load ' fcheck]);
				cloud=cat(3,cloud,tVAP);
        end
    end
end

clear chl days fcheck filename2 i k n numdays numyears path sst tSST years tCLD
