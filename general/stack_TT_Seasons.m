load seasons
load primer
years=[1998:2005];  %selected years of data to load
days=fall;
numyears=length(years);
numdays=length(days);
path='/Users/gaube/Documents/NSU/APPTIV_PB/data/daily/PAC/Seachl/mfiles_raw/';    
load primer
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
                eval(['load ' fcheck]);
				sst=cat(3,sst,sCHL);
        end
    end
end

tSST=nan*sst(:,:,1);
for i = 1:5:length(sst(1,1,:))
    x = sst(:,:,i:i+4);
   	Fx = ~isnan(x);
	Nx = sum(Fx,3);
	r = find(isnan(x));
	x(r) = 0;
	xbar = sum(x,3)./Nx;
	tSST = cat(3,tSST,xbar);
end

clear Fx i j x Nx r xbar nws t