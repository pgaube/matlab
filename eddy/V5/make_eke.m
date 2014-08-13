clear all

load global_tracks_v5 track_jday

jdays=unique(track_jday);
lj=length(jdays);
lj=500;


asave_path='~/data/eddy/V5/mat/';
asave_head='AVISO_25_W_';



load([asave_path asave_head num2str(jdays(1))],'lon','lat')
meta_eke=nan(length(lat(:,1)),length(lon(1,:)),lj);

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([asave_path asave_head num2str(jdays(m))],'u','v')
	eke=(u.^2+v.^2)./2;
	meta_eke(:,:,m)=eke;
	
	save([asave_path asave_head num2str(jdays(m))],'eke','-append')
	clear u v eke
end

mean_eke=nanmean(meta_eke,3);
save mean_eke mean_eke lat lon