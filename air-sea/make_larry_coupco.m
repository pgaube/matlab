
clear all
close all
%{
startjd=2452459;
endjd=2454489;
jdays=startjd:7:endjd;
q_in='/Volumes/matlab/data/QuickScat/mat/QSCAT_30_25km_'
t_in='/Volumes/matlab/data/ReynoldsSST/mat/OI_25_30_'
load([t_in,num2str(jdays(1))],'lat','lon','bp26_sst','sst_week')
slon=lon;
slat=lat;
load([q_in,num2str(jdays(1))],'lat','lon','bp26_wspd','wspd_week')
qlon=lon;
qlat=lat;
load /Volumes/matlab/matlab/domains/larry_AGU_lat_lon
[rat,cat]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
[raq,caq]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
load /Volumes/matlab/matlab/domains/larry_KUR_lat_lon
[rkt,ckt]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
[rkq,ckq]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);


agu_sst=nan(length(rat),length(cat),length(jdays));
agu_bp26_spd=agu_sst;
agu_spd=agu_sst;
agu_bp26_sst=agu_sst;

kur_sst=nan(length(rkt),length(ckt),length(jdays));
kur_bp26_spd=kur_sst;
kur_spd=kur_sst;
kur_bp26_sst=kur_sst;

for m=1:length(jdays)
	fprintf('\r     io file %03u of %03u \r',m,length(jdays))
	load([t_in,num2str(jdays(m))],'bp26_sst','sst_week')
	load([q_in,num2str(jdays(m))],'bp26_wspd','wspd_week')
	agu_sst(:,:,m)=sst_week(rat,cat);
	agu_spd(:,:,m)=wspd_week(raq,caq);
	kur_sst(:,:,m)=sst_week(rkt,ckt);
	kur_spd(:,:,m)=wspd_week(rkq,ckq);
	agu_bp26_sst(:,:,m)=bp26_sst(rat,cat);
	agu_bp26_spd(:,:,m)=bp26_wspd(raq,caq);
	kur_bp26_sst(:,:,m)=bp26_sst(rkt,ckt);
	kur_bp26_spd(:,:,m)=bp26_wspd(rkq,ckq);
end

save larry_coupco
%
load larry_coupco *bp26_*


pscatter(agu_bp26_sst(:),agu_bp26_spd(:),.5,0,[-1.8:.05:1.8],.4,-2,2,-1,1,...
'perturbation sst  ','perturbation wind speed  ')
figure(22)
text(-2,1.2,'Agulhas Return Current')
print -dpng -r300 figs/coupco_sst_wspd_agu_100th_bg

figure(23)
text(-2,1.2,'Agulhas Return Current')
print -dpng -r300 figs/coupco_sst_wspd_agu_100th

pscatter(kur_bp26_sst(:),kur_bp26_spd(:),.5,0,[-1.1:.05:1.1],.4,-2,2,-1,1,...
'perturbation sst  ','perturbation wind speed  ')

figure(22)
text(-2,1.2,'Kuroshio Current')
print -dpng -r300 figs/coupco_sst_wspd_kur_100th_bg

figure(23)
text(-2,1.2,'Kuroshio Current')
print -dpng -r300 figs/coupco_sst_wspd_kur_100th

%}
cd /matlab/matlab/eddy-wind
load bp26_sst_sample_bp26_wspd_sample_coupcoef
pscatter(tmp_var1,tmp_var2,.5,0,[-1:.05:1],.4,-2,2,-1,1,...
'perturbation sst  ','perturbation wind speed  ','')

figure(22)
text(-2,1.2,'Midlatitude Eddies')
print -dpng -r300 figs/coupco_sst_wspd_mid_lats_100th_bg

figure(23)
text(-2,1.2,'Midlatitude Eddies')
print -dpng -r300 figs/coupco_sst_wspd_mid_lats_100th
cd /Volumes/matlab/matlab/air-sea