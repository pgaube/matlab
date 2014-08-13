years=[1998:2005];  %selected years of data to load
days=[1:365];
numyears=length(years);
numdays=length(days);
path1='~/Documents/NSU/APPTIV_PB/data/daily/PAC/TMIsst/mfiles_raw/';  
path2='~/Documents/NSU/APPTIV_PB/data/daily/PAC/Seachl/mfiles_raw/';    
ext = '.mat';

for i=1:numyears;
    for k=1:numdays;
        if days(k) < 10
            fcheck	= [path1, 'TT',int2str(years(i)),'00',int2str(days(k)), ext];
            fcheck1 = ['TT',int2str(years(i)),'00',int2str(days(k))];
            fcheck2 = ['SC',int2str(years(i)),'00',int2str(days(k))];
        end 
        if days(k) > 9 & days(k) < 100;
            fcheck1 = ['TT',int2str(years(i)),'0',int2str(days(k))];
            fcheck2 = ['SC',int2str(years(i)),'0',int2str(days(k))];
            fcheck	= [path1, 'TT',int2str(years(i)),'0',int2str(days(k)), ext];

        end
        if days(k) > 99 
            fcheck1 = ['TT',int2str(years(i)),int2str(days(k))];
            fcheck2 = ['SC',int2str(years(i)),int2str(days(k))];
            fcheck	= [path1, 'TT',int2str(years(i)),int2str(days(k)), ext];
        end
        if exist(fcheck)
                eval(['load ' path1, fcheck1, ext]);
                eval(['load ' path2, fcheck2, ext]);
				j = find(isnan(sCHL));
		        tSST(j) = nan;
		        i = find(isnan(tSST));
		        sCHL(i) = nan;
				eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/PAC/TMIsst/mfiles_clean/' fcheck1 ' tSST'])
        end
    end
end
