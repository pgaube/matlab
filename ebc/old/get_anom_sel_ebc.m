
[cc_anom_bar,cc_N,cc_ids,cc_edi,cc_k,cc_amp] = means_4km('CC_lat_lon_tracks_16_weeks.mat','raw_anom_sample');
save ebc_samps/cc_anom_samps
clear

[pc_anom_bar,pc_N,pc_ids,pc_edi,pc_k,pc_amp] = means_4km('PC_lat_lon_tracks_16_weeks.mat','raw_anom_sample');
save ebc_samps/pc_anom_samps
clear

[lw_anom_bar,lw_N,lw_ids,lw_edi,lw_k,lw_amp] = means_4km('LW_lat_lon_tracks_16_weeks.mat','raw_anom_sample');
save ebc_samps/lw_anom_samps
clear

[bg_anom_bar,bg_N,bg_ids,bg_edi,bg_k,bg_amp] = means_4km('BG_lat_lon_tracks_16_weeks.mat','raw_anom_sample');
save ebc_samps/bg_anom_samps
clear

[ccns_anom_bar,ccns_N,ccns_ids,ccns_edi,ccns_k,ccns_amp] = means_4km('CCNS_lat_lon_tracks_16_weeks.mat','raw_anom_sample');
save ebc_samps/ccns_anom_samps
clear

[ak_anom_bar,ak_N,ak_ids,ak_edi,ak_k,ak_amp] = means_4km('ak_lat_lon_tracks_16_weeks.mat','raw_anom_sample');
save ebc_samps/ak_anom_samps
clear

