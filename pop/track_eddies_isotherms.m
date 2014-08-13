% clear all
% 
% minlat=30;
% maxlat=50;
% minlon=180+(180-70);
% maxlon=180+(180-35);
% 
% % % Now track eddies in model run 14
% 
% spath='~/matlab/pop/mat/run14_';
% pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
% 
% 
% % now load pop SSH data
% load ~/matlab/pop/mat/pop_model_domain.mat lat lon z
% idepth=14
% depth_of_iso=z(14)
% load(['~/data/eddy/V5/mat/AVISO_25_W_2451549'],'ssh')
% 
% 
% [rp,cp]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
% plat=lat(rp,cp);
% plon=lon(rp,cp);
% 
% pSSH=nan(length(rp),length(cp),length(pdays));
% pTEMP=pSSH;
% 
% for m=1:length(pdays)
%     if exist([spath,num2str(pdays(m)),'.mat'])
%         load([spath,num2str(pdays(m))],'bp21_ssh','t')
%         if exist('bp21_ssh')
%             m
%             pSSH(:,:,m)=bp21_ssh(rp,cp);
%             pTEMP(:,:,m)=t(rp,cp,idepth);
%             
%             clear bp21_ssh t
%         end
%     end
% %     figure(1)
% %     clf
% %     pmap(plon,plat,pTEMP(:,:,m));
% %     title(num2str(m))
% %     drawnow
% end
% 
% save temp_iso_and_ssh plat plon pdays pSSH pTEMP
clear
load temp_iso_and_ssh
jdays_tmp=1:length(pdays);
pop_eddies=track_eddies_CI(plon,plat,jdays_tmp,pSSH,pTEMP,15,.1);
pop_eddies.track_jday=jday2pday(pop_eddies.track_jday)
save GS_rings_from_15_deg_iso_at_200_m
