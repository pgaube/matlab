path = '/Volumes/matlab/data/chl/mat/';

startjd = 2454028;
endjd = 2454101;

for p = startjd:endjd
    fcheck = [path 'SC' int2str(p) '.mat']
    eval(['!bzip2 ' fcheck]);
end