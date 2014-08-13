years=[1998];  %selected years of data to load
days=[1:10];
numyears=length(years);
numdays=length(days);               
loN=[0:8640]/24;
lon=loN(2:2:8639);
laT=[2160:-1:-2160]/24;
lat=laT(2:2:4320);
c=find(lat>=-10 & lat<=10); 
r=find(lon>=180 & lon<=290);


blank = nan*ones(2160,4320);
path='/Users/gaube/Documents/NSU/APPTIV_PB/data/daily/Seachl/mfile_raw';    %set this path to the directory                                                               %containg the SeaWiFS data   

for i=1:numyears;
    for k=1:numdays;
        if days(k) < 10
            filename = ['S',int2str(years(i)),'00',int2str(days(k)),'.L3m_DAY_CHLO_9'];
            filename2 = [int2str(years(i)),'00',int2str(days(k))];
            fcheck = [path,'S',int2str(years(i)),'00',int2str(days(k)),'.L3m_DAY_CHLO_9.bz2'];
        end 
        if days(k) > 9 & days(k) < 100;
                filename = ['S',int2str(years(i)),'0',int2str(days(k)),'.L3m_DAY_CHLO_9'];
                filename2 = [int2str(years(i)),'0',int2str(days(k))];
                fcheck = [path,'S',int2str(years(i)),'0',int2str(days(k)),'.L3m_DAY_CHLO_9.bz2'];
        end
        if days(k) > 99 
             filename = ['S',int2str(years(i)),int2str(days(k)),'.L3m_DAY_CHLO_9'];
             filename2 = [int2str(years(i)),int2str(days(k))];
             fcheck = [path,'S',int2str(years(i)),int2str(days(k)),'.L3m_DAY_CHLO_9.bz2'];
        end
        if exist(fcheck)
            tic
            eval(['!bzip2 -d ' path filename2]);
            lon=loN(r); 
			lat=laT(c);
			sCHL = sCHL(c,r);
            eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/Seachl/mfiles/SC' filename2 ' sCHL lat lon'])
            toc/60
			else
			sCHL = nan*sCHL;
			eval(['save /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/Seachl/mfiles/SC' filename2 ' sCHL'])
			clear data
            toc/60
        end
    end
end
clear data C base inter slope LAt LOn R STEP c days fcheck filename filename2 i XRAD w k laT level loN LON numdays l numyears path r step years
