clear all
% 
% mon=['jan';'feb';'mar';'apr';'may';'jun';'jul';'aug';'sep';'oct';'nov';'dec'];
% % 
% % % % load ~/data/eddy/V5/new_lw_p_lat_lon_orgin_tracks x y cyc id track_jday scale k
% load ~/matlab/regions/tracks/tight/lw_tracks x y cyc id track_jday scale k
% ii=find(track_jday>=2451911 & track_jday<=2455137);
% x=x(ii);
% y=y(ii);
% cyc=cyc(ii);
% id=id(ii);
% track_jday=track_jday(ii);
% scale=scale(ii);
% k=k(ii);
% 
% [yeaa,mona,daya]=jd2jdate(track_jday);
% % 
% for n=1:12
%     ii=find(mona==n);
%     eval(['[lw_',num2str(n),'_noac_a,lw',...
%         '_',num2str(n),'_noac_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
%         char(39),'hp66_noac_chl',char(39),',',char(39),...
%         '~/data/gsm/larry_no_eddy_mat/GSM_9_21_',char(39),',',...
%         char(39),'ddw',char(39),');'])
%     
%     eval(['[lw_',num2str(n),'_nocc_a,lw',...
%         '_',num2str(n),'_nocc_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
%         char(39),'hp66_nocc_chl',char(39),',',char(39),...
%         '~/data/gsm/larry_no_eddy_mat/GSM_9_21_',char(39),',',...
%         char(39),'ddw',char(39),');'])
%      
% d 
% end
% save -append FINAL_ddw_comps
% % return
% 
% %now just winter
% 
% load ~/matlab/regions/tracks/tight/lw_tracks
% [yeaa,mona,daya]=jd2jdate(track_jday);
% %ii=find(track_jday>=2451911 & track_jday<=2452599);
% %ii=find(mona>=5 & mona<=10 & track_jday>=2451911 & track_jday<=2455137);
% ii=find(mona>=5 & mona<=10 & track_jday>=2451911 & track_jday<=2452599);
% x=x(ii);
% y=y(ii);
% cyc=cyc(ii);
% id=id(ii);
% track_jday=track_jday(ii);
% scale=scale(ii);
% k=k(ii);
% 
% [lw_chl_a,lw_chl_c]=comps(x,y,cyc,k,id,track_jday,scale,'sp66_chl','~/data/gsm/mat/GSM_9_21_','ddw');
% [lw_car_a,lw_car_c]=comps(x,y,cyc,k,id,track_jday,scale,'sp66_car','~/data/gsm/mat/GSM_9_21_','cw');
% [lw_ccc_a,lw_ccc_c]=comps(x,y,cyc,k,id,track_jday,scale,'sp66_cc','~/data/gsm/mat/GSM_9_21_','w');
% [lw_wek_a,lw_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'w_ek','~/data/QuickScat/mat/QSCAT_30_25km_','w');
% % % 
% % 
% save -append FINAL_ddw_comps
% %now plot
% % 


% %now plot
% % 


% clear
 load FINAL_ddw_comps
