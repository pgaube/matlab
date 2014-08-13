interp_jdays=[2450849:7:2454832];


load_path = '/home/wallaby/data/pgaube/data/seawifs/mat/'
load(['/Volumes/matlab/data/SeaWiFS/mat/SCHL_9_21_2450821'],'glon','glat')
lat=single(glat);
lon=single(glon);

tmp=nan(length(lat(:,1)),length(lon(1,:)),24);
for m=13:length(interp_jdays)-13
        fprintf('\r     writing to file %03u of %03u \r',m,length(interp_jdays))
    	for d=1:9
        	fname = ['/Volumes/matlab/data/gsm/mat/GSM_9_21_' num2str(interp_jdays(m+(d-5))) '.mat'];
        	load(fname,'sm_gchl_week')
        	tmp(:,:,d)=sm_gchl_week;
        	clear sm_gchl_week
        end
        ba_gchl_week=linx_smooth2d_f(nanmean(tmp,3),3,3);
        tmp=nan*tmp;
        fname = ['/Volumes/matlab/data/gsm/mat/GSM_9_21_' num2str(interp_jdays(m)) '.mat'];
        eval(['save -append ' fname ' ba_*'])
    end
