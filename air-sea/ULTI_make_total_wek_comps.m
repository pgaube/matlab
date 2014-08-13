clear all

curs = {'new_SP',...
    'AGR',...
    'HAW',...
    'EIO',...
    'CAR',...
    'AGU',...
    'new_EIO',...
    'new_SEA',...
    'SP'};

%			sst		crl	    W_E		W_Ec	W_T		W_Tc
cranges= [	.3		.4		10		2		1		.25		%SP		1
            .7		.7		35		5		15		2		%AGR	2
            .15		.5		20		5		2		.2		%HAW	3
            .4		.7		15		3		3		.5		%EIO	4
            .06		.5		35		5		3		.5   	%CAR	5
            1		1		20		5		10		1       %SEA	6
            .4		.7		12		2		2		.25     %newEIO 7
            1		1		15		2		7		1       %SEA2	8
            .3		.4		10		2		1		.25];	%old SP 9


% %
% %
% for mm=9%1:6
%     cd ~/data/eddy/V6/
%         eval(['subset_tracks_tight_ext_v6(',char(39),curs{mm},'_lat_lon',char(39),')'])
%     %
%     load(['~/data/eddy/V6/',curs{mm},'_lat_lon_tracks_V6'])
%     ii=find(track_jday>=2452571 & track_jday<=2455159 & age>=12);
%     ext_x=ext_x(ii);
%     ext_y=ext_y(ii);
%     k=k(ii);
%     id=id(ii);
%     track_jday=track_jday(ii);
%     cyc=cyc(ii);
%     scale=scale(ii);
%     cd ~/matlab/air-sea
%     
%     %     eval(['[',curs{mm},'_wek_zeta_a,',curs{mm},'_wek_zeta_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%     %         char(39),'hp_zeta_wek_est',char(39),',',char(39),...
%     %         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%     %         char(39),'n',char(39),');'])
%     %     eval(['[',curs{mm},'_wek_crl_a,',curs{mm},'_wek_crl_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%     %         char(39),'hp_crl_wek_est',char(39),',',char(39),...
%     %         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%     %         char(39),'n',char(39),');'])
%     eval(['[',curs{mm},'_wek_total_a,',curs{mm},'_wek_total_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp_total_wek_est',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
%     
%     %     eval(['[',curs{mm},'_rot_wek_total_a,',curs{mm},'_rot_wek_total_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%     %         char(39),'hp_total_wek_est',char(39),',',char(39),...
%     %         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%     %         char(39),'w',char(39),');'])
%     %
%     %     eval(['[',curs{mm},'_wek_zeta_qscat_a,',curs{mm},'_wek_zeta_qscat_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%     %         char(39),'hp_zeta_wek_qscat',char(39),',',char(39),...
%     %         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%     %         char(39),'n',char(39),');'])
%     %     eval(['[',curs{mm},'_wek_crl_qscat_a,',curs{mm},'_wek_crl_qscat_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%     %         char(39),'hp_crl_wek_qscat',char(39),',',char(39),...
%     %         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%     %         char(39),'n',char(39),');'])
%     eval(['[',curs{mm},'_wek_total_qscat_a,',curs{mm},'_wek_total_qscat_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp_total_wek_qscat',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
%     %
%     eval(['[',curs{mm},'_wek_sst_a,',curs{mm},'_wek_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp_wek_sst_week_cross',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
%     
%     eval(['[',curs{mm},'_fixed_wek_sst_a,',curs{mm},'_fixed_wek_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp_wek_sst_week_fixed',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
%     
%     eval(['[',curs{mm},'_crlg_a,',curs{mm},'_crlg_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp66_crlg',char(39),',',char(39),...
%         '~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
%         char(39),'n',char(39),');'])
% %     
%     eval(['[',curs{mm},'_ssh_a,',curs{mm},'_ssh_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'ssh',char(39),',',char(39),...
%         '~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
%         char(39),'n',char(39),');'])
%     
%     
%     eval(['[',curs{mm},'_sst_a,',curs{mm},'_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp66_sst',char(39),',',char(39),...
%         '~/data/ReynoldsSST/mat/OI_25_30_',char(39),',',...
%         char(39),'n',char(39),');'])
%         eval(['[',curs{mm},'_dtdn_a,',curs{mm},'_dtdn_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%             char(39),'norm_hp66_dtdn',char(39),',',char(39),...
%             '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%             char(39),'n',char(39),');'])
%     
%     save(['~/matlab/air-sea/V6_',curs{mm},'_comps'],'*_a','*_c','-append')
% end
% 
% 
% 




load region_crlstr_dtdn_coupling_coeff alpha_n
alpha_n_round=-round(10000*alpha_n)/10000;

for mm=5%1:6
    load(['V6_',curs{mm},'_comps'],'*_a','*_c')
%     

%%%% Test understimation of W_sst

% %     %wek total and wek reg SST plus 20% test
%     flc='test_wek_add_reg_ten_percent_c';
%     eval(['tmp = ',curs{mm},'_wek_total_c;'])
%     eval(['tmp2 = ',curs{mm},'_dtdn_c;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_c.n_max_sample;'])
%     tmp.mean=tmp.mean+(1.5*alpha_n_round(mm).*tmp2.mean);
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_add_reg_ten_percent_a';
%     eval(['tmp = ',curs{mm},'_wek_total_a;'])
%     eval(['tmp2 = ',curs{mm},'_dtdn_a;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_a.n_max_sample;'])
%     tmp.mean=tmp.mean+(1.5*alpha_n_round(mm).*tmp2.mean);
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])

    
    
%     
%     %crl and ssh
%     flc='crlg_c_with_ssh';
%     eval(['tmp = ',curs{mm},'_crlg_c;'])
%     eval(['tmp2 = ',curs{mm},'_ssh_c;'])
%     eval(['n = ',curs{mm},'_ssh_c.n_max_sample;'])
%     
%     pcomps_raw(tmp.mean,tmp2.mean,[-1e-5*cranges(mm,2) 1e-5*cranges(mm,2)],-100,2,100,[''],1,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='crlg_a_with_ssh';
%     eval(['tmp = ',curs{mm},'_crlg_a;'])
%     eval(['tmp2 = ',curs{mm},'_ssh_a;'])
%     eval(['n = ',curs{mm},'_ssh_a.n_max_sample;'])
%     
%     pcomps_raw(tmp.mean,tmp2.mean,[-1e-5*cranges(mm,2) 1e-5*cranges(mm,2)],-100,2,100,[''],1,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     %%SST and SSh
%     flc='sst_c_with_ssh';
%     eval(['tmp = ',curs{mm},'_sst_c;'])
%     eval(['tmp2 = ',curs{mm},'_ssh_c;'])
%     eval(['n = ',curs{mm},'_sst_c.n_max_sample;'])
%     
%     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,1) cranges(mm,1)],-100,2,100,[''],1,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='sst_a_with_ssh';
%     eval(['tmp = ',curs{mm},'_sst_a;'])
%     eval(['tmp2 = ',curs{mm},'_ssh_a;'])
%     eval(['n = ',curs{mm},'_sst_a.n_max_sample;'])
%     
%     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,1) cranges(mm,1)],-100,2,100,[''],1,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     

    %%wek SST regional coupco
    flc='wek_sst_reg_c_with_wek_crl';
    eval(['tmp = ',curs{mm},'_dtdn_c;'])
    eval(['tmp2 = ',curs{mm},'_dtdn_c;'])
    eval(['n = ',curs{mm},'_wek_sst_c.n_max_sample;'])
    pcomps_raw(alpha_n_round(mm).*tmp.mean,alpha_n_round(mm).*tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='wek_sst_reg_a_with_wek_crl';
    eval(['tmp = ',curs{mm},'_dtdn_a;'])
    eval(['tmp2 = ',curs{mm},'_dtdn_a;'])
    eval(['n = ',curs{mm},'_wek_sst_a.n_max_sample;'])
    pcomps_raw(alpha_n_round(mm).*tmp.mean,alpha_n_round(mm).*tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
%     %w%ek total and wek fixed SST
%     flc='test_wek_add_reg_c';
%     eval(['tmp = ',curs{mm},'_wek_total_c;'])
%     eval(['tmp2 = ',curs{mm},'_dtdn_c;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_c.n_max_sample;'])
%     tmp.mean=tmp.mean+(alpha_n_round(mm).*tmp2.mean);
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_add_reg_a';
%     eval(['tmp = ',curs{mm},'_wek_total_a;'])
%     eval(['tmp2 = ',curs{mm},'_dtdn_a;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_a.n_max_sample;'])
%     tmp.mean=tmp.mean+(alpha_n_round(mm).*tmp2.mean);
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     %%wek crl
%     flc='test_wek_crl_c';
%     eval(['tmp = ',curs{mm},'_wek_crl_c;'])
%     eval(['tmp2 = ',curs{mm},'_wek_crl_c;'])
%     eval(['n = ',curs{mm},'_wek_crl_c.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_crl_a';
%     eval(['tmp = ',curs{mm},'_wek_crl_a;'])
%     eval(['tmp2 = ',curs{mm},'_wek_crl_a;'])
%     eval(['n = ',curs{mm},'_wek_crl_a.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_crl_qscat_c';
%     eval(['tmp = ',curs{mm},'_wek_crl_qscat_c;'])
%     eval(['tmp2 = ',curs{mm},'_wek_crl_qscat_c;'])
%     eval(['n = ',curs{mm},'_wek_crl_qscat_c.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_crl_qscat_a';
%     eval(['tmp = ',curs{mm},'_wek_crl_qscat_a;'])
%     eval(['tmp2 = ',curs{mm},'_wek_crl_qscat_a;'])
%     eval(['n = ',curs{mm},'_wek_crl_qscat_a.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     %%wek zeta
%     flc='test_wek_zeta_c';
%     eval(['tmp = ',curs{mm},'_wek_zeta_c;'])
%     eval(['tmp2 = ',curs{mm},'_wek_zeta_c;'])
%     eval(['n = ',curs{mm},'_wek_zeta_c.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_zeta_a';
%     eval(['tmp = ',curs{mm},'_wek_zeta_a;'])
%     eval(['tmp2 = ',curs{mm},'_wek_zeta_a;'])
%     eval(['n = ',curs{mm},'_wek_zeta_a.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_zeta_qscat_c';
%     eval(['tmp = ',curs{mm},'_wek_zeta_qscat_c;'])
%     eval(['tmp2 = ',curs{mm},'_wek_zeta_qscat_c;'])
%     eval(['n = ',curs{mm},'_wek_zeta_qscat_c.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_zeta_qscat_a';
%     eval(['tmp = ',curs{mm},'_wek_zeta_qscat_a;'])
%     eval(['tmp2 = ',curs{mm},'_wek_zeta_qscat_a;'])
%     eval(['n = ',curs{mm},'_wek_zeta_qscat_a.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     %wek total
%     flc='test_wek_total_c';
%     eval(['tmp = ',curs{mm},'_wek_total_c;'])
%     eval(['tmp2 = ',curs{mm},'_wek_total_c;'])
%     eval(['n = ',curs{mm},'_wek_total_c.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_total_a';
%     eval(['tmp = ',curs{mm},'_wek_total_a;'])
%     eval(['tmp2 = ',curs{mm},'_wek_total_a;'])
%     eval(['n = ',curs{mm},'_wek_total_a.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_total_qscat_c';
%     eval(['tmp = ',curs{mm},'_wek_total_qscat_c;'])
%     eval(['tmp2 = ',curs{mm},'_wek_total_qscat_c;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_c.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_total_qscat_a';
%     eval(['tmp = ',curs{mm},'_wek_total_qscat_a;'])
%     eval(['tmp2 = ',curs{mm},'_wek_total_qscat_a;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_a.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     %%wek total and wek SST
%     flc='test_wek_add_qscat_c';
%     eval(['tmp = ',curs{mm},'_wek_total_c;'])
%     eval(['tmp2 = ',curs{mm},'_wek_sst_c;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_c.n_max_sample;'])
%     tmp.mean=tmp.mean+tmp2.mean;
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_add_qscat_a';
%     eval(['tmp = ',curs{mm},'_wek_total_a;'])
%     eval(['tmp2 = ',curs{mm},'_wek_sst_a;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_a.n_max_sample;'])
%     tmp.mean=tmp.mean+tmp2.mean;
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     %%wek SST
%     flc='wek_sst_c_with_wek_crl';
%     eval(['tmp = ',curs{mm},'_wek_sst_c;'])
%     eval(['tmp2 = ',curs{mm},'_wek_sst_c;'])
%     eval(['n = ',curs{mm},'_wek_sst_c.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='wek_sst_a_with_wek_crl';
%     eval(['tmp = ',curs{mm},'_wek_sst_a;'])
%     eval(['tmp2 = ',curs{mm},'_wek_sst_a;'])
%     eval(['n = ',curs{mm},'_wek_sst_a.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     %wek total and wek fixed SST
%     flc='test_wek_add_fix_qscat_c';
%     eval(['tmp = ',curs{mm},'_wek_total_c;'])
%     eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_c;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_c.n_max_sample;'])
%     tmp.mean=tmp.mean+tmp2.mean;
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_add_fix_qscat_a';
%     eval(['tmp = ',curs{mm},'_wek_total_a;'])
%     eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_a;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_a.n_max_sample;'])
%     tmp.mean=tmp.mean+tmp2.mean;
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     %%wek fixed SST
%     flc='wek_sst_fixed_c_with_wek_crl';
%     eval(['tmp = ',curs{mm},'_fixed_wek_sst_c;'])
%     eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_c;'])
%     eval(['n = ',curs{mm},'_wek_sst_c.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='wek_sst_fixed_a_with_wek_crl';
%     eval(['tmp = ',curs{mm},'_fixed_wek_sst_a;'])
%     eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_a;'])
%     eval(['n = ',curs{mm},'_wek_sst_a.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     wek total rotated
%     flc='rot_wek_total_c';
%     eval(['tmp = ',curs{mm},'_rot_wek_total_c;'])
%     eval(['tmp2 = ',curs{mm},'_rot_wek_total_c;'])
%     eval(['n = ',curs{mm},'_wek_total_c.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='rot_wek_total_a';
%     eval(['tmp = ',curs{mm},'_rot_wek_total_a;'])
%     eval(['tmp2 = ',curs{mm},'_rot_wek_total_a;'])
%     eval(['n = ',curs{mm},'_wek_total_a.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
end


