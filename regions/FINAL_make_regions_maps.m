clear
set_regions
% 
load ~/data/gsm/FINAL_cor_out
% 
cor_0=r0_ssh(:,:,9);
cor_plus_4=r0_ssh(:,:,13);
Sig=Sig_ssh;
wcor=r0_wek(:,:,9);
wSig=Sig_wek;


sm_cor_plus_4=smooth2d_loess(cor_plus_4,lon(1,:),lat(:,1),10,10,lon(1,:),lat(:,1));

sm_cor_0=smooth2d_loess(cor_0,lon(1,:),lat(:,1),10,10,lon(1,:),lat(:,1));
sm_wcor=smooth2d_loess(wcor,lon(1,:),lat(:,1),10,10,lon(1,:),lat(:,1));
% 
[r,c]=imap(-60,60,0,360,lat,lon);

save FINAL_cor_sm_output lat lon r c sm_* *Sig*
load FINAL_cor_sm_output
mask=nan*wcor;
mask(abs(sm_wcor)>wSig(1,1,9))=1;



clf
pmap(lon(r,c),lat(r,c),sm_wcor(r,c).*mask(r,c))
hold on
m_contour(lon(r,c),lat(r,c),sm_wcor(r,c),[-wSig(1,1,9) wSig(1,1,9)],'k--','linewidth',1)
m_contour(lon(r,c),lat(r,c),sm_wcor(r,c),[wSig(1,1,9) wSig(1,1,9)],'k','linewidth',1)
caxis([-.5 .5])
load bwr.pal
draw_regions_boxes
colormap(bwr)
print -dpng -r300 figs/cor_chl_wek_0

load ~/data/gsm/FINAL_cor_out lat lon
mask(abs(sm_cor_0)>Sig(1,1,9))=1;


clf
pmap(lon(r,c),lat(r,c),sm_cor_0(r,c).*mask(r,c))
hold on
m_contour(lon(r,c),lat(r,c),sm_cor_0(r,c),[-Sig(1,1,9) -Sig(1,1,9)],'k--','linewidth',1)
m_contour(lon(r,c),lat(r,c),sm_cor_0(r,c),[Sig(1,1,9) Sig(1,1,9)],'k','linewidth',1)
caxis([-.5 .5])
load bwr.pal
draw_regions_boxes
colormap(bwr)
print -dpng -r300 figs/cor_chl_ssh_0

load ~/data/gsm/FINAL_cor_out lat lon

mask=nan*cor_0;
mask(abs(sm_cor_plus_4)>Sig(1,1,13))=1;



clf
pmap(lon(r,c),lat(r,c),sm_cor_plus_4(r,c).*mask(r,c))
hold on
m_contour(lon(r,c),lat(r,c),sm_cor_plus_4(r,c),[-Sig(1,1,13) -Sig(1,1,13)],'k--','linewidth',1)
m_contour(lon(r,c),lat(r,c),sm_cor_plus_4(r,c),[Sig(1,1,13) Sig(1,1,13)],'k','linewidth',1)
caxis([-.25 .25])
draw_regions_boxes
colormap(bwr)
print -dpng -r300 figs/cor_chl_ssh_+4



load ~/data/gsm/FINAL_cor_out lat lon

norm_cor=sm_cor_0-sm_cor_plus_4;
mask=nan*cor_0;
mask(abs(norm_cor)>Sig(1,1,9))=1;


clf
pmap(lon(r,c),lat(r,c),norm_cor(r,c).*mask(r,c))
m_contour(lon(r,c),lat(r,c),norm_cor(r,c),[-Sig(1,1,9) -Sig(1,1,9)],'k--','linewidth',1)
m_contour(lon(r,c),lat(r,c),norm_cor(r,c),[Sig(1,1,9) Sig(1,1,9)],'k','linewidth',1)
caxis([-.5 .5])
load bwr.pal
load bwr.pal
draw_regions_boxes

colormap(bwr)
print -dpng -r300 figs/norm_cor



clf
load ~/data/gsm/mean_gchl.mat glat glon median_dfdy_gchl
load ~/data/gsm/cor_chl_ssh_out.mat lat lon
[rg,cg]=imap(-60,60,0,360,glat,glon);
pmap(glon(rg,cg),glat(rg,cg),median_dfdy_gchl(rg,cg))
hold on
m_contour(lon(r,c),lat(r,c),sm_cor_plus_4(r,c),[-Sig(1,1,13) -Sig(1,1,13)],'k--','linewidth',1)
m_contour(lon(r,c),lat(r,c),sm_cor_plus_4(r,c),[Sig(1,1,13) Sig(1,1,13)],'k','linewidth',1)
caxis([-.06 .06])
draw_regions_boxes
colormap(bwr)
print -dpng -r300 figs/dchl_dy

