%loads SeaWiFS CHL data
%clear all
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


wek_sst=single(nan(length(lat(:,1)),1440,lj));
wek_crlg=wek_sst;


ff=f_cor(lat);
ff=(8640000./(1020.*ff));


load coupco_map_crlstr beta_*
ddo=1;

for m=65:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([qsave_path qsave_head num2str(jdays(m))],'u_week','v_week','sm_u_week','sm_v_week')
	load([asave_path asave_head num2str(jdays(m))],'u','v')

	
	%sst
	if exist([oqsave_path oqsave_head num2str(jdays(m)) '.mat'])
	load([oqsave_path oqsave_head num2str(jdays(m))],'bp26_dtdn','bp26_dtds')
	[yea,mon,day]=jd2jdate(jdays(m));
	hp_wek_sst_week_dtdn=ff.*((beta_n(:,:,mon).*bp26_dtds)+(beta_s(:,:,mon).*bp26_dtdn));
	wek_sst(:,:,m)=single(hp_wek_sst_week_dtdn);
	end
	%
	%crlg
	u_rel=sm_u_week-u(rs,:);
	v_rel=sm_v_week-v(rs,:);
	[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
	crl_tau=dfdx(lat,tau_y,.25)-dfdy(tau_x,.25);
	tt=ff.*crl_tau;
	ii=find(abs(tt)>200);
	tt(ii)=nan;
	lp=linx_smooth2d_f(tt,6,6);
	rr=tt-lp;
	ii=find(abs(rr)>200);
	rr(ii)=nan;
	hp_wek_crlg_week=rr;
	wek_crlg(:,:,m)=single(hp_wek_crlg_week);
	clear lp tt rr
	%{
	figure(1)
	clf
	subplot(211)
	pcolor(lon,lat,double(wek_sst(:,:,m)));shading flat
	caxis([-10 10])
	ylabel(num2str(jdays(m)))
	title('W_E SST')
	subplot(212)
	pcolor(lon,lat,double(wek_crlg(:,:,m)));shading flat
	caxis([-10 10])
	ylabel(num2str(jdays(m)))
	title('W_E Curlg')
	eval(['print -dpng -r300 frames/confirm_wek/frame_',num2str(ddo)])
	ddo=ddo+1;
	%}
	if exist('bp26_dtdn')
		eval(['save -append ',[qsave_path qsave_head num2str(jdays(m))],' hp_*_week* bp26_dtdn bp26_dtds'])
	else
		eval(['save -append ',[qsave_path qsave_head num2str(jdays(m))],' hp_*_week*'])
	end	
	clear bp26_* hp* u v 
end

%save -v7.3 tmp lat lon CHL SSH

mean_hp_ratio=nanmean(abs(wek_sst)./abs(wek_crlg),3);
median_hp_ratio=nanmedian(abs(wek_sst)./abs(wek_crlg),3);
mean_wek_sst=nanmean(abs(wek_sst),3);
mean_wek_crlg=nanmean(abs(wek_crlg),3);
sm_mean_hp_ratio=smoothn(mean_hp_ratio,20);
sm_median_hp_ratio=smoothn(median_hp_ratio,10);

save sst_wek_maps median_* mean_* lat lon sm_*
return
%}

load sst_wek_maps lat lon mean_* median_*
mask=ones(size(median_hp_ratio));
mask(find(isnan(median_hp_ratio)))=nan;
sm_median_hp_ratio=smoothn(median_hp_ratio,10).*mask;
[r,c]=imap(-60,60,0,360,lat,lon);
mask=nan*lat;
mask(abs(lat)>10)=1;
ff=abs(f_cor(lat));
fo=f_cor(30);

figure(1)
clf
pmap(lon(r,c),lat(r,c),mean_wek_crlg(r,c).*mask(r,c))
caxis([0 8])
draw_air_sea_regions
print -dpng -r300 figs/paper_wek_mean_crlg
load sst_wek_maps lat lon
%
figure(2)
clf
pmap(lon(r,c),lat(r,c),(ff(r,c)./fo).*mean_wek_crlg(r,c).*mask(r,c))
caxis([0 8])
draw_air_sea_regions
print -dpng -r300 figs/paper_wek_mean_crlg_ff
load sst_wek_maps lat lon

figure(1)
clf
pmap(lon(r,c),lat(r,c),mean_wek_sst(r,c).*mask(r,c))
caxis([0 8])
draw_air_sea_regions
print -dpng -r300 figs/paper_wek_mean_sst
load sst_wek_maps lat lon

figure(2)
clf
pmap(lon(r,c),lat(r,c),(ff(r,c)./fo).*mean_wek_sst(r,c).*mask(r,c))
caxis([0 8])
draw_air_sea_regions
print -dpng -r300 figs/paper_wek_mean_sst_ff
load sst_wek_maps lat lon

figure(2)
clf
pmap(lon(r,c),lat(r,c),log10(median_hp_ratio(r,c)).*mask(r,c))
m_contour(lon(r,c),lat(r,c),sm_median_hp_ratio(r,c).*mask(r,c),[1 1],'color','k','linewidth',2)
caxis([-2 .5])
print -dpng -r300 figs/paper_median_rat
draw_air_sea_regions
%
load gradt_steady
[r,c]=imap(-60,60,0,360,lat,lon);
figure(1)
clf
pmap(lon(r,c),lat(r,c),1e5*mean_gradt(r,c))
hold on
load sst_wek_maps lat lon
[r,c]=imap(-60,60,0,360,lat,lon);
m_contour(lon(r,c),lat(r,c),sm_median_hp_ratio(r,c).*mask(r,c),[1 1],'color','k','linewidth',2)
caxis([0 3])
draw_air_sea_regions
print -dpng -r300 figs/paper_mean_gradt


