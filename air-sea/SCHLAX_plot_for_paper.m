
clear all

load region_crlstr_dtdn_coupling_coeff alpha_n
alpha_n_round=round(1000*alpha_n(9))/1000
multi=[.94 .98 1.2];

load SCHLAX_wind_SH_comps
load ULTI_wind_SH_comps w_ek_total_qscat*

w_ek_total_qscat_a.mean=multi(2).*w_ek_total_qscat_a.mean;
w_ek_total_qscat_c.mean=multi(2).*w_ek_total_qscat_c.mean;
%%From QSCAT

pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SCHLAX_sh_wek_total_qscat_c'])

pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SCHLAX_sh_wek_total_qscat_a'])

pcomps_raw2(w_ek_total_c.mean,w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SCHLAX_sh_wek_total_c'])

pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SCHLAX_sh_wek_total_a'])

pcomps_raw2(w_ek_total_c.mean-(0.013/0.01)*w_ek_sst_fixed_c.mean,w_ek_total_c.mean-(0.013/0.01)*w_ek_sst_fixed_c.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SCHLAX_sh_wek_add_fixed_c'])

pcomps_raw2(w_ek_total_a.mean-(0.013/0.01)*w_ek_sst_fixed_a.mean,w_ek_total_a.mean-(0.013/0.01)*w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SCHLAX_sh_wek_add_fixed_a'])

pcomps_raw2(-(0.013/0.01)*w_ek_sst_fixed_c.mean,-(0.013/0.01)*w_ek_sst_fixed_c.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SCHLAX_sh_wek_sst_fixed_c'])

pcomps_raw2(-(0.013/0.01)*w_ek_sst_fixed_a.mean,-(0.013/0.01)*w_ek_sst_fixed_a.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SCHLAX_sh_wek_sst_fixed_a'])
return


load SCHLAX_wind_NH_comps
w_ek_total_qscat_a.mean=multi(1).*w_ek_total_qscat_a.mean;
w_ek_total_qscat_c.mean=multi(1).*w_ek_total_qscat_c.mean;
% 
% % %%From QSCAT
% pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot} N=',num2str(num_c)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_total_qscat_c'])
% 
% pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot} N=',num2str(num_a)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_total_qscat_a'])
% % 
pcomps_raw2(noro_w_ek_total_qscat_c.mean,noro_w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_noro_wek_total_qscat_c'])

pcomps_raw2(noro_w_ek_total_qscat_a.mean,noro_w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_noro_wek_total_qscat_a'])
% 
% %%Estimated
% 
% pcomps_raw2(w_ek_total_c.mean+w_ek_sst_fixed_c.mean,w_ek_total_c.mean+w_ek_sst_fixed_c.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST} N=',num2str(num_c)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_add_fixed_c'])
% 
% pcomps_raw2(w_ek_total_a.mean+w_ek_sst_fixed_a.mean,w_ek_total_a.mean+w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST} N=',num2str(num_a)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_add_fixed_a'])
% 
% pcomps_raw2(w_ek_sst_fixed_c.mean,w_ek_sst_fixed_c.mean,[-2 2],-100,.2,100,['W_{SST} N=',num2str(num_c)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_sst_ixed_c'])
% 
% pcomps_raw2(w_ek_sst_fixed_a.mean,w_ek_sst_fixed_a.mean,[-2 2],-100,.2,100,['W_{SST} N=',num2str(num_a)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_sst_fixed_a'])
% 
% 
% pcomps_raw2(w_ek_total_c.mean,w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur} N=',num2str(num_c)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_total_c'])
% 
% pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur} N=',num2str(num_a)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_total_a'])
% % 
pcomps_raw2(noro_w_ek_total_c.mean,noro_w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_noro_wek_total_c'])

pcomps_raw2(noro_w_ek_total_a.mean,noro_w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_noro_wek_total_a'])
% % 
pcomps_raw2(noro_w_ek_total_c.mean+noro_w_ek_sst_fixed_c.mean,noro_w_ek_total_c.mean+noro_w_ek_sst_fixed_c.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_noro_wek_add_fixed_c'])

pcomps_raw2(noro_w_ek_total_a.mean+noro_w_ek_sst_fixed_a.mean,noro_w_ek_total_a.mean+noro_w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_noro_wek_add_fixed_a'])
% % 
% % pcomps_raw2(noro_w_ek_sst_fixed_c.mean,noro_w_ek_sst_fixed_c.mean,[-2 2],-100,.2,100,['SST N=',num2str(num_c)],2,30)
% % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_noro_wek_sst_ixed_c'])
% % 
% % pcomps_raw2(noro_w_ek_sst_fixed_a.mean,noro_w_ek_sst_fixed_a.mean,[-2 2],-100,.2,100,['SST N=',num2str(num_c)],2,30)
% % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_noro_wek_sst_fixed_a'])

% pcomps_raw2(alpha_n_round.*dtdn_c.mean,alpha_n_round.*dtdn_c.mean,[-2 2],-100,.2,100,['W_{SST} N=',num2str(num_c)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_dtdn_wek_c'])
% 
% pcomps_raw2(alpha_n_round.*dtdn_a.mean,alpha_n_round.*dtdn_a.mean,[-2 2],-100,.2,100,['W_{SST} N=',num2str(num_c)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_dtdn_wek_a'])
% % 
% pcomps_raw2(w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean),w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean),[-10 10],-100,1,100,['W_{cur}+W_{SST} N=',num2str(num_c)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_dtdn_wek_add_c'])
% 
% pcomps_raw2(w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean),w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean),[-10 10],-100,1,100,['W_{cur}+W_{SST} N=',num2str(num_c)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_dtdn_wek_add_a'])

% return
%%NOW plot midlat
load  SCHLAX_wind_midlat_rot_comps
w_ek_total_qscat_a.mean=multi(3).*w_ek_total_qscat_a.mean;
w_ek_total_qscat_c.mean=multi(3).*w_ek_total_qscat_c.mean;
%%%From SST
% pcomps_raw2(w_ek_sst_fixed_c.mean,w_ek_sst_fixed_c.mean,[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_sst_fixed_c'])
% 
% pcomps_raw2(w_ek_sst_fixed_a.mean,w_ek_sst_fixed_a.mean,[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_sst_fixed_a'])

% pcomps_raw2(noro_w_ek_sst_c.mean,noro_w_ek_sst_c.mean,[-2 2],-100,.1,100,['SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/noro_wek_sst_c'])
% 
% pcomps_raw2(noro_w_ek_sst_a.mean,noro_w_ek_sst_a.mean,[-2 2],-100,.1,100,['SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/noro_wek_sst_a'])

pcomps_raw2(noro_w_ek_total_c.mean+noro_w_ek_sst_fixed_c.mean,noro_w_ek_total_c.mean+noro_w_ek_sst_fixed_c.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/noro_wek_add_fixed_c'])

pcomps_raw2(noro_w_ek_total_a.mean+noro_w_ek_sst_fixed_a.mean,noro_w_ek_total_a.mean+noro_w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/noro_wek_add_fixed_a'])

%%%From QSCAT
% pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_total_qscat_c'])
% 
% pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_total_qscat_a'])

pcomps_raw2(noro_w_ek_total_qscat_c.mean,noro_w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/noro_wek_total_qscat_c'])

pcomps_raw2(noro_w_ek_total_qscat_a.mean,noro_w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/noro_wek_total_qscat_a'])

% % % pcomps_raw2(w_ek_crlg_qscat_c.mean,w_ek_crlg_qscat_c.mean,[-10 10],-100,1,100,['QuikSCAT Stress Curl pumping'],2,30)
% % % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_crlg_qscat_c'])
% % % 
% % % pcomps_raw2(w_ek_crlg_qscat_a.mean,w_ek_crlg_qscat_a.mean,[-10 10],-100,1,100,['QuikSCAT Stress Curl pumping'],2,30)
% % % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_crlg_qscat_a'])
% % % 
% % % pcomps_raw2(w_ek_zeta_qscat_c.mean,w_ek_zeta_qscat_c.mean,[-10 10],-100,1,100,['QuikSCAT Stress Curl pumping'],2,30)
% % % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_zeta_qscat_c'])
% % % 
% % % pcomps_raw2(w_ek_zeta_qscat_a.mean,w_ek_zeta_qscat_a.mean,[-10 10],-100,1,100,['QuikSCAT Stress Curl pumping'],2,30)
% % % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_zeta_qscat_a'])
% 
%%%Estimated
% pcomps_raw2(w_ek_total_c.mean,w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_total_c'])
% 
% pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_total_a'])

pcomps_raw2(noro_w_ek_total_c.mean,noro_w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/noro_wek_total_c'])

pcomps_raw2(noro_w_ek_total_a.mean,noro_w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/noro_wek_total_a'])
% % % 
% % % pcomps_raw2(w_ek_crlg_c.mean,w_ek_crlg_c.mean,[-10 10],-100,1,100,['Stress Curl pumping'],2,30)
% % % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_crlg_c'])
% % % 
% % % pcomps_raw2(w_ek_crlg_a.mean,w_ek_crlg_a.mean,[-10 10],-100,1,100,['Stress Curl pumping'],2,30)
% % % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_crlg_a'])
% % % 
% % % pcomps_raw2(w_ek_zeta_c.mean,w_ek_zeta_c.mean,[-10 10],-100,1,100,['QuikSCAT Stress Curl pumping'],2,30)
% % % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_zeta_c'])
% % % 
% % % pcomps_raw2(w_ek_zeta_a.mean,w_ek_zeta_a.mean,[-10 10],-100,1,100,['QuikSCAT Stress Curl pumping'],2,30)
% % % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_zeta_a'])
% 
% %%%Combined
% pcomps_raw2(w_ek_total_c.mean+w_ek_sst_fixed_c.mean,w_ek_total_c.mean+w_ek_sst_fixed_c.mean,[-10 10],-100,1,100,['Current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_add_fixed_c'])
% 
% pcomps_raw2(w_ek_total_a.mean+w_ek_sst_fixed_a.mean,w_ek_total_a.mean+w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['Current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_add_fixed_a'])

% pcomps_raw2(noro_w_ek_total_c.mean+noro_w_ek_sst_c.mean,noro_w_ek_total_c.mean+noro_w_ek_sst_c.mean,[-10 10],-100,1,100,['Current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/noro_wek_add_c'])
% 
% pcomps_raw2(noro_w_ek_total_a.mean+noro_w_ek_sst_a.mean,noro_w_ek_total_a.mean+noro_w_ek_sst_a.mean,[-10 10],-100,1,100,['Current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/noro_wek_add_a'])
% 
% pcomps_raw2(noro_w_ek_total_c.mean+noro_w_ek_sst_fixed_c.mean,noro_w_ek_total_c.mean+noro_w_ek_sst_fixed_c.mean,[-10 10],-100,1,100,['Current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/noro_wek_add_fixed_c'])
% 
% pcomps_raw2(noro_w_ek_total_a.mean+noro_w_ek_sst_fixed_a.mean,noro_w_ek_total_a.mean+noro_w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['Current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/noro_wek_add_fixed_a'])

% pcomps_raw2(alpha_n_round.*dtdn_c.mean,alpha_n_round.*dtdn_c.mean,[-1 1],-100,.1,100,['W_{SST}'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/dtdn_wek_c'])
% 
% pcomps_raw2(alpha_n_round.*dtdn_a.mean,alpha_n_round.*dtdn_a.mean,[-1 1],-100,.1,100,['W_{SST}'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/dtdn_wek_a'])
% 
% pcomps_raw2(w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean),w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean),[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/dtdn_wek_add_c'])
% 
% pcomps_raw2(w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean),w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean),[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/dtdn_wek_add_a'])

% %%%test
% pcomps_raw2(w_ek_total_qscat_c.mean-w_ek_total_c.mean,w_ek_total_qscat_c.mean-w_ek_total_c.mean,[-.2 .2],-1,.01,1,['QSCAT-Estimated'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/test_total_qscat_c'])
% 
% pcomps_raw2(w_ek_total_qscat_a.mean-w_ek_total_a.mean,w_ek_total_qscat_a.mean-w_ek_total_a.mean,[-.2 .2],-1,.01,1,['QSCAT-Estimated'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/test_total_qscat_a'])

