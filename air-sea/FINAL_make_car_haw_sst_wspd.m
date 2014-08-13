clear all

curs = {'CAR'};

%			sst		crl	    W_E		W_Ec	W_T		W_Tc				
cranges= [	.06		.5		10		1		.05		.01];	%CAR	2



for m=1:length(curs)
load(['FINAL_',curs{m},'_comps'])
% % % load([curs{m},'_comps'])

%%wspd
flc='wspd_c_with_sst';
eval(['tmp = ',curs{m},'_wspd_c;'])
eval(['tmp2 = ',curs{m},'_sst_c;'])
eval(['n = ',curs{m},'_wspd_c.n_max_sample;'])

pcomps_raw2(smoothn(tmp.median,2),smoothn(tmp.median,2),[-.15 .15],-1,.02,1,['relative wind speed anomaly'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='wspd_a_with_sst';
eval(['tmp = ',curs{m},'_wspd_a;'])
eval(['tmp2 = ',curs{m},'_sst_a;'])
eval(['n = ',curs{m},'_wspd_a.n_max_sample;'])

pcomps_raw2(smoothn(tmp.median,2),smoothn(tmp.median,2),[-.15 .15],-1,.02,1,['relative wind speed anomaly'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])


%%sst
flc='sst_c_wth_sst';
eval(['tmp = ',curs{m},'_wspd_c;'])
eval(['tmp2 = ',curs{m},'_sst_c;'])
eval(['n = ',curs{m},'_wspd_c.n_max_sample;'])

pcomps_raw2(smoothn(tmp2.median,2),smoothn(tmp2.median,2),[-.06 .06],-1,.01,1,['SST anomaly'],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='sst_a_wth_sst';
eval(['tmp = ',curs{m},'_wspd_a;'])
eval(['tmp2 = ',curs{m},'_sst_a;'])
eval(['n = ',curs{m},'_wspd_a.n_max_sample;'])

pcomps_raw2(smoothn(tmp2.median,2),smoothn(tmp2.median,2),[-.06 .06],-1,.01,1,['SST anomaly'],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

end