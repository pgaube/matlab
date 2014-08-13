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
%     cd ~/data/eddy/V5/
%     eval(['subset_tracks_tight_v5(',char(39),curs{mm},'_lat_lon',char(39),')'])
%     cd ~/data/eddy/V5/
%     eval(['subset_tracks_orgin_v5(',char(39),curs{mm},'_lat_lon',char(39),')'])
%     % %
%     load(['~/data/eddy/V5/',curs{mm},'_lat_lon_tracks'])
%     ii=find(track_jday>=2452427 & track_jday<=2455159);
%     ext_x=ext_x(ii);
%     ext_y=ext_y(ii);
%     k=k(ii);
%     id=id(ii);
%     track_jday=track_jday(ii);
%     cyc=cyc(ii);
%     scale=scale(ii);
%     cd ~/matlab/air-sea
% %     
% %     eval(['[',curs{mm},'_ssh_a,',curs{mm},'_ssh_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% %         char(39),'ssh',char(39),',',char(39),...
% %         '~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
% %         char(39),'n',char(39),');'])
% %     
% %     eval(['[',curs{mm},'_crlg_a,',curs{mm},'_crlg_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% %         char(39),'hp66_crlg',char(39),',',char(39),...
% %         '~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
% %         char(39),'n',char(39),');'])
% %     
%     eval(['[',curs{mm},'_wek_crlg_a,',curs{mm},'_wek_crlg_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp_wek_crlg_week',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat3/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
% %     
% %     eval(['[',curs{mm},'_clean_wek_sst_a,',curs{mm},'_clean_wek_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% %         char(39),'hp_wek_sst_week_dtdn',char(39),',',char(39),...
% %         '~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_',char(39),',',...
% %         char(39),'n',char(39),');'])
%         eval(['[',curs{mm},'_fixed_wek_sst_a,',curs{mm},'_fixed_wek_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%             char(39),'hp_wek_sst_week_fixed',char(39),',',char(39),...
%             '~/data/QuickScat/ULTI_mat3/QSCAT_30_25km_',char(39),',',...
%             char(39),'n',char(39),');'])
%     
%     eval(['[',curs{mm},'_wek_a,',curs{mm},'_wek_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'wek',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat3/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
% %     % % 	eval(['[',curs{mm},'_raw_wek_a,',curs{mm},'_raw_wek_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% %     % % 	    char(39),'wek',char(39),',',char(39),...
% %     % % 		'~/data/QuickScat/new_mat/QSCAT_30_25km_',char(39),',',...
% %     % % 		char(39),'n',char(39),');'])
% %     eval(['[',curs{mm},'_sst_a,',curs{mm},'_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% %         char(39),'hp66_sst',char(39),',',char(39),...
% %         '~/data/ReynoldsSST/mat/OI_25_30_',char(39),',',...
% %         char(39),'n',char(39),');'])
%     save(['~/matlab/air-sea/FINAL_',curs{mm},'_comps'],'*_a','*_c','-append')
% end
% % 
% % return

for mm=6%1:length(curs)
    load(['FINAL_',curs{mm},'_comps'])
    %%fixed sst wek and sst wek
    flc='fixed_wek_sst_c_with_wek_crl';
    eval(['tmp = ',curs{mm},'_fixed_wek_sst_c;'])
    eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_c;'])
    eval(['n = ',curs{mm},'_fixed_wek_sst_c.n_max_sample;'])
    tmp.mean=-tmp.mean;
    tmp2.mean=-tmp2.mean;
    
    pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='fixed_wek_sst_a_with_wek_crl';
    eval(['tmp = ',curs{mm},'_fixed_wek_sst_a;'])
    eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_a;'])
    eval(['n = ',curs{mm},'_fixed_wek_sst_a.n_max_sample;'])
    tmp.mean=-tmp.mean;
    tmp2.mean=-tmp2.mean;
    
    pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    %%clean tot wek and tot wek
    flc='fixed_wek_tot_c_with_tot_crl';
    eval(['tmp = ',curs{mm},'_wek_crlg_c;'])
    eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_c;'])
    eval(['n = ',curs{mm},'_sst_c.n_max_sample;'])
    
    tmp.mean=tmp.mean-tmp2.mean;
%     if m==5
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3)-3 cranges(mm,3)+3],-100,cranges(mm,4)+.7,100,[''],2,30)
%     elseif m==3
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3)-1 cranges(mm,3)+1],-100,cranges(mm,4)+.2,100,[''],2,30)
%     else
        pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     end
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    
    flc='fixed_wek_tot_a_with_tot_crl';
    eval(['tmp = ',curs{mm},'_wek_crlg_a;'])
    eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_a;'])
    eval(['n = ',curs{mm},'_sst_a.n_max_sample;'])
    
    tmp.mean=tmp.mean-tmp2.mean;
