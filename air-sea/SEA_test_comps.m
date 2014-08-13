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
cranges= [	.3		.4		5		1		0.5		.1		%SP		1
    .7		.7		15		2		15		2		%AGR	2
    .15		.5		10		2		1		.1		%HAW	3
    .4		.7		12		2		2		.25		%EIO	4
    .06		.5		12		2		.5		.1   	%CAR	5
    1		1		15		2		7		1       %SEA	6
    .4		.7		12		2		2		.25     %newEIO 7
    1		1		15		2		7		1 ];    %SEA	8
% %
% %
% % % % % % %
% for mm=6%1:length(curs)
%     load(['~/data/eddy/V5/',curs{mm},'_lat_lon_tracks'])
%     ii=find(track_jday>=2452427 & track_jday<=2455159);
%     ext_x=ext_x(ii);
%     ext_y=ext_y(ii);
%     x=x(ii);
%     y=y(ii);
%     k=k(ii);
%     id=id(ii);
%     track_jday=track_jday(ii);
%     cyc=cyc(ii);
%     scale=scale(ii);
%     
%     %remove top right 5x5 box
%     ii=find(y>-40 & x>15);
%     ext_x(ii)=[];
%     ext_y(ii)=[];
%     x(ii)=[];
%     y(ii)=[];
%     k(ii)=[];
%     id(ii)=[];
%     track_jday(ii)=[];
%     cyc(ii)=[];
%     scale(ii)=[];
% 
%     figure(1)
%     clf
%     pmap(min(x)-10:max(x)+10,min(y)-10:max(y)+10,[x y id cyc track_jday k],'new_tracks')
%     
%     eval(['[',curs{mm},'_wek_crlg_a,',curs{mm},'_wek_crlg_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp_wek_crlg_week',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat3/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
% 
%     eval(['[',curs{mm},'_fixed_wek_sst_a,',curs{mm},'_fixed_wek_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp_wek_sst_week_fixed',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat3/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
%     
%     eval(['[',curs{mm},'_wek_a,',curs{mm},'_wek_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'wek',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat3/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
% 
%     save(['~/matlab/air-sea/test_SEA_comps'],'*_a','*_c')
% end
% %
% % return

for mm=6%1:length(curs)
    load ~/matlab/air-sea/test_SEA_comps
    %%fixed sst wek and sst wek
    flc='fixed_wek_sst_c_with_wek_crl';
    eval(['tmp = ',curs{mm},'_fixed_wek_sst_c;'])
    eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_c;'])
    eval(['n = ',curs{mm},'_fixed_wek_sst_c.n_max_sample;'])
    tmp.mean=-tmp.mean;
    tmp2.mean=-tmp2.mean;
    
    pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/test_SEA_comps/',flc])
    
    flc='fixed_wek_sst_a_with_wek_crl';
    eval(['tmp = ',curs{mm},'_fixed_wek_sst_a;'])
    eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_a;'])
    eval(['n = ',curs{mm},'_fixed_wek_sst_a.n_max_sample;'])
    tmp.mean=-tmp.mean;
    tmp2.mean=-tmp2.mean;
    
    pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/test_SEA_comps/',flc])
    
    
    %wek and wek
    flc='wek_c_with_wek';
    eval(['tmp = ',curs{mm},'_wek_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_c;'])
    eval(['n = ',curs{mm},'_wek_c.n_max_sample;'])
    
    pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/test_SEA_comps/',flc])
    
    flc='wek_a_with_wek';
    eval(['tmp = ',curs{mm},'_wek_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_a;'])
    eval(['n = ',curs{mm},'_wek_a.n_max_sample;'])
    
    pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/test_SEA_comps/',flc])
    
    %%crl wek and crl wek
    flc='wek_crl_c_with_wek_crl';
    eval(['tmp = ',curs{mm},'_wek_crlg_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_crlg_c;'])
    eval(['n = ',curs{mm},'_wek_crlg_c.n_max_sample;'])
    
    
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/test_SEA_comps/',flc])
    
    flc='wek_crl_a_with_wek_crl';
    eval(['tmp = ',curs{mm},'_wek_crlg_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_crlg_a;'])
    eval(['n = ',curs{mm},'_wek_crlg_a.n_max_sample;'])
    
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/test_SEA_comps/',flc])
    
    
    
end
