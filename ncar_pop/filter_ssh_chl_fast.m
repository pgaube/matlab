clear all
dir_list=dir(['/glade/u/home/pgaube/mat/POP_BEC_JAN_15_2014_*']);

slat=[-69.875:.25:69.875];
slon=[.125:.25:359.875];
[slon,slat]=meshgrid(slon,slat);

for m=1:length(dir_list)
    fname=['/glade/u/home/pgaube/mat/',getfield(dir_list(m),'name')];
    load(fname,'tlon','tlat','chl','ssh','jdays')
    

    
    tic
    lp=smooth2d_loess(ssh,tlon(1,:),tlat(:,1),6,6,tlon(1,:),tlat(:,1));
    hp21_chl=chl-lp;
    toc
    
    tic
    lp=smooth2d_loess(chl,tlon(1,:),tlat(:,1),6,6,tlon(1,:),tlat(:,1));
    hp66_chl=chl-lp;
    toc
    
    save(fname,'-append','hp*')
    clear lp hp* sm
    
end
