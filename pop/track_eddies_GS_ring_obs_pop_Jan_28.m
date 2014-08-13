clear all

minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);

%first track eddies in AVISO

spath='~/data/eddy/V5/mat/AVISO_25_W_';
startjd=2451549; %5 Jan 2000
endjd=2453523; %1 Jun 2005
jdays=[startjd:7:endjd];
%     
% 
% % now load SSH data
load([spath,num2str(startjd)],'lat','lon')
[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
slat=lat(r,c);
slon=lon(r,c);
% 
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
% njdays=[startjd:5:endjd];
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
load tmp_aviso_ssh
aviso_eddies=track_eddies_PG(slon,slat,jdays,nSSH,.25,5);
% save GS_rings_tracks_aviso_jan_29
% % % % 

% % % Now track eddies in model run 14

% spath='~/matlab/pop/mat/run14_';
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
% for m=1:length(pdays)
%     if exist([spath,num2str(pdays(m)),'.mat'])
%         load([spath,num2str(pdays(m))],'bp21_ssh','mdt')
%         if exist('bp21_ssh')
%             m
%             pSSH(:,:,m)=bp21_ssh(rp,cp).*mask;
%             pMDT(:,:,m)=mdt(rp,cp).*mask;
%             
%             clear bp21_ssh mdt
%         end
%     end
% %     figure(1)
% %     clf
% %     pmap(plon,plat,pMDT(:,:,m));
% %     title(num2str(m))
% %     drawnow
% end
% jdays_tmp=1:length(pdays);
pop_eddies=track_eddies_PG(plon,plat,jdays_tmp,pSSH,.1,5);
pop_eddies.track_jday=jday2pday(pop_eddies.track_jday)
save GS_rings_tracks_run14_jan_30
