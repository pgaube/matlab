%Make eddy composites for the EBC and plot

clear
load chelle.pal
c=29;


%start with the BG

[BG_comp_anom_anti,BG_comp_anom_cycl]=comps_4km('/Volumes/matlab/matlab/ebc/BG_lat_lon_tracks_16_weeks.mat','chl_anom_sample');

figure(1)
clf
hax=axes;
pcolor(double(BG_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/BG/nfamsre_cycl_d_16']) 



save BG_chl_comps BG*

return


%next do CCN
[CCN_comp_nfamsre_anti,CCN_comp_nfamsre_cycl]=comps('/Volumes/matlab/matlab/ebc/CCN_lat_lon_tracks_16_weeks.mat','nfamsre_sample');
[CCN_comp_nssh_anti,CCN_comp_nssh_cycl]=comps('/Volumes/matlab/matlab/ebc/CCN_lat_lon_tracks_16_weeks.mat','nssh_sample');

figure(1)
clf
hax=axes;
pcolor(double(CCN_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/CCN/nfamsre_cycl_d_16']) 



figure(2)
clf
hax=axes;
pcolor(double(CCN_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Anticyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/CCN/nfamsre_anti_d_16']) 


figure(3)
clf
hax=axes;
pcolor(double(CCN_comp_nfamsre_cycl(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
[c,h]=contour(double(CCN_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/CCN/nfamsre_close_cycl_d_16']) 

figure(4)
clf
hax=axes;
pcolor(double(CCN_comp_nfamsre_anti(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','antionic Eddies'})
[c,h]=contour(double(CCN_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/CCN/nfamsre_close_anti_d_16']) 


save CCN_nfamsre_comps CCN*

%next do CCS
[CCS_comp_nfamsre_anti,CCS_comp_nfamsre_cycl]=comps('/Volumes/matlab/matlab/ebc/CCS_lat_lon_tracks_16_weeks.mat','nfamsre_sample');
[CCS_comp_nssh_anti,CCS_comp_nssh_cycl]=comps('/Volumes/matlab/matlab/ebc/CCS_lat_lon_tracks_16_weeks.mat','nssh_sample');

figure(1)
clf
hax=axes;
pcolor(double(CCS_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/CCS/nfamsre_cycl_d_16']) 



figure(2)
clf
hax=axes;
pcolor(double(CCS_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Anticyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/CCS/nfamsre_anti_d_16']) 


figure(3)
clf
hax=axes;
pcolor(double(CCS_comp_nfamsre_cycl(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
[c,h]=contour(double(CCS_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/CCS/nfamsre_close_cycl_d_16']) 

figure(4)
clf
hax=axes;
pcolor(double(CCS_comp_nfamsre_anti(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','antionic Eddies'})
[c,h]=contour(double(CCS_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/CCS/nfamsre_close_anti_d_16']) 


save CCS_nfamsre_comps CCS*

%next do CC
[CC_comp_nfamsre_anti,CC_comp_nfamsre_cycl]=comps('/Volumes/matlab/matlab/ebc/CC_lat_lon_tracks_16_weeks.mat','nfamsre_sample');
[CC_comp_nssh_anti,CC_comp_nssh_cycl]=comps('/Volumes/matlab/matlab/ebc/CC_lat_lon_tracks_16_weeks.mat','nssh_sample');

figure(1)
clf
hax=axes;
pcolor(double(CC_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/CC/nfamsre_cycl_d_16']) 



figure(2)
clf
hax=axes;
pcolor(double(CC_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Anticyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/CC/nfamsre_anti_d_16']) 


figure(3)
clf
hax=axes;
pcolor(double(CC_comp_nfamsre_cycl(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
[c,h]=contour(double(CC_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/CC/nfamsre_close_cycl_d_16']) 

figure(4)
clf
hax=axes;
pcolor(double(CC_comp_nfamsre_anti(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','antionic Eddies'})
[c,h]=contour(double(CC_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/CC/nfamsre_close_anti_d_16']) 


save CC_nfamsre_comps CC*

%next do IB
[IB_comp_nfamsre_anti,IB_comp_nfamsre_cycl]=comps('/Volumes/matlab/matlab/ebc/IB_lat_lon_tracks_16_weeks.mat','nfamsre_sample');
[IB_comp_nssh_anti,IB_comp_nssh_cycl]=comps('/Volumes/matlab/matlab/ebc/IB_lat_lon_tracks_16_weeks.mat','nssh_sample');

figure(1)
clf
hax=axes;
pcolor(double(IB_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/IB/nfamsre_cycl_d_16']) 



figure(2)
clf
hax=axes;
pcolor(double(IB_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Anticyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/IB/nfamsre_anti_d_16']) 


figure(3)
clf
hax=axes;
pcolor(double(IB_comp_nfamsre_cycl(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
[c,h]=contour(double(IB_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/IB/nfamsre_close_cycl_d_16']) 

figure(4)
clf
hax=axes;
pcolor(double(IB_comp_nfamsre_anti(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','antionic Eddies'})
[c,h]=contour(double(IB_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/IB/nfamsre_close_anti_d_16']) 


save IB_nfamsre_comps IB*

%next do LW
[LW_comp_nfamsre_anti,LW_comp_nfamsre_cycl]=comps('/Volumes/matlab/matlab/ebc/LW_lat_lon_tracks_16_weeks.mat','nfamsre_sample');
[LW_comp_nssh_anti,LW_comp_nssh_cycl]=comps('/Volumes/matlab/matlab/ebc/LW_lat_lon_tracks_16_weeks.mat','nssh_sample');

figure(1)
clf
hax=axes;
pcolor(double(LW_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/LW/nfamsre_cycl_d_16']) 



figure(2)
clf
hax=axes;
pcolor(double(LW_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Anticyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/LW/nfamsre_anti_d_16']) 


figure(3)
clf
hax=axes;
pcolor(double(LW_comp_nfamsre_cycl(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
[c,h]=contour(double(LW_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/LW/nfamsre_close_cycl_d_16']) 

figure(4)
clf
hax=axes;
pcolor(double(LW_comp_nfamsre_anti(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','antionic Eddies'})
[c,h]=contour(double(LW_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/LW/nfamsre_close_anti_d_16']) 


save LW_nfamsre_comps LW*

%next do ME
[ME_comp_nfamsre_anti,ME_comp_nfamsre_cycl]=comps('/Volumes/matlab/matlab/ebc/ME_lat_lon_tracks_16_weeks.mat','nfamsre_sample');
[ME_comp_nssh_anti,ME_comp_nssh_cycl]=comps('/Volumes/matlab/matlab/ebc/ME_lat_lon_tracks_16_weeks.mat','nssh_sample');

figure(1)
clf
hax=axes;
pcolor(double(ME_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/ME/nfamsre_cycl_d_16']) 



figure(2)
clf
hax=axes;
pcolor(double(ME_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Anticyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/ME/nfamsre_anti_d_16']) 


figure(3)
clf
hax=axes;
pcolor(double(ME_comp_nfamsre_cycl(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
[c,h]=contour(double(ME_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/ME/nfamsre_close_cycl_d_16']) 

figure(4)
clf
hax=axes;
pcolor(double(ME_comp_nfamsre_anti(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','antionic Eddies'})
[c,h]=contour(double(ME_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/ME/nfamsre_close_anti_d_16']) 


save ME_nfamsre_comps ME*

%next do PCN
[PCN_comp_nfamsre_anti,PCN_comp_nfamsre_cycl]=comps('/Volumes/matlab/matlab/ebc/PCN_lat_lon_tracks_16_weeks.mat','nfamsre_sample');
[PCN_comp_nssh_anti,PCN_comp_nssh_cycl]=comps('/Volumes/matlab/matlab/ebc/PCN_lat_lon_tracks_16_weeks.mat','nssh_sample');

figure(1)
clf
hax=axes;
pcolor(double(PCN_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/PCN/nfamsre_cycl_d_16']) 



figure(2)
clf
hax=axes;
pcolor(double(PCN_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Anticyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/PCN/nfamsre_anti_d_16']) 


figure(3)
clf
hax=axes;
pcolor(double(PCN_comp_nfamsre_cycl(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
[c,h]=contour(double(PCN_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/PCN/nfamsre_close_cycl_d_16']) 

figure(4)
clf
hax=axes;
pcolor(double(PCN_comp_nfamsre_anti(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','antionic Eddies'})
[c,h]=contour(double(PCN_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/PCN/nfamsre_close_anti_d_16']) 


save PCN_nfamsre_comps PCN*

%next do PCS
[PCS_comp_nfamsre_anti,PCS_comp_nfamsre_cycl]=comps('/Volumes/matlab/matlab/ebc/PCS_lat_lon_tracks_16_weeks.mat','nfamsre_sample');
[PCS_comp_nssh_anti,PCS_comp_nssh_cycl]=comps('/Volumes/matlab/matlab/ebc/PCS_lat_lon_tracks_16_weeks.mat','nssh_sample');

figure(1)
clf
hax=axes;
pcolor(double(PCS_comp_nfamsre_cycl));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/PCS/nfamsre_cycl_d_16']) 



figure(2)
clf
hax=axes;
pcolor(double(PCS_comp_nfamsre_anti));shading flat;axis image
set(hax,'xtick',1:4:57,'ytick',1:4:57,'xticklabel',abs(-7:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 57],[29 29],'color','k')
line([29 29],[0 57],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Anticyclonic Eddies'})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/PCS/nfamsre_anti_d_16']) 


figure(3)
clf
hax=axes;
pcolor(double(PCS_comp_nfamsre_cycl(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','Cyclonic Eddies'})
[c,h]=contour(double(PCS_comp_nssh_cycl(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/PCS/nfamsre_close_cycl_d_16']) 

figure(4)
clf
hax=axes;
pcolor(double(PCS_comp_nfamsre_anti(22:36,22:36)));shading interp;axis image
set(hax,'xtick',1:2:15,'ytick',1:2:15,'xticklabel',abs(-1.75:.5:1.75),'yticklabel',abs(-1.75:.5:1.75),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid'})
xlabel({,'normalized distance from eddy centroid'})
%rotateticklabel(hax,90);
caxis([-.5 .5])
colormap(chelle)
hold on
line([0 15],[8 8],'color','k')
line([8 8],[0 15],'color','k')
title({'Composite Filtered AMSR-E SST Anomaly','antionic Eddies'})
[c,h]=contour(double(PCS_comp_nssh_anti(22:36,22:36)),'k');
clabel(c,h);
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C')
eval(['print -dpng ~/Documents/OSU/classes/EB09/project/figs/comps/PCS/nfamsre_close_anti_d_16']) 


save PCS_nfamsre_comps PCS*