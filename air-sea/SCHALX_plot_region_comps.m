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


load region_crlstr_dtdn_coupling_coeff alpha_n
alpha_n_round=round(10000*alpha_n)/10000;
load SCHLAX_region_comps
for mm=1:6
    eval([curs{mm},'_dtdn_a.mean=-(1/.01)*',curs{mm},'_fixed_wek_sst_a.mean;'])
    eval([curs{mm},'_dtdn_c.mean=-(1/.01)*',curs{mm},'_fixed_wek_sst_c.mean;'])
    
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
    flc='schlax_wek_sst_reg_c_with_wek_crl';
    eval(['tmp = ',curs{mm},'_dtdn_c;'])
    eval(['tmp2 = ',curs{mm},'_dtdn_c;'])
%     eval(['n = ',curs{mm},'_dtdn_c.n_max_sample;'])
    pcomps_raw(alpha_n_round(mm).*tmp.mean,alpha_n_round(mm).*tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='schlax_wek_sst_reg_a_with_wek_crl';
    eval(['tmp = ',curs{mm},'_dtdn_a;'])
    eval(['tmp2 = ',curs{mm},'_dtdn_a;'])
%     eval(['n = ',curs{mm},'_dtdn_a.n_max_sample;'])
    pcomps_raw(alpha_n_round(mm).*tmp.mean,alpha_n_round(mm).*tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    %w%ek total and wek reg SST
    flc='schlax_test_wek_add_reg_c';
    eval(['tmp = ',curs{mm},'_wek_total_c;'])
    eval(['tmp2 = ',curs{mm},'_dtdn_c;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_c.n_max_sample;'])
    tmp.mean=tmp.mean+(alpha_n_round(mm).*tmp2.mean);
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='schlax_test_wek_add_reg_a';
    eval(['tmp = ',curs{mm},'_wek_total_a;'])
    eval(['tmp2 = ',curs{mm},'_dtdn_a;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_a.n_max_sample;'])
    tmp.mean=tmp.mean+(alpha_n_round(mm).*tmp2.mean);
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
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
%     eval(['n = ',curs{mm},'_fixed_wek_sst_c.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='wek_sst_fixed_a_with_wek_crl';
%     eval(['tmp = ',curs{mm},'_fixed_wek_sst_a;'])
%     eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_a;'])
%     eval(['n = ',curs{mm},'_fixed_wek_sst_c.n_max_sample;'])
%     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    
end


