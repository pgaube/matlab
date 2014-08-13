function [maps,time] = stack_maps(path,prefix,startjd,endjd,avg_over);
%check to see if length of regord is dibisable by avg_over;
    numdays = endjd-startjd;
    if rem(numdays,avg_over)~=0
        error('The number of maps must be divisable by avg_over')
    end
if avg_over>1
    numdays = endjd-startjd;
    weekjd = [startjd+avg_over:avg_over:endjd];
    numweeks = length(weekjd);
    eval(['load ' path,prefix,int2str(startjd),'.mat'])
    [M,N,P]=size(sCHL);
    chl = nan(M,N,avg_over);
    maps = nan(M,N,numweeks);
    startday = 1;
    jweek = weekjd(1);
    jday = startjd;
    q=1;
    b=1;
    for p=1:numdays+1
        filename = [prefix,int2str(startjd-1+p), '.mat'];
        fcheck = [path,prefix,int2str(startjd-1+p), '.mat'];
        if exist(fcheck)
            eval(['load ' fcheck ]);
            chl(:,:,b)=sCHL;
            b=b+1;
            switch (jday)
              case endjd;
                x = chl;
                Fx = ~isnan(x);
                Nx = sum(Fx,3);
                r = find(isnan(x));
                x(r) = 0;
                xbar = sum(x,3)./Nx;
                maps(:,:,numweeks) = xbar;
              case jweek;
                x = chl;
                Fx = ~isnan(x);
                Nx = sum(Fx,3);
                r = find(isnan(x));
                x(r) = 0;
                xbar = sum(x,3)./Nx;
                maps(:,:,q) = xbar;
                q=q+1;
                b=1;
                startday = 1;
                time(p)=jweek;
                jweek = jday+avg_over;
                chl = nan(M,N,avg_over);
            end
        jday = startjd+p;
        startday = startday+1;
        end
    end
else
    numdays = endjd-startjd;
    eval(['load ' path,prefix,int2str(startjd),'.mat'])
    [M,N,P]=size(sCHL);
    maps = nan(M,N,numdays);
    startday = 1;
    jday = startjd;
    for p=1:numdays+1
        filename = [prefix,int2str(startjd-1+p), '.mat'];
        fcheck = [path,prefix,int2str(startjd-1+p), '.mat'];
        if exist(fcheck)
            eval(['load ' fcheck ]);
            maps(:,:,p)=sCHL;
            time(p) = startjd+p;
        end
    end
end