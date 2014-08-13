for years = [1999:2005]

%years=[1998:2001];  %selected years of data to load
days=[1:365];
numyears=length(years);
numdays=length(days);
path='/Users/gaube/Documents/NSU/APPTIV_PB/data/PAC/sCHL/mfiles_raw/';    %set this path to the directory                                                               %containg the SeaWiFS data   
%!cd /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/Seachl/mfiles
%load primer
chl=sCHL;
for i=1:numyears;
    for k=1:numdays;
        if days(k) < 10
            filename2 = ['SC',int2str(years(i)),'00',int2str(days(k)), '.mat'];
            fcheck = [path,'SC',int2str(years(i)),'00',int2str(days(k)), '.mat'];
        end 
        if days(k) > 9 & days(k) < 100;
                filename2 = ['SC',int2str(years(i)),'0',int2str(days(k)), '.mat'];
                fcheck = [path,'SC',int2str(years(i)),'0',int2str(days(k)), '.mat'];
        end
        if days(k) > 99 
             filename2 = ['SC',int2str(years(i)),int2str(days(k)), '.mat'];
             fcheck = [path,'SC',int2str(years(i)),int2str(days(k)), '.mat'];
        end
        if exist(fcheck)
			eval(['load ' path filename2 ]);
			chl=cat(3,chl,sCHL);
            clear data
        end
    end
end

eval(['save chl' int2str(years(i))]);
clear chl
end