

load_path = '/Volumes/matlab/data/QuickScat/gridded_week/'
load([load_path,'QSCAT_W_25km_2454454'],'lat','lon')
mid_week_jdays=2452459:7:2454489;
[lon,lat]=meshgrid(lon,lat);
%use to make monthy comps

%{
tau_tmp=nan(length(lat(:,1)),length(lon(1,:)),4);

for m=1:4:length(mid_week_jdays)
    
    fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
    fname2 = [load_path 'QSCAT_M_25km_' num2str(mid_week_jdays(m)) '.mat'];
    for p=1:4
    	if m+p-1<=291
    	fname = [load_path 'QSCAT_W_25km_' num2str(mid_week_jdays(m+p-1)) '.mat'];
    	load(fname, 'Wstrm')
    	tau_tmp(:,:,p)=Wstrm;
    	end
    end	
    Mstrm=nanmean(tau_tmp,3);
	eval(['save ', fname2, ' lat lon Mstrm mid_week_jdays'])
	tau_tmp=nan*tau_tmp;
end
%use to make annual comps
%}
tau_tmp=nan(length(lat(:,1)),length(lon(1,:)),12);

for m=1:52:length(mid_week_jdays)
    
    fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
    fname3 = [load_path 'QSCAT_Y_25km_' num2str(mid_week_jdays(m)) '.mat'];
    for p=1:12
    	if m+(p-1)*4<=291
    	fname = [load_path 'QSCAT_M_25km_' num2str(mid_week_jdays(m+(p-1)*4)) '.mat'];
    	load(fname, 'Mstrm_anom')
    	tau_tmp(:,:,p)=Mstrm_anom;
    	end
    end	
    Ystrm_anom=nanmean(tau_tmp,3);
	eval(['save ', fname3, ' lat lon Ystrm_anom mid_week_jdays'])
	tau_tmp=nan*tau_tmp;
end