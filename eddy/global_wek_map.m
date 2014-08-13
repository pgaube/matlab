
clear
ssh_path='/Volumes/matlab/data/eddy/V4/mat/';
ssh_head='AVISO_25_W_';

q_head   = 'QSCAT_21_25km_';
q_path   = '/Volumes/matlab/data/QuickScat/new_mat/';
 
jdays=[2452431:7:2454811];

m=1;

load([ssh_path ssh_head num2str(jdays(m))],'lat','lon')
slat=lat(41:600,:);
slon=lon(41:600,:);
mean_w_ek_a=nan(length(slat(:,1)),length(slat(1,:)),length(jdays));
mean_w_ek_c=nan(length(slat(:,1)),length(slat(1,:)),length(jdays));


load([q_path q_head num2str(jdays(m))],'lat','lon')

for m=1:length(jdays)
	fprintf('\r file %3u of %3u \r',m,length(jdays))
	load([ssh_path ssh_head num2str(jdays(m))],'a_mask','c_mask')
	a_mask=a_mask(41:600,:);
	c_mask=c_mask(41:600,:);
	load([q_path q_head num2str(jdays(m))],'w_ek')
	mean_w_ek_a(:,:,m)=w_ek.*a_mask;
	mean_w_ek_c(:,:,m)=w_ek.*c_mask;
end

N_a=nansum(~isnan(mean_w_ek_a),3);
N_c=nansum(~isnan(mean_w_ek_c),3);


mean_w_ek_a=nanmean(mean_w_ek_a,3);
mean_w_ek_c=nanmean(mean_w_ek_c,3);

mean_w_ek_a(N_a<10)=nan;
mean_w_ek_c(N_c<10)=nan;

mean_w_ek_a_2_2=linx_smooth2d_f(mean_w_ek_a,2,2);
mean_w_ek_c_2_2=linx_smooth2d_f(mean_w_ek_c,2,2);

save global_w_ek_map

fprintf('\n')
	
