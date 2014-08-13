clear all
load ebc_samps/lw_anom_samps
cplot_anom_ts(lw_anom_ts_a.mean(1:100),lw_anom_ts_c.mean(1:100), ...
			  lw_anom_ts_a.N(1:100),lw_anom_ts_c.N(1:100),90,10, ...
			  '~/Documents/OSU/figures/ebc/samps/LW')
			  
load ebc_samps/ccns_anom_samps
cplot_anom_ts(ccns_anom_ts_a.mean(1:100),ccns_anom_ts_c.mean(1:100), ...
			  ccns_anom_ts_a.N(1:100),ccns_anom_ts_c.N(1:100),200,20, ...
			  '~/Documents/OSU/figures/ebc/samps/CCNS')

load ebc_samps/bg_anom_samps
cplot_anom_ts(bg_anom_ts_a.mean(1:100),bg_anom_ts_c.mean(1:100), ...
			  bg_anom_ts_a.N(1:100),bg_anom_ts_c.N(1:100),160,20, ...
			  '~/Documents/OSU/figures/ebc/samps/bg')	
			  
load ebc_samps/pc_anom_samps
cplot_anom_ts(pc_anom_ts_a.mean(1:100),pc_anom_ts_c.mean(1:100), ...
			  pc_anom_ts_a.N(1:100),pc_anom_ts_c.N(1:100),350,50, ...
			  '~/Documents/OSU/figures/ebc/samps/pc')	

load ebc_samps/ak_anom_samps
cplot_anom_ts(ak_anom_ts_a.mean(1:100),ak_anom_ts_c.mean(1:100), ...
			  ak_anom_ts_a.N(1:100),ak_anom_ts_c.N(1:100),60,10, ...
			  '~/Documents/OSU/figures/ebc/samps/ak')	
			  
load ebc_samps/cc_anom_samps
cplot_anom_ts(cc_anom_ts_a.mean(1:100),cc_anom_ts_c.mean(1:100), ...
			  cc_anom_ts_a.N(1:100),cc_anom_ts_c.N(1:100),350,50, ...
			  '~/Documents/OSU/figures/ebc/samps/cc')			  


load ebc_anom_comps_9km

mask_maj=nan*LW_anom_c.N(r,c);
mask_maj((LW_anom_c.N(r,c)./LW_anom_c.n_max_sample)>=.1)=1;
tmp = double(LW_anom_c.mean(r,c).*mask_maj);

cplot_comps_3_3_chelle(tmp,-.07,.07, ...
	'~/Documents/OSU/figures/ebc/comps/LW_anom_c_bg')
	
mask_maj=nan*LW_anom_a.N(r,c);
mask_maj((LW_anom_a.N(r,c)./LW_anom_a.n_max_sample)>=.1)=1;
tmp = double(LW_anom_a.mean(r,c).*mask_maj);

cplot_comps_3_3_chelle(tmp,-.07,.07, ...
	'~/Documents/OSU/figures/ebc/comps/LW_anom_a_bg')	
	
	
mask_maj=nan*CCNS_anom_c.N(r,c);
mask_maj((CCNS_anom_c.N(r,c)./CCNS_anom_c.n_max_sample)>=.1)=1;
tmp = double(CCNS_anom_c.mean(r,c).*mask_maj);

cplot_comps_3_3_chelle(tmp,-.12,.12, ...
	'~/Documents/OSU/figures/ebc/comps/CCNS_anom_c_bg')
	
mask_maj=nan*CCNS_anom_a.N(r,c);
mask_maj((CCNS_anom_a.N(r,c)./CCNS_anom_a.n_max_sample)>=.1)=1;
tmp = double(CCNS_anom_a.mean(r,c).*mask_maj);

cplot_comps_3_3_chelle(tmp,-.12,.12, ...
	'~/Documents/OSU/figures/ebc/comps/CCNS_anom_a_bg')		

mask_maj=nan*CC_anom_c.N(r,c);
mask_maj((CC_anom_c.N(r,c)./CC_anom_c.n_max_sample)>=.1)=1;
tmp = double(CC_anom_c.mean(r,c).*mask_maj);

cplot_comps_3_3_chelle(tmp,-.03,.03, ...
	'~/Documents/OSU/figures/ebc/comps/CC_anom_c_bg')
	
mask_maj=nan*CC_anom_a.N(r,c);
mask_maj((CC_anom_a.N(r,c)./CC_anom_a.n_max_sample)>=.1)=1;
tmp = double(CC_anom_a.mean(r,c).*mask_maj);

cplot_comps_3_3_chelle(tmp,-.03,.03, ...
	'~/Documents/OSU/figures/ebc/comps/CC_anom_a_bg')	

mask_maj=nan*BG_anom_c.N(r,c);
mask_maj((BG_anom_c.N(r,c)./BG_anom_c.n_max_sample)>=.1)=1;
tmp = double(BG_anom_c.mean(r,c).*mask_maj);

cplot_comps_3_3_chelle(tmp,-.11,.11, ...
	'~/Documents/OSU/figures/ebc/comps/BG_anom_c_bg')
	
mask_maj=nan*BG_anom_a.N(r,c);
mask_maj((BG_anom_a.N(r,c)./BG_anom_a.n_max_sample)>=.1)=1;
tmp = double(BG_anom_a.mean(r,c).*mask_maj);

cplot_comps_3_3_chelle(tmp,-.11,.11, ...
	'~/Documents/OSU/figures/ebc/comps/BG_anom_a_bg')	
	
mask_maj=nan*AK_anom_c.N(r,c);
mask_maj((AK_anom_c.N(r,c)./AK_anom_c.n_max_sample)>=.1)=1;
tmp = double(AK_anom_c.mean(r,c).*mask_maj);

cplot_comps_3_3_chelle(tmp,-.1,.1, ...
	'~/Documents/OSU/figures/ebc/comps/AK_anom_c_bg')
	
mask_maj=nan*AK_anom_a.N(r,c);
mask_maj((AK_anom_a.N(r,c)./AK_anom_a.n_max_sample)>=.1)=1;
tmp = double(AK_anom_a.mean(r,c).*mask_maj);

cplot_comps_3_3_chelle(tmp,-.1,.1, ...
	'~/Documents/OSU/figures/ebc/comps/AK_anom_a_bg')	
	
mask_maj=nan*PC_anom_c.N(r,c);
mask_maj((PC_anom_c.N(r,c)./PC_anom_c.n_max_sample)>=.1)=1;
tmp = double(PC_anom_c.mean(r,c).*mask_maj);

cplot_comps_3_3_chelle(tmp,-.08,.08, ...
	'~/Documents/OSU/figures/ebc/comps/PC_anom_c_bg')
	
mask_maj=nan*PC_anom_a.N(r,c);
mask_maj((PC_anom_a.N(r,c)./PC_anom_a.n_max_sample)>=.1)=1;
tmp = double(PC_anom_a.mean(r,c).*mask_maj);

cplot_comps_3_3_chelle(tmp,-.08,.08, ...
	'~/Documents/OSU/figures/ebc/comps/PC_anom_a_bg')		