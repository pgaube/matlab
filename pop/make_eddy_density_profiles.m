% clear all
% load zissou.pal
% load GS_core_eddies_run14_sla
% load /Users/new_gaube/matlab/pop/mat/pop_model_domain.mat lat lon z
% z=z(1:20);
% uid=unique(stream_eddies.id);
% !toast figs/pdens/eddy_*
% 
% for m=1:length(uid)
%     ii=find(stream_eddies.id==uid(m));
%     if stream_eddies.cyc(ii(1))==1
%         ucyc(m)=1;
%     else
%         ucyc(m)=-1;
%     end
% end
% 
% [pd1,apd1,pd4,apd4]=deal(nan(20,60,length(uid)));
% 
% for m=1:length(uid)
%     ii=find(stream_eddies.id==uid(m) & stream_eddies.k==1 & stream_eddies.amp>=10);
%     jj=find(stream_eddies.id==uid(m) & stream_eddies.k==5 & stream_eddies.amp>=10);
%     if any(ii&jj)
%         load(['~/matlab/pop/mat/run14_',num2str(stream_eddies.track_jday(ii))],'pdens','pdens_anom')
%         
%         [r,c]=imap(stream_eddies.y(ii)-.1,stream_eddies.y(ii)+.1,stream_eddies.x(ii)-3,stream_eddies.x(ii)+3,lat,lon);
%         figure(1)
%         clf
%         contourf(lon(r(1),c),z,double(squeeze(pdens_anom(r(1),c,:)))');shading flat;axis ij;colormap(zissou)
%         hold on
%         [cs,h]=contour(lon(r(1),c),z,double(squeeze(pdens(r(1),c,:)))',[23.6:.5:30],'k')
%         caxis([-1 1])
%         clabel(cs,h)
%         colorbar
%         if ucyc(m)==1
%             title(['Anticyclone ',num2str(uid(m)),' at week 1 with amp=',num2str(stream_eddies.amp(ii))])
%         else
%             title(['Cyclone ',num2str(uid(m)),' at week 1 with amp=',num2str(stream_eddies.amp(ii))])
%         end
%         eval(['print -dpng -r300 figs/pdens/eddy_week1_',num2str(uid(m))])
%         pd1(:,:,m)=double(squeeze(pdens(r(1),c(1:60),:)))';
%         apd1(:,:,m)=double(squeeze(pdens_anom(r(1),c(1:60),:)))';
%         
%         clear r c pdnes pdens_anom
%         load(['~/matlab/pop/mat/run14_',num2str(stream_eddies.track_jday(jj))],'pdens','pdens_anom')
%         [r,c]=imap(stream_eddies.y(jj)-.1,stream_eddies.y(jj)+.1,stream_eddies.x(jj)-3,stream_eddies.x(jj)+3,lat,lon);
%         figure(2)
%         clf
%         contourf(lon(r(1),c),z,double(squeeze(pdens_anom(r(1),c,:)))');shading flat;axis ij;colormap(zissou)
%         hold on
%         [cs,h]=contour(lon(r(1),c),z,double(squeeze(pdens(r(1),c,:)))',[23.6:.5:30],'k')
%         caxis([-1 1])
%         clabel(cs,h)
%         colorbar
%         if ucyc(m)==1
%             title(['Anticyclone ',num2str(uid(m)),' at week 5 with amp=',num2str(stream_eddies.amp(jj))])
%         else
%             title(['Cyclone ',num2str(uid(m)),' at week 5 with amp=',num2str(stream_eddies.amp(jj))])
%         end
%         eval(['print -dpng -r300 figs/pdens/eddy_week5_',num2str(uid(m))])
%         pd4(:,:,m)=double(squeeze(pdens(r(1),c(1:60),:)))';
%         apd4(:,:,m)=double(squeeze(pdens_anom(r(1),c(1:60),:)))';
%         
%         
%         
%         
%         
%     end
% end
% 
% dist=111.11*(lon(r(1),c)-stream_eddies.x(jj))
% dist=dist(1:60);
% save zonal_dens_sections_eddys z dist pd1 pd4 apd1 apd4 

figure(1)
clf
subplot(221)
mean_pd=nanmean(pd1(:,:,find(ucyc==1)),3);
mean_apd=nanmean(apd1(:,:,find(ucyc==1)),3);
contourf(dist,z,mean_apd);shading flat;axis ij;colormap(zissou)
hold on
[cs,h]=contour(dist,z,mean_pd,[23.6:.5:30],'k')
caxis([-.5 .5])
clabel(cs,h)
colorbar
title('Mean anticyclones @ week 1')


subplot(222)
mean_pd=nanmean(pd1(:,:,find(ucyc==-1)),3);
mean_apd=nanmean(apd1(:,:,find(ucyc==-1)),3);
contourf(dist,z,mean_apd);shading flat;axis ij;colormap(zissou)
hold on
[cs,h]=contour(dist,z,mean_pd,[23.6:.5:30],'k')
caxis([-.5 .5])
clabel(cs,h)
colorbar
title('Mean cyclones @ week 1')


subplot(223)
mean_pd=nanmean(pd4(:,:,find(ucyc==1)),3);
mean_apd=nanmean(apd4(:,:,find(ucyc==1)),3);
contourf(dist,z,mean_apd);shading flat;axis ij;colormap(zissou)
hold on
[cs,h]=contour(dist,z,mean_pd,[23.6:.5:30],'k')
caxis([-.5 .5])
clabel(cs,h)
colorbar
title('Mean anticyclones @ week 5')


subplot(224)
mean_pd=nanmean(pd4(:,:,find(ucyc==-1)),3);
mean_apd=nanmean(apd4(:,:,find(ucyc==-1)),3);
contourf(dist,z,mean_apd);shading flat;axis ij;colormap(zissou)
hold on
[cs,h]=contour(dist,z,mean_pd,[23.6:.5:30],'k')
caxis([-.5 .5])
clabel(cs,h)
colorbar
title('Mean cyclones @ week 5')
print -dpng -r300 figs/pdens/means_eddies


