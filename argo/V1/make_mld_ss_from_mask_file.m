clear all
x=1:365;
f=2*pi/365.25;
load /matlab/matlab/domains/oPC_lat_lon
dlat=lat;
dlon=lon;
load /matlab/matlab/woa/woa05 lat lon MLD NC
load /matlab/matlab/argo/UCSD_mld
ii=find(plon<0);
plon(ii)=180+(180+plon(ii));

ii=find(plon>=min(dlon) & plon<=max(dlon) & plat>=min(dlat) & plat<=max(dlat));


sjday=pjday(ii);
smld=mld(ii);
slat=plat(ii);
slon=plon(ii);
uday=unique(sjday);
jdays=min(uday):max(uday);

for m=1:length(uday)
	jj=find(sjday==uday(m));
	dmld(m)=nanmean(smld(jj));
end

[ss_mld,beta_mld]=harm_reg(uday,dmld,2,f);
mld_y=beta_mld(1)+beta_mld(2)*cos(f*x)+beta_mld(3)*cos(2*f*x)+beta_mld(4)*sin(f*x)+beta_mld(5)*sin(2*f*x);

figure(2)
clf
plot(x,mld_y)
figure(1)
pmap(dlon,dlat,nan(length(dlat),length(dlon)))
hold on
for r=1:length(slat);
	m_plot(slon(r),slat(r),'b.','markersize',2)
end
title('ARGO float profile locations')
print -dpng -r300 ~/Documents/OSU/figures/argo/ss/opac_float_loc_map

cplot_seasonal_cycle(x,mld_y,mld_y,round(min(mld_y))-2,round(max(mld_y))+2,50,'m','OPAC MLD from ARGO',...
					 ['~/Documents/OSU/figures/argo/ss/OPAC_mld'])

