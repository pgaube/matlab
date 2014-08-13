function plot_comps(data,'var')



load chelle.pal

south_nfoi_a=interp2(south_nfoi_a,3);  
south_nfoi_c=interp2(south_nfoi_c,3);            
south_nssh_a=interp2(south_nssh_a,3);          
south_nssh_c=interp2(south_nssh_c,3);

xs=ones(length([-7:.25:7]),1)*[-7:.25:7];
ys=xs';
cent=29;
dist=sqrt((xs-xs(cent,cent)).^2+(ys-ys(cent,cent)).^2);
dist=interp2(dist,2);
xs=interp2(xs,2);
ys=interp2(ys,2);
mask=nan.*dist;
mask(dist<=4)=1;

south_nfoi_a=south_nfoi_a.*mask;
south_nfoi_c=south_nfoi_c.*mask;      
south_nssh_a=south_nssh_a.*mask;
south_nssh_c=south_nssh_c.*mask;
%}

figure(2)
clf
hax=axes;
pcolor(xs,ys,double(south_nfoi_c));shading flat;axis image
hold on
[c,h]=contour(xs,ys,double(south_nssh_c),[-1:.1:-.6],'k');
%clabel(c,h);
set(hax,'xminortick','on','yminortick','on')
%set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'distance from eddy centroid normalized by e-folding scale'},'fontsize',14)
%xlabel({,'distance from eddy centroid normalized by e-folding scale'},'fontsize',14)
%rotateticklabel(hax,90);
caxis([-.6 .6])
colormap(chelle)
hold on
line([-7 7],[0 0],'color','k')
line([0 0],[-7 7],'color','k')
title({'Composite Filtered OI SST Anomaly','Cyclonic Eddies'},'fontsize',14)
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C','fontsize',14)
eval(['print -dpng /Users/gaube/Documents/OSU/figures/south/trans/nfoi_cycl_d_16']) 

figure(1)
clf
hax=axes;
pcolor(xs,ys,double(south_nfoi_a));shading flat;axis image
hold on
[c,h]=contour(xs,ys,double(south_nssh_a),[.6:.1:1],'k');
%clabel(c,h);
set(hax,'xminortick','on','yminortick','on')
%set(hax,'xtick',1:8:57,'ytick',1:8:57,'xticklabel',abs(-7:2:7),'yticklabel',abs(-7:2:7),'xminortick','on','yminortick','on')
%ylabel({'distance from eddy centroid normalized by e-folding scale'},'fontsize',14)
%xlabel({'distance from eddy centroid normalized by e-folding scale'},'fontsize',14)
%rotateticklabel(hax,90);
caxis([-.6 .6])
colormap(chelle)
hold on
line([-7 7],[0 0],'color','k')
line([0 0],[-7 7],'color','k')
title({'Composite Filtered OI SST Anomaly','Anticyclonic Eddies'},'fontsize',14)
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('^{\circ}C','fontsize',14)
eval(['print -dpng /Users/gaube/Documents/OSU/figures/south/trans/nfoi_anti_d_16']) 


