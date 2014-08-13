%loads SeaWiFS CHL data
%clear all
%close all


jdays=[2452459:7:2454706];%[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);

asave_path='~/data/eddy/V5/mat/';
asave_head='AVISO_25_W_';
qsave_path='~/data/QuickScat/new_mat/';
qsave_head='QSCAT_30_25km_';
osave_path='~/data/ReynoldsSST/mat/';
osave_head='OI_25_30_';

load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;
load([osave_path osave_head num2str(jdays(1))],'lon','lat')
olat=lat;
olon=lon;
load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')


[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
[ro,co]=imap(min(lat(:)),max(lat(:)),1,1,olat,olon);


%wek_sst=nan(length(lat(:,1)),1440,lj);
%wek_crlg=wek_sst;


ff=f_cor(lat);
ff=(8640000./(1020.*ff));
alpha=0.32;
nf=f_cor(lat)./f_cor(30);
load coupco_map_crlstr a_crl beta_* CI
ddo=1;

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	%load([qsave_path qsave_head num2str(jdays(m))],'wspd_week','u_week','v_week','wspd_week','crlstr_week','sm_crlstr_week','w_ek')
	load([qsave_path qsave_head num2str(jdays(m))],'hp_wek_crlg_week','hp66_dtdn','hp66_dtds','u_e','v_e','sm_u_week','sm_v_week')
	load([asave_path asave_head num2str(jdays(m))],'u','v')
	%load([osave_path osave_head num2str(jdays(m))],'bp26_sst')
	%load([OUT_PATH OUT_HEAD num2str(jdays(m))],'mag_t_bar','theta_prime')
	%
	
	
	%sst
	%
	
	[yea,mon,day]=jd2jdate(jdays(m));
	hp_wek_sst_week_dtdn=ff.*((beta_n(:,:,mon).*hp66_dtds)+(beta_s(:,:,mon).*hp66_dtdn));
	wek_sst(:,:,m)=hp_wek_sst_week_dtdn;
	
	%{
	%crlg
	u_rel=sm_u_week-u(rs,:).*mask;
	v_rel=sm_v_week-v(rs,:).*mask;
	[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
	crl_tau=dfdx(lat,tau_y,.25)-dfdy(tau_x,.25);
	tt=ff.*crl_tau.*mask;
	lp=linx_smooth2d_f(tt,6,6);
	hp_wek_crlg_week=tt-lp;
	%}
	wek_crlg(:,:,m)=hp_wek_crlg_week;
	
	figure(1)
	clf
	subplot(211)
	pmap(lon,lat,nf.*double(hp_wek_sst_week_dtdn));
	caxis([-10 10])
	ylabel(num2str(jdays(m)))
	title('W_E SST')
	subplot(212)
	pmap(lon,lat,nf.*double(hp_wek_crlg_week));
	caxis([-10 10])
	ylabel(num2str(jdays(m)))
	title('W_E Curlg')
	eval(['print -dpng -r300 frames/confirm_wek/frame_',num2str(ddo)])
	ddo=ddo+1;
	
	eval(['save -append ',[qsave_path qsave_head num2str(jdays(m))],' hp_*_week*'])
	clear hp66_* hp_* u v 
end

%save -v7.3 tmp lat lon CHL SSH

mean_hp_ratio=nanmean(abs(wek_sst)./abs(wek_crlg),3);
median_hp_ratio=nanmedian(abs(wek_sst)./abs(wek_crlg),3);
mean_wek_sst=nanmean(abs(wek_sst),3);
mean_wek_crlg=nanmean(abs(wek_crlg),3);
sm_mean_hp_ratio=smoothn(mean_hp_ratio,20);
sm_median_hp_ratio=smoothn(median_hp_ratio,10);

%}
save -append sst_wek_maps median_* mean_* lat lon sm_*
