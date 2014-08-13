
clear
ssh_path='/Volumes/matlab/data/eddy/V4/mat/';
ssh_head='AVISO_25_W_';

foi_head   = 'OI_25_W_';
foi_path   = '/Volumes/matlab/data/ReynoldsSST/mat/';

jdays=[2452431:7:2454811];

m=1;

load([ssh_path ssh_head num2str(jdays(m))],'lat','lon')
mean_foi_a=nan(length(lat(:,1)),length(lat(1,:)),length(jdays));
mean_foi_c=nan(length(lat(:,1)),length(lat(1,:)),length(jdays));
slat=lat;
slon=lon;

load([foi_path foi_head num2str(jdays(m))],'lat','lon')
r=find(lat(:,1)>=min(slat(:,1))-.01 & lat(:,1)<=max(slat(:,1))+.01);

for m=1:length(jdays)
	fprintf('\r file %3u of %3u \r',m,length(jdays))
	load([ssh_path ssh_head num2str(jdays(m))],'a_mask','c_mask')
	load([foi_path foi_head num2str(jdays(m))],'filtered_sst_oi')
	filtered_sst_oi=filtered_sst_oi(r,:);
	mean_foi_a(:,:,m)=filtered_sst_oi.*a_mask;
	mean_foi_c(:,:,m)=filtered_sst_oi.*c_mask;
end

N_a=nansum(~isnan(mean_foi_a),3);
N_c=nansum(~isnan(mean_foi_c),3);


mean_foi_a=nanmean(mean_foi_a,3);
mean_foi_c=nanmean(mean_foi_c,3);

mean_foi_a(N_a<10)=nan;
mean_foi_c(N_c<10)=nan;

mean_foi_a_2_2=linx_smooth2d_f(mean_foi_a,2,2);
mean_foi_c_2_2=linx_smooth2d_f(mean_foi_c,2,2);

save global_foi_map

fprintf('\n')
	
