clear all
load bwr.pal 
load ~/matlab/pop/mat/mean_chl
load ~/matlab/pop/mat/mean_diaz_biomass
load ~/matlab/pop/mat/mean_diat_biomass
load ~/matlab/pop/mat/mean_small_biomass
mean_car=mean_diaz_biomass+mean_diat_biomass+mean_small_biomass;
mean_hp66_chl_pop=mean_hp66_chl;

load ~/matlab/pop/tmp_natl_chl 
mean_ncar_chl=nanmean(CHL,3);
mean_ncar_achl=nanmean(aCHL,3);
flon=flon(r,c);flat=flat(r,c);

load ~/data/gsm/mean_gchl mean_gchl mean_hp66_chl mean_gcar glon glat
[r,c]=imap(min(mean_lat(:)),max(mean_lat(:)),min(mean_lon(:)),max(mean_lon(:)),glat,glon);


%%%first means
figure(1)
clf
pmap(glon(r,c),glat(r,c),mean_gchl(r,c))
caxis([-1.45 -.1])
cc=colorbar;
yti=[.05 .1 .5];
set(cc,'ytick',log10(yti),'yticklabel',yti')
print -dpng -r300 figs/mean_seawifs_chl

figure(2)
clf
pmap(mean_lon,mean_lat,log10(mean_chl))
caxis([-1.45 -.1])
cc=colorbar;
yti=[.05 .1 .5];
set(cc,'ytick',log10(yti),'yticklabel',yti')
print -dpng -r300 figs/mean_bec_chl

figure(3)
clf
pmap(flon,flat,log10(mean_ncar_chl))
caxis([-1.45 -.1])
cc=colorbar;
yti=[.05 .1 .5];
set(cc,'ytick',log10(yti),'yticklabel',yti')
print -dpng -r300 figs/mean_ncar_bec_chl

figure(4)
clf
pmap(flon,flat,log10(mean_ncar_achl))
caxis([-1.45 -.1])
cc=colorbar;
yti=[.05 .1 .5];
set(cc,'ytick',log10(yti),'yticklabel',yti')
print -dpng -r300 figs/mean_ncar_bec_achl


%%%now diffs
diff_chl=10.^mean_gchl(r,c)-griddata(mean_lon,mean_lat,double(mean_chl),double(glon(r,c)),double(glat(r,c)));
figure(5)
clf
pmap(glon(r,c),glat(r,c),diff_chl)
caxis([-.2 .2])
cc=colorbar;
colormap(bwr)
print -dpng -r300 figs/mean_diff_obs_bec_chl

diff_chl=10.^mean_gchl(r,c)-griddata(flon,flat,double(mean_ncar_chl),double(glon(r,c)),double(glat(r,c)));
figure(6)
clf
pmap(glon(r,c),glat(r,c),diff_chl)
caxis([-.2 .2])
cc=colorbar;
colormap(bwr)
print -dpng -r300 figs/mean_diff_obs_ncar_bec_chl

diff_chl=10.^mean_gchl(r,c)-griddata(flon,flat,double(mean_ncar_achl),double(glon(r,c)),double(glat(r,c)));
figure(7)
clf
pmap(glon(r,c),glat(r,c),diff_chl)
caxis([-.2 .2])
cc=colorbar;
colormap(bwr)
print -dpng -r300 figs/mean_diff_obs_ncar_bec_achl

diff_chl=griddata(mean_lon,mean_lat,double(mean_chl),double(glon(r,c)),double(glat(r,c)))-griddata(flon,flat,double(mean_ncar_chl),double(glon(r,c)),double(glat(r,c)));
figure(8)
clf
pmap(glon(r,c),glat(r,c),diff_chl)
caxis([-.2 .2])
cc=colorbar;
colormap(bwr)
print -dpng -r300 figs/mean_diff_bec_ncar_chl

diff_chl=griddata(mean_lon,mean_lat,double(mean_chl),double(glon(r,c)),double(glat(r,c)))-griddata(flon,flat,double(mean_ncar_achl),double(glon(r,c)),double(glat(r,c)));
figure(9)
clf
pmap(glon(r,c),glat(r,c),diff_chl)
caxis([-.2 .2])
cc=colorbar;
colormap(bwr)
print -dpng -r300 figs/mean_diff_bec_ncar_achl

diff_chl=griddata(flon,flat,double(mean_ncar_chl),double(glon(r,c)),double(glat(r,c)))-griddata(flon,flat,double(mean_ncar_achl),double(glon(r,c)),double(glat(r,c)));
figure(9)
clf
pmap(glon(r,c),glat(r,c),diff_chl)
caxis([-.05 .05])
cc=colorbar;
colormap(bwr)
print -dpng -r300 figs/mean_diff_bec_ncar_chl_achl