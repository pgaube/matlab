function add_wspd_to_track(TRACK_NAME)
out_dir='/Volumes/matlab/data/QuickScat/new_mat/'
out_head='QSCAT_21_25km_'



load(TRACK_NAME)
track_wspd=nan*x;

%qscat jdays
jdays=[2451395:7:2454811];

it=find(track_jday>=min(jdays) & track_jday<=max(jdays));

udays=unique(track_jday(it));
lj=length(udays);
for m=1:lj
	fprintf('\r    calculating %03u of %03u\r',m,lj)
	load_file = [out_dir out_head num2str(jdays(m))];
	load(load_file,'wspd_21','lon','lat')
	ii=find(track_jday==udays(m));
		for p=1:length(ii)
			[r,c]=imap(y(ii(p))-2,y(ii(p))+2,x(ii(p))-2,x(ii(p))+2,lat,lon);
			tmp=wspd_21(r,c);
			track_wspd(ii(p))=nanmean(tmp(:));
		end
end

eval(['save -append ' TRACK_NAME ' track_wspd'])