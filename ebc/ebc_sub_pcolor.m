

load BG_nfamsre_comps
load LW_nfamsre_comps
load CCN_nfamsre_comps
load CCS_nfamsre_comps
load PCN_nfamsre_comps
load PCS_nfamsre_comps
load IB_nfamsre_comps
load ME_nfamsre_comps
load CC_nfamsre_comps


load chelle.pal

figure(1)
clf
hax=subplot(431);
text(0,.5,'Cyclones')
set(hax,'visible','off')
hax=subplot(434)
pcolor(double(BG_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Benguela'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(437)
pcolor(double(LW_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Leeuwin'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(432)

pcolor(double(CCN_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'North California'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(435)

pcolor(double(CCS_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'South California'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(438)

pcolor(double(PCN_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'North Peru-Chile'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(4,3,11)

pcolor(double(PCS_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'South Peru-Chile'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(433)

pcolor(double(IB_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Iberian'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(436)

pcolor(double(ME_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Mediterranean'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(439)

pcolor(double(CC_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Canary'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
land
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/nfamsre_cycl_d_16'])








figure(2)
clf
hax=subplot(431);
text(0,.5,'Cyclones')
set(hax,'visible','off')
hax=subplot(434)
pcolor(double(BG_comp_nfamsre_cycl(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(BG_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Benguela'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(437)
pcolor(double(LW_comp_nfamsre_cycl(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(LW_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Leeuwin'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(432)

pcolor(double(CCN_comp_nfamsre_cycl(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(CCN_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'North California'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(435)

pcolor(double(CCS_comp_nfamsre_cycl(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(CCN_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'South California'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(438)

pcolor(double(PCN_comp_nfamsre_cycl(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(PCN_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'North Peru-Chile'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(4,3,11)

pcolor(double(PCS_comp_nfamsre_cycl(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(PCS_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'South Peru-Chile'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(433)

pcolor(double(IB_comp_nfamsre_cycl(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(IB_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Iberian'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(436)

pcolor(double(ME_comp_nfamsre_cycl(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(ME_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Mediterranean'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(439)

pcolor(double(CC_comp_nfamsre_cycl(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(CC_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Canary'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
land
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/nfamsre_close_cycl_d_16'])


figure(1)
clf
hax=subplot(431);
text(0,.5,'Anticyclones')
set(hax,'visible','off')
hax=subplot(434)
pcolor(double(BG_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Benguela'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(437)
pcolor(double(LW_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Leeuwin'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(432)

pcolor(double(CCN_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'North California'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(435)

pcolor(double(CCS_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'South California'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(438)

pcolor(double(PCN_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'North Peru-Chile'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(4,3,11)

pcolor(double(PCS_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'South Peru-Chile'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(433)

pcolor(double(IB_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Iberian'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(436)

pcolor(double(ME_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Mediterranean'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(439)

pcolor(double(CC_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Canary'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
land
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/nfamsre_anti_d_16'])



figure(2)
clf
hax=subplot(431);
text(0,.5,'Anticyclones')
set(hax,'visible','off')
hax=subplot(434)
pcolor(double(BG_comp_nfamsre_anti(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(BG_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Benguela'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(437)
pcolor(double(LW_comp_nfamsre_anti(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(LW_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Leeuwin'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(432)

pcolor(double(CCN_comp_nfamsre_anti(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(CCN_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'North California'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(435)

pcolor(double(CCS_comp_nfamsre_anti(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(CCN_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'South California'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(438)

pcolor(double(PCN_comp_nfamsre_anti(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(PCN_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'North Peru-Chile'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(4,3,11)

pcolor(double(PCS_comp_nfamsre_anti(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(PCS_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'South Peru-Chile'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(433)

pcolor(double(IB_comp_nfamsre_anti(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(IB_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Iberian'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(436)

pcolor(double(ME_comp_nfamsre_anti(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
%xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(ME_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Mediterranean'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')

hax=subplot(439)

pcolor(double(CC_comp_nfamsre_anti(22:36,22:36)));shading flat;axis image
set(hax,'xtick',1:4:15,'ytick',1:4:15,'xticklabel',abs(-1.75:1.75),'yticklabel',abs(-1.75:1.75),'xminortick','on','yminortick','on')

%ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
[c,h]=contour(double(CC_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Canary'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
land
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/nfamsre_close_anti_d_16'])
