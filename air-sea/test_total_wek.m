clear all

curs = {'new_SP',...
    'AGR',...
    'HAW',...
    'EIO',...
    'CAR',...
    'AGU',...
    'new_EIO',...
    'new_SEA'};

%			sst		crl	    W_E		W_Ec	W_T		W_Tc
cranges= [	.3		.4		10		2		0.5		.1		%SP		1
            .7		.7		15		2		15		2		%AGR	2
            .15		.5		20		5		1		.1		%HAW	3
            .4		.7		15		3		2		.25		%EIO	4
            .06		.5		35		5		.5		.1   	%CAR	5
            1		1		15		2		7		1       %SEA	6
            .4		.7		12		2		2		.25     %newEIO 7
            1		1		15		2		7		1 ];    %SEA2	8


% % %
for mm=[2 6]
    cd ~/data/eddy/V6/
%     eval(['subset_tracks_tight_ext_v6(',char(39),curs{mm},'_lat_lon',char(39),')'])
    % %
    load(['~/data/eddy/V6/',curs{mm},'_lat_lon_tracks_V6'])
    ii=find(track_jday>=2452571 & track_jday<=2455159 & age>=12);
    ext_x=ext_x(ii);
    ext_y=ext_y(ii);
    k=k(ii);
    id=id(ii);
    track_jday=track_jday(ii);
    cyc=cyc(ii);
    scale=scale(ii);
    cd ~/matlab/air-sea
    
    eval(['[',curs{mm},'_wek_zeta_a,',curs{mm},'_wek_zeta_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
        char(39),'hp_zeta_wek_est',char(39),',',char(39),...
        '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
        char(39),'n',char(39),');'])
    eval(['[',curs{mm},'_wek_crl_a,',curs{mm},'_wek_crl_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
        char(39),'hp_crl_wek_est',char(39),',',char(39),...
        '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
        char(39),'n',char(39),');'])
    eval(['[',curs{mm},'_wek_total_a,',curs{mm},'_wek_total_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
        char(39),'hp_total_wek_est',char(39),',',char(39),...
        '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
        char(39),'n',char(39),');'])
    
    eval(['[',curs{mm},'_wek_zeta_qscat_a,',curs{mm},'_wek_zeta_qscat_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
        char(39),'hp_zeta_wek_qscat',char(39),',',char(39),...
        '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
        char(39),'n',char(39),');'])
    eval(['[',curs{mm},'_wek_crl_qscat_a,',curs{mm},'_wek_crl_qscat_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
        char(39),'hp_crl_wek_qscat',char(39),',',char(39),...
        '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
        char(39),'n',char(39),');'])
    eval(['[',curs{mm},'_wek_total_qscat_a,',curs{mm},'_wek_total_qscat_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
        char(39),'hp_total_wek_qscat',char(39),',',char(39),...
        '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
        char(39),'n',char(39),');'])
    
    save(['~/matlab/air-sea/V6_',curs{mm},'_comps'],'*_a','*_c','-append')
end

for mm=[2 6]
    load(['V6_',curs{mm},'_comps'],'*_a','*_c')
    
    %%estimated wek crl
    flc='test_wek_crl_c';
    eval(['tmp = ',curs{mm},'_wek_crl_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_crl_c;'])
    eval(['n = ',curs{mm},'_wek_crl_c.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_crl_a';
    eval(['tmp = ',curs{mm},'_wek_crl_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_crl_a;'])
    eval(['n = ',curs{mm},'_wek_crl_a.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_crl_qscat_c';
    eval(['tmp = ',curs{mm},'_wek_crl_qscat_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_crl_qscat_c;'])
    eval(['n = ',curs{mm},'_wek_crl_qscat_c.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_crl_qscat_a';
    eval(['tmp = ',curs{mm},'_wek_crl_qscat_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_crl_qscat_a;'])
    eval(['n = ',curs{mm},'_wek_crl_qscat_a.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    %%estimated wek zeta
    flc='test_wek_zeta_c';
    eval(['tmp = ',curs{mm},'_wek_zeta_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_zeta_c;'])
    eval(['n = ',curs{mm},'_wek_zeta_c.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_zeta_a';
    eval(['tmp = ',curs{mm},'_wek_zeta_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_zeta_a;'])
    eval(['n = ',curs{mm},'_wek_zeta_a.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_zeta_qscat_c';
    eval(['tmp = ',curs{mm},'_wek_zeta_qscat_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_zeta_qscat_c;'])
    eval(['n = ',curs{mm},'_wek_zeta_qscat_c.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_zeta_qscat_a';
    eval(['tmp = ',curs{mm},'_wek_zeta_qscat_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_zeta_qscat_a;'])
    eval(['n = ',curs{mm},'_wek_zeta_qscat_a.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    %%estimated wek total
    flc='test_wek_total_c';
    eval(['tmp = ',curs{mm},'_wek_total_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_total_c;'])
    eval(['n = ',curs{mm},'_wek_total_c.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_total_a';
    eval(['tmp = ',curs{mm},'_wek_total_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_total_a;'])
    eval(['n = ',curs{mm},'_wek_total_a.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_total_qscat_c';
    eval(['tmp = ',curs{mm},'_wek_total_qscat_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_total_qscat_c;'])
    eval(['n = ',curs{mm},'_wek_total_qscat_c.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_total_qscat_a';
    eval(['tmp = ',curs{mm},'_wek_total_qscat_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_total_qscat_a;'])
    eval(['n = ',curs{mm},'_wek_total_qscat_a.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    
end


