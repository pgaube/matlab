
interp_jdays=[2451556:7:2454797];


load_path = '/matlab/data/QuickScat/mat/'
load([load_path,'QSCAT_30_25km_2454734'],'lon','lat')

data=single(nan(length(lat(:,1)),length(lat(1,:)),length(interp_jdays)));
grad_data=data;

for m=1:length(interp_jdays)
    fname = [load_path 'QSCAT_30_25km_' num2str(interp_jdays(m)) '.mat'];
    fprintf('\r     loading and calc grad of file %03u of %03u \r',m,length(interp_jdays))
	eval(['load ' fname ' wspd_week'])
	data(:,:,m)=wspd_week;
end


%var_mu=nanvar(data,0,3);
mean_wspd=nanmean(data,3);

save mean_qscat -append var_* mean_*