%     if m==5
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3)-3 cranges(mm,3)+3],-100,cranges(mm,4)+.7,100,[''],2,30)
%     elseif m==3
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3)-1 cranges(mm,3)+1],-100,cranges(mm,4)+.2,100,[''],2,30)
%     else
        pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     end
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    

    % % % load([curs{mm},'_comps'])
    %
    % %%sst 125wek and sst wek
    % flc='wek125_sst_c_with_wek_crl';
    % eval(['tmp = ',curs{mm},'_wek125_sst_c;'])
    % eval(['tmp2 = ',curs{mm},'_wek125_sst_c;'])
    % eval(['n = ',curs{mm},'_wek_sst_c.n_max_sample;'])
    % tmp.mean=-tmp.mean;
    % tmp2.mean=-tmp2.mean;
    % % if m==2
    % %     tmp.mean=-tmp.mean;
    % %     tmp2.mean=-tmp2.mean;
    % % end
    % pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    %
    % %%sst 125wek and sst wek
    % flc='wek125_sst_a_with_wek_crl';
    % eval(['tmp = ',curs{mm},'_wek125_sst_a;'])
    % eval(['tmp2 = ',curs{mm},'_wek125_sst_a;'])
    % eval(['n = ',curs{mm},'_wek_sst_a.n_max_sample;'])
    % tmp.mean=-tmp.mean;
    % tmp2.mean=-tmp2.mean;
    % % if m==2
    % %     tmp.mean=-tmp.mean;
    % %     tmp2.mean=-tmp2.mean;
    % % end
    % pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    %
    % %%tot wek and tot wek
    % flc='wek_125tot_c_with_tot_crl';
    % eval(['tmp = ',curs{mm},'_wek_crlg_c;'])
    % eval(['tmp2 = ',curs{mm},'_wek125_sst_c;'])
    % eval(['n = ',curs{mm},'_sst_c.n_max_sample;'])
    %
    % tmp.mean=tmp.mean-tmp2.mean;
    % tmp.std=tmp2.std;
    % pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    %
    %
    % flc='wek_125tot_a_with_tot_crl';
    % eval(['tmp = ',curs{mm},'_wek_crlg_a;'])
    % eval(['tmp2 = ',curs{mm},'_wek125_sst_a;'])
    % eval(['n = ',curs{mm},'_sst_a.n_max_sample;'])
    %
    % tmp.mean=tmp.mean-tmp2.mean;
    % tmp.std=tmp2.std;
    % pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    %
    %
    
    
    
    %
    % %
    %%crl and ssh
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
    % %wspd and wspd
    % flc='wspd_c_with_wspd';
    % eval(['tmp = ',curs{mm},'_wspd_c;'])
    % eval(['tmp2 = ',curs{mm},'_wspd_c;'])
    % eval(['n = ',curs{mm},'_wspd_c.n_max_sample;'])
    %
    % pcomps_raw2(tmp.mean,tmp2.mean,[-.15 .15],-100,.025,100,[''],1,30)
    % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    %
    % flc='wspd_a_with_wspd';
    % eval(['tmp = ',curs{mm},'_wspd_a;'])
    % eval(['tmp2 = ',curs{mm},'_wspd_a;'])
    % eval(['n = ',curs{mm},'_sst_a.n_max_sample;'])
    %
    % pcomps_raw2(tmp.mean,tmp2.mean,[-.15 .15],-100,.025,100,[''],1,30)
    % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    % return
    %
    % %%raw_wek and wek
    % flc='raw_wek_c_with_wek';
    % eval(['tmp = ',curs{mm},'_raw_wek_c;'])
    % eval(['tmp2 = ',curs{mm},'_raw_wek_c;'])
    % eval(['n = ',curs{mm},'_wek_c.n_max_sample;'])
    %
    % pcomps_raw(smoothn(100*tmp.mean,2),smoothn(100*tmp2.mean,2),[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    %
    % flc='raw_wek_a_with_wek';
    % eval(['tmp = ',curs{mm},'_raw_wek_a;'])
    % eval(['tmp2 = ',curs{mm},'_raw_wek_a;'])
    % eval(['n = ',curs{mm},'_wek_a.n_max_sample;'])
    %
    % pcomps_raw(smoothn(100*tmp.mean,2),smoothn(100*tmp2.mean,2),[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    %
    %wek and wek
    flc='wek_c_with_wek';
    eval(['tmp = ',curs{mm},'_wek_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_c;'])
    eval(['n = ',curs{mm},'_wek_c.n_max_sample;'])
    
    pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='wek_a_with_wek';
    eval(['tmp = ',curs{mm},'_wek_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_a;'])
    eval(['n = ',curs{mm},'_wek_a.n_max_sample;'])
    
    pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
    %%crl wek and crl wek
    flc='wek_crl_c_with_wek_crl';
    eval(['tmp = ',curs{mm},'_wek_crlg_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_crlg_c;'])
    eval(['n = ',curs{mm},'_wek_crlg_c.n_max_sample;'])
    
%     if m==5
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3)-3 cranges(mm,3)+3],-100,cranges(mm,4)+.7,100,[''],2,30)
%     elseif m==3
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3)-1 cranges(mm,3)+1],-100,cranges(mm,4)+.2,100,[''],2,30)
%     else
        pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     end
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='wek_crl_a_with_wek_crl';
    eval(['tmp = ',curs{mm},'_wek_crlg_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_crlg_a;'])
    eval(['n = ',curs{mm},'_wek_crlg_a.n_max_sample;'])
