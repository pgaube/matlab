
for m=1:2:16
	eval(['load /Volumes/matlab/data/eddy/V4/global_tracks_V4_',num2str(3+m),'_',...
		  num2str(5+m),'_cm']);
	tmp_subset_north
	eval(['save track/north_tracks_V4_',num2str(3+m),'_',num2str(5+m),'_cm']);
	
	eval(['load /Volumes/matlab/data/eddy/V4/global_tracks_V4_',num2str(3+m),'_',...
		  num2str(5+m),'_cm']);
	tmp_subset_south
	eval(['save track/south_tracks_V4_',num2str(3+m),'_',num2str(5+m),'_cm']);
end

