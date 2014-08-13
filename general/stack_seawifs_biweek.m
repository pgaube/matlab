avg_over=7;

startjd = 2450716; %First day of data to be stacked
endjd = 2452494; %last day of data to be used, the number of week smust be divisable by 7

numdays = endjd-startjd;
weekjd = [startjd+avg_over:avg_over:endjd];
numweeks = length(weekjd);
path='/Volumes/matlab/data/chl/timor/';    %set this path to the directory containg the SeaWiFS data   
eval(['load ' path,int2str(startjd),',mat'])
[M,N,P]=size(sCHL)
chl = nan(M,N); %make sure these are the dim of your data, also change line 40
week = nan(M,N);
startday = 1;
jweek = weekjd(1);
jday = startjd;
for i=1:numdays+1
    filename = [int2str(startjd-1+i), '.mat'];
	fcheck = [path,int2str(startjd-1+i), '.mat'];
    if exist(fcheck)
	eval(['load ' fcheck ]);
        chl=cat(3,chl,sCHL);
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
                jweek = jday+avg_over;
                chl = nan(M,N);
        end
        jday = startjd+i;
        startday = startday+1;
    end
end

sCHL = week(:,:,2:numweeks+1);

clear fcheck filename i path Fx Nx chl fcheck filename i path r ...
    startday startweek x xbar jday jweek p weekjd week

%save tmp_stack_seawifs_biweek
