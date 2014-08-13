global M
global N

%load last data record prior to running script


lat=single(lat);
lon=single(lon);


load_path = '/Volumes/matlab/matlab/timor/modis_chl_4km/'






    for m=1:length(mid_week_jdays)
        fname = [load_path 'CHL_4_W_' num2str(mid_week_jdays(m)) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
        load(fname, 'chl_week')
        chl=single(log10(chl_week));
        lp=smooth2d_f(chl,20,10);
        filtered_chl=chl-lp;
        eval(['save ', fname, ' -append filtered_chl']);
    end
 
