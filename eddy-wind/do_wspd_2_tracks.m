track_file={'tracks/oID_lat_lon_tracks','tracks/oSPC_lat_lon_tracks',...
			 'tracks/oNPC_lat_lon_tracks','tracks/oSAT_lat_lon_tracks',...
			 'tracks/oNAT_lat_lon_tracks','tracks/oID_lat_lon_tracks',...
			 'tracks/oSPC_lat_lon_tracks','tracks/oNPC_lat_lon_tracks',...
			 'tracks/oSAT_lat_lon_tracks','tracks/oNAT_lat_lon_tracks'};

w=2:2:12;


for n=1:length(track_file)
	%add_wspd_to_track(track_file{n})
	
	%now stratify
	
	for m=1:length(w)-1
		load(track_file{n},'id','eid','x','y','gx','gy','amp','nneg','axial_speed','scale','radius','track_jday','prop_speed','k','track_wspd')
		ii=find(track_wspd>=w(m) & track_wspd< w(m+1));
		track_wspd=track_wspd(ii);
		id=id(ii);
		eid=eid(ii);
		x=x(ii);
		y=y(ii);
		gx=gx(ii);
		gy=gy(ii);
		amp=amp(ii);
		axial_speed=axial_speed(ii);
		scale=scale(ii);
		radius=radius(ii);
		track_jday=track_jday(ii);
		prop_speed=prop_speed(ii);
		k=k(ii);
		unique_id=unique(id);
		ai=find(id>=nneg);
		ci=find(id<nneg);
		
		save([track_file{n} '_wspd_' num2str(w(m)) '_' num2str(w(m+1))])
	end
end