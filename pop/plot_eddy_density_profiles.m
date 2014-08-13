clear all
load zissou.pal
load /Users/new_gaube/matlab/pop/mat/pop_model_domain.mat lat lon z
z=z(1:20);

figure(1)
set(gcf,'PaperPosition',[1 1 6 6])
plot(Sig*ones(size(z)),z,'k--')

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