% %  load no_coast_comps
% % 
% 
% fbc=lw_chl_a.mean;
% fbc2=lw_wek_a.mean;
% fbc=interp2(fbc,2);
% fbc2=interp2(fbc2,2);
% pcomps_raw2(fbc,fbc2,[-.12 .12],-1,.01,1,['CHL',char(39) char(39)],1,20)
% print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/sp66_chl_a
% 
% 
% fbc=smoothn(lw_car_a.median,2);
% fbc=interp2(fbc,2);
% pcomps_raw2(fbc,fbc2,[-.05 .05],-1,.01,1,['C_{phyto}',char(39) char(39)],1,20)
% print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/sp66_car_a
% 
% fbc=smoothn(lw_ccc_a.mean,2);
% fbc=(interp2(fbc,2));
% pcomps_raw2(fbc,fbc2,[-.001 .001],-1,.01,1,['r_C',char(39)],1,20)
% print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/sp66_cc_a
% 
% fbc=lw_chl_c.mean;
% fbc2=lw_wek_c.mean;
% fbc=interp2(fbc,2);
% fbc2=interp2(fbc2,2);
% pcomps_raw2(fbc,fbc2,[-.12 .12],-1,.01,1,['CHL',char(39) char(39)],1,20)
% print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/sp66_chl_c
% 
% 
% fbc=smoothn(lw_car_c.median,2);
% fbc=interp2(fbc,2);
% pcomps_raw2(fbc,fbc2,[-.05 .05],-1,.01,1,['C_{phyto}',char(39) char(39)],1,20)
% print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/sp66_car_c
% 
% fbc=smoothn(lw_ccc_c.mean,3);
% fbc=(interp2(fbc,2));
% pcomps_raw2(fbc,fbc2,[-.001 .001],-1,.01,1,['r_C',char(39)],1,20)
% print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/winter/sp66_cc_c
% 

clear
load FINAL_ddw_comps
for n=1:12
    
    fbc=['lw','_',num2str(n),'_chl_a.median'];
    fbc2=['lw','_',num2str(n),'_wek_a.median'];
    nn=['lw','_',num2str(n),'_chl_a.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double((',fbc,'));'])
    eval(['fbc2=double(smoothn(',fbc2,',1));'])
    pcomps_raw(fbc,fbc2,[-.1 .1],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/sp66_chl/lw_',num2str(n),'_a']) 

    fbc=['lw','_',num2str(n),'_chl_c.median'];
    fbc2=['lw','_',num2str(n),'_wek_c.median'];
    nn=['lw','_',num2str(n),'_chl_c.n_max_sample'];
    eval(['fbc=double((',fbc,'));'])
    eval(['fbc2=double(smoothn(',fbc2,',1));'])
    eval(['lab=num2str(', nn,');'])
    pcomps_raw(fbc,fbc2,[-.1 .1],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/sp66_chl/lw_',num2str(n),'_c'])
        
    
    fbc=['lw','_',num2str(n),'_nocc_a.median'];
    fbc2=['lw','_',num2str(n),'_wek_a.median'];
    nn=['lw','_',num2str(n),'_chl_a.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double((',fbc,'));'])
    eval(['fbc2=double(smoothn(',fbc2,',1));'])
    pcomps_raw(fbc,fbc2,[-.1 .1],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/nocc_chl/lw_',num2str(n),'_a']) 

    fbc=['lw','_',num2str(n),'_noac_c.median'];
    fbc2=['lw','_',num2str(n),'_wek_c.median'];
    nn=['lw','_',num2str(n),'_chl_c.n_max_sample'];
    eval(['fbc=double((',fbc,'));'])
    eval(['fbc2=double(smoothn(',fbc2,',1));'])
    eval(['lab=num2str(', nn,');'])
    pcomps_raw(fbc,fbc2,[-.1 .1],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/noac_chl/lw_',num2str(n),'_c'])
        
     
    fbc=['lw','_',num2str(n),'_log_a.mean'];
    fbc2=['lw','_',num2str(n),'_wek_a.mean'];
    nn=['lw','_',num2str(n),'_chl_a.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double((',fbc,'));'])
    eval(['fbc2=double(smoothn(',fbc2,',1));'])
    pcomps_raw(fbc,fbc2,[-.03 .03],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/bp26_chl/lw_',num2str(n),'_a']) 

    fbc=['lw','_',num2str(n),'_log_c.mean'];
    fbc2=['lw','_',num2str(n),'_wek_c.mean'];
    nn=['lw','_',num2str(n),'_chl_c.n_max_sample'];
    eval(['fbc=double((',fbc,'));'])
    eval(['fbc2=double(smoothn(',fbc2,',1));'])
    eval(['lab=num2str(', nn,');'])
    pcomps_raw(fbc,fbc2,[-.03 .03],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/bp26_chl/lw_',num2str(n),'_c'])
        
  end
