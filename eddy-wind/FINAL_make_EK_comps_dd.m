clear all
% 
mon=['jan';'feb';'mar';'apr';'may';'jun';'jul';'aug';'sep';'oct';'nov';'dec'];
% % 
% % % load ~/data/eddy/V5/new_lw_p_lat_lon_orgin_tracks x y cyc id track_jday scale k
load ~/matlab/regions/tracks/tight/lw_tracks x y cyc id track_jday scale k
ii=find(track_jday>=2451911 & track_jday<=2455137);
x=x(ii);
y=y(ii);
cyc=cyc(ii);
id=id(ii);
track_jday=track_jday(ii);
scale=scale(ii);
k=k(ii);

[yeaa,mona,daya]=jd2jdate(track_jday);
% 
for n=1:12
    ii=find(mona==n);
%     eval(['[lw_',num2str(n),'_noac_a,lw',...
%         '_',num2str(n),'_noac_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
%         char(39),'hp66_noac_chl',char(39),',',char(39),...
%         '/Users/new_gaube/data/gsm/no_eddy_mat/GSM_9_21_',char(39),',',...
%         char(39),'n',char(39),');'])
%     
%     eval(['[lw_',num2str(n),'_nocc_a,lw',...
%         '_',num2str(n),'_nocc_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
%         char(39),'hp66_nocc_chl',char(39),',',char(39),...
%         '/Users/new_gaube/data/gsm/no_eddy_mat/GSM_9_21_',char(39),',',...
%         char(39),'n',char(39),');'])
% % %     
%     eval(['[lw_',num2str(n),'_ddwchl_a,lw',...
%         '_',num2str(n),'_ddwchl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
%         char(39),'sp66_chl',char(39),',',char(39),...
%         '~/data/gsm/mat/GSM_9_21_',char(39),',',...
%         char(39),'ddw',char(39),');'])
% % 
% %     eval(['[lw_',num2str(n),'_log_a,lw',...
% %         '_',num2str(n),'_log_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
% %         char(39),'bp26_chl',char(39),',',char(39),...
% %         '~/data/gsm/mat/GSM_9_21_',char(39),',',...
% %         char(39),'w',char(39),');'])
% % 
% 
% %     
% %     eval(['[lw_',num2str(n),'_ddchl_a,lw',...
% %         '_',num2str(n),'_ddchl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
% %         char(39),'sp66_chl',char(39),',',char(39),...
% %         '~/data/gsm/mat/GSM_9_21_',char(39),',',...
% %         char(39),'dd',char(39),');'])    
% %     
% % % %     eval(['[lw_',num2str(n),'_car_a,lw',...
% % % %         '_',num2str(n),'_car_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
% % % %         char(39),'sp66_car',char(39),',',char(39),...
% % % %         '~/data/gsm/mat/GSM_9_21_',char(39),',',...
% % % %         char(39),'n',char(39),');'])
% % % %     
% % % %     eval(['[lw_',num2str(n),'_cc_a,lw',...
% % % %         '_',num2str(n),'_cc_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
% % % %         char(39),'sp66_cc',char(39),',',char(39),...
% % % %         '~/data/gsm/mat/GSM_9_21_',char(39),',',...
% % % %         char(39),'n',char(39),');'])
% % % %     
    eval(['[lw_',num2str(n),'_wekw_a,lw',...
        '_',num2str(n),'_wekw_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
        char(39),'wek',char(39),',',char(39),...
        '~/data/QuickScat/ULTI_mat/QSCAT_30_25km_',char(39),',',...
        char(39),'w',char(39),');'])
