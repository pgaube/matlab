clear all

curs = {'SP',...
		'AGR',...
		'HAW',...
		'EIO',...
		'CAR',...
		'AGU'};

%			sst		crl	    W_E		W_Ec	W_T		W_Tc				
cranges= [	.2		.3		2		.5		.15		.01		%SP		1
			.7		.7		10		1		10		1		%AGR	2
			.12		.4		5		1		.3		.05		%HAW	3
			.3		.5		5		1		.8		.1		%EIO	4
			.06		.5		7		1		.2		.05		%CAR	5
			.9		1		12		2		5		1];     %AGU	6


% % for m=9%1:length(curs)
% % 	eval(['mkdir ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/'])
% % end	
% % 	
%
% for m=2%1:length(curs)
% % % % 	cd ~/data/eddy/V5/
% % % % 	eval(['subset_tracks_tight_v5(',char(39),'/matlab/matlab/domains/',char(39),',',...
% % % % 		   char(39),curs{m},'_lat_lon',char(39),')'])
% 
% 	load(['~/data/eddy/V5/',curs{m},'_lat_lon_tracks'])	
% 	
%     eval(['[',curs{m},'_crlg_a,',curs{m},'_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'hp66_crlg',char(39),',',char(39),...
% 		'~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
% 		char(39),'n',char(39),');'])
% 	eval(['[',curs{m},'_wek_crlg_a,',curs{m},'_wek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'hp_wek_crlg_week',char(39),',',char(39),...
% 		'~/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
% 		char(39),'n',char(39),');'])
% 	eval(['[',curs{m},'_wek_sst_a,',curs{m},'_wek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'hp_wek_sst_week_dtdn',char(39),',',char(39),...
% 		'~/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
% 		char(39),'n',char(39),');'])	
% 	eval(['[',curs{m},'_wek_a,',curs{m},'_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'w_ek',char(39),',',char(39),...
% 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
% 		char(39),'n',char(39),');'])	
% 	eval(['[',curs{m},'_ssh_a,',curs{m},'_ssh_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'ssh',char(39),',',char(39),...
% 		'~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
% 		char(39),'n',char(39),');'])
% 	eval(['[',curs{m},'_sst_a,',curs{m},'_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'bp26_sst',char(39),',',char(39),...
% 		'~/data/ReynoldsSST/mat/OI_25_30_',char(39),',',...
% 		char(39),'n',char(39),');'])		
% 	save(['FINAL_',curs{m},'_comps'],'*_a','*_c')	
%  	%save([curs{m},'_comps'],'*_a','*_c','-append')	
% 	
% end

for m=1:length(curs)
%load(['FINAL_',curs{m},'_comps'])
 load([curs{m},'_comps'])

%%crl and ssh
flc='crlg_c_with_ssh';
eval(['tmp = ',curs{m},'_crlg_c;'])
eval(['tmp2 = ',curs{m},'_ssh_c;'])
eval(['n = ',curs{m},'_ssh_c.n_max_sample;'])

pcomps(tmp,tmp2,[-1e-5*cranges(m,2) 1e-5*cranges(m,2)],-100,2,100,['AVISO current vorticity N=',num2str(n)],1)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc],1)

flc='crlg_a_with_ssh';
eval(['tmp = ',curs{m},'_crlg_a;'])
eval(['tmp2 = ',curs{m},'_ssh_a;'])
eval(['n = ',curs{m},'_ssh_a.n_max_sample;'])

pcomps(tmp,tmp2,[-1e-5*cranges(m,2) 1e-5*cranges(m,2)],-100,2,100,['AVISO current vorticity N=',num2str(n)],1)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc],1)

%%SST and SSh
flc='sst_c_with_ssh';
eval(['tmp = ',curs{m},'_sst_c;'])
eval(['tmp2 = ',curs{m},'_ssh_c;'])
eval(['n = ',curs{m},'_sst_c.n_max_sample;'])

pcomps(tmp,tmp2,[-cranges(m,1) cranges(m,1)],-100,2,100,['NOAA SST N=',num2str(n)],1)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='sst_a_with_ssh';
eval(['tmp = ',curs{m},'_sst_a;'])
eval(['tmp2 = ',curs{m},'_ssh_a;'])
eval(['n = ',curs{m},'_sst_a.n_max_sample;'])

pcomps(tmp,tmp2,[-cranges(m,1) cranges(m,1)],-100,2,100,['NOAA SST N=',num2str(n)],1)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])


