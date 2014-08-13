%loads SeaWiFS CHL data
clear all
%close all
%{

jdays=[2451388:7:2455147];%[2451556:7:2454797];
lj=length(jdays);

asave_path='/matlab/data/eddy/V5/mat/';
asave_head='AVISO_25_W_';
qsave_path='/matlab/data/QuickScat/new_mat/';
qsave_head='QSCAT_30_25km_';
oqsave_path='/matlab/data/QuickScat/mat/';
oqsave_head='QSCAT_30_25km_';
osave_path='/matlab/data/ReynoldsSST/mat/';
osave_head='OI_25_30_';


load([asave_path asave_head num2str(jdays(300))],'lon','lat')
slat=lat;
slon=lon;
load([osave_path osave_head num2str(jdays(300))],'lon','lat')
olat=lat;
olon=lon;
load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')


[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
[ro,co]=imap(min(lat(:)),max(lat(:)),1,1,olat,olon);


wek=single(nan(length(lat(:,1)),1440,lj));
crlg=wek;

ddo=1;

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([qsave_path qsave_head num2str(jdays(m))],'w_ek')
	load([asave_path asave_head num2str(jdays(m))],'crl')

	
	wek(:,:,m)=single(w_ek);
	crlg(:,:,m)=single(crl(rs,:));
	clear w_ek crl
end

%save -v7.3 tmp lat lon CHL SSH

%
load test
crlg=sparse(crlg);
wek=sparse(wek);
mean_wek=nanmean(abs(wek),3);
median_wek=nanmedian(abs(wek),3);
mean_crlg=nanmean(abs(crlg),3);
median_crlg=nanmedian(abs(crlg),3);

save decay_maps median_* mean_* lat lon 
return
%}

load decay_maps lat lon mean_* median_*

mask=ones(size(mean_wek));
mask(find(isnan(mean_wek)))=nan;


[r,c]=imap(-60,60,0,360,lat,lon);
mask=nan*lat;
mask(abs(lat)>10)=1;
ff=abs(f_cor(lat));
fo=f_cor(30);

wek=mean_wek./60./60./24;
crlg=mean_crlg;
tau_500=500*crlg./2./ff./wek./60./60./24./365.25*12;
tau_1000=1000*crlg./2./ff./wek./60./60./24./365.25*12;
tau_500(tau_500<1)=nan;
tau_1000(tau_1000<1)=nan;
mask(isnan(tau_500))=nan;
sm_tau_500=smoothn(tau_500,10).*mask;

%
figure(1)
clf
pmap(lon(r,c),lat(r,c),100*mean_wek(r,c).*mask(r,c))
caxis([0 8])
draw_air_sea_regions
print -dpng -r300 figs/paper_wek_mean
load sst_wek_maps lat lon
%
figure(2)
clf
pmap(lon(r,c),lat(r,c),100*(ff(r,c)./fo).*mean_wek(r,c).*mask(r,c))
caxis([0 8])
draw_air_sea_regions
print -dpng -r300 figs/paper_wek_mean_ff
load sst_wek_maps lat lon
%

figure(1)
clf
pmap(lon(r,c),lat(r,c),tau_500(r,c).*mask(r,c))
caxis([1 11])
draw_air_sea_regions
print -dpng -r300 figs/paper_wek_tau_500
load sst_wek_maps lat lon

figure(2)
clf
pmap(lon(r,c),lat(r,c),sm_tau_500(r,c).*mask(r,c))
caxis([1 11])
%draw_air_sea_regions
print -dpng -r300 figs/paper_wek_sm_tau_500
load sst_wek_maps lat lon
%}

%{
load /matlab/data/eddy/V5/global_tracks_v5_12_weeks.mat
ii=find(k>=78);
uid=unique(id(ii));
ii=sames(uid,id);
x=x(ii);
y=y(ii);
id=id(ii);
cyc=cyc(ii);
track_jday=track_jday(ii);
k=k(ii);
save year_long_tracks x y id cyc ii track_jday k
%}
load decay_maps lat lon 
[r,c]=imap(-60,60,0,360,lat,lon);
load year_long_tracks
figure(1)
clf
pmap(lon(r,c),lat(r,c),[x y id cyc track_jday k],'new_tracks')
print -dpng -r300 figs/paper_year_long_tracks


