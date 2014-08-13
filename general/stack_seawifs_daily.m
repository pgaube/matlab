startjd = 2450716; %First day of data to be stacked
%numdays = 2454282-startjd;
numdays = 56;
path='/Volumes/data/chl/tropac/mat/'
chl = nan(240,300);
week = nan(240,300);
startweek = 1;
startday = 1;
for i=1:numdays
    filename = ['SC',int2str(startjd+i), '.mat'];
	fcheck = [path,'SC',int2str(startjd+i), '.mat'];
    if exist(fcheck)
		eval(['load ' fcheck ]);
        chl=cat(3,chl,sCHL);
        if startday ==1
            chl(:,:,1)=[];
        end
        if startday == 7;
            x = chl(:,:,1:7);
            Fx = ~isnan(x);
            Nx = sum(Fx,3);
            r = find(isnan(x));
            x(r) = 0;
            xbar = sum(x,3)./Nx;
            week = cat(3,week,xbar);
            startday = 1;
            chl = nan(240,300);
        end
        startday = startday+1;
    end
end

%clear fcheck filename i path 