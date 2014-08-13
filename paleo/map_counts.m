clear all

load /matlab/data/eddy/V5/mean_eke
llat=lat;
llon=lon;
mask=ones(size(mean_eke));
[r,c]=imap(-15,15,0,360,llat,llon);
mask(r,c)=nan;
%mean_eke=smoothn(mean_eke,30).*mask;
mean_eke=mean_eke.*mask;
load data
lon(lon<0)=180-lon(lon<0);
plat=min(lat):max(lat);
plon=min(lon):max(lon);

for m=1:length(lon)
	[r,c]=imap(lat(m)-.25,lat(m)+.25,lon(m)-.25,lon(m)+.25,llat,llon);
	core_eke(m)=mean_eke(r(1),c(1));
end

core_eke(dead<=1)=nan;
core_eke(core_eke<=0.01)=nan;

[ny,beta]=reg(core_eke,dead,'lin');
figure(1)
clf
scatter(core_eke,dead)
hold on
plot(core_eke,ny)
text(.06,35,'y=134x+6.19')
ylabel('percent dead')
xlabel('EKE at core location m^{2} s^{-2}')
print -dpng -r150 eke_vs_dead


return


[r,c]=imap(min(plat),max(plat),min(plon),max(plon),llat,llon);
figure(1)
clf
pmap(plon,plat,nan(length(plat),length(plon)))
hold on
m_contour(llon(r,c),llat(r,c),mean_eke(r,c),[.1:.1:1],'k','linewidth',3)
[x,y] = m_ll2xy(lon,lat);
scatter(x,y,20,dead,'filled')
caxis([0 30])
cc=colorbar;
axes(cc)
ylabel('% dead')

print -dpng -r300 dead

figure(2)
clf
pmap(plon,plat,nan(length(plat),length(plon)))
hold on
m_contour(llon(r,c),llat(r,c),mean_eke(r,c),[.1:.1:1],'k','linewidth',3)
[x,y] = m_ll2xy(lon,lat);
scatter(x,y,20,live,'filled')
caxis([0 15])
cc=colorbar;
axes(cc)
ylabel('% live')

print -dpng -r300 live

figure(3)
clf
pmap(plon,plat,nan(length(plat),length(plon)))
hold on
m_contour(llon(r,c),llat(r,c),mean_eke(r,c),[.1:.1:1],'k','linewidth',3)
[x,y] = m_ll2xy(lon,lat);
scatter(x,y,20,dead./live,'filled')
caxis([0 20])
cc=colorbar;
axes(cc)
ylabel('ratio dead/live')

print -dpng -r300 ratio


