clear
set_regions
% 

load FINAL_cor_sm_output
[r,c]=imap(-70,15,30,170,lat,lon);

clf
pmap(lon(r,c),lat(r,c),sm_wcor(r,c))
hold on
m_contour(lon(r,c),lat(r,c),sm_wcor(r,c),[.17 .17],'color',[.5 .5 .5],'linewidth',3)
caxis([-.5 .5])
load bwr.pal
colormap(bwr)
title('Cross correlation of Ekman pumping and CHL anomalies   ')

print -dpng -r300 figs/SIO_cor_wek_chl


[r,c]=imap(-50,-5,30,170,lat,lon);

clf
pmap(lon(r,c),lat(r,c),sm_wcor(r,c))
hold on
% m_contour(lon(r,c),lat(r,c),sm_wcor(r,c),[.17 .17],'color',[.5 .5 .5],'linewidth',3)
caxis([-.3 .3])
load bwr.pal
colormap(bwr)
title('Cross correlation of Ekman pumping and CHL anomalies   ')
print -dpng -r300 figs/SIO_cor_wek_chl2