%%wek and wek
flc='wek_c_with_wek';
eval(['tmp = ',curs{m},'_wek_c;'])
eval(['tmp2 = ',curs{m},'_wek_c;'])
eval(['n = ',curs{m},'_wek_c.n_max_sample;'])

pcomps(tmp,tmp2,[-.01*cranges(m,3) .01*cranges(m,3)],-1,.01*cranges(m,4),1,['QuikSCAT Ekman Downwelling N=',num2str(n)],2)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='wek_a_with_wek';
eval(['tmp = ',curs{m},'_wek_a;'])
eval(['tmp2 = ',curs{m},'_wek_a;'])
eval(['n = ',curs{m},'_wek_a.n_max_sample;'])

pcomps(tmp,tmp2,[-.01*cranges(m,3) .01*cranges(m,3)],-1,.01*cranges(m,4),1,['QuikSCAT Ekman Upwelling N=',num2str(n)],2)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

%%crl wek and crl wek
flc='wek_crl_c_with_wek_crl';
eval(['tmp = ',curs{m},'_wek_crlg_c;'])
eval(['tmp2 = ',curs{m},'_wek_crlg_c;'])
eval(['n = ',curs{m},'_wek_crlg_c.n_max_sample;'])
% if m==2
%     tmp.mean=tmp.median;
%     tmp2.mean=tmp2.median;
% end
pcomps(tmp,tmp2,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,['AVISO Ekman Downwelling N=',num2str(n)],2)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='wek_crl_a_with_wek_crl';
eval(['tmp = ',curs{m},'_wek_crlg_a;'])
eval(['tmp2 = ',curs{m},'_wek_crlg_a;'])
eval(['n = ',curs{m},'_wek_crlg_a.n_max_sample;'])
% if m==2
%     tmp.mean=tmp.median;
%     tmp2.mean=tmp2.median;
% end
pcomps(tmp,tmp2,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,['AVISO Ekman Upwelling N=',num2str(n)],2)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

%%sst wek and sst wek
flc='wek_sst_c_with_wek_crl';
eval(['tmp = ',curs{m},'_wek_sst_c;'])
eval(['tmp2 = ',curs{m},'_wek_sst_c;'])
eval(['n = ',curs{m},'_wek_sst_c.n_max_sample;'])
tmp.mean=-tmp.mean;
tmp2.mean=-tmp2.mean;
% if m==2
%     tmp.mean=-tmp.median;
%     tmp2.mean=-tmp2.median;
% end
pcomps(tmp,tmp2,[-cranges(m,5) cranges(m,5)],-100,cranges(m,6),100,['SST-induced Ekman Downwelling N=',num2str(n)],2)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='wek_sst_a_with_wek_crl';
eval(['tmp = ',curs{m},'_wek_sst_a;'])
eval(['tmp2 = ',curs{m},'_wek_sst_a;'])
eval(['n = ',curs{m},'_wek_sst_a.n_max_sample;'])
tmp.mean=-tmp.mean;
tmp2.mean=-tmp2.mean;
% if m==2
%     tmp.mean=-tmp.median;
%     tmp2.mean=-tmp2.median;
% end
pcomps(tmp,tmp2,[-cranges(m,5) cranges(m,5)],-100,cranges(m,6),100,['SST-induced Ekman Upwelling N=',num2str(n)],2)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

%%tot wek and tot wek
flc='wek_tot_c_with_tot_crl';
eval(['tmp = ',curs{m},'_wek_crlg_c;'])
eval(['tmp2 = ',curs{m},'_wek_sst_c;'])
eval(['n = ',curs{m},'_sst_c.n_max_sample;'])

tmp.mean=tmp.mean-tmp2.mean;
tmp.std=tmp2.std;
pcomps(tmp,tmp,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,['Combined Ekman Upwelling'],2)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])


flc='wek_tot_a_with_tot_crl';
eval(['tmp = ',curs{m},'_wek_crlg_a;'])
eval(['tmp2 = ',curs{m},'_wek_sst_a;'])
eval(['n = ',curs{m},'_sst_a.n_max_sample;'])

tmp.mean=tmp.mean-tmp2.mean;
tmp.std=tmp2.std;
pcomps(tmp,tmp,[-cranges(m,3) cranges(m,3)],-100,cranges(m,4),100,['Combined Ekman Upwelling'],2)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])



end	
	