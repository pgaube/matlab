clear all
interp_jdays=[2450884:7:2454832];


load_path = '/Volumes/matlab/data/SeaWiFS/mat/'
load([load_path,'SCHL_9_21_2450821'],'glon','glat')

data=single(nan(length(glat(:,1)),length(glat(1,:)),length(interp_jdays)));

for m=1:length(interp_jdays)
    fname = [load_path 'SCHL_9_21_' num2str(interp_jdays(m)) '.mat'];
    fprintf('\r     loading and calc grad of file %03u of %03u \r',m,length(interp_jdays))
	eval(['load ' fname ' gpar_week'])
	data(:,:,m)=gpar_week;
end


var_par=nanvar(data,0,3);
mean_par=nanmean(data,3);

save new_mean_schl -append var_* mean_*


