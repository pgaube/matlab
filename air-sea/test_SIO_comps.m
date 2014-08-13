clear all

curs = {'SP',...
		'AGR',...
		'HAW',...
		'EIO',...
		'CAR',...
		'AGU',...
        'sub_SIO',...
        'sub_SP'};

%			sst		crl	    W_E		W_Ec	W_T		W_Tc				
cranges= [	.2		.3		3		.5		.15		.02		%SP		1
			.7		.7		12		1		10		1		%AGR	2
			.12		.4		8		1		.5		.05		%HAW	3
			.3		.5		8		1		1.3		.1		%EIO	4
			.06		.5		8		1		.2		.05		%CAR	5
			.9		1		15		2		7		1       %SEA	6
            .3		.5		8		1		1.3		.1		%sEIO	7
            .2		.3		3		.5		.15		.02];	%sSP	8

% % % 
% % % 
for m=4

	load(['~/data/eddy/V5/',curs{m},'_lat_lon_tracks'])
% 	eval(['[',curs{m},'_wek_a,',curs{m},'_wek_c]=comps_dir_grad(ext_x,ext_y,cyc,id,track_jday,scale,'...
% 	    char(39),'w_ek',char(39),',',char(39),...
% 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
% 		char(39),'t',char(39),');'])
%     eval(['[',curs{m},'_sst_a,',curs{m},'_sst_c]=comps_dir_grad(ext_x,ext_y,cyc,id,track_jday,scale,'...
% 	    char(39),'bp26_sst',char(39),',',char(39),...
% 		'comps_dir_grad',char(39),',',...
% 		char(39),'t',char(39),');'])
    eval(['[',curs{m},'_wek_a_w,',curs{m},'_wek_c_w]=comps(x,y,cyc,k,id,track_jday,scale,'...
	    char(39),'w_ek',char(39),',',char(39),...
		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
		char(39),'w',char(39),');'])%     
    eval(['[',curs{m},'_wek_a,',curs{m},'_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
 	    char(39),'w_ek',char(39),',',char(39),...
 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
 		char(39),'n',char(39),');'])
    eval(['[',curs{m},'_crlg_wek_a,',curs{m},'_crlg_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
 	    char(39),'hp_wek_crlg_week',char(39),',',char(39),...
 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
 		char(39),'n',char(39),');'])
    eval(['[',curs{m},'_sst_wek_a,',curs{m},'_sst_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
 	    char(39),'hp_wek_sst_week_dtdn',char(39),',',char(39),...
 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
 		char(39),'n',char(39),');'])
%     eval(['[',curs{m},'_sstwek_a_w,',curs{m},'_sstwek_c_w]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'hp_wek_sst_week_dtdn',char(39),',',char(39),...
% 		'~/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
% 		char(39),'w',char(39),');'])
% 	eval(['[',curs{m},'_sst_a,',curs{m},'_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'bp26_sst',char(39),',',char(39),...
% 		'~/data/ReynoldsSST/mat/OI_25_30_',char(39),',',...
% 		char(39),'n',char(39),');'])		
	save test_SIO	
end


for m=7
load test_SIO
%%rotated wek and wek

flc='wek_c_with_wek2';
eval(['tmp = ',curs{m},'_wek_c;'])
eval(['tmp2 = ',curs{m},'_wek_c;'])


pcomps_raw(tmp.median,tmp2.median,[-.01*cranges(m,3) .01*cranges(m,3)],-1,.01*cranges(m,4),1,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='wek_a_with_wek2';
eval(['tmp = ',curs{m},'_wek_a;'])
eval(['tmp2 = ',curs{m},'_wek_a;'])

pcomps_raw(tmp.median,tmp2.median,[-.01*cranges(m,3) .01*cranges(m,3)],-1,.01*cranges(m,4),1,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])


flc='wrot_wek_c_with_wek';
eval(['tmp = ',curs{m},'_wek_c_w;'])
eval(['tmp2 = ',curs{m},'_wek_c_w;'])


pcomps_raw(tmp.median,tmp2.median,[-.01*cranges(m,3) .01*cranges(m,3)],-1,.01*cranges(m,4),1,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='wrot_wek_a_with_wek';
eval(['tmp = ',curs{m},'_wek_a_w;'])
eval(['tmp2 = ',curs{m},'_wek_a_w;'])

pcomps_raw(tmp.median,tmp2.median,[-.01*cranges(m,3) .01*cranges(m,3)],-1,.01*cranges(m,4),1,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='crlg_wek_c_with_wek2';
eval(['tmp = ',curs{m},'_crlg_wek_c;'])
eval(['tmp2 = ',curs{m},'_crlg_wek_c;'])


pcomps_raw(tmp.median,tmp2.median,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='crlg_wek_a_with_wek2';
eval(['tmp = ',curs{m},'_crlg_wek_a;'])
eval(['tmp2 = ',curs{m},'_crlg_wek_a;'])

pcomps_raw(tmp.median,tmp2.median,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='sst_wek_c_with_wek2';
eval(['tmp = ',curs{m},'_sst_wek_c;'])
eval(['tmp2 = ',curs{m},'_sst_wek_c;'])


pcomps_raw(-tmp.median,-tmp2.median,[-cranges(m,5) cranges(m,5)],-1,cranges(m,6),1,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='sst_wek_a_with_wek2';
eval(['tmp = ',curs{m},'_sst_wek_a;'])
eval(['tmp2 = ',curs{m},'_sst_wek_a;'])

pcomps_raw(-tmp.median,-tmp2.median,[-cranges(m,5) cranges(m,5)],-1,cranges(m,6),1,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='sup_c';
eval(['tmp = ',curs{m},'_crlg_wek_c;'])
eval(['tmp2 = ',curs{m},'_sst_wek_c;'])
tmp.median=tmp.median-tmp2.median;

pcomps_raw(tmp.median,tmp.median,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='sup_a';
eval(['tmp = ',curs{m},'_crlg_wek_a;'])
eval(['tmp2 = ',curs{m},'_sst_wek_a;'])
tmp.median=tmp.median-tmp2.median;

pcomps_raw(tmp.median,tmp.median,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])


return


flc='wrot_sst_wek_c_with_wek';
eval(['tmp = ',curs{m},'_sstwek_c_w;'])
eval(['tmp2 = ',curs{m},'_sstwek_c_w;'])


pcomps_raw(-tmp.median,-tmp2.median,[-1 1],-1,cranges(m,6),1,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='wrot_sst_wek_a_with_wek';
eval(['tmp = ',curs{m},'_sstwek_a_w;'])
eval(['tmp2 = ',curs{m},'_sstwek_a_w;'])

pcomps_raw(-tmp.median,-tmp2.median,[-1 1],-1,cranges(m,6),1,[''],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

end	
	