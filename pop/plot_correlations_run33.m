load bwr.pal

load pop_bec_cor_0_run_33
load mean_gs_path_obs_pop_run_33 lons lats std_lats

load mean_gulf_stream
mean(:,1)=180+(180+mean(:,1));
minlat=30;
maxlat=50;
minlon=min(mean(:,1));
maxlon=max(mean(:,1));

bs=7;
as=2;

[rp,cp]=imap(minlat,maxlat,minlon,maxlon,plat,plon);
plat=plat(rp,cp);
plon=plon(rp,cp);

load mat/pop_model_domain lat lon mask1
[r,c]=imap(minlat,maxlat,min(plon(1,:)),max(plon(1,:)),lat,lon);
mask=mask1(r,c);

% rref=round(100*(tinv(.05/2,N(1,1,6)-2)/sqrt(N(1,1,9))))./100

rref=.12

mask=ones(size(r0(rp,cp,1)));
mask(find(isnan(r0(rp,cp,6))))=nan;
sm_r0=smoothn(r0(rp,cp,6),3).*mask;
r0=smoothn(r0(rp,cp,6),1).*mask;
r0(abs(r0)<rref)=nan;

mask=ones(size(ar0(rp,cp,1)));
mask(find(isnan(ar0(rp,cp,6))))=nan;
sm_r0a=smoothn(ar0(rp,cp,6),3).*mask;
r0a=smoothn(ar0(rp,cp,6),1).*mask;
r0a(abs(r0a)<rref)=nan;

mask=ones(size(cr0(rp,cp,1)));
mask(find(isnan(cr0(rp,cp,6))))=nan;
sm_r0c=smoothn(cr0(rp,cp,6),3).*mask;
r0c=smoothn(cr0(rp,cp,6),1).*mask;
r0c(abs(r0c)<rref)=nan;

mask=ones(size(nr0(rp,cp,1)));
mask(find(isnan(nr0(rp,cp,6))))=nan;
sm_r0n=smoothn(nr0(rp,cp,6),3).*mask;
r0n=smoothn(nr0(rp,cp,6),1).*mask;
r0n(abs(r0n)<rref)=nan;

mask=ones(size(tr0(rp,cp,1)));
mask(find(isnan(tr0(rp,cp,6))))=nan;
sm_r0t=smoothn(tr0(rp,cp,6),3).*mask;
r0t=smoothn(tr0(rp,cp,6),1).*mask;
r0t(abs(r0t)<rref)=nan;

figure(1)
clf
pmap(plon,plat,r0,'gs')
colormap(bwr)
caxis([-.75 .75])
hold on
m_contour(plon,plat,sm_r0,[-rref rref],'k')
ax=m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
title('POP run33 cor')
print -dpng -r300 figs/paper_run33_cor

figure(2)
clf
pmap(plon,plat,r0a,'gs')
colormap(bwr)
caxis([-.75 .75])
hold on
m_contour(plon,plat,sm_r0a,[-rref rref],'k')
ax=m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
title('POP run33 anticyclones')
print -dpng -r300 figs/paper_run33_cor_ac

figure(3)
clf
pmap(plon,plat,r0c,'gs')
colormap(bwr)
caxis([-.75 .75])
hold on
m_contour(plon,plat,sm_r0c,[-rref rref],'k')
ax=m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
title('POP run33 cyclones')
print -dpng -r300 figs/paper_run33_cor_cc

figure(4)
clf
pmap(plon,plat,r0t,'gs')
colormap(bwr)
caxis([-.75 .75])
hold on
m_contour(plon,plat,sm_r0t,[-rref rref],'k')
ax=m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
title('POP run33 all eddies')
print -dpng -r300 figs/paper_run33_cor_all

figure(5)
clf
pmap(plon,plat,r0n,'gs')
colormap(bwr)
caxis([-.75 .75])
hold on
m_contour(plon,plat,sm_r0n,[-rref rref],'k')
ax=m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
title('POP run33 no eddies')
print -dpng -r300 figs/paper_run33_cor_none


