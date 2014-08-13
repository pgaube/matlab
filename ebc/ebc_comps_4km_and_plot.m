
clear all
load ebc_anom_comps r c
[LW_anom_a,LW_anom_c]  =  ...
		comps_4km('tracks/cLW_lat_lon_tracks.mat','nranom_sample');
[CCNS_anom_a,CCNS_anom_c]  =  ...
		comps_4km('tracks/cCCNS_lat_lon_tracks.mat','nranom_sample');
save ebc_anom_comps_noro
