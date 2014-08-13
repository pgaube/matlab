clear all
% 
mon=['jan';'feb';'mar';'apr';'may';'jun';'jul';'aug';'sep';'oct';'nov';'dec'];
% 
load ~/matlab/regions/tracks/tight/lw_tracks x y cyc id track_jday scale k
ii=find(track_jday>=2450828 & track_jday<=2455137);
% ii=find(track_jday>=2451913 & track_jday<=2455137);
% % ii=find(track_jday>=2451913 & track_jday<=2452046);
% 
x=x(ii);
y=y(ii);
cyc=cyc(ii);
id=id(ii);
track_jday=track_jday(ii);
scale=scale(ii);
k=k(ii);
% [lw_chl_a,lw_chl_c]=comps(x,y,cyc,k,id,track_jday,scale,'sp66_chl','~/data/gsm/mat/GSM_9_21_','n');
[lw_kd490_a,lw_kd490_c]=comps(x,y,cyc,k,id,track_jday,scale,'gkd_week','~/data/gsm/mat/GSM_9_21_','n');

% [lw_full_chl_a,lw_full_chl_c]=comps(x,y,cyc,k,id,track_jday,scale,'gchl_week','~/data/gsm/mat/GSM_9_21_','n');
save -append FINAL_monthly_comps lw_*_a lw_*_c
return
% [yeaa,mona,daya]=jd2jdate(track_jday);
% 
% for n=1:12
%     ii=find(mona==n);
%     eval(['[lw_',num2str(n),'_chl_a,lw',...
%         '_',num2str(n),'_chl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
%         char(39),'sp66_chl',char(39),',',char(39),...
%         '~/data/gsm/mat/GSM_9_21_',char(39),',',...
%         char(39),'ddw',char(39),');'])
%     
% %     eval(['[lw_',num2str(n),'_noac_chl_a,lw',...
% %         '_',num2str(n),'_noac_chl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
% %         char(39),'hp66_noac_chl',char(39),',',char(39),...
% %         '~/data/gsm/larry_no_eddy_mat/GSM_9_21_',char(39),',',...
% %         char(39),'ddw',char(39),');'])
%          
%     eval(['[lw_',num2str(n),'_wek_a,lw',...
%         '_',num2str(n),'_wek_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
%         char(39),'wek',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_',char(39),',',...
%         char(39),'w',char(39),');'])
%       
% end
% 
% save -append FINAL_monthly_comps

load FINAL_monthly_comps
for n=1:12


    fbc=['lw','_',num2str(n),'_chl_c.mean'];
    fbc2=['lw','_',num2str(n),'_wek_c.mean'];
    nn=['lw','_',num2str(n),'_chl_c.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double(smoothn(',fbc,',1));'])
    eval(['fbc2=double(smoothn(',fbc2,',2));'])
    
    pcomps_raw2(fbc,fbc2,[-.12 .12],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/FINAL_chl/lw_',num2str(n),'_c'])
 
%     
%     fbc=['lw','_',num2str(n),'_noac_chl_c.mean'];
%     fbc2=['lw','_',num2str(n),'_wek_c.mean'];
%     nn=['lw','_',num2str(n),'_noac_chl_c.n_max_sample'];
%     eval(['lab=num2str(', nn,');'])
%     eval(['fbc=double(smoothn(',fbc,',1));'])
%     eval(['fbc2=double(smoothn(',fbc2,',2));'])
%     
%     pcomps_raw2(fbc,fbc2,[-.12 .12],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/FINAL_chl/lw_',num2str(n),'_c'])
%  
    fbc=['lw','_',num2str(n),'_chl_a.mean'];
    fbc2=['lw','_',num2str(n),'_wek_a.mean'];
    nn=['lw','_',num2str(n),'_chl_a.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double(smoothn(',fbc,',1));'])
    eval(['fbc2=double(smoothn(',fbc2,',2));'])
    
    pcomps_raw2(fbc,fbc2,[-.12 .12],-100,1,100,[mon(n,:),' N=',num2str(lab)],1,50)
        eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/FINAL_chl/lw_',num2str(n),'_a'])

    
end