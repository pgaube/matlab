% clear all
% 
% minlat=30;
% maxlat=50;
% minlon=180+(180-70);
% maxlon=180+(180-35);
% 
% % % first track eddies in AVISO

spath='~/data/eddy/V5/mat/AVISO_25_W_';
startjd=2451549; %5 Jan 2000
endjd=2453523; %1 Jun 2005
jdays=[startjd:7:endjd];
%     
% 
% % now load SSH data
% load([spath,num2str(startjd)],'lat','lon')
% [r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
% slat=lat(r,c);
% slon=lon(r,c);
% % 
% 
% SSH=nan(length(r),length(c),length(jdays));
% MDT=SSH;
% for m=1:length(jdays)
%     m
%     load([spath,num2str(jdays(m))],'ssh','mdt')
%     SSH(:,:,m)=ssh(r,c);
%     MDT(:,:,m)=mdt(r,c);
%     
%     clear ssh
% end
% 
% %%%%% Now interpolate to 5-day week
njdays=[startjd:5:endjd];
% nSSH=nan(length(r),length(c),length(njdays));
% nMDT=nSSH;
% 
% for m=1:length(slat(:,1))
%     for n=1:length(slon(1,:))
%         nSSH(m,n,:)=interp1(jdays,squeeze(SSH(m,n,:)),njdays);
%         nMDT(m,n,:)=interp1(jdays,squeeze(MDT(m,n,:)),njdays);
%     end
% end
% 
%         
% 
% save tmp_aviso_ssh slat slon nSSH nMDT jdays
% load tmp_aviso_ssh
% 
% aviso_eddies=track_eddies_SLA(slon,slat,njdays,nSSH,.25);
% save -append GS_rings_tracks_run14_sla aviso_eddies

% % % % % 

% % % Now track eddies in model run 14
% 
% spath='~/matlab/pop/mat/run14_';
pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
% 
% 
% % now load pop SSH data
% load ~/matlab/pop/mat/pop_model_domain.mat lat lon
% load(['~/data/eddy/V5/mat/AVISO_25_W_2451549'],'ssh')
% mask=nan*ssh;
% mask(~isnan(ssh))=1;
% mask=mask(r,c);
% 
% [rp,cp]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
% plat=lat(rp,cp);
% plon=lon(rp,cp);
% 
% mask=griddata(slon,slat,double(mask),plon,plat,'nearest');
% 
% 
% pSSH=nan(length(rp),length(cp),length(pdays));
% pMDT=pSSH;
% 
% aSSH=nan(length(slat(:,1)),length(slon(1,:)),length(pdays));
% aMDT=aSSH;
% 
% for m=1:length(pdays)
%     if exist([spath,num2str(pdays(m)),'.mat'])
%         load([spath,num2str(pdays(m))],'bp21_ssh','mdt')
%         if exist('bp21_ssh')
%             m
%             pSSH(:,:,m)=bp21_ssh(rp,cp).*mask;
%             pMDT(:,:,m)=mdt(rp,cp).*mask;
%             
%             aSSH(:,:,m)=griddata(plon,plat,bp21_ssh(rp,cp).*mask,slon,slat,'linear');
%             aMDT(:,:,m)=griddata(plon,plat,mdt(rp,cp).*mask,slon,slat,'linear');
%             clear bp21_ssh mdt
%         end
%     end
% %     figure(1)
% %     clf
% %     subplot(211)
% %     pmap(plon,plat,pMDT(:,:,m));
% %     title(num2str(m))
% %     drawnow
% %     
% %     subplot(212)
% %     pmap(slon,slat,aMDT(:,:,m));
% %     title(num2str(m))
% %     drawnow
% end
% jdays_tmp=1:length(pdays);
% 
% save tmp_pop_ssh plat plon slon slat aSSH aMDT pSSH pMDT jdays_tmp pdays
% 
load tmp_pop_ssh
pop_grid_eddies=track_eddies_SLA(slon,slat,jdays_tmp,aSSH,.25);
pop_grid_eddies.track_jday=jday2pday(pop_grid_eddies.track_jday);
pop_grid_eddies.jday=jday2pday(pop_grid_eddies.jdays);
% % 
% pop_eddies=track_eddies_SLA(plon,plat,jdays_tmp,pSSH,.1);
% pop_eddies.track_jday=jday2pday(pop_eddies.track_jday);
% pop_eddies.jday=jday2pday(pop_eddies.jdays);
% % 
save -append GS_rings_tracks_run14_sla pop_*eddies
return


% % % Now track eddies in model run 33
% 
% spath='~/matlab/pop/mat/run33_';
% pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
% 
% 
% % now load pop SSH data
% load ~/matlab/pop/mat/pop_model_domain.mat lat lon
% load(['~/data/eddy/V5/mat/AVISO_25_W_2451549'],'ssh')
% mask=nan*ssh;
% mask(~isnan(ssh))=1;
% mask=mask(r,c);
% 
% [rp,cp]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
% plat=lat(rp,cp);
% plon=lon(rp,cp);
% 
% mask=griddata(slon,slat,double(mask),plon,plat,'nearest');
% 
% 
% pSSH=nan(length(rp),length(cp),length(pdays));
% pMDT=pSSH;
% 
% aSSH=nan(length(slat(:,1)),length(slon(1,:)),length(pdays));
% aMDT=aSSH;
% 
% for m=1:length(pdays)
%     if exist([spath,num2str(pdays(m)),'.mat'])
%         load([spath,num2str(pdays(m))],'bp21_ssh','mdt')
%         if exist('bp21_ssh')
%             m
%             pSSH(:,:,m)=bp21_ssh(rp,cp).*mask;
%             pMDT(:,:,m)=mdt(rp,cp).*mask;
%             
%             aSSH(:,:,m)=griddata(plon,plat,bp21_ssh(rp,cp).*mask,slon,slat,'linear');
%             aMDT(:,:,m)=griddata(plon,plat,mdt(rp,cp).*mask,slon,slat,'linear');
%             clear bp21_ssh mdt
%         end
%     end
% %     figure(1)
% %     clf
% %     subplot(211)
% %     pmap(plon,plat,pMDT(:,:,m));
% %     title(num2str(m))
% %     drawnow
% %     
% %     subplot(212)
% %     pmap(slon,slat,aMDT(:,:,m));
% %     title(num2str(m))
% %     drawnow
% end
% jdays_tmp=1:length(pdays);
% 
% save tmp_pop_ssh_run_33 plat plon slon slat aSSH aMDT pSSH pMDT jdays_tmp pdays
% 
load tmp_pop_ssh_run_33
pop_grid_eddies=track_eddies_SLA(slon,slat,jdays_tmp,aSSH,.25);
pop_grid_eddies.track_jday=jday2pday(pop_grid_eddies.track_jday);
pop_grid_eddies.jdays=jday2pday(pop_grid_eddies.jdays);

% 
% pop_eddies=track_eddies_SLA(plon,plat,jdays_tmp,pSSH,.1);
% pop_eddies.track_jday=jday2pday(pop_eddies.track_jday);
% pop_eddies.jdays=jday2pday(pop_eddies.jdays);

save -append GS_rings_tracks_run33_sla pop_*eddies
