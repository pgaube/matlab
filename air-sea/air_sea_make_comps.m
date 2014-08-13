load /Volumes/matlab/matlab/north/new_north_south_comps r c

for m=1:2:16
	tnname=['/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_',num2str(3+m),'_',num2str(5+m),'_cm'];
	tsname=['/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_',num2str(3+m),'_',num2str(5+m),'_cm'];
	nonamea=['north_',num2str(3+m),'_',num2str(5+m),'_oi_cm_a'];
	nonamec=['north_',num2str(3+m),'_',num2str(5+m),'_oi_cm_c'];
	sonamea=['south_',num2str(3+m),'_',num2str(5+m),'_oi_cm_a'];
	sonamec=['south_',num2str(3+m),'_',num2str(5+m),'_oi_cm_c'];
	nsnamea=['north_',num2str(3+m),'_',num2str(5+m),'_spd_cm_a'];
	nsnamec=['north_',num2str(3+m),'_',num2str(5+m),'_spd_cm_c'];
	ssnamea=['south_',num2str(3+m),'_',num2str(5+m),'_spd_cm_a'];
	ssnamec=['south_',num2str(3+m),'_',num2str(5+m),'_spd_cm_c'];
	cname=['comps/comps_',num2str(3+m),'_',num2str(5+m),'_oi_cm'];
	
	eval(['[',nonamea,',',nonamec,']=comps(',char(39),tnname,char(39),',',char(39),'nrfoi_sample',char(39),');'])
	eval(['[',sonamea,',',sonamec,']=comps(',char(39),tsname,char(39),',',char(39),'nrfoi_sample',char(39),');'])
	eval(['[',nsnamea,',',nsnamec,']=comps(',char(39),tnname,char(39),',',char(39),'nrspd_sample',char(39),');'])
	eval(['[',ssnamea,',',ssnamec,']=comps(',char(39),tsname,char(39),',',char(39),'nrspd_sample',char(39),');'])
	
	save(cname)
	clear
end

