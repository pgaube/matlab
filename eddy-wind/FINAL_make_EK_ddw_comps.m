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

[yeaa,mona,daya]=jd2jdate(track_jday);

for n=1:12
    ii=find(mona==n);
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
        
    eval(['[lw_',num2str(n),'_wek_a,lw',...
        '_',num2str(n),'_wek_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
        char(39),'w_ek',char(39),',',char(39),...
        '~/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
        char(39),'w',char(39),');'])
      
end

save -append FINAL_ddw_comps
% 

%full year
[lw_noac_a,lw_noac_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp66_noac_chl','~/data/gsm/larry_no_eddy_mat/GSM_9_21_','n');
save -append FINAL_ddw_comps
return
clear
load FINAL_ddw_comps
for n=1:12


    fbc=['lw','_',num2str(n),'_noac_c.mean'];
    fbc2=['lw','_',num2str(n),'_wekw_c.mean'];
    nn=['lw','_',num2str(n),'_ddchl_c.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double(smoothn(',fbc,',1));'])
    if n==12
        eval(['fbc2=double(smoothn(',fbc2,',3));'])
    else
        eval(['fbc2=double(smoothn(',fbc2,',1));'])
    end
    
    pcomps_raw(fbc,fbc2,[-.12 .12],-1,.01,1,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/noac_chl/lw_',num2str(n),'_c'])
    
    fbc=['lw','_',num2str(n),'_noac_a.mean'];
    fbc2=['lw','_',num2str(n),'_wekw_a.mean'];
    nn=['lw','_',num2str(n),'_ddwchl_a.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double(smoothn(',fbc,',1));'])
    eval(['fbc2=double(smoothn(',fbc2,',1));'])
    pcomps_raw(fbc,fbc2,[-.12 .12],-1,.01,1,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/noac_chl/lw_',num2str(n),'_a'])
    
    
    fbc=['lw','_',num2str(n),'_ddwchl_a.mean'];
    fbc2=['lw','_',num2str(n),'_wekw_a.mean'];
    nn=['lw','_',num2str(n),'_ddchl_a.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double(smoothn(',fbc,',1));'])
    eval(['fbc2=double(smoothn(',fbc2,',1));'])
    pcomps_raw(fbc,fbc2,[-.12 .12],-1,.01,1,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/nocc_chl/lw_',num2str(n),'_a']) 
    
    fbc=['lw','_',num2str(n),'_nocc_c.mean'];
    fbc2=['lw','_',num2str(n),'_wekw_c.mean'];
    nn=['lw','_',num2str(n),'_ddchl_c.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double(smoothn(',fbc,',1));'])
    eval(['fbc2=double(smoothn(',fbc2,',1));'])
    pcomps_raw(fbc,fbc2,[-.12 .12],-1,.01,1,[mon(n,:),' N=',num2str(lab)],1,50)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/nocc_chl/lw_',num2str(n),'_c']) 
    
end