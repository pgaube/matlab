startjd = 2450716; %First day of data to be stacked
endjd = startjd+70%2454279; %last day of data to be used, the number of week smust be divisable by 7
numdays = endjd-startjd;
weekjd = [startjd+7:7:endjd];
numweeks = length(weekjd);
path='/Users/admin/Documents/OSU/data/chl/mfiles/';    %set this path to the directory containg the SeaWiFS data   
chl = nan(240,300);
week = nan(240,300);
startday = 1;
jweek = weekjd(1);
jday = startjd;
for i=1:numdays+1
    filename = ['SC',int2str(startjd-1+i), '.mat'];
	fcheck = [path,'SC',int2str(startjd-1+i), '.mat'];
    if exist(fcheck)
	eval(['load ' fcheck ]);
        chl=cat(3,chl,sCHL);
        if startday ==1
            chl(:,:,1)=[];
        end
        switch (jday)
            case endjd;
                x = chl;
                Fx = ~isnan(x);
                Nx = sum(Fx,3);
                r = find(isnan(x));
                x(r) = 0;
                xbar = sum(x,3)./Nx;
                week = cat(3,week,xbar);
            case jweek;
                x = chl;
                Fx = ~isnan(x);
                Nx = sum(Fx,3);
                r = find(isnan(x));
                x(r) = 0;
                xbar = sum(x,3)./Nx;
                week = cat(3,week,xbar);
                startday = 1;
                jweek = jday+7;
                chl = nan(240,300);
        end
        jday = startjd+i;
        startday = startday+1;
    end
end

sCHL = week(:,:,2:numweeks+1);

clear fcheck filename i path Fx Nx chl fcheck filename i path r ...
    startday startweek x xbar jday jweek p weekjd week

%save tmp_stack_seawifs_week
