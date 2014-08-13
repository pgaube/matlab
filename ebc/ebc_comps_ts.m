

ra=121;
ca=117;
rc=113;
cc=109;

[ccns_anom_ts_a,ccns_anom_ts_c] = ts_comps_9km('tracks/cCCNS_lat_lon_tracks.mat','nrchl_anom_sample',ra,ca,rc,cc,'n');
save ebc_samps/ccns_anom_samps
clear

ra=113;
ca=110;
rc=109;
cc=123;

[lw_anom_ts_a,lw_anom_ts_c]  = ts_comps_9km('tracks/cLW_lat_lon_tracks.mat','nrchl_anom_sample',ra,ca,rc,cc,'n');
save ebc_samps/lw_anom_samps
clear

ra=111;
ca=122;
rc=105;
cc=111;

[bg_anom_ts_a,bg_anom_ts_c]  = ts_comps_9km('tracks/cBG_lat_lon_tracks.mat','nrchl_anom_sample',ra,ca,rc,cc,'n');
save ebc_samps/bg_anom_samps
clear

ra=97;
ca=114;
rc=113;
cc=122;

[ak_anom_ts_a,ak_anom_ts_c]  = ts_comps_9km('tracks/cAK_lat_lon_tracks.mat','nrchl_anom_sample',ra,ca,rc,cc,'n');
save ebc_samps/ak_anom_samps
clear

ra=116;
ca=128;
rc=116;
cc=101;

[cc_anom_ts_a,cc_anom_ts_c]  = ts_comps_9km('tracks/cCC_lat_lon_tracks.mat','nrchl_anom_sample',ra,ca,rc,cc,'n');
save ebc_samps/cc_anom_samps
clear

ra=106;
ca=122;
rc=102;
cc=113;

[pc_anom_ts_a,pc_anom_ts_c]  = ts_comps_9km('tracks/cPC_lat_lon_tracks.mat','nrchl_anom_sample',ra,ca,rc,cc,'n');
save ebc_samps/pc_anom_samps
clear






