set_hovs
!toast /Volumes/matlab/matlab/hovmuller/for_mike/*chl.dat
for m=[24]%length(lat)
load(['gline_' num2str(m) '_hov'],'cjdays','clon','chov','full_chov')
chov=fillnans(chov);
tt=basin_id(m);
eval(['save -ascii for_mike/vocals_time_lon_section_chl_hp.dat tt'])
tt=lat(m);
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl_hp.dat tt'])
tt=wlon(m);
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl_hp.dat tt'])
tt=elon(m);
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl_hp.dat tt'])
tt=cjdays(1);
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl_hp.dat tt'])
tt=cjdays(end);
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl_hp.dat tt'])
tt=length(chov(1,:));
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl_hp.dat tt'])
tt=length(chov(:,1));
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl_hp.dat tt'])
tt=.25;
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl_hp.dat tt'])
tt=7;
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl_hp.dat tt'])
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl_hp.dat chov'])


load(['gline_' num2str(m) '_hov'],'cjdays','clon','chov','full_chov')
chov=fillnans(full_chov);
tt=basin_id(m);
eval(['save -ascii for_mike/vocals_time_lon_section_chl.dat tt'])
tt=lat(m);
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl.dat tt'])
tt=wlon(m);
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl.dat tt'])
tt=elon(m);
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl.dat tt'])
tt=cjdays(1);
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl.dat tt'])
tt=cjdays(end);
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl.dat tt'])
tt=length(chov(1,:));
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl.dat tt'])
tt=length(chov(:,1));
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl.dat tt'])
tt=.25;
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl.dat tt'])
tt=7;
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl.dat tt'])
eval(['save -ascii -append for_mike/vocals_time_lon_section_chl.dat chov'])
end

% ( (log_chl(i,j),i=1,nx),j=1,ny)