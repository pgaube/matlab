load seasons
load primer
years=[1998:2005];  %selected years of data to load
days=[winter];
numyears=length(years);
numdays=length(days);
path='/Users/gaube/Documents/NSU/APPTIV_PB/data/daily/PAC/Seachl/mfiles_raw';    %set this path to the directory                                                               %containg the SeaWiFS data   
%!cd /Users/gaube/Documents/NSU/APPTIV_PB/data/daily/Seachl/mfiles
sCHL=[];
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
			chl=cat(3,chl,tSST);
            clear data
        end
    end
end
data=chl(:,:,2:length(chl-1));
for i = 1:5:length(chl(1,1,:))
    x = chl(:,:,i:i+4);
   	Fx = ~isnan(x);
	Nx = sum(Fx,3);
	r = find(isnan(x));
	x(r) = 0;
	xbar = sum(x,3)./Nx;
	temp = cat(3,temp,xbar);
end

clear Fx i j x Nx r xbar nws t years days numyears numdays path 