%     if m==5
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3)-3 cranges(mm,3)+3],-100,cranges(mm,4)+.7,100,[''],2,30)
%     elseif m==3
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3)-1 cranges(mm,3)+1],-100,cranges(mm,4)+.2,100,[''],2,30)
%     else
        pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     end
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    % %
    % %%sst wek and sst wek
    % flc='wek_sst_c_with_wek_crl';
    % eval(['tmp = ',curs{mm},'_wek_sst_c;'])
    % eval(['tmp2 = ',curs{mm},'_wek_sst_c;'])
    % eval(['n = ',curs{mm},'_wek_sst_c.n_max_sample;'])
    % tmp.mean=-tmp.mean;
    % tmp2.mean=-tmp2.mean;
    % % if m==6 | m==5
    % %
    % %     tmp.mean=-tmp.median;
    % %     tmp2.mean=-tmp2.median;
    % % end
    % pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    %
    % flc='wek_sst_a_with_wek_crl';
    % eval(['tmp = ',curs{mm},'_wek_sst_a;'])
    % eval(['tmp2 = ',curs{mm},'_wek_sst_a;'])
    % eval(['n = ',curs{mm},'_wek_sst_a.n_max_sample;'])
    % tmp.mean=-tmp.mean;
    % tmp2.mean=-tmp2.mean;
    % % if m==6 | m==5
    % %     tmp.mean=-tmp.median;
    % %     tmp2.mean=-tmp2.median;
    % % end
    % pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    % %%tot wek and tot wek
    % flc='wek_tot_c_with_tot_crl';
    % eval(['tmp = ',curs{mm},'_wek_crlg_c;'])
    % eval(['tmp2 = ',curs{mm},'_wek_sst_c;'])
    % eval(['n = ',curs{mm},'_sst_c.n_max_sample;'])
    %
    % tmp.mean=tmp.mean-tmp2.mean;
    %
    % pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    %
    %
    % flc='wek_tot_a_with_tot_crl';
    % eval(['tmp = ',curs{mm},'_wek_crlg_a;'])
    % eval(['tmp2 = ',curs{mm},'_wek_sst_a;'])
    % eval(['n = ',curs{mm},'_sst_a.n_max_sample;'])
    %
    % tmp.mean=tmp.mean-tmp2.mean;
    %
    % pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    % eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    % %
    % %     %fixed sst wek and sst wek
    % %     flc='fixed_wek_sst_c_with_wek_crl';
    % %     eval(['tmp = ',curs{mm},'_fixed_wek_sst_c;'])
    % %     eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_c;'])
    % %     eval(['n = ',curs{mm},'_wek_sst_c.n_max_sample;'])
    % %     tmp.mean=-tmp.mean;
    % %     tmp2.mean=-tmp2.mean;
    % %
    % %     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    % %
    % %     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    % %
    % %     flc='fixed_wek_sst_a_with_wek_crl';
    % %     eval(['tmp = ',curs{mm},'_fixed_wek_sst_a;'])
    % %     eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_a;'])
    % %     eval(['n = ',curs{mm},'_wek_sst_a.n_max_sample;'])
    % %     tmp.mean=-tmp.mean;
    % %     tmp2.mean=-tmp2.mean;
    % %
    % %     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    % %
    % %     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    % %
    % %     %fixed tot wek and tot wek
    % %     flc='fixed_wek_tot_c_with_tot_crl';
    % %     eval(['tmp = ',curs{mm},'_wek_crlg_c;'])
    % %     eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_c;'])
    % %     eval(['n = ',curs{mm},'_sst_c.n_max_sample;'])
    % %
    % %     tmp.mean=tmp.mean-tmp2.mean;
    % %
    % %     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    % %
    % %     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    % %
    % %
    % %     flc='fixed_wek_tot_a_with_tot_crl';
    % %     eval(['tmp = ',curs{mm},'_wek_crlg_a;'])
    % %     eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_a;'])
    % %     eval(['n = ',curs{mm},'_sst_a.n_max_sample;'])
    % %
    % %     tmp.mean=tmp.mean-tmp2.mean;
    % %
    % %     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    % %
    % %     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    % %
    % %
    % %
    % %
    
