clear all

%{
%first do north oi a

ra = 101;
ca = 130;
rc = 108;
cc = 109;

[north_ts_oi_a,north_ts_oi_c]  =  ...
		ts_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrfoi_sample',ra,ca,rc,cc);
				
figure(1)
title('North oi anticyclones')
plot([1:52],north_ts_oi_a.mean(1:52),'r')
hold on
plot([1:52],north_ts_oi_c.mean(1:52),'b')


figure(2)
title('North oi cyclones')
plot([1:52],north_ts_oi_a.N(1:52),'r')
hold on
plot([1:52],north_ts_oi_c.N(1:52),'b')

%now do south oi

ra = 107;
ca = 97;
rc = 101;
cc = 121;

[south_ts_oi_a,south_ts_oi_c]  =  ...
		ts_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrfoi_sample',ra,ca,rc,cc);
				
figure(3)
title('South oi anticyclones')
plot([1:52],south_ts_oi_a.mean(1:52),'r')
hold on
plot([1:52],south_ts_oi_c.mean(1:52),'b')

figure(4)
title('South oi cyclones')
plot([1:52],south_ts_oi_a.N(1:52),'r')
hold on
plot([1:52],south_ts_oi_c.N(1:52),'b')

save /Volumes/matlab/matlab/air-sea/comps/comps_ts_oi_16_weeks south* north*
%}

%do north spd a

ra = 101;
ca = 130;
rc = 108;
cc = 109;

[north_ts_spd_a,north_ts_spd_c]  =  ...
		ts_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrspd_sample',ra,ca,rc,cc);
				
figure(1)
title('North spd anticyclones')
plot([1:52],north_ts_spd_a.mean(1:52),'r')
hold on
plot([1:52],north_ts_spd_c.mean(1:52),'b')


figure(2)
title('North spd cyclones')
plot([1:52],north_ts_spd_a.N(1:52),'r')
hold on
plot([1:52],north_ts_spd_c.N(1:52),'b')

%now do south spd

ra = 107;
ca = 97;
rc = 101;
cc = 121;

[south_ts_spd_a,south_ts_spd_c]  =  ...
		ts_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrspd_sample',ra,ca,rc,cc);
				
figure(3)
title('South spd anticyclones')
plot([1:52],south_ts_spd_a.mean(1:52),'r')
hold on
plot([1:52],south_ts_spd_c.mean(1:52),'b')

figure(4)
title('South spd cyclones')
plot([1:52],south_ts_spd_a.N(1:52),'r')
hold on
plot([1:52],south_ts_spd_c.N(1:52),'b')

save /Volumes/matlab/matlab/air-sea/comps/comps_ts_spd_16_weeks south* north*

				
				

