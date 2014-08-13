%{
load chelle.pal
load /matlab/data/gsm/mean_gchl.mat mean_gchl glat glon
load /matlab/data/gsm/mask
mean_gchl=smoothn(mean_gchl,20);
%}

figure(1)
clf
%set(gcf,'color','k')
%set(gca,'color','k')
%set(gcf, 'InvertHardCopy', 'off')

m_proj('satellite','lon',200,'lat',-10,'alt',300);   
%m_grid('xtick',[0:50:360],'ytick',[-90:10:90],'tickdir','in','color','w','lineweight',1.5);  
hold on
m_pcolor(glon,glat,double(mean_gchl))
hold on
%m_contour(glon,glat,double(mean_gchl),[-3:.1:1],'color',[.5 .5 .5])
shading flat
m_coast('patch',[0 0 0]);
caxis([-1.3 .1])

colormap(chelle)
set(gca,'xcolor','w','ycolor','w')
axis image

print -dpng -r300 ~/Desktop/tattoo




	
   		