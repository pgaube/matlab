load chelle.pal
%load tmp_ssh_trans_sample norm*

xi=[-7:1/15:7];
[dlon,dlat]=meshgrid(xi,xi);
dist = sqrt((dlon.^2)+(dlat.^2));
mask=nan*dist;
mask(dist<=3)=1;

figure(2)
clf
hax=axes;
pcolor(mask.*ak_anom_c);shading interp;axis image
hold on
set(hax,'xtick',1:15:211,'ytick',1:15:211,'xticklabel',abs(-7:1:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid   '})
xlabel({,'normalized distance from eddy centroid   '})
%rotateticklabel(hax,90);
caxis([-.15 .15])
colormap(chelle)
hold on
line([0 211],[106 106],'color','k')
line([106 106],[0 221],'color','k')
axis([45 165 45 165])
title({'Alaska Current  ','Composite Normalized CHL Anomaly  ','Cyclonic Eddies  '})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('log_{10}(mg m^{-3})')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/comps/AK_anom_cycl.png']) 

figure(1)
clf
hax=axes;
pcolor(mask.*ak_anom_a);shading interp;axis image
hold on
set(hax,'xtick',1:15:211,'ytick',1:15:211,'xticklabel',abs(-7:1:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid   '})
xlabel({,'normalized distance from eddy centroid   '})
%rotateticklabel(hax,90);
caxis([-.15 .15])
colormap(chelle)
hold on
line([0 211],[106 106],'color','k')
line([106 106],[0 221],'color','k')
axis([45 165 45 165])
title({'Alaska Current  ','Composite Normalized CHL Anomaly  ','Anticyclonic Eddies  '})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('log_{10}(mg m^{-3})')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/comps/AK_anom_anti.png']) 

figure(2)
clf
hax=axes;
pcolor(mask.*ccns_anom_c);shading interp;axis image
hold on
set(hax,'xtick',1:15:211,'ytick',1:15:211,'xticklabel',abs(-7:1:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid   '})
xlabel({,'normalized distance from eddy centroid   '})
%rotateticklabel(hax,90);
caxis([-.15 .15])
colormap(chelle)
hold on
line([0 211],[106 106],'color','k')
line([106 106],[0 221],'color','k')
axis([45 165 45 165])
title({'California Current  ','Composite Normalized CHL Anomaly  ','Cyclonic Eddies  '})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('log_{10}(mg m^{-3})')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/comps/ccns_anom_cycl.png']) 

figure(1)
clf
hax=axes;
pcolor(mask.*ccns_anom_a);shading interp;axis image
hold on
set(hax,'xtick',1:15:211,'ytick',1:15:211,'xticklabel',abs(-7:1:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid   '})
xlabel({,'normalized distance from eddy centroid   '})
%rotateticklabel(hax,90);
caxis([-.15 .15])
colormap(chelle)
hold on
line([0 211],[106 106],'color','k')
line([106 106],[0 221],'color','k')
axis([45 165 45 165])
title({'California Current  ','Composite Normalized CHL Anomaly  ','Anticyclonic Eddies  '})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('log_{10}(mg m^{-3})')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/comps/ccns_anom_anti.png']) 


figure(2)
clf
hax=axes;
pcolor(mask.*pc_anom_c);shading interp;axis image
hold on
set(hax,'xtick',1:15:211,'ytick',1:15:211,'xticklabel',abs(-7:1:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid   '})
xlabel({,'normalized distance from eddy centroid   '})
%rotateticklabel(hax,90);
caxis([-.1 .1])
colormap(chelle)
hold on
line([0 211],[106 106],'color','k')
line([106 106],[0 221],'color','k')
axis([45 165 45 165])
title({'Peru-Chile Current  ','Composite Normalized CHL Anomaly  ','Cyclonic Eddies  '})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('log_{10}(mg m^{-3})')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/comps/pc_anom_cycl.png']) 

figure(1)
clf
hax=axes;
pcolor(mask.*pc_anom_a);shading interp;axis image
hold on
set(hax,'xtick',1:15:211,'ytick',1:15:211,'xticklabel',abs(-7:1:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid   '})
xlabel({,'normalized distance from eddy centroid   '})
%rotateticklabel(hax,90);
caxis([-.1 .1])
colormap(chelle)
hold on
line([0 211],[106 106],'color','k')
line([106 106],[0 221],'color','k')
axis([45 165 45 165])
title({'Peru-Chile Current  ','Composite Normalized CHL Anomaly  ','Anticyclonic Eddies  '})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('log_{10}(mg m^{-3})')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/comps/pc_anom_anti.png']) 


figure(2)
clf
hax=axes;
pcolor(mask.*cc_anom_c);shading interp;axis image
hold on
set(hax,'xtick',1:15:211,'ytick',1:15:211,'xticklabel',abs(-7:1:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid   '})
xlabel({,'normalized distance from eddy centroid   '})
%rotateticklabel(hax,90);
caxis([-.05 .05])
colormap(chelle)
hold on
line([0 211],[106 106],'color','k')
line([106 106],[0 221],'color','k')
axis([45 165 45 165])
title({'Canary Current  ','Composite Normalized CHL Anomaly  ','Cyclonic Eddies  '})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('log_{10}(mg m^{-3})')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/comps/cc_anom_cycl.png']) 

figure(1)
clf
hax=axes;
pcolor(mask.*cc_anom_a);shading interp;axis image
hold on
set(hax,'xtick',1:15:211,'ytick',1:15:211,'xticklabel',abs(-7:1:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid   '})
xlabel({,'normalized distance from eddy centroid   '})
%rotateticklabel(hax,90);
caxis([-.05 .05])
colormap(chelle)
hold on
line([0 211],[106 106],'color','k')
line([106 106],[0 221],'color','k')
axis([45 165 45 165])
title({'Canary Current  ','Composite Normalized CHL Anomaly  ','Anticyclonic Eddies  '})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('log_{10}(mg m^{-3})')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/comps/cc_anom_anti.png']) 




figure(2)
clf
hax=axes;
pcolor(mask.*bg_anom_c);shading interp;axis image
hold on
set(hax,'xtick',1:15:211,'ytick',1:15:211,'xticklabel',abs(-7:1:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid   '})
xlabel({,'normalized distance from eddy centroid   '})
%rotateticklabel(hax,90);
caxis([-.15 .15])
colormap(chelle)
hold on
line([0 211],[106 106],'color','k')
line([106 106],[0 221],'color','k')
axis([45 165 45 165])
title({'Benguela Current  ','Composite Normalized CHL Anomaly  ','Cyclonic Eddies  '})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('log_{10}(mg m^{-3})')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/comps/bg_anom_cycl.png']) 

figure(1)
clf
hax=axes;
pcolor(mask.*bg_anom_a);shading interp;axis image
hold on
set(hax,'xtick',1:15:211,'ytick',1:15:211,'xticklabel',abs(-7:1:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid   '})
xlabel({,'normalized distance from eddy centroid   '})
%rotateticklabel(hax,90);
caxis([-.15 .15])
colormap(chelle)
hold on
line([0 211],[106 106],'color','k')
line([106 106],[0 221],'color','k')
axis([45 165 45 165])
title({'Benguela Current  ','Composite Normalized CHL Anomaly  ','Anticyclonic Eddies  '})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('log_{10}(mg m^{-3})')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/comps/bg_anom_anti.png']) 

%}
figure(2)
clf
hax=axes;
pcolor(mask.*lw_anom_c);shading interp;axis image
hold on
set(hax,'xtick',1:15:211,'ytick',1:15:211,'xticklabel',abs(-7:1:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid   '})
xlabel({,'normalized distance from eddy centroid   '})
%rotateticklabel(hax,90);
caxis([-.15 .15])
colormap(chelle)
hold on
line([0 211],[106 106],'color','k')
line([106 106],[0 221],'color','k')
axis([45 165 45 165])
title({'Leeuwin Current  ','Composite Normalized CHL Anomaly  ','Cyclonic Eddies  '})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('log_{10}(mg m^{-3})')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/comps/lw_anom_cycl.png']) 

figure(1)
clf
hax=axes;
pcolor(mask.*lw_anom_a);shading interp;axis image
hold on
set(hax,'xtick',1:15:211,'ytick',1:15:211,'xticklabel',abs(-7:1:7),'yticklabel',abs(-7:7),'xminortick','on','yminortick','on')
ylabel({'normalized distance from eddy centroid   '})
xlabel({,'normalized distance from eddy centroid   '})
%rotateticklabel(hax,90);
caxis([-.15 .15])
colormap(chelle)
hold on
line([0 211],[106 106],'color','k')
line([106 106],[0 221],'color','k')
axis([45 165 45 165])
title({'Leeuwin Current  ','Composite Normalized CHL Anomaly  ','Anticyclonic Eddies  '})
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('log_{10}(mg m^{-3})')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/comps/lw_anom_anti.png']) 


