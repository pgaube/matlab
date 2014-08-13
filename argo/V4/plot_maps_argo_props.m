% load /Users/new_gaube/matlab/argo/V4/global_comps/mean_maps
% load ~/data/eddy/V5/mat/AVISO_25_W_2448910 lat lon
% load bwr.pal
% 
% sec2year=365.25*24*60*60;
% heat_transport_ac=(map_ac_aha.*map_num_ac_yr)./sec2year;
% heat_transport_cc=(map_cc_aha.*map_num_cc_yr)./sec2year;
% vol_transport_ac=(map_ac_vol.*map_num_ac_yr)./sec2year;
% vol_transport_cc=(map_cc_vol.*map_num_cc_yr)./sec2year;
% 
% in_ac_tr=griddata(mlon,mlat,heat_transport_ac,lon,lat,'nearest');
% in_cc_tr=griddata(mlon,mlat,heat_transport_cc,lon,lat,'nearest');
% mask=ones(size(in_ac_tr));
% [r,c]=imap(-10,10,0,360,lat,lon);
% mask(r,c)=nan;
% 
sm_ac_tr=smoothn(in_ac_tr,50);
sm_cc_tr=smoothn(in_cc_tr,50);
% 
amask=nan*in_ac_tr;
amask(~isnan(in_ac_tr))=1;
cmask=nan*in_cc_tr;
cmask(~isnan(in_cc_tr))=1;

figure(1)
clf
pmap(lon,lat,1e-12*in_ac_hf.*mask)
shading flat
hold on
% m_contour(lon,lat,1e-12*sm_ac_tr.*amask.*mask,[-100:25:100],'k','linewidth',2)
m_coast('patch','k')
caxis([-20 20])
cc=colorbar;
title('Eddy Heat transport of anticyclones')
colormap(bwr);
axes(cc)
xlabel('terawatts')
hold on
print -dpng -r300 map_ac_hf

figure(2)
clf
pmap(lon,lat,1e-12*in_cc_hf.*mask)
shading flat
% m_contour(lon,lat,1e-12*sm_cc_tr.*cmask.*mask,[-100:25:100],'k','linewidth',2)
m_coast('patch','k')
caxis([-20 20])
cc=colorbar;
title('Eddy Heat transport of cyclones')
colormap(bwr);
axes(cc)
xlabel('terawatts')
print -dpng -r300 map_cc_hf
return


in_ac_aha=griddata(mlon,mlat,map_ac_aha,lon,lat,'nearest');
in_cc_aha=griddata(mlon,mlat,map_cc_aha,lon,lat,'nearest');
mask=ones(size(in_ac_aha));
[r,c]=imap(-10,10,0,360,lat,lon);
mask(r,c)=nan;


figure(1)
clf
pmap(lon,lat,1e-18*in_ac_aha.*mask)
shading flat
m_coast('patch','k')
caxis([-40 40])
colorbar
title('Available heat anaomaly (10^{18} J) of anticyclones')
colormap(bwr)
hold on
m_contour(lon,lat,1e-18*in_ac_aha.*mask,[7 10],'k','linewidth',2)
print -dpng -r300 map_ac_aha

figure(2)
clf
pmap(lon,lat,1e-18*in_cc_aha.*mask)
shading flat
m_coast('patch','k')
caxis([-40 40])
colorbar
title('Available heat anaomaly (10^{18} J) of cyclones')
colormap(bwr)
hold on
m_contour(lon,lat,1e-18*in_ac_aha.*mask,[-6 -4],'k','linewidth',2)
print -dpng -r300 map_cc_aha
return
in_ac_asa=griddata(mlon,mlat,map_ac_asa,lon,lat,'nearest');
in_cc_asa=griddata(mlon,mlat,map_cc_asa,lon,lat,'nearest');


figure(1)
clf
pmap(lon,lat,1e-10*in_ac_asa.*mask)
shading flat
m_coast('patch','k')
caxis([-90 90])
colormap(bwr);
title('Available salt anaomaly of anticyclones')
cc=colorbar;
axes(cc)
xlabel('10^{10} kg')
print -dpng -r300 map_ac_asa

figure(2)
clf
pmap(lon,lat,1e-10*in_cc_asa.*mask)
shading flat
m_coast('patch','k')
caxis([-90 90])
title('Available salt anaomaly of cyclones')
colormap(bwr)
cc=colorbar;
axes(cc)
xlabel('10^{10} kg')
print -dpng -r300 map_cc_asa

return



rat_vol=double(map_ac_vol./map_cc_vol);
mask=nan*rat_vol;
mask(~isnan(rat_vol))=1;
[r,c]=imap(-50,50,0,360,mlat,mlon);
mask(r,c)=1;
sm_rat_vol=smoothn(rat_vol,1).*mask;

in_rat_vol=griddata(mlon,mlat,rat_vol,lon,lat,'nearest');
sm_rat_vol=griddata(mlon,mlat,sm_rat_vol,lon,lat,'nearest');


figure(1)
clf
pmap(mlon,mlat,rat_vol)
shading flat
m_coast('patch','k')
%pmap(lon,lat,sm_rat_vol)
hold on
caxis([0 4])
colorbar
title('ratio of the trapped volume of anticyclones to cyclones')
print -dpng -r300 map_rat_vol

figure(2)
clf
pmap(lon,lat,in_rat_vol)
shading flat
m_coast('patch','k')
hold on
caxis([0 4])
colorbar
title('interpolated ratio of the trapped volume of anticyclones to cyclones')

figure(3)
clf
pmap(lon,lat,sm_rat_vol)
shading flat
m_coast('patch','k')
caxis([0.5 4])
colorbar
title('sm ratio of the trapped volume of anticyclones to cyclones')

return
rat_trap=double(map_ac_trap./map_cc_trap);
mask=nan*rat_trap;
mask(~isnan(rat_trap))=1;
[r,c]=imap(-50,50,0,360,mlat,mlon);
mask(r,c)=1;
sm_rat_trap=smoothn(rat_trap,1).*mask;

in_rat_trap=griddata(mlon,mlat,rat_trap,lon,lat,'nearest');
sm_rat_trap=griddata(mlon,mlat,sm_rat_trap,lon,lat,'nearest');


figure(1)
clf
pmap(mlon,mlat,rat_trap)
shading flat
m_coast('patch','k')
%pmap(lon,lat,sm_rat_trap)
hold on
caxis([0 4])
colorbar
title('ratio of the trapping depth of anticyclones to cyclones')
print -dpng -r300 map_rat_trap

figure(2)
clf
pmap(lon,lat,in_rat_trap)
shading flat
m_coast('patch','k')
hold on
caxis([0 4])
colorbar
title('interpolated ratio of the trapping depth of anticyclones to cyclones')

figure(3)
clf
pmap(lon,lat,sm_rat_trap)
shading flat
m_coast('patch','k')
caxis([0.5 4])
colorbar
title('sm ratio of the trapping depth of anticyclones to cyclones')
