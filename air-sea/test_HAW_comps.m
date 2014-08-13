clear all

curs = {'HAW_1',...
		'HAW_2',...
		'HAW_3'};

%			sst		crl	    W_E		W_Ec	W_T		W_Tc				
cranges= [	.15		.5		8		1		.5		.05		%HAW	1
			.15		.5		8		1		.5		.05		%HAW	2
			.15		.5		8		1		.5		.05];	%HAW	3
			

% 
% 
% for m=1:length(curs)
% 	cd ~/data/eddy/V5/
% 	eval(['subset_tracks_tight_v5(',char(39),curs{m},'_lat_lon',char(39),')'])
% % 
% 	load(['~/data/eddy/V5/',curs{m},'_lat_lon_tracks'])	
% 	cd ~/matlab/air-sea
% 	eval(['[',curs{m},'_wspd_a,',curs{m},'_wspd_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'hp66_wspd',char(39),',',char(39),...
% 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
% 		char(39),'n',char(39),');'])
% % 	eval(['[',curs{m},'_ssh_a,',curs{m},'_ssh_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% % 	    char(39),'ssh',char(39),',',char(39),...
% % 		'~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
% % 		char(39),'n',char(39),');'])
% %   eval(['[',curs{m},'_crlg_a,',curs{m},'_crlg_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% % 	    char(39),'hp66_crlg',char(39),',',char(39),...
% % 		'~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
% % 		char(39),'n',char(39),');'])
% 	eval(['[',curs{m},'_wek_crlg_a,',curs{m},'_wek_crlg_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'hp_wek_crlg_week',char(39),',',char(39),...
% 		'~/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
% 		char(39),'n',char(39),');'])
% 	eval(['[',curs{m},'_wek125_sst_a,',curs{m},'_wek125_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'wek_sst_125',char(39),',',char(39),...
% 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
% 		char(39),'n',char(39),');'])	
% 	eval(['[',curs{m},'_weknods_sst_a,',curs{m},'_weknods_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'wek_sst_no_ds',char(39),',',char(39),...
% 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
% 		char(39),'n',char(39),');'])
% 	eval(['[',curs{m},'_wek_sst_a,',curs{m},'_wek_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'hp_wek_sst_week_dtdn',char(39),',',char(39),...
% 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
% 		char(39),'n',char(39),');'])	    
% 	eval(['[',curs{m},'_wek_a,',curs{m},'_wek_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'wek',char(39),',',char(39),...
% 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
% 		char(39),'n',char(39),');'])	
% 	eval(['[',curs{m},'_sst_a,',curs{m},'_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'hp66_sst',char(39),',',char(39),...
% 		'~/data/ReynoldsSST/mat/OI_25_30_',char(39),',',...
% 		char(39),'n',char(39),');'])		
% 	save(['~/matlab/air-sea/',curs{m},'_comps'],'*_a','*_c','-append')	
% end



