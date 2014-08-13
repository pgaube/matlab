clear all
clf

for m=1:2:16
	tnname=['/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_',num2str(3+m),'_',num2str(5+m),'_cm'];
	tsname=['/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_',num2str(3+m),'_',num2str(5+m),'_cm'];
	snname=['/Volumes/matlab/matlab/air-sea/map_tracks/north_tracks_V4_',num2str(3+m),'_',num2str(5+m),'_cm_map'];
	ssname=['/Volumes/matlab/matlab/air-sea/map_tracks/south_tracks_V4_',num2str(3+m),'_',num2str(5+m),'_cm_map'];
	nmap_name=['north_',num2str(3+m),'_',num2str(5+m),'map'];
	smap_name=['south_',num2str(3+m),'_',num2str(5+m),'map'];
	
	load(tnname)
	[lon,lat,eddy_density]=eddy_density(x,y);
	save(snname,'lon','lat','eddy_density')
	
	clf
	pmap(lon,lat,eddy_density,'blank')
	caxis([1 15])
	eval(['title(' char(39) nmap_name char(39) ')'])
	eval(['print -dpng ', snname])
	
	
	clear x y lat lon eddy_density
	
	load(tsname)
	[lon,lat,eddy_density]=eddy_density(x,y);
	save(snname,'lon','lat','eddy_density')
	
	clf
	pmap(lon,lat,eddy_density,'blank')
	caxis([1 15])
	eval(['title(' char(39) smap_name char(39) ')'])
	eval(['print -dpng ', ssname])
	clear
end
