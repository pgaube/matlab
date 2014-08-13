years=[1999:2006];  %selected years of data to load
days=[1:365];
numyears=length(years);
numdays=length(days);
path2='~/Documents/NSU/APPTIV_PB/data/daily/Seachl/mfiles_raw/';    
ext = '.mat';

for i=1:numyears;
    for k=1:numdays;
        if days(k) < 10
            fcheck	= [path2, 'SC',int2str(years(i)),'00',int2str(days(k)), ext];
            fcheck2 = ['SC',int2str(years(i)),'00',int2str(days(k))];
        end 
        if days(k) > 9 & days(k) < 100;
            fcheck2 = ['SC',int2str(years(i)),'0',int2str(days(k))];
            fcheck	= [path2, 'SC',int2str(years(i)),'0',int2str(days(k)), ext];

        end
        if days(k) > 99 
            fcheck2 = ['SC',int2str(years(i)),int2str(days(k))];
            fcheck	= [path2, 'SC',int2str(years(i)),int2str(days(k)), ext];
        end
        if exist(fcheck)
                eval(['load ' fcheck]);
				sCHL = smallgrid(sCHL);
				eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/Seachl/mfiles_25km/' fcheck2 ' sCHL'])
        end
    end
end