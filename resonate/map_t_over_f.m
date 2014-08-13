load mapped_eddy_properties
load chelle.pal

t_ed=period_map;
t_E=pi./abs(f_cor(lat))./60./60./24;

tt=t_ed./t_E;

[r,c]=imap(-70,70,0,360,lat,lon);

figure(1)
clf
set(gcf,'PaperPosition',[1 1 11 11])
subplot(311)
pmap(lon(r,c),lat(r,c),amplitude_map(r,c))
caxis([0 30])
hold on
[cs,cc]=m_contour(lon(r,c),lat(r,c),smoothn(amplitude_map(r,c),20),[0:5:100],'k');
clabel(cs,cc,'labelspacing', 100,'fontsize',8);
cb=colorbar
title('a) Mesoscale Eddy Amplitude')
axes(cb)
ylabel('cm')

subplot(312)
pmap(lon(r,c),lat(r,c),period_map(r,c))
caxis([0 15])
hold on
[cs,cc]=m_contour(lon(r,c),lat(r,c),smoothn(period_map(r,c),20),[0:2:30],'k');
clabel(cs,cc,'labelspacing', 100,'fontsize',8);
cb=colorbar
title('b) Mesoscale Eddy Rotation Period')
axes(cb)
ylabel('days')

subplot(313)
pmap(lon(r,c),lat(r,c),tt(r,c))
caxis([0 35])
hold on
[cs,cc]=m_contour(lon(r,c),lat(r,c),smoothn(tt(r,c),20),[0:5:30],'k');
clabel(cs,cc,'labelspacing', 100,'fontsize',8);
cb=colorbar
title('c) Mesoscale Eddy Rotation Period Divided by Inertial Period')
axes(cb)
ylabel('T_{eddy}f/2\pi')
colormap(chelle)

print -dpng -r300 t_eddy_over_t_earth_3_pan