for m=1:length(curs)
load([curs{m},'_comps'])
% % % load([curs{m},'_comps'])
%  
% %%sst 125wek and sst wek
% flc='wek125_sst_c_with_wek_crl';
% eval(['tmp = ',curs{m},'_wek125_sst_c;'])
% eval(['tmp2 = ',curs{m},'_wek125_sst_c;'])
% eval(['n = ',curs{m},'_wek_sst_c.n_max_sample;'])
% tmp.median=-tmp.median;
% tmp2.median=-tmp2.median;
% % if m==2
% %     tmp.mean=-tmp.median;
% %     tmp2.mean=-tmp2.median;
% % end
% pcomps_raw(tmp.median,tmp2.median,[-cranges(m,5) cranges(m,5)],-100,cranges(m,6),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% %%sst 125wek and sst wek
% flc='wek125_sst_a_with_wek_crl';
% eval(['tmp = ',curs{m},'_wek125_sst_a;'])
% eval(['tmp2 = ',curs{m},'_wek125_sst_a;'])
% eval(['n = ',curs{m},'_wek_sst_a.n_max_sample;'])
% tmp.median=-tmp.median;
% tmp2.median=-tmp2.median;
% % if m==2
% %     tmp.mean=-tmp.median;
% %     tmp2.mean=-tmp2.median;
% % end
% pcomps_raw(tmp.median,tmp2.median,[-cranges(m,5) cranges(m,5)],-100,cranges(m,6),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% %%sst nodswek and sst wek
% flc='weknods_sst_c_with_wek_crl';
% eval(['tmp = ',curs{m},'_weknods_sst_c;'])
% eval(['tmp2 = ',curs{m},'_weknods_sst_c;'])
% eval(['n = ',curs{m},'_weknods_sst_c.n_max_sample;'])
% tmp.median=-tmp.median;
% tmp2.median=-tmp2.median;
% % if m==2
% %     tmp.mean=-tmp.median;
% %     tmp2.mean=-tmp2.median;
% % end
% pcomps_raw(tmp.median,tmp2.median,[-cranges(m,5) cranges(m,5)],-100,cranges(m,6),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% %%sst nodswek and sst wek
% flc='weknods_sst_a_with_wek_crl';
% eval(['tmp = ',curs{m},'_weknods_sst_a;'])
% eval(['tmp2 = ',curs{m},'_weknods_sst_a;'])
% eval(['n = ',curs{m},'_weknods_sst_a.n_max_sample;'])
% tmp.median=-tmp.median;
% tmp2.median=-tmp2.median;
% % if m==2
% %     tmp.mean=-tmp.median;
% %     tmp2.mean=-tmp2.median;
% % end
% pcomps_raw(tmp.median,tmp2.median,[-cranges(m,5) cranges(m,5)],-100,cranges(m,6),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

% 
% 
% % 
% %%crl and ssh
% flc='crlg_c_with_ssh';
% eval(['tmp = ',curs{m},'_crlg_c;'])
% eval(['tmp2 = ',curs{m},'_ssh_c;'])
% eval(['n = ',curs{m},'_ssh_c.n_max_sample;'])
% 
% pcomps_raw(tmp.median,tmp2.median,[-1e-5*cranges(m,2) 1e-5*cranges(m,2)],-100,2,100,[''],1,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% flc='crlg_a_with_ssh';
% eval(['tmp = ',curs{m},'_crlg_a;'])
% eval(['tmp2 = ',curs{m},'_ssh_a;'])
% eval(['n = ',curs{m},'_ssh_a.n_max_sample;'])
% 
% pcomps_raw(tmp.median,tmp2.median,[-1e-5*cranges(m,2) 1e-5*cranges(m,2)],-100,2,100,[''],1,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
%%SST and SSh
flc='sst_c_with_ssh';
eval(['tmp = ',curs{m},'_sst_c;'])
eval(['tmp2 = ',curs{m},'_sst_c;'])
eval(['n = ',curs{m},'_sst_c.n_max_sample;'])

pcomps_raw(tmp.median,tmp2.median,[-cranges(m,1) cranges(m,1)],-1,.05,1,[''],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='sst_a_with_ssh';
eval(['tmp = ',curs{m},'_sst_a;'])
eval(['tmp2 = ',curs{m},'_sst_a;'])
eval(['n = ',curs{m},'_sst_a.n_max_sample;'])

pcomps_raw(tmp.median,tmp2.median,[-cranges(m,1) cranges(m,1)],-1,.05,1,[''],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

%%wspd and wspd
flc='wspd_c_with_wspd';
eval(['tmp = ',curs{m},'_wspd_c;'])
eval(['tmp2 = ',curs{m},'_wspd_c;'])
eval(['n = ',curs{m},'_wspd_c.n_max_sample;'])

pcomps_raw2(tmp.median,tmp2.median,[-cranges(m,1) cranges(m,1)],-100,.05,100,[''],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='wspd_a_with_wspd';
eval(['tmp = ',curs{m},'_wspd_a;'])
eval(['tmp2 = ',curs{m},'_wspd_a;'])
eval(['n = ',curs{m},'_sst_a.n_max_sample;'])

pcomps_raw2(tmp.median,tmp2.median,[-cranges(m,1) cranges(m,1)],-100,.05,100,[''],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

% % 
% %%wek and wek
% flc='wek_c_with_wek';
% eval(['tmp = ',curs{m},'_wek_c;'])
% eval(['tmp2 = ',curs{m},'_wek_c;'])
% eval(['n = ',curs{m},'_wek_c.n_max_sample;'])
% 
% pcomps_raw(tmp.median,tmp2.median,[-.01*cranges(m,3) .01*cranges(m,3)],-1,.01*cranges(m,4),1,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% flc='wek_a_with_wek';
% eval(['tmp = ',curs{m},'_wek_a;'])
% eval(['tmp2 = ',curs{m},'_wek_a;'])
% eval(['n = ',curs{m},'_wek_a.n_max_sample;'])
% 
% pcomps_raw(tmp.median,tmp2.median,[-.01*cranges(m,3) .01*cranges(m,3)],-1,.01*cranges(m,4),1,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% %%crl wek and crl wek
% flc='wek_crl_c_with_wek_crl';
% eval(['tmp = ',curs{m},'_wek_crlg_c;'])
% eval(['tmp2 = ',curs{m},'_wek_crlg_c;'])
% eval(['n = ',curs{m},'_wek_crlg_c.n_max_sample;'])
% % if m==2
% %     tmp.mean=tmp.median;
% %     tmp2.mean=tmp2.median;
% % end
% pcomps_raw(tmp.median,tmp2.median,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% flc='wek_crl_a_with_wek_crl';
% eval(['tmp = ',curs{m},'_wek_crlg_a;'])
% eval(['tmp2 = ',curs{m},'_wek_crlg_a;'])
% eval(['n = ',curs{m},'_wek_crlg_a.n_max_sample;'])
% % if m==2
% %     tmp.mean=tmp.median;
% %     tmp2.mean=tmp2.median;
% % end
% pcomps_raw(tmp.median,tmp2.median,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% %%sst wek and sst wek
% flc='wek_sst_c_with_wek_crl';
% eval(['tmp = ',curs{m},'_wek_sst_c;'])
% eval(['tmp2 = ',curs{m},'_wek_sst_c;'])
% eval(['n = ',curs{m},'_wek_sst_c.n_max_sample;'])
% tmp.median=-tmp.median;
% tmp2.median=-tmp2.median;
% % if m==2
% %     tmp.mean=-tmp.median;
% %     tmp2.mean=-tmp2.median;
% % end
% pcomps_raw(tmp.median,tmp2.median,[-cranges(m,5) cranges(m,5)],-100,cranges(m,6),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% flc='wek_sst_a_with_wek_crl';
% eval(['tmp = ',curs{m},'_wek_sst_a;'])
% eval(['tmp2 = ',curs{m},'_wek_sst_a;'])
% eval(['n = ',curs{m},'_wek_sst_a.n_max_sample;'])
% tmp.median=-tmp.median;
% tmp2.median=-tmp2.median;
% % if m==2
% %     tmp.mean=-tmp.median;
% %     tmp2.mean=-tmp2.median;
% % end
% pcomps_raw(tmp.median,tmp2.median,[-cranges(m,5) cranges(m,5)],-100,cranges(m,6),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% %%tot wek and tot wek
% flc='wek_tot_c_with_tot_crl';
% eval(['tmp = ',curs{m},'_wek_crlg_c;'])
% eval(['tmp2 = ',curs{m},'_wek_sst_c;'])
% eval(['n = ',curs{m},'_sst_c.n_max_sample;'])
% 
% tmp.mean=tmp.median-tmp2.median;
% tmp.std=tmp2.std;
% pcomps_raw(tmp.mean,tmp.mean,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% 
% flc='wek_tot_a_with_tot_crl';
% eval(['tmp = ',curs{m},'_wek_crlg_a;'])
% eval(['tmp2 = ',curs{m},'_wek_sst_a;'])
% eval(['n = ',curs{m},'_sst_a.n_max_sample;'])
% 
% tmp.mean=tmp.median-tmp2.median;
% tmp.std=tmp2.std;
% pcomps_raw(tmp.mean,tmp.mean,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 


end	
	