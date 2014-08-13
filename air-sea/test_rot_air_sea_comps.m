clear all

curs = {'SP',...
		'AGR',...
		'HAW',...
		'EIO',...
		'CAR',...
		'AGU'};

%			sst		crl	    W_E		W_Ec	W_T		W_Tc				
cranges= [	.3		.4		5		.5		.2		.05		%SP		1
			.7		.7		15		2		15		2		%AGR	2
			.15		.5		10		1		1		.1		%HAW	3
			.4		.7		12		2		2		.25		%EIO	4
			.06		.5		12		2		.3		.1   	%CAR	5
			1		1		15		2		7		1];     %SEA	6
% 
% 
% % % % 
% for m=[1 4]%1:length(curs)
% 
% 	load(['~/data/eddy/V5/',curs{m},'_lat_lon_tracks'])	
% 
% % 	eval(['[',curs{m},'_rot_wek_crlg_a,',curs{m},'_rot_wek_crlg_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% % 	    char(39),'hp_wek_crlg_week',char(39),',',char(39),...
% % 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
% % 		char(39),'w',char(39),');'])
% % 
% %     eval(['[',curs{m},'_rot_wek_sst_a,',curs{m},'_rot_wek_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% % 	    char(39),'hp_wek_sst_week_dtdn',char(39),',',char(39),...
% % 		'~/data/QuickScat/FINAL_mat/QSCAT_30_25km_',char(39),',',...
% % 		char(39),'w',char(39),');'])
%     
%     eval(['[',curs{m},'_rot_wek_a,',curs{m},'_rot_wek_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'wek',char(39),',',char(39),...
% 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
% 		char(39),'w',char(39),');'])
% 		
% 	save(['~/matlab/air-sea/FINAL_',curs{m},'_comps'],'*_a','*_c','-append')	
% end
% 


for m=[1 4]%1:length(curs)
load(['FINAL_',curs{m},'_comps'])
% % % load([curs{m},'_comps'])


% %%wek
% flc='rot_wek_c_with_wek_crl';
% eval(['tmp = ',curs{m},'_rot_wek_c;'])
% eval(['tmp2 = ',curs{m},'_rot_wek_c;'])
% eval(['n = ',curs{m},'_wek_sst_c.n_max_sample;'])
% 
% pcomps_raw(100*tmp.mean,100*tmp2.mean,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% flc='rot_wek_a_with_wek_crl';
% eval(['tmp = ',curs{m},'_rot_wek_a;'])
% eval(['tmp2 = ',curs{m},'_rot_wek_a;'])
% eval(['n = ',curs{m},'_wek_sst_a.n_max_sample;'])
% 
% pcomps_raw(100*tmp.mean,100*tmp2.mean,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% % 
% %%clean sst wek and sst wek
% flc='rot_wek_sst_c_with_wek_crl';
% eval(['tmp = ',curs{m},'_rot_wek_sst_c;'])
% eval(['tmp2 = ',curs{m},'_rot_wek_sst_c;'])
% eval(['n = ',curs{m},'_wek_sst_c.n_max_sample;'])
% tmp.mean=-tmp.mean;
% tmp2.mean=-tmp2.mean;
% % if m==6 | m==5
% % 
% %     tmp.mean=-tmp.median;
% %     tmp2.mean=-tmp2.median;
% % end
% pcomps_raw(tmp.mean,tmp2.mean,[-cranges(m,5) cranges(m,5)],-100,cranges(m,6),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
% 
% flc='rot_wek_sst_a_with_wek_crl';
% eval(['tmp = ',curs{m},'_rot_wek_sst_a;'])
% eval(['tmp2 = ',curs{m},'_rot_wek_sst_a;'])
% eval(['n = ',curs{m},'_wek_sst_a.n_max_sample;'])
% tmp.mean=-tmp.mean;
% tmp2.mean=-tmp2.mean;
% % if m==6 | m==5
% %     tmp.mean=-tmp.median;
% %     tmp2.mean=-tmp2.median;
% % end
% pcomps_raw(tmp.mean,tmp2.mean,[-cranges(m,5) cranges(m,5)],-100,cranges(m,6),100,[''],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

%%clean tot wek and tot wek
flc='rot_wek_tot_c_with_tot_crl';
eval(['tmp = ',curs{m},'_rot_wek_crlg_c;'])
eval(['tmp2 = ',curs{m},'_rot_wek_sst_c;'])
eval(['n = ',curs{m},'_sst_c.n_max_sample;'])

tmp.mean=tmp.mean-tmp2.mean;

pcomps_raw(tmp.mean,tmp.mean,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])


flc='rot_wek_tot_a_with_tot_crl';
eval(['tmp = ',curs{m},'_rot_wek_crlg_a;'])
eval(['tmp2 = ',curs{m},'_rot_wek_sst_a;'])
eval(['n = ',curs{m},'_sst_a.n_max_sample;'])

tmp.mean=tmp.mean-tmp2.mean;

pcomps_raw(tmp.mean,tmp.mean,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])



end	
	