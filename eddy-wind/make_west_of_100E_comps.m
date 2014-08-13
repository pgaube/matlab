clear all

mon=['jan';'feb';'mar';'apr';'may';'jun';'jul';'aug';'sep';'oct';'nov';'dec'];
% 
% load ~/matlab/regions/tracks/tight/lw_tracks x y cyc id track_jday scale k
% jj=find(track_jday>=2451911 & track_jday<=2455137 & x<107);
% ii=find(k(jj)==1);
% uid=unique(id(jj(ii)));
% ii=sames(uid,id);
% x=x(ii);
% y=y(ii);
% cyc=cyc(ii);
% id=id(ii);
% track_jday=track_jday(ii);
% scale=scale(ii);
% k=k(ii);
% [yeaa,mona,daya]=jd2jdate(track_jday);
% 
% figure(1)
% clf
% pmap([min(x)-10:max(x)+20],[min(y)-5:max(y)+5],[x y id cyc track_jday k],'new_tracks_starts');
% 
% for n=1:12
%     ii=find(mona==n);
%     eval(['[lw_',num2str(n),'_chl_a,lw',...
%         '_',num2str(n),'_chl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
%         char(39),'sp66_chl',char(39),',',char(39),...
%         '~/data/gsm/mat/GSM_9_21_',char(39),',',...
%         char(39),'n',char(39),');'])
% 
%     eval(['[lw_',num2str(n),'_wek_a,lw',...
%         '_',num2str(n),'_wek_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
%         char(39),'w_ek',char(39),',',char(39),...
%         '~/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
% end
% save 107E_comps
clear

load 107E_comps
for n=1:12
    fbc=['lw','_',num2str(n),'_chl_a.median'];
    fbc2=['lw','_',num2str(n),'_wek_a.median'];
    nn=['lw','_',num2str(n),'_chl_a.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double(interp2(',fbc,'));'])
    eval(['fbc2=double(interp2(',fbc2,'));'])
    pcomps_raw(fbc,fbc2,[-.004 .004],-1,.01,1,[mon(n,:),' N=',num2str(lab)],1)
    eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/107e/lw_',num2str(n),'_a']) 

    fbc=['lw','_',num2str(n),'_chl_c.median'];
    fbc2=['lw','_',num2str(n),'_wek_c.median'];
    nn=['lw','_',num2str(n),'_chl_c.n_max_sample'];
    eval(['fbc=double(interp2(',fbc,'));'])
    eval(['fbc2=double(interp2(',fbc2,'));'])
    eval(['lab=num2str(', nn,');'])
    pcomps_raw(fbc,fbc2,[-.004 .004],-1,.01,1,[mon(n,:),' N=',num2str(lab)],1)
    eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_comps/107e/lw_',num2str(n),'_c'])
end