% %  
%     eval(['[lw_',num2str(n),'_wek_a,lw',...
%         '_',num2str(n),'_wek_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
%         char(39),'w_ek',char(39),',',char(39),...
%         '~/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])    
end
save -append FINAL_ddw_comps
% return

%now just winter

load ~/matlab/regions/tracks/tight/lw_tracks
[yeaa,mona,daya]=jd2jdate(track_jday);
%ii=find(track_jday>=2451911 & track_jday<=2452599);
%ii=find(mona>=5 & mona<=10 & track_jday>=2451911 & track_jday<=2455137);
ii=find(mona>=5 & mona<=10 & track_jday>=2451911 & track_jday<=2452599);
x=x(ii);
y=y(ii);
cyc=cyc(ii);
id=id(ii);
track_jday=track_jday(ii);
scale=scale(ii);
k=k(ii);
% 
% [lw_chl_a,lw_chl_c]=comps(x,y,cyc,k,id,track_jday,scale,'sp66_chl','~/data/gsm/mat/GSM_9_21_','ddw');
% [lw_car_a,lw_car_c]=comps(x,y,cyc,k,id,track_jday,scale,'sp66_car','~/data/gsm/mat/GSM_9_21_','cw');
% [lw_ccc_a,lw_ccc_c]=comps(x,y,cyc,k,id,track_jday,scale,'sp66_cc','~/data/gsm/mat/GSM_9_21_','w');
[lw_wek_a,lw_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'w_ek','~/data/QuickScat/mat/QSCAT_30_25km_','w');
% % 
% 
save -append FINAL_ddw_comps
%now plot
% 
% clear
 load FINAL_ddw_comps
% %  load no_coast_comps
% % 
fbc=lw_wek_a.mean;
fbc2=lw_wek_a.mean;
fbc=interp2(fbc,2);
fbc2=interp2(fbc2,2);
pcomps_raw2(fbc,fbc2,[-7 7],-1,.01,1,['Ekman upwelling'],2,20)
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/wek_a

fbc=lw_wek_c.mean;
fbc2=lw_wek_c.mean;
fbc=interp2(fbc,2);
fbc2=interp2(fbc2,2);
pcomps_raw2(fbc,fbc2,[-7 7],-1,.01,1,['Ekman downwelling'],2,20)
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/wek_c


fbc=lw_chl_a.mean;
fbc2=lw_wek_a.mean;
fbc=interp2(fbc,2);
fbc2=interp2(fbc2,2);
pcomps_raw2(fbc,fbc2,[-.12 .12],-1,.01,1,['CHL',char(39) char(39)],1,20)
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/sp66_chl_a


fbc=smoothn(lw_car_a.median,2);
fbc=interp2(fbc,2);
pcomps_raw2(fbc,fbc2,[-.05 .05],-1,.01,1,['C_{phyto}',char(39) char(39)],1,20)
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/sp66_car_a

fbc=smoothn(lw_ccc_a.mean,2);
fbc=(interp2(fbc,2));
pcomps_raw2(fbc,fbc2,[-.001 .001],-1,.01,1,['r_C',char(39)],1,20)
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/sp66_cc_a

fbc=lw_chl_c.mean;
fbc2=lw_wek_c.mean;
fbc=interp2(fbc,2);
fbc2=interp2(fbc2,2);
pcomps_raw2(fbc,fbc2,[-.12 .12],-1,.01,1,['CHL',char(39) char(39)],1,20)
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/sp66_chl_c


fbc=smoothn(lw_car_c.median,2);
fbc=interp2(fbc,2);
pcomps_raw2(fbc,fbc2,[-.05 .05],-1,.01,1,['C_{phyto}',char(39) char(39)],1,20)
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/sp66_car_c

fbc=smoothn(lw_ccc_c.mean,3);
fbc=(interp2(fbc,2));
pcomps_raw2(fbc,fbc2,[-.001 .001],-1,.01,1,['r_C',char(39)],1,20)
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/sp66_cc_c

% 
% % 
% % 
% % fbc=lw_chl_a.median;
% % fbc2=smoothn(lw_wek_a.median,40);
% % % fbc2=smoothn(lw_wek_a.median,40)+.02;
% % fbc=interp2(fbc,2);
% % fbc2=interp2(fbc2,2);
% % pcomps_raw(fbc,fbc2,[-.004 .004],-1,.01,1,['mean CHL',char(39),' and Ekman pumping'],1,50)
% % print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/mean_sp66_chl_a
% % 
% % fbc=lw_chl_c.median;
% % fbc2=smoothn(lw_wek_c.median,40);
% % % fbc2=smoothn(lw_wek_c.median,40)-.02;
% % fbc=interp2(fbc,2);
% % fbc2=interp2(fbc2,2);
% % pcomps_raw(fbc,fbc2,[-.004 .004],-1,.01,1,['mean CHL',char(39),' and Ekman pumping'],1,50)
% % print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/mean_sp66_chl_c
% 
% % 
% fbc=lw_6_ddwchl_a.median;
% fbc2=lw_6_wekw_a.median;
% fbc=interp2(fbc,2);
% fbc2=interp2(fbc2,2);
% pcomps_raw2(fbc,fbc2,[-.12 .12],-1,.01,1,['June median anticyclones'],1,30)
% print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/dud_compare/meadian_sp66_chl_a
% 
% fbc=lw_6_ddwchl_a.mean;
% fbc2=lw_6_wekw_a.mean;
% fbc=interp2(fbc,2);
% fbc2=interp2(fbc2,2);
% pcomps_raw2(fbc,fbc2,[-.12 .12],-1,.01,1,['June mean anticyclones'],1,30)
% print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/dud_compare/mean_sp66_chl_a
% 
% fbc=lw_6_ddwchl_c.median;
% fbc2=lw_6_wekw_c.median;
% fbc=interp2(fbc,2);
% fbc2=interp2(fbc2,2);
% pcomps_raw2(fbc,fbc2,[-.12 .12],-1,.01,1,['June median cyclones'],1,30)
% print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/dud_compare/meadian_sp66_chl_c
% 
% fbc=lw_6_ddwchl_c.mean;
% fbc2=lw_6_wekw_c.mean;
% fbc=interp2(fbc,2);
% fbc2=interp2(fbc2,2);
% pcomps_raw2(fbc,fbc2,[-.12 .12],-1,.01,1,['June mean cyclones'],1,30)
% print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/dud_compare/mean_sp66_chl_c
% 
% return

clear
load FINAL_ddw_comps
for n=1:12
    
     
%     fbc=['lw','_',num2str(n),'_chl_a.n'];
%     nn=['lw','_',num2str(n),'_chl_a.n_max_sample'];
%     eval(['lab=num2str(', nn,');'])
%     eval(['fbc=double(interp2(',fbc,'));'])
%     pcomps_raw(fbc,fbc,[485 525],-1,.001,1,['June N anticyclones'],1)
%     eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/sp66_chl_cont/lw_n',num2str(n),'_a']) 
% 
%     fbc=['lw','_',num2str(n),'_chl_c.n'];
%     nn=['lw','_',num2str(n),'_chl_c.n_max_sample'];
%     eval(['lab=num2str(', nn,');'])
%     eval(['fbc=double(interp2(',fbc,'));'])
%     pcomps_raw(fbc,fbc,[521 556],-1,.001,1,['June N cyclones'],1)
%     eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/sp66_chl_cont/lw_n',num2str(n),'_c']) 
%      
% %     return
%     fbc=['lw','_',num2str(n),'_noac_a.median'];
%     nn=['lw','_',num2str(n),'_ddchl_a.n_max_sample'];
%     eval(['lab=num2str(', nn,');'])
%     eval(['fbc=double(interp2(',fbc,'));'])
%     pcomps_raw(fbc,fbc,[-.004 .004],-1,.001,1,[mon(n,:),' N=',num2str(lab)],1,50)
%     eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/noac_chl/lw_',num2str(n),'_a']) 
% 
%     fbc=['lw','_',num2str(n),'_noac_c.median'];
%     nn=['lw','_',num2str(n),'_ddchl_c.n_max_sample'];
%     eval(['fbc=double(interp2(',fbc,'));'])
%     eval(['lab=num2str(', nn,');'])
%     pcomps_raw(fbc,fbc,[-.004 .004],-1,.001,1,[mon(n,:),' N=',num2str(lab)],1,50)
%     eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/noac_chl/lw_',num2str(n),'_c'])
%     
%     
%     fbc=['lw','_',num2str(n),'_nocc_a.median'];
%     nn=['lw','_',num2str(n),'_chl_a.n_max_sample'];
%     eval(['lab=num2str(', nn,');'])
%     eval(['fbc=double(interp2(',fbc,'));'])
%     pcomps(fbc,fbc,[-.004 .004],-1,.001,1,[mon(n,:),' N=',num2str(lab)])
%     eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/nocc_chl/lw_',num2str(n),'_a']) 
% 
%     fbc=['lw','_',num2str(n),'_noac_a.median'];
%     nn=['lw','_',num2str(n),'_chl_c.n_max_sample'];
%     eval(['fbc=double(interp2(',fbc,'));'])
%     eval(['lab=num2str(', nn,');'])
%     pcomps(-fliplr(flipud(fbc)),-fliplr(flipud(fbc))+.0005,[-.004 .004],-1,.001,1,[mon(n,:),' N=',num2str(lab)])
%     eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/nocc_chl/lw_',num2str(n),'_c'])
%     
%     
%  
%     fbc=['lw','_',num2str(n),'_chl_a.median'];
%     nn=['lw','_',num2str(n),'_chl_a.n_max_sample'];
%     eval(['lab=num2str(', nn,');'])
%     eval(['fbc=double(interp2(',fbc,'));'])
%     pcomps(fbc,fbc,[-.004 .004],-1,.001,1,[mon(n,:),' N=',num2str(lab)])
%     eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/sp66_chl_cont/lw_',num2str(n),'_a']) 
% 
%     fbc=['lw','_',num2str(n),'_chl_c.median'];
%     nn=['lw','_',num2str(n),'_chl_c.n_max_sample'];
%     eval(['fbc=double(interp2(',fbc,'));'])
%     eval(['lab=num2str(', nn,');'])
%     pcomps(fbc,fbc,[-.004 .004],-1,.001,1,[mon(n,:),' N=',num2str(lab)])
%     eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/sp66_chl_cont/lw_',num2str(n),'_c'])
%     
%     
%     fbc=['lw','_',num2str(n),'_chl_a.median'];
%     fbc2=['lw','_',num2str(n),'_ddchl_a.median'];
%     nn=['lw','_',num2str(n),'_ddchl_a.n_max_sample'];
%     eval(['lab=num2str(', nn,');'])
%     eval(['fbc=double((',fbc,'));'])
%     eval(['fbc2=double((',fbc2,'));'])
%     pcomps_raw((abs(fbc./max(abs(fbc(:))))-abs(fbc2./max(abs(fbc2(:))))),nan*fbc2,[-.1 .1],-1,.01,1,[mon(n,:)],1,50)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/diff_chl/lw_',num2str(n),'_a']) 
% 
%     fbc=['lw','_',num2str(n),'_chl_c.median'];
%     fbc2=['lw','_',num2str(n),'_ddchl_c.median'];
%     nn=['lw','_',num2str(n),'_ddchl_c.n_max_sample'];
%     eval(['lab=num2str(', nn,');'])
%     eval(['fbc=double((',fbc,'));'])
%     eval(['fbc2=double((',fbc2,'));'])
%     pcomps_raw((abs(fbc./max(abs(fbc(:))))-abs(fbc2./max(abs(fbc2(:))))),nan*fbc2,[-.1 .1],-1,.01,1,[mon(n,:)],1,50)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/diff_chl/lw_',num2str(n),'_c']) 
%     

    fbc=['lw','_',num2str(n),'_ddchl_a.median'];
    fbc2=['lw','_',num2str(n),'_wek_a.median'];
    nn=['lw','_',num2str(n),'_ddchl_a.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double((',fbc,'));'])
    eval(['fbc2=double((',fbc2,'));'])
    pcomps_raw(fbc,fbc2,[-.1 .1],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/00_ddsp66_chl/lw_',num2str(n),'_a']) 

    fbc=['lw','_',num2str(n),'_ddchl_c.median'];
    fbc2=['lw','_',num2str(n),'_wek_c.median'];
    nn=['lw','_',num2str(n),'_ddchl_c.n_max_sample'];
    eval(['fbc=double((',fbc,'));'])
    eval(['fbc2=double((',fbc2,'));'])
    eval(['lab=num2str(', nn,');'])
    pcomps_raw(fbc,fbc2,[-.1 .1],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/00_ddsp66_chl/lw_',num2str(n),'_c'])
        
%     
    fbc=['lw','_',num2str(n),'_log_a.mean'];
    fbc2=['lw','_',num2str(n),'_wekw_a.mean'];
    nn=['lw','_',num2str(n),'_ddchl_a.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double((',fbc,'));'])
    eval(['fbc2=double(smoothn(',fbc2,',1));'])
    pcomps_raw(fbc,fbc2,[-.03 .03],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/00_bp26_chl/lw_',num2str(n),'_a']) 

    fbc=['lw','_',num2str(n),'_log_c.mean'];
    fbc2=['lw','_',num2str(n),'_wekw_c.mean'];
    nn=['lw','_',num2str(n),'_ddchl_c.n_max_sample'];
    eval(['fbc=double((',fbc,'));'])
    if n==12
        eval(['fbc2=double(smoothn(',fbc2,',3));'])
    else
        eval(['fbc2=double(smoothn(',fbc2,',1));'])
    end
    eval(['lab=num2str(', nn,');'])
    pcomps_raw(fbc,fbc2,[-.03 .03],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/00_bp26_chl/lw_',num2str(n),'_c'])
        
    


%     fbc=['lw','_',num2str(n),'_car_a.median'];
%     fbc2=['lw','_',num2str(n),'_wek_a.median'];
%     nn=['lw','_',num2str(n),'_car_a.n_max_sample'];
%     eval(['fbc=double(interp2(',fbc,'));'])
%     eval(['fbc2=double(interp2(',fbc2,'));'])
%     eval(['lab=num2str(', nn,');'])
%     pcomps(fbc,fbc2,[-.4 .4],-1,.01,1,[mon(n,:),' N=',num2str(lab)])
%     eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/sp66_car/lw_',num2str(n),'_a']) 
% 
%     fbc=['lw','_',num2str(n),'_car_c.median'];
%     fbc2=['lw','_',num2str(n),'_wek_c.median'];
%     eval(['fbc=double(interp2(',fbc,'));'])
%     eval(['fbc2=double(interp2(',fbc2,'));'])
%     nn=['lw','_',num2str(n),'_car_c.n_max_sample'];
%     eval(['lab=num2str(', nn,');'])
%     pcomps(fbc,fbc2,[-.4 .4],-1,.01,1,[mon(n,:),' N=',num2str(lab)])
%     eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/sp66_car/lw_',num2str(n),'_c'])
  end
