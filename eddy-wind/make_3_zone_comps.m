clear all

mon=['jan';'feb';'mar';'apr';'may';'jun';'jul';'aug';'sep';'oct';'nov';'dec'];
% 
% 
% 
% for rr=1:4
%     load ~/matlab/regions/tracks/tight/lw_tracks x y cyc id track_jday scale k
% 
%     if rr==1
%         ii=find(track_jday>=2451911 & track_jday<=2455137 & x<80);
%     elseif rr==2
%         ii=find(track_jday>=2451911 & track_jday<=2455137 & x>80 & x<94);
%     elseif rr==3
%         ii=find(track_jday>=2451911 & track_jday<=2455137 & x>94 & x<108);
%     elseif rr==4
%         ii=find(track_jday>=2451911 & track_jday<=2455137 & x>108);
%     end
%     
%     x=x(ii);
%     y=y(ii);
%     cyc=cyc(ii);
%     id=id(ii);
%     track_jday=track_jday(ii);
%     scale=scale(ii);
%     k=k(ii);
%     [yeaa,mona,daya]=jd2jdate(track_jday);
%     
%     for n=1:12
%         ii=find(mona==n);
%         
%         eval(['[lw_',num2str(n),'_chl_a,lw',...
%             '_',num2str(n),'_chl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
%             char(39),'sp66_chl',char(39),',',char(39),...
%             '~/data/gsm/mat/GSM_9_21_',char(39),',',...
%             char(39),'n',char(39),');'])
%         
%         
%         eval(['[lw_',num2str(n),'_wek_a,lw',...
%             '_',num2str(n),'_wek_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
%             char(39),'w_ek',char(39),',',char(39),...
%             '~/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
%             char(39),'n',char(39),');'])
%     end
%     eval(['save 4_zone_comp_',num2str(rr)])
% end

% %%now plot
% for rr=1:4
%     eval(['load 4_zone_comp_',num2str(rr)])
%     for n=1:12
%         
%         fbc=['lw','_',num2str(n),'_chl_a.median'];
%         fbc2=['lw','_',num2str(n),'_wek_a.median'];
%         nn=['lw','_',num2str(n),'_chl_a.n_max_sample'];
%         eval(['lab=num2str(', nn,');'])
%         eval(['fbc=double(interp2(',fbc,'));'])
%         eval(['fbc2=double(interp2(',fbc2,'));'])
%         pcomps_raw(fbc,fbc2,[-.008 .008],-1,.01,1,['N=',num2str(lab)],1,40)
%         eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/3_zone/',num2str(rr),'/lw_',num2str(n),'_a'])
%         
%         fbc=['lw','_',num2str(n),'_chl_c.median'];
%         fbc2=['lw','_',num2str(n),'_wek_c.median'];
%         nn=['lw','_',num2str(n),'_chl_c.n_max_sample'];
%         eval(['fbc=double(interp2(',fbc,'));'])
%         eval(['fbc2=double(interp2(',fbc2,'));'])
%         eval(['lab=num2str(', nn,');'])
%         pcomps_raw(fbc,fbc2,[-.008 .008],-1,.01,1,['N=',num2str(lab)],1,40)
%         eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/3_zone/',num2str(rr),'/lw_',num2str(n),'_c'])
%     end
% end

for rr=1:4
    eval(['load 4_zone_comp_',num2str(rr)])
    for n=[1 6]
        
        fbc=['lw','_',num2str(n),'_chl_a.median'];
        fbc2=['lw','_',num2str(n),'_wek_a.median'];
        nn=['lw','_',num2str(n),'_chl_a.n_max_sample'];
        eval(['lab=num2str(', nn,');'])
        eval(['fbc=double(interp2(',fbc,'));'])
        eval(['fbc2=double(interp2(',fbc2,'));'])
        pcomps_raw(fbc,fbc2,[-.008 .008],-1,.01,1,[mon(n,:),' N=',num2str(lab)],1,40)
        eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/3_zone2/',num2str(rr),'/lw_',num2str(n),'_a'])
        
        fbc=['lw','_',num2str(n),'_chl_c.median'];
        fbc2=['lw','_',num2str(n),'_wek_c.median'];
        nn=['lw','_',num2str(n),'_chl_c.n_max_sample'];
        eval(['fbc=double(interp2(',fbc,'));'])
        eval(['fbc2=double(interp2(',fbc2,'));'])
        eval(['lab=num2str(', nn,');'])
        pcomps_raw(fbc,fbc2,[-.008 .008],-1,.01,1,[mon(n,:),' N=',num2str(lab)],1,40)
        eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/3_zone2/',num2str(rr),'/lw_',num2str(n),'_c'])
    end
end