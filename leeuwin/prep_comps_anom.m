clear all

load leeuwin_anom_comps

mask_maj=nan*lw_anom_10_50_c.N(r,c);
mask_min=nan*lw_anom_10_50_c.N(r,c);
mask_maj((lw_anom_10_50_c.N(r,c)./lw_anom_10_50_c.n_max_sample)>=.1)=1;
mask_min(lw_anom_10_50_c.N(r,c)>=5)=1;
tmpc = double(lw_anom_10_50_c.mean(r,c).*mask_min);

mask_maj2=nan*lw_anom_10_50_a.N(r,c);
mask_min2=nan*lw_anom_10_50_a.N(r,c);
mask_maj2((lw_anom_10_50_a.N(r,c)./lw_anom_10_50_a.n_max_sample)>=.1)=1;
mask_min2(lw_anom_10_50_a.N(r,c)>=5)=1;
tmpa = double(lw_anom_10_50_a.mean(r,c).*mask_min2);

tmaskc = double(lw_trap_10_50_c.N(r,c));
tmaska = double(lw_trap_10_50_a.N(r,c));

%[l_lac,t_lac]=transect(tmpc,100,-.1,.1);
%[l_lac,t_lac]=transect(tmpa,100,-.1,.1);


cplot_comps2(tmpc,-.07,.07, ...
	'~/Documents/OSU/figures/leeuwin/leeuwin_anom_c_bg')
cplot_comps2(tmpa,-.07,.07, ...
	'~/Documents/OSU/figures/leeuwin/leeuwin_anom_a_bg')	

tmpc = double(lw_anom_10_50_c.mean(r,c).*mask_maj);
tmpa = double(lw_anom_10_50_a.mean(r,c).*mask_maj2);

cplot_comps2_cont(tmpc,(tmaskc./lw_trap_10_50_c.n_max_sample).*100,-.07,.07,5,85,100, ...
	'~/Documents/OSU/figures/leeuwin/leeuwin_anom_c')
cplot_comps2_cont(tmpa,(tmaska./lw_trap_10_50_a.n_max_sample).*100,-.07,.07,5,85,100, ...
	'~/Documents/OSU/figures/leeuwin/leeuwin_anom_a')	