clear all
load pop_bec_cor_0
load mean_gs_path_obs_pop
load bwr.pal

r_min=abs(tinv((.05)/2,N(1,1,6)-1)./sqrt(N(1,1,6)))


sm_r0=smoothn(r0(:,:,6),200);
sm_r0(abs(sm_r0)<r_min)=nan;

figure(1)
clf
pmap(plon,plat,sm_r0)
colormap(bwr)
caxis([-.5 .5])
hold on
m_contour(plon,plat,sm_r0,[-.2 -.2],'k')
m_plot(lons,lats,'k','linewidth',4)
m_plot(lons,lats-4*std_lats,'k--','linewidth',3)
m_plot(lons,lats+4*std_lats,'k--','linewidth',3)
title('Correlation of SSH and CHL')
print -dpng -r300 figs/cor_and_pop_stream_loc


sm_r0=smoothn(tr0(:,:,6),200);
sm_r0(abs(sm_r0)<r_min)=nan;

figure(2)
clf
pmap(plon,plat,sm_r0)
colormap(bwr)
caxis([-.5 .5])
hold on
m_contour(plon,plat,sm_r0,[-.2 -.2],'k')
m_plot(lons,lats,'k','linewidth',4)
m_plot(lons,lats-4*std_lats,'k--','linewidth',3)
m_plot(lons,lats+4*std_lats,'k--','linewidth',3)
title('Correlation of SSH and CHL in eddies')
print -dpng -r300 figs/tcor_and_pop_stream_loc

sm_r0=smoothn(nr0(:,:,6),200);
sm_r0(abs(sm_r0)<r_min)=nan;

figure(3)
clf
pmap(plon,plat,sm_r0)
colormap(bwr)
caxis([-.5 .5])
hold on
m_contour(plon,plat,sm_r0,[-.2 -.2],'k')
m_plot(lons,lats,'k','linewidth',4)
m_plot(lons,lats-4*std_lats,'k--','linewidth',3)
m_plot(lons,lats+4*std_lats,'k--','linewidth',3)
title('Correlation of SSH and CHL not in eddies')
print -dpng -r300 figs/ncor_and_pop_stream_loc


sm_r0=smoothn(ar0(:,:,6),200);
sm_r0(abs(sm_r0)<r_min)=nan;

figure(4)
clf
pmap(plon,plat,sm_r0)
colormap(bwr)
caxis([-.5 .5])
hold on
m_contour(plon,plat,sm_r0,[-.2 -.2],'k')
m_plot(lons,lats,'k','linewidth',4)
m_plot(lons,lats-4*std_lats,'k--','linewidth',3)
m_plot(lons,lats+4*std_lats,'k--','linewidth',3)
title('Correlation of SSH and CHL in anticyclones')
print -dpng -r300 figs/acor_and_pop_stream_loc


sm_r0=smoothn(cr0(:,:,6),200);
sm_r0(abs(sm_r0)<r_min)=nan;

figure(5)
clf
pmap(plon,plat,sm_r0)
colormap(bwr)
caxis([-.5 .5])
hold on
m_contour(plon,plat,sm_r0,[-.2 -.2],'k')
m_plot(lons,lats,'k','linewidth',4)
m_plot(lons,lats-4*std_lats,'k--','linewidth',3)
m_plot(lons,lats+4*std_lats,'k--','linewidth',3)
title('Correlation of SSH and CHL in cyclones')
print -dpng -r300 figs/ccor_and_pop_stream_loc



