clear all

curs = {'SP',...
		'AGR',...
		'KURS',...
		'KURN',...
		'HAW',...
		'EIO',...
		'CAR',...
		'AGU',...
		'CC'};

%			sst		crl	    W_E		W_Ec	W_T		W_Tc				
cranges= [	.2		.3		2		.5		.05		.01		%SP		1
			.7		.7		10		1		10		1		%AGR	2
			.3		.5		3		.5		.1		.01		%KURS	3
			.6		.5		3		.5		1		.1		%KURN	4
			.12		.4		5		1		.2		.05		%HAW	5
			.3		.5		5		1		.8		.1		%EIO	6
			.06		.5		5		1		.1		.01		%CAR	7
			.9		1		10		1		5		.5		%AGU	8
			.3		.4		3		.5		.2		.05];	%CC 	9

%{
for m=9%1:length(curs)
	eval(['mkdir ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/'])
end	
	
%
for m=1:length(curs)
	%{
	cd /matlab/data/eddy/V5/
	eval(['subset_tracks_tight_v5(',char(39),'/matlab/matlab/domains/',char(39),',',...
		   char(39),curs{m},'_lat_lon',char(39),')'])
	cd /matlab/matlab/air-sea
	%}
	load(['/matlab/data/eddy/V5/',curs{m},'_lat_lon_tracks'])
	%{
	eval(['[',curs{m},'_trot_wek_a,',curs{m},'_trot_wek_c]=comps_dir_grad(x,y,cyc,id,track_jday,scale,'...
	    char(39),'w_ek',char(39),',',char(39),...
		'/matlab/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
		char(39),'t',char(39),');'])	
	eval(['[',curs{m},'_crlg_a,',curs{m},'_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
	    char(39),'hp66_crlg',char(39),',',char(39),...
		'/matlab/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
		char(39),'n',char(39),');'])
	eval(['[',curs{m},'_wek_crlg_a,',curs{m},'_wek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
	    char(39),'hp_wek_crlg_week',char(39),',',char(39),...
		'/matlab/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
		char(39),'n',char(39),');'])
	eval(['[',curs{m},'_wek_sst_a,',curs{m},'_wek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
	    char(39),'hp_wek_sst_week_dtdn',char(39),',',char(39),...
		'/matlab/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
		char(39),'n',char(39),');'])	
	%}	
	eval(['[',curs{m},'_wek_a,',curs{m},'_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
	    char(39),'w_ek',char(39),',',char(39),...
		'/matlab/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
		char(39),'n',char(39),');'])	
	%{
	eval(['[',curs{m},'_ssh_a,',curs{m},'_ssh_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
	    char(39),'ssh',char(39),',',char(39),...
		'/matlab/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
		char(39),'n',char(39),');'])
	eval(['[',curs{m},'_sst_a,',curs{m},'_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
	    char(39),'bp26_sst',char(39),',',char(39),...
		'/matlab/data/ReynoldsSST/mat/OI_25_30_',char(39),',',...
		char(39),'n',char(39),');'])	
	%}	
	save([curs{m},'_comps'],'*_a','*_c','-append')	
	%
end
return
%}
for m=1:length(curs)
load([curs{m},'_comps'])
%{
flc='crlg_c_with_ssh';
eval(['tmp = double(interp2(',curs{m},'_crlg_c.median,2));'])
eval(['tmp2 = double(interp2(',curs{m},'_ssh_c.median,2));'])
cplot_comps_cont_2_2(1e5*tmp,tmp2,-cranges(m,2),cranges(m,2),2,-100,100,'AVISO @MAiD@ u_g^ Cyclones',...
	['~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc]) 
flc='crlg_a_with_ssh';
eval(['tmp = double(interp2(',curs{m},'_crlg_a.median,2));'])
eval(['tmp2 = double(interp2(',curs{m},'_ssh_a.median,2));'])
cplot_comps_cont_2_2(1e5*tmp,tmp2,-cranges(m,2),cranges(m,2),2,-100,100,'AVISO @MAiD@ u_g^ Anticyclones',...
	['~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='sst_c_with_ssh';
eval(['tmp = double(interp2(',curs{m},'_sst_c.median,2));'])
eval(['tmp2 = double(interp2(',curs{m},'_ssh_c.median,2));'])
cplot_comps_cont_2_2(tmp,tmp2,-cranges(m,1),cranges(m,1),2,-100,100,'NOAA SST Cyclones',...
	['~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc]) 
flc='sst_a_with_ssh';
eval(['tmp = double(interp2(',curs{m},'_sst_a.median,2));'])
eval(['tmp2 = double(interp2(',curs{m},'_ssh_a.median,2));'])
cplot_comps_cont_2_2(tmp,tmp2,-cranges(m,1),cranges(m,1),2,-100,100,'NOAA SST Anticyclones',...
	['~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])
%	
flc='wek_c_with_wek';
eval(['tmp = 100*double(interp2(',curs{m},'_wek_c.median,2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-cranges(m,3),cranges(m,3),cranges(m,4),-100,100,'QuikSCAT Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc]) 
flc='wek_a_with_wek';
eval(['tmp = 100*double(interp2(',curs{m},'_wek_a.median,2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-cranges(m,3),cranges(m,3),cranges(m,4),-100,100,'QuikSCAT Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc]) 		
%
flc='wek_crl_c_with_wek_crl';
eval(['tmp = double(interp2(',curs{m},'_wek_crlg_c.median,2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-cranges(m,3),cranges(m,3),cranges(m,4),-100,100,'AVISO Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc]) 
flc='wek_crl_a_with_wek_crl';
eval(['tmp = double(interp2(',curs{m},'_wek_crlg_a.median,2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-cranges(m,3),cranges(m,3),cranges(m,4),-100,100,'AVISO Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc]) 
	
flc='wek_sst_c_with_wek_crl';
eval(['tmp = -double(interp2(',curs{m},'_wek_sst_c.median,2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-cranges(m,5),cranges(m,5),cranges(m,6),-100,100,'SST-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])	
flc='wek_sst_a_with_wek_crl';
eval(['tmp = -double(interp2(',curs{m},'_wek_sst_a.median,2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-cranges(m,5),cranges(m,5),cranges(m,6),-100,100,'SST-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])	
%}

flc='wek_tot_c_with_wek_tot';
eval(['tmp = double(interp2(',curs{m},'_wek_crlg_c.median,2));'])
eval(['tmp2 = -double(interp2(',curs{m},'_wek_sst_c.median,2));'])
tmp=tmp+tmp2;
cplot_comps_cont_2_2_bwr(tmp,tmp,-cranges(m,3),cranges(m,3),cranges(m,4),-100,100,'Combined Ekman Pumping',...
	['~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])

flc='wek_tot_a_with_wek_tot';
eval(['tmp = double(interp2(',curs{m},'_wek_crlg_a.median,2));'])
eval(['tmp2 = -double(interp2(',curs{m},'_wek_sst_a.median,2));'])
tmp=tmp+tmp2;
cplot_comps_cont_2_2_bwr(tmp,tmp,-cranges(m,3),cranges(m,3),cranges(m,4),-100,100,'Combined Ekman Pumping',...
	['~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/',flc])	


end	
	