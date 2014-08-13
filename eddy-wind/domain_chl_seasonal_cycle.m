
interp_jdays=[2450884:7:2454300];


load_path = '/matlab/data/gsm/mat/'
load([load_path,'GSM_9_21_2450821'],'glon','glat')
load /matlab/data/gsm/cor_chl_ssh_out lat lon
load /matlab/matlab/masks/mask_cor_lw
[r,c]=imap(min(lat(:)),max(lat(:)),min(lon(:)),max(lon(:)),glat,glon);
for m=1:length(interp_jdays)
    fname = [load_path 'GSM_9_21_' num2str(interp_jdays(m)) '.mat'];
    fprintf('\r     loading and calc grad of file %03u of %03u \r',m,length(interp_jdays))
	eval(['load ' fname ' gchl_week'])
	xx=flipud(gchl_week(r,c)).*mask;
	data(m)=pmean(xx(:));
	jdays(m)=interp_jdays(m);
end

   	
save /matlab/matlab/eddy-wind/lw_domain_chl_ss data jdays
	