
% clear all
% 
% 
% load tracks/midlat_tracks
% ii=find(track_jday>=2452459 & track_jday<=2454489);
% x=x(ii);
% y=y(ii);
% k=k(ii);
% id=id(ii);
% track_jday=track_jday(ii);
% cyc=cyc(ii);
% scale=scale(ii);
% amp=amp(ii);
% %
% prctile(amp,[25 50 75 95])

% 
% ii=find(amp<=3.1);
% [sst_25_cc,sst_25_c]=comps_dir_grad(x(ii),y(ii),cyc(ii),id(ii),track_jday(ii),scale(ii),'hp66_sst','~/data/ReynoldsSST/mat/OI_25_30_','t')
% 
% ii=find(amp>3.1 & amp<=5.2);
% [sst_50_cc,sst_50_c]=comps_dir_grad(x(ii),y(ii),cyc(ii),id(ii),track_jday(ii),scale(ii),'hp66_sst','~/data/ReynoldsSST/mat/OI_25_30_','t')
% 
% ii=find(amp>5.2 & amp<=8.9);
% [sst_75_cc,sst_75_c]=comps_dir_grad(x(ii),y(ii),cyc(ii),id(ii),track_jday(ii),scale(ii),'hp66_sst','~/data/ReynoldsSST/mat/OI_25_30_','t')

ii=find(amp>8.9 & amp<=22.5);
[sst_75_95_cc,sst_75_95_c]=comps_dir_grad(x(ii),y(ii),cyc(ii),id(ii),track_jday(ii),scale(ii),'hp66_sst','~/data/ReynoldsSST/mat/OI_25_30_','t')

% ii=find(amp>=22.5);
% [sst_95_cc,sst_95_c]=comps_dir_grad(x(ii),y(ii),cyc(ii),id(ii),track_jday(ii),scale(ii),'hp66_sst','~/data/ReynoldsSST/mat/OI_25_30_','t')
% 
save -append FINAL_sst_by_amp
% return

load FINAL_sst_by_amp
%

% pcomps_raw2(sst_25_cc.N_median,sst_25_cc.N_median,[-0.4 0.4],-1,.08,1,['25th percentile N=',num2str(sst_25_cc.N_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_25_prctile_cc_N
% pcomps_raw2(sst_25_c.N_median,sst_25_c.N_median,[-0.4 0.4],-1,.08,1,['25th percentile N=',num2str(sst_25_c.N_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_25_prctile_cw_N
% pcomps_raw2(sst_25_cc.S_median,sst_25_cc.S_median,[-0.4 0.4],-1,.08,1,['25th percentile N=',num2str(sst_25_cc.S_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_25_prctile_cc_S
% pcomps_raw2(sst_25_c.S_median,sst_25_c.S_median,[-0.4 0.4],-1,.08,1,['25th percentile N=',num2str(sst_25_c.S_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_25_prctile_cw_S
% 
% pcomps_raw2(sst_50_cc.N_median,sst_50_cc.N_median,[-0.4 0.4],-1,.08,1,['25-50th percentile N=',num2str(sst_50_cc.N_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_50_prctile_cc_N
% pcomps_raw2(sst_50_c.N_median,sst_50_c.N_median,[-0.4 0.4],-1,.08,1,['25-50th percentile N=',num2str(sst_50_c.N_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_50_prctile_cw_N
% pcomps_raw2(sst_50_cc.S_median,sst_50_cc.S_median,[-0.4 0.4],-1,.08,1,['25-50th percentile N=',num2str(sst_50_cc.S_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_50_prctile_cc_S
% pcomps_raw2(sst_50_c.S_median,sst_50_c.S_median,[-0.4 0.4],-1,.08,1,['25-50th percentile N=',num2str(sst_50_c.S_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_50_prctile_cw_S
% 
% pcomps_raw2(sst_75_cc.N_median,sst_75_cc.N_median,[-0.4 0.4],-1,.08,1,['50-75th percentile N=',num2str(sst_75_cc.N_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_75_prctile_cc_N
% pcomps_raw2(sst_75_c.N_median,sst_75_c.N_median,[-0.4 0.4],-1,.08,1,['50-75th percentile N=',num2str(sst_75_c.N_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_75_prctile_cw_N
% pcomps_raw2(sst_75_cc.S_median,sst_75_cc.S_median,[-0.4 0.4],-1,.08,1,['50-75th percentile N=',num2str(sst_75_cc.S_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_75_prctile_cc_S
% pcomps_raw2(sst_75_c.S_median,sst_75_c.S_median,[-0.4 0.4],-1,.08,1,['50-75th percentile N=',num2str(sst_75_c.S_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_75_prctile_cw_S

pcomps_raw2(sst_75_95_cc.N_median,sst_75_95_cc.N_median,[-0.4 0.4],-1,.08,1,['75-95th percentile N=',num2str(sst_75_95_cc.N_n_max_sample)],1,30)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_75_95_prctile_cc_N
pcomps_raw2(sst_75_95_c.N_median,sst_75_95_c.N_median,[-0.4 0.4],-1,.08,1,['75-95th percentile N=',num2str(sst_75_95_c.N_n_max_sample)],1,30)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_75_95_prctile_cw_N
pcomps_raw2(sst_75_95_cc.S_median,sst_75_95_cc.S_median,[-0.4 0.4],-1,.08,1,['75-95th percentile N=',num2str(sst_75_95_cc.S_n_max_sample)],1,30)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_75_95_prctile_cc_S
pcomps_raw2(sst_75_95_c.S_median,sst_75_95_c.S_median,[-0.4 0.4],-1,.08,1,['75-95th percentile N=',num2str(sst_75_95_c.S_n_max_sample)],1,30)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_75_95_prctile_cw_S
% 
% pcomps_raw2(sst_95_cc.N_median,sst_95_cc.N_median,[-0.4 0.4],-1,.08,1,['95th percentile N=',num2str(sst_95_cc.N_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_95_prctile_cc_N
% pcomps_raw2(sst_95_c.N_median,sst_95_c.N_median,[-0.4 0.4],-1,.08,1,['95th percentile N=',num2str(sst_95_c.N_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_95_prctile_cw_N
% pcomps_raw2(sst_95_cc.S_median,sst_95_cc.S_median,[-0.4 0.4],-1,.08,1,['95th percentile N=',num2str(sst_95_cc.S_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_95_prctile_cc_S
% pcomps_raw2(sst_95_c.S_median,sst_95_c.S_median,[-0.4 0.4],-1,.08,1,['95th percentile N=',num2str(sst_95_c.S_n_max_sample)],1,30)
% print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/midlat_95_prctile_cw_S
