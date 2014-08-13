function MAPS=stack_maps(path,startjd,endjd,avg_over);

if avg_over>1
numdays = endjd-startjd;
weekjd = [startjd+avg_over:avg_over:endjd];
numweeks = length(weekjd);
eval(['load ' path,int2str(startjd),'.mat'])
[M,N,P]=size(sCHL);
chl = nan(M,N,avg_over);
maps = nan(M,N,numweeks);
startday = 1;
jweek = weekjd(1);
jday = startjd;
q=1;
b=1;
for p=1:numdays+1
    filename = [int2str(startjd-1+p), '.mat'];
    fcheck = [path,int2str(startjd-1+p), '.mat'];
    if exist(fcheck)
	eval(['load ' fcheck ]);
        sCHL=single(sCHL);  %only use this if you want single persision
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
                maps(:,:,q) = xbar
                q=q+1;
                b=1;
                startday = 1;
                jweek = jday+avg_over
                chl = nan(M,N,avg_over);
        end
        jday = startjd+i;
        startday = startday+1;
    end
end

else
numdays = endjd-startjd;
eval(['load ' path,int2str(startjd),'.mat'])
[M,N,P]=size(sCHL);
maps = nan(M,N,numdays);
startday = 1;
jday = startjd;
for p=1:numdays+1
    filename = [int2str(startjd-1+i), '.mat'];
    fcheck = [path,int2str(startjd-1+i), '.mat'];
    if exist(fcheck)
        eval(['load ' fcheck ]);
        sCHL=single(sCHL);  %only use this if you want single persision
        maps(:,:,p)=sCHL;
        time(p) = startjd+i;
    end
end
