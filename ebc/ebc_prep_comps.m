clear all

load ebc_samps/lw_anom_samps
cplot_anom_ts(lw_anom_ts_a.mean(1:100),lw_anom_ts_c.mean(1:100), ...
			  lw_anom_ts_a.N(1:100),lw_anom_ts_c.N(1:100),50,10, ...
			  '~/Documents/OSU/figures/ebc/samps/lw')
			  
load ebc_samps/ccns_anom_samps
cplot_anom_ts(ccns_anom_ts_a.mean(1:100),ccns_anom_ts_c.mean(1:100), ...
			  ccns_anom_ts_a.N(1:100),ccns_anom_ts_c.N(1:100),120,20, ...
			  '~/Documents/OSU/figures/ebc/samps/ccns')
			  

return
load ebc_anom_comps


mask_maj=nan*LW_anom_c.N(r,c);
mask_min=nan*LW_anom_c.N(r,c);
mask_maj((LW_anom_c.N(r,c)./LW_anom_c.n_max_sample)>=.1)=1;
mask_min(LW_anom_c.N(r,c)>=100)=1;
tmp = double(LW_anom_c.mean(r,c).*mask_min);

cplot_comps_3_3_chelle(tmp,-.07,.07, ...
	'~/Documents/OSU/figures/ebc/comps/lw_anom_c_bg')
	
mask_maj=nan*LW_anom_a.N(r,c);
mask_min=nan*LW_anom_a.N(r,c);
mask_maj((LW_anom_a.N(r,c)./LW_anom_a.n_max_sample)>=.1)=1;
mask_min(LW_anom_a.N(r,c)>=100)=1;
tmp = double(LW_anom_a.mean(r,c).*mask_min);

cplot_comps_3_3_chelle(tmp,-.07,.07, ...
	'~/Documents/OSU/figures/ebc/comps/lw_anom_a_bg')	
	
	
mask_maj=nan*CCNS_anom_c.N(r,c);
mask_min=nan*CCNS_anom_c.N(r,c);
mask_maj((CCNS_anom_c.N(r,c)./CCNS_anom_c.n_max_sample)>=.1)=1;
mask_min(CCNS_anom_c.N(r,c)>=100)=1;
tmp = double(CCNS_anom_c.mean(r,c).*mask_min);

cplot_comps_3_3_chelle(tmp,-.12,.12, ...
	'~/Documents/OSU/figures/ebc/comps/CCNS_anom_c_bg')
	
mask_maj=nan*CCNS_anom_a.N(r,c);
mask_min=nan*CCNS_anom_a.N(r,c);
mask_maj((CCNS_anom_a.N(r,c)./CCNS_anom_a.n_max_sample)>=.1)=1;
mask_min(CCNS_anom_a.N(r,c)>=100)=1;
tmp = double(CCNS_anom_a.mean(r,c).*mask_min);

cplot_comps_3_3_chelle(tmp,-.12,.12, ...
	'~/Documents/OSU/figures/ebc/comps/CCNS_anom_a_bg')		