%     %%clean sst wek and sst wek
%     flc='clean_wek_sst_c_with_wek_crl';
%     eval(['tmp = ',curs{mm},'_clean_wek_sst_c;'])
%     eval(['tmp2 = ',curs{mm},'_clean_wek_sst_c;'])
%     eval(['n = ',curs{mm},'_clean_wek_sst_c.n_max_sample;'])
%     tmp.mean=-tmp.mean;
%     tmp2.mean=-tmp2.mean;
%     
%     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
%     
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='clean_wek_sst_a_with_wek_crl';
%     eval(['tmp = ',curs{mm},'_clean_wek_sst_a;'])
%     eval(['tmp2 = ',curs{mm},'_clean_wek_sst_a;'])
%     eval(['n = ',curs{mm},'_clean_wek_sst_a.n_max_sample;'])
%     tmp.mean=-tmp.mean;
%     tmp2.mean=-tmp2.mean;
%     
%     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
%     
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
% %     
%     %%clean tot wek and tot wek
%     flc='clean_wek_tot_c_with_tot_crl';
%     eval(['tmp = ',curs{mm},'_wek_crlg_c;'])
%     eval(['tmp2 = ',curs{mm},'_clean_wek_sst_c;'])
%     eval(['n = ',curs{mm},'_sst_c.n_max_sample;'])
%     
%     tmp.mean=tmp.mean-tmp2.mean;
%     if mm==5
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3)-3 cranges(mm,3)+3],-100,cranges(mm,4)+.7,100,[''],2,30)
%     elseif mm==3
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3)-1 cranges(mm,3)+1],-100,cranges(mm,4)+.2,100,[''],2,30)
%     else
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     end
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     
%     flc='clean_wek_tot_a_with_tot_crl';
%     eval(['tmp = ',curs{mm},'_wek_crlg_a;'])
%     eval(['tmp2 = ',curs{mm},'_clean_wek_sst_a;'])
%     eval(['n = ',curs{mm},'_sst_a.n_max_sample;'])
%     
%     tmp.mean=tmp.mean-tmp2.mean;
%     if mm==5
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3)-3 cranges(mm,3)+3],-100,cranges(mm,4)+.7,100,[''],2,30)
%     elseif mm==3
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3)-1 cranges(mm,3)+1],-100,cranges(mm,4)+.2,100,[''],2,30)
%     else
%         pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     end
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    %
    
end
