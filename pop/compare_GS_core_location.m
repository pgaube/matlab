clear all
load mean_gulf_stream
mean(:,1)=180+(180+mean(:,1));
minlat=30;
maxlat=50;
minlon=min(mean(:,1));
maxlon=max(mean(:,1));
ff=1;
% C=[nan;nan]
% % % load temp data
% 
% spath='~/matlab/pop/mat/run33_';
% pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
% 
% 
% % now load pop SSH data
% load ~/matlab/pop/mat/pop_model_domain.mat lat lon z
% % load(['~/data/eddy/V5/mat/AVISO_25_W_2451549'],'ssh')
% idepth=14
% depth_of_iso=z(14)
% 
% [rp,cp]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
% plat=lat(rp,cp);
% plon=lon(rp,cp);
% 
% temp=nan(length(rp),length(cp),length(pdays));
% 
% for m=1:length(pdays)
%     if exist([spath,num2str(pdays(m)),'.mat'])
%         load([spath,num2str(pdays(m))],'t')
%         if exist('t')
%             m
%             temp(:,:,m)=t(rp,cp,idepth);
% 
%             clear t
%         end
%     end
%     figure(1)
%     clf
%     pmap(plon,plat,temp(:,:,m));
%     hold on
%     m_contour(plon,plat,temp(:,:,m),[15 15],'k')
%     m_plot(mean(:,1),mean(:,2),'w','linewidth',4)
%     title(num2str(m))
%     drawnow
%     eval(['print -dpng -r300 frames/15_deg_iso/frame_',num2str(ff)])
%     ff=ff+1;
%     C=cat(2,C,contourc(plon(1,:),plat(:,1),temp(:,:,m),[15 15]));
% end
% save pop_temp_at_200m_run_33 plon plat z temp C
% 
% 
% load pop_temp_at_200m_run_33 plon plat z temp C
% figure(1)
% clf
% pmap(plon,plat,nan*temp(:,:,1));
% hold on
% 
% C(:,1)=[];
% st=2;
% ed=C(2,1)+1;
% while ed<length(C(1,:))
%     if ed-st>400
%         m_plot(C(1,st:ed),C(2,st:ed),'k')
%         tmp(:,st:ed)=C(:,st:ed);
%     end
%     
%     st=ed+2;
%     ed=st-1+C(2,st-1);
% end
% m_plot(mean(:,1),mean(:,2),'g','linewidth',1)
% m_plot(mean(:,1),mean(:,2)-std,'g-','linewidth',.1)
% m_plot(mean(:,1),mean(:,2)+std,'g-','linewidth',.1)
% title('15^\cric isotherm @ 200m and climatological GS landward wall')
% 
% tmp(isnan(tmp))=[];
% deg_15_iso_contours=tmp;
% 
% lons=min(tmp(1,:)):.1:max(tmp(1,:));
% 
% for m=1:length(lons)-1
%     ii=find(tmp(1,:)>=lons(m) & tmp(1,:)<lons(m+1));
%     lats(m)=pmean(tmp(2,ii));
%     std_lats(m)=pstd(tmp(2,ii));
% end
% lons(end)=[];
% 
% m_plot(lons,lats,'r','linewidth',1)
% m_plot(lons,lats+std_lats,'r-','linewidth',.1)
% m_plot(lons,lats-std_lats,'r-','linewidth',.1)
% 
% print -dpng -r300 figs/15_deg_iso_and_steam_loc_run_33
% 
% save mean_gs_path_obs_pop_run_33 lons lats std_lats mean std

load pop_temp_at_200m_run_33 plon plat
load mean_gs_path_obs_pop
figure(1)
clf
pmap(plon,plat,nan(length(plat(:,1)),length(plon(1,:))),'gs');
hold on
ax=m_plot(smoothn(mean(:,1),10),smoothn(mean(:,2),10),'k','linewidth',2)
m_plot(smoothn(mean(:,1),10),smoothn(mean(:,2)-std,10),'k--','linewidth',.1)
m_plot(smoothn(mean(:,1),10),smoothn(mean(:,2)+std,10),'k--','linewidth',.1)
bx=m_plot(smoothn(lons,10),smoothn(lats,10),'g','linewidth',2)
% m_plot(lons,lats+std_lats,'b-','linewidth',.1)
% m_plot(lons,lats-std_lats,'b-','linewidth',.1)

load mean_gs_path_obs_pop_run_33
cx=m_plot(smoothn(lons,10),smoothn(lats,10),'b','linewidth',2)
% m_plot(lons,lats+std_lats,'b-','linewidth',.1)
% m_plot(lons,lats-std_lats,'b-','linewidth',.1)
title('Gulf Stream Landward Edge')

% m_legend([ax bx cx],'Observation','POP w/ Eddy/Wind','POP w/o Eddy/Wind')
m_line([180+(180-55) 180+(180-54)],[34.7 34.7],'color','k','linewidth',2)
m_line([180+(180-55) 180+(180-54)],[33.7 33.7],'color','b','linewidth',2)
m_line([180+(180-55) 180+(180-54)],[32.7 32.7],'color','g','linewidth',2)

m_text(180+(180-53.5),34.7,'Obs.','fontsize',8)
m_text(180+(180-53.5),33.7,'POP w/ Eddy/Wind','fontsize',8)
m_text(180+(180-53.5),32.7,'POP w/o Eddy/Wind','fontsize',8)

print -dpng -r300 figs/paper_compare_gs_core




