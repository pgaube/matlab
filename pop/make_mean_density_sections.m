clear all
load zissou.pal
load /Users/new_gaube/matlab/pop/mat/pop_model_domain.mat lat lon z
z=z(1:20);
% % % 
% load GS_core_meanders_run14_sla
% % % 
% % [mcompa,mcompc] = pop_comps3D(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.radius,stream_eddies.track_jday,'pdens_anom');
% [mcompda,mcompdc] = pop_comps3D(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.radius,stream_eddies.track_jday,'pdens');
% % clear stream_eddies
% % 
% load GS_core_eddies_run14_sla
% % 
% % [ecompa,ecompc] = pop_comps3D(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.radius,stream_eddies.track_jday,'pdens_anom');
% [ecompda,ecompdc] = pop_comps3D(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.radius,stream_eddies.track_jday,'pdens');
% % 
% save -append pdens_3d_comp ecomp* mcomp*
% % % return

load pdens_3d_comp
xi=[-2:.125:2];
figure(1)
clf
set(gcf,'PaperPosition',[1 1 8 6])
subplot(221)
contourf(xi,z,squeeze(mcompa.mean(17,:,:))');shading flat;axis ij;colormap(zissou)
hold on
contour(xi,z,squeeze(mcompda.mean(17,:,:))',[23.5:30],'k')
[cs,h]=contour(xi,z,squeeze(mcompda.mean(17,:,:))',[23:30],'k')
clabel(cs,h,'LabelSpacing',1000,'fontsize',10)
caxis([-.5 .5])
set(gca,'LineWidth',1,'TickLength',[.02 .04],'layer','top','xtick',[-2:2])
daspect([2 250 1])
line([0 0],[0 600],'color','k')

subplot(222)
contourf(xi,z,squeeze(mcompc.mean(17,:,:))');shading flat;axis ij;colormap(zissou)
hold on
contour(xi,z,squeeze(mcompdc.mean(17,:,:))',[23.5:30],'k')
[cs,h]=contour(xi,z,squeeze(mcompdc.mean(17,:,:))',[23:30],'k')
clabel(cs,h,'LabelSpacing',1000,'fontsize',10)
caxis([-.5 .5])
set(gca,'LineWidth',1,'TickLength',[.02 .04],'layer','top','xtick',[-2:2])
daspect([2 250 1])
line([0 0],[0 600],'color','k')

subplot(223)
contourf(xi,z,squeeze(ecompa.mean(17,:,:))');shading flat;axis ij;colormap(zissou)
hold on
contour(xi,z,squeeze(ecompda.mean(17,:,:))',[23.5:30],'k')
[cs,h]=contour(xi,z,squeeze(ecompda.mean(17,:,:))',[23:30],'k')
clabel(cs,h,'LabelSpacing',1000,'fontsize',10)
caxis([-.5 .5])
set(gca,'LineWidth',1,'TickLength',[.02 .04],'layer','top','xtick',[-2:2])
daspect([2 250 1])
line([0 0],[0 600],'color','k')

subplot(224)
contourf(xi,z,squeeze(ecompc.mean(17,:,:))');shading flat;axis ij;colormap(zissou)
hold on
contour(xi,z,squeeze(ecompdc.mean(17,:,:))',[23.5:30],'k')
[cs,h]=contour(xi,z,squeeze(ecompdc.mean(17,:,:))',[23:30],'k')
clabel(cs,h,'LabelSpacing',1000,'fontsize',10)
caxis([-.5 .5])
set(gca,'LineWidth',1,'TickLength',[.02 .04],'layer','top','xtick',[-2:2])
daspect([2 250 1])
line([0 0],[0 600],'color','k')


print -dpng -r300 figs/mean_section_of_pends