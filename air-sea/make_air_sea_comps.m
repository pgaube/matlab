clear all
%
set_air_sea

for m=1:length(curs)
load(['/matlab/matlab/domains/air-sea_',low_curs{m},'_lat_lon'])
load(['/matlab/data/eddy/V4/air-sea_',low_curs{m},'_lat_lon_tracks'])
%{
eval(['[',curs{m},'_wek_a,',curs{m},'_wek_c]=mcomps(',char(39),...
'/matlab/data/eddy/V4/air-sea_',low_curs{m},'_lat_lon_tracks',...
char(39),',',char(39),'nrw_ek_sample',chr(39),',',char(39),'n',char(39),');'])
%[AGU_sst_a,AGU_sst_c]=mcomps('/matlab/data/eddy/V4/air-sea_agu_lat_lon_tracks','nrbp26_sst_sample','n');
%[AGU_ssh_a,AGU_ssh_c]=mcomps('/matlab/data/eddy/V4/air-sea_agu_lat_lon_tracks','nrssh_sample','n');
%[AGU_raw_a,AGU_raw_c]=mcomps('/matlab/data/eddy/V4/air-sea_agu_lat_lon_tracks','nrraw_hp66_chl_sample','n');
%[AGU_wek_crlg_a,AGU_wek_crlg_c]=mcomps('/matlab/data/eddy/V4/air-sea_agu_lat_lon_tracks','nrhp_wek_crlg_week_sample','n');
%[AGU_crlg_a,AGU_crlg_c]=mcomps('/matlab/data/eddy/V4/air-sea_agu_lat_lon_tracks','nrbp26_crlg_sample','n');
%[AGU_wek_sst_a,AGU_wek_sst_c]=mcomps('/matlab/data/eddy/V4/air-sea_agu_lat_lon_tracks','nrhp_wek_sst_week_dtdn_sample','n');
%[AGU_wek_drift_a,AGU_wek_drift_c]=mcomps('/matlab/data/eddy/V4/air-sea_agu_lat_lon_tracks','nrhp_wek_drift_week_sample','n');
%[AGU_wek_all_a,AGU_wek_all_c]=mcomps('/matlab/data/eddy/V4/air-sea_agu_lat_lon_tracks','nrhp_wek_total_week_sample','n');
eval(['save -append ',curs{m},'_comps']) 

%}

load([curs{m},'_comps'])
r=9:41;
c=9:41;

eval([
tmp = double(interp2(AGU_wek_crlg_c.median(r,c),2));
tmp2 = double(interp2(AGU_wek_crlg_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-10,10,1,-100,100,'AVISO Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/AGU_wek_crlg_c_with_wek_crlg']) 


fla='AGU_wek_crlg_a_with_wek_crlg';
tmp = double(interp2(AGU_wek_crlg_a.median(r,c),2));
tmp2 = double(interp2(AGU_wek_crlg_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-10,10,1,-100,100,'AVISO Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',fla]) 
	
%{
flc='AGU_wek_all_c_with_wek_all';
tmp = double(interp2(AGU_wek_all_c.median(r,c),2));
tmp2 = double(interp2(AGU_wek_all_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,.5,-100,100,'combined Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',flc]) 


fla='AGU_wek_all_a_with_wek_all';
tmp = double(interp2(AGU_wek_all_a.median(r,c),2));
tmp2 = double(interp2(AGU_wek_all_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,.5,-100,100,'combined Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',fla]) 
%}

flc='AGU_wek_sst_c_with_wek_sst';
tmp = double(interp2(AGU_wek_sst_c.median(r,c),2));
tmp2 = double(interp2(AGU_wek_sst_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-10,10,'SST-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',flc]) 


fla='AGU_wek_sst_a_with_wek_sst';
tmp = double(interp2(AGU_wek_sst_a.median(r,c),2));
tmp2 = double(interp2(AGU_wek_sst_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-10,10,'SST-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',fla]) 
%{	
flc='AGU_wek_drift_c_with_wek_drift';
tmp = double(interp2(AGU_wek_drift_c.median(r,c),2));
tmp2 = double(interp2(AGU_wek_drift_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.0.5,-10,10,'Drift-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',flc]) 


fla='AGU_wek_drift_a_with_wek_drift';
tmp = double(interp2(AGU_wek_drift_a.median(r,c),2));
tmp2 = double(interp2(AGU_wek_drift_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.0.5,-10,10,'Drift-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',fla]) 
%}
flc='AGU_wek_c_with_wek';
tmp = double(interp2(AGU_wek_c.median(r,c),2));
tmp2 = double(interp2(AGU_wek_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-1,1,'QuikSCAT Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',flc]) 


fla='AGU_wek_a_with_wek';
tmp = double(interp2(AGU_wek_a.median(r,c),2));
tmp2 = double(interp2(AGU_wek_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-1,1,'QuikSCAT Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',fla]) 
	
flc='AGU_ssh_c_with_ssh';
tmp = double(interp2(AGU_ssh_c.median(r,c),2));
tmp2 = double(interp2(AGU_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-30,30,2,-100,100,'AVISO SSH Cyclones',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',flc]) 
 
flc='AGU_ssh_a_with_ssh';
tmp = double(interp2(AGU_ssh_a.median(r,c),2));
tmp2 = double(interp2(AGU_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-30,30,2,-100,100,'AVISO SSH Anticyclones',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',flc]) 
	
flc='AGU_crlg_c_with_ssh';
tmp = double(interp2(AGU_crlg_c.median(r,c),2));
tmp2 = double(interp2(AGU_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-1,1,2,-100,100,'AVISO @MAiD@ u_g^ Cyclones',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',flc]) 
 
flc='AGU_crlg_a_with_ssh';
tmp = double(interp2(AGU_crlg_a.median(r,c),2));
tmp2 = double(interp2(AGU_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-1,1,2,-100,100,'AVISO @MAiD@ u_g^ Anticyclones',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',flc]) 
		
flc='AGU_sst_c_with_ssh';
tmp = double(interp2(AGU_sst_c.median(r,c),2));
tmp2 = double(interp2(AGU_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-1,1,2,-100,100,'NOAA SST Cyclones',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',flc]) 
 
flc='AGU_sst_a_with_ssh';
tmp = double(interp2(AGU_sst_a.median(r,c),2));
tmp2 = double(interp2(AGU_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-1,1,2,-100,100,'NOAA SST Anticyclones',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',flc]) 	
	
return	
flc='AGU_raw_c_with_wek';
tmp = double(interp2(AGU_raw_c.median(r,c),2));
tmp2 = double(interp2(AGU_wek_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.005,-1,1,'GSM CHL Cyclones',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',flc]) 
 
flc='AGU_raw_a_with_ssh';
tmp = double(interp2(AGU_raw_a.median(r,c),2));
tmp2 = double(interp2(AGU_wek_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.005,-1,1,'GSM CHL Anticyclones',...
	['~/Documents/OSU/figures/air-sea/AGU_comps/',flc]) 		