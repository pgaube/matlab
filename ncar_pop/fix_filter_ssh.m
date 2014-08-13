clear all
dir_list=dir(['/Volumes/ys-home/mat/POP_BEC_JAN_15_2014_*']);

slat=[-69.875:.25:69.875];
slon=[.125:.25:359.875];
[slon,slat]=meshgrid(slon,slat);

for m=1:length(dir_list)
    fname=['/Volumes/ys-home/mat/',getfield(dir_list(m),'name')];
    load(fname,'hp21_chl')
    m
   
    
    hp66_ssh=hp21_chl;
    
    save(fname,'-append','hp66_ssh')
    clear lp hp* sm
    
end
