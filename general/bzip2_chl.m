%loads data and take longitudinal band for lon-timeplots

path = '/Users/gaube/Documents/OSU/data/chl/mfiles/';

startjd = 2450815; %1.1.1998
endjd = 2453371; %12.31.2004


for p = startjd:endjd
    fcheck = [path 'SC' int2str(p) '.mat'];
    if exist(fcheck)
        eval(['!bzip2 ' fcheck])
    end
end


        

