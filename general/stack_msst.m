

load_path = '/Volumes/matlab/matlab/vocals/modis_sst_4km/'
load([load_path,'SST_4_W_2454321'])

sst_week=nan(length(grid_lat),length(grid_lon),length(mid_week_jdays));
filtered_sst=sst_week;

    for m=1:length(mid_week_jdays)
        fname = [load_path 'SST_4_W_' num2str(mid_week_jdays(m)) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
        load(fname,'sst_grid', 'ls_filtered_sst')
        sst_week(:,:,m)=sst_grid;
        filtered_sst(:,:,m)=ls_filtered_sst;
    end    
        
clear caldates ct filtered_sst_week fname jdays jt lat lon load_path m ls_filtered_sst sst_grid



