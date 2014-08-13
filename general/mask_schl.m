clear all
chl_path = '/home/bettong/data2/data/seawifs/mat/'
ssh_path = '/Volumes/matlab/data/eddy/V4/mat/'
chl_prload = '/home/bettong/data2/data/seawifs/mat/SCHL_4_W_2454482'
ssh_prload = '/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_2454482'

load(ssh_prload);
lat=[-89.875:.25:89.875];
mlat=lat'*ones(1,length(lon(1,:)));
mlon=ones(length(lat),1)*lon(1,:);

load(chl_prload,'lon','lat','mid_week_jdays');
lat=single(lat);
lon=single(lon);


    for m=1:length(mid_week_jdays)
        fnamec = [chl_path 'SCHL_4_W_' num2str(mid_week_jdays(m)) '.mat'];
        fnames = [ssh_path 'AVISO_25_W_' num2str(mid_week_jdays(m)) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
        load(fnames,'idmask')
        idmask=cat(1,nan(40,1440),idmask,nan(40,1440));
        %load(fnamec,'chl_week','chl_anom','chl_filled','SS','lat','lon')
        idmask_9km = interp2(mlon,mlat,idmask,lon,lat,'*nearest*');
        mask_9km=nan(size(idmask_9km));
        mask_9km(~isnan(idmask_9km))=1;
        eval(['save ', fnamec, ' -append idmask_9km mask_9km']);
    end
 
