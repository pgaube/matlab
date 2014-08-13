clear all
mon=['jan';'feb';'mar';'apr';'may';'jun';'jul';'aug';'sep';'oct';'nov';'dec'];

load ~/matlab/regions/tracks/tight/lw_tracks x y cyc id track_jday scale k
ii=find(track_jday>=2451911 & track_jday<=2455137 & x<107);
x=x(ii);
y=y(ii);
cyc=cyc(ii);
id=id(ii);
track_jday=track_jday(ii);
scale=scale(ii);
k=k(ii);
[yeaa,mona,daya]=jd2jdate(track_jday);

for n=1:12
    ii=find(mona==n);
    eval(['[lw_',num2str(n),'_noac_a,lw',...
        '_',num2str(n),'_noac_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
        char(39),'hp66_noac_chl',char(39),',',char(39),...
        '~/data/gsm/larry_no_eddy_mat/GSM_9_21_',char(39),',',...
        char(39),'ddw',char(39),');'])
    
    eval(['[lw_',num2str(n),'_nocc_a,lw',...
        '_',num2str(n),'_nocc_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
        char(39),'hp66_nocc_chl',char(39),',',char(39),...
        '~/data/gsm/larry_no_eddy_mat/GSM_9_21_',char(39),',',...
        char(39),'ddw',char(39),');'])
%     
    eval(['[lw_',num2str(n),'_chl_a,lw',...
        '_',num2str(n),'_chl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
        char(39),'sp66_chl',char(39),',',char(39),...
        '~/data/gsm/mat/GSM_9_21_',char(39),',',...
        char(39),'ddw',char(39),');'])
    
% %     eval(['[lw_',num2str(n),'_car_a,lw',...
% %         '_',num2str(n),'_car_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
% %         char(39),'sp66_car',char(39),',',char(39),...
% %         '~/data/gsm/mat/GSM_9_21_',char(39),',',...
% %         char(39),'n',char(39),');'])
% %     
% %     eval(['[lw_',num2str(n),'_cc_a,lw',...
% %         '_',num2str(n),'_cc_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
% %         char(39),'sp66_cc',char(39),',',char(39),...
% %         '~/data/gsm/mat/GSM_9_21_',char(39),',',...
% %         char(39),'n',char(39),');'])
%     
    eval(['[lw_',num2str(n),'_wek_a,lw',...
        '_',num2str(n),'_wek_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
        char(39),'w_ek',char(39),',',char(39),...
        '~/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
        char(39),'w',char(39),');'])
end
save -append FINAL_EK_comps



load FINAL_EK_offshore_comps
for n=1:12
    
     
    
    fbc=['lw','_',num2str(n),'_chl_a.mean'];
    fbc2=['lw','_',num2str(n),'_wek_a.mean'];
    nn=['lw','_',num2str(n),'_chl_a.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double(smoothn(',fbc,',1));'])
    eval(['fbc2=double(smoothn(',fbc2,',1));'])
    pcomps_raw(fbc,fbc2,[-.14 .14],-1,.01,1,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/00_no_coast_sp66_chl/lw_',num2str(n),'_a']) 

    fbc=['lw','_',num2str(n),'_noac_c.mean'];
    fbc2=['lw','_',num2str(n),'_wek_c.mean'];
    nn=['lw','_',num2str(n),'_chl_c.n_max_sample'];
    eval(['fbc=double(smoothn(',fbc,',1));'])
    if n==12
        eval(['fbc2=double(smoothn(',fbc2,',3));'])
    else
        eval(['fbc2=double(smoothn(',fbc2,',1));'])
    end
    eval(['lab=num2str(', nn,');'])
    pcomps_raw(fbc,fbc2,[-.14 .14],-1,.01,1,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/00_no_coast_sp66_chl/lw_',num2str(n),'_c'])
      end
