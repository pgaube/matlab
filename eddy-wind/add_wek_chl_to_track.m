function add_wspd_to_track(TRACK_NAME)
zgrid_grid
dist=sqrt(xi.^2+yi.^2);
ii=find(dist<=1);
mask=nan*dist;
mask(ii)=1;

shead='/Volumes/matlab/matlab/global/trans_samp/TRANS_W_NOR_'

load(TRACK_NAME)
%track_wek=nan*x;
track_hp26_chl=nan*x;

%track jdays
%jdays=[2452431:7:2454811];
%qscat jdays
jdays=[2451395:7:2454811];

it=find(track_jday>=min(jdays) & track_jday<=max(jdays));

udays=unique(track_jday(it));
lj=length(udays);
for m=[1:67 69:lj]
fprintf('\r    calculating %03u of %03u\r',m,lj)
	load([shead num2str(jdays(m))],'nrnbp26_chl_sample','nrw_ek_sample','id_index')
	ww=find(track_jday==jdays(m));
	ii=sames(id_index,id(ww));
	jj=sames(id(ww),id_index);
		for p=1:length(ii)
			tmp=squeeze(nrw_ek_sample(:,:,jj(p))).*mask;
			track_wek(ww(ii(p)))=nanmean(tmp(:));
			tmp=squeeze(nrnbp26_chl_sample(:,:,jj(p))).*mask;
			track_hp26_chl(ww(ii(p)))=nanmean(tmp(:));
		end	
end

eval(['save -append ' TRACK_NAME ' track_*'])