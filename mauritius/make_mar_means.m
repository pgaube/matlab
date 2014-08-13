clear all


% cd ~/data/eddy/V5/
% 
% load maurtitus_lat_lon_tracks
% 
% cd ~/matlab/mauritius/
% jdays=unique(track_jday);
% 
% 
% load ~/data/eddy/V5/mat/AVISO_25_W_2448910.mat lat lon
% slat=lat;slon=lon;
% load ~/data/gsm/mat/GSM_9_21_2450821.mat glat glon
% load ~/matlab/domains/maurtitus_lat_lon
% 
% [r,c]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
% [rg,cg]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);
% 
% [chl_none,chl_tot,chl_ac,chl_cc,chl_ed]=deal(nan(length(rg),length(cg),length(jdays)));
% N=0;
% ghead='~/data/gsm/mat/GSM_9_21_';
% shead='~/data/eddy/V5/mat/AVISO_25_W_';
% for m=1:length(jdays)
%     if exist([ghead,num2str(jdays(m)),'.mat'])
%         N=N+1
%         load([ghead,num2str(jdays(m))],'gchl_week')
%         load([shead,num2str(jdays(m))],'idmask')
%         chl=10.^gchl_week(rg,cg);
%         mask=idmask(r,c);
%         ac_mask=nan*mask;
%         cc_mask=nan*mask;
%         day_ac_eid=eid(find(track_jday==jdays(m) & cyc==1));
%         day_cc_eid=eid(find(track_jday==jdays(m) & cyc==-1));
%         for dd=1:length(day_ac_eid)
%             ac_mask(abs(mask)==day_ac_eid(dd))=1;
%         end
%         for dd=1:length(day_cc_eid)
%             cc_mask(abs(mask)==day_cc_eid(dd))=1;
%         end
%         
%         non_mask=nan*mask;
%         non_mask(isnan(mask))=1;
%         
%         ed_mask=nan*mask;
%         ed_mask(~isnan(mask))=1;
%         
%         chl_none(:,:,m)=chl.*non_mask;
%         chl_tot(:,:,m)=chl;
%         chl_ac(:,:,m)=chl.*ac_mask;
%         chl_cc(:,:,m)=chl.*cc_mask;
%         chl_ed(:,:,m)=chl.*ed_mask;
% %         
% %         figure(1)
% %         clf
% %         subplot(311)
% %         pmap(glon(rg,cg),glat(rg,cg),chl)
% %         
% %         subplot(312)
% %         pmap(glon(rg,cg),glat(rg,cg),chl.*ac_mask)
% %         
% %         subplot(313)
% %         pmap(glon(rg,cg),glat(rg,cg),chl.*cc_mask)
% %         
% %         drawnow
%     end
% end
%         
% save mear_means chl_* N

load mear_means
tab(1,1)=pmean(chl_tot);
tab(2,1)=pmean(chl_ed);
tab(3,1)=pmean(chl_none);
tab(4,1)=pmean(chl_ac);
tab(5,1)=pmean(chl_cc);
   

tab(1,3)=pstd(chl_tot);
tab(2,3)=pstd(chl_ed);
tab(3,3)=pstd(chl_none);
tab(4,3)=pstd(chl_ac);
tab(5,3)=pstd(chl_cc);
   

tab(1,2)=abs(pstd(chl_tot)*tinv((.05)/2,N-1)/sqrt(N));
tab(2,2)=abs(pstd(chl_ed)*tinv((.05)/2,N-1)/sqrt(N));
tab(3,2)=abs(pstd(chl_none)*tinv((.05)/2,N-1)/sqrt(N));
tab(4,2)=abs(pstd(chl_ac)*tinv((.05)/2,N-1)/sqrt(N));
tab(5,2)=abs(pstd(chl_cc)*tinv((.05)/2,N-1)/sqrt(N));

tab(:,4)=N;
        

f = figure(5);
clf
% set(f,'Position',[200 200 400 250]);
cnames = {'Mean','95% C.I.','std','N weeks'};
rnames = {'Total CHL','CHL in Eddies','CHL outside Eddies','CHL in Anticyclones','CHL in Cyclones'};
t = uitable('Parent',f,'Data',tab,'ColumnName',cnames,... 
            'RowName',rnames,'Position',[50 200 500 130],'fontsize',17);
print -dpdf figs/mean_stats_tab

