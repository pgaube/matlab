
load_path = '/Volumes/matlab/matlab/timor/modis_sst_4km/'
load([load_path,'SST_4_W_2454321'])

max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));

%make grid lat lon
j=[1:640];
i=[1:1440];
dy=.25;
dx=.25;
lat= -80+dy/2+(j*dy);
lon= 0+dx/2+(i*dx);

%create indecies and subset lat lon to grid_lon grid_lat
r=find(lat>=min_lat & lat<=max_lat);
c=find(lon>=min_lon & lon<=max_lon);
grid_lat=lat(r);
grid_lon=lon(c);



    for m=1:length(mid_week_jdays)
        fname = [load_path 'SST_4_W_' num2str(mid_week_jdays(m)) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
        load(fname, 'sst_week')
        sst_grid = flipud(biggrid(sst_week,4,25));
        lp = smooth2d_f(sst_grid,20,10);
        ls_filtered_sst=sst_grid-lp;
        eval(['save ', fname, ' -append sst_grid grid_lon grid_lat ls_filtered_sst']);
    end    
        


