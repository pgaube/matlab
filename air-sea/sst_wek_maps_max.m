%loads SeaWiFS CHL data
%clear all
%close all


jdays=[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);

asave_path='/matlab/data/eddy/V4/mat/';
asave_head='AVISO_25_W_';
qsave_path='/matlab/data/QuickScat/mat/';
qsave_head='QSCAT_30_25km_';
osave_path='/matlab/data/ReynoldsSST/mat/';
osave_head='OI_25_30_';
OUT_HEAD   = 'SSTWIND_25_W_';
OUT_PATH   = '/matlab/data/SSTWIND/mat/';

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

%load coupco_map_crlstr a_crl sm_coupco_* CI

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	%load([qsave_path qsave_head num2str(jdays(m))],'wspd_week','u_week','v_week','wspd_week','crlstr_week','sm_crlstr_week','w_ek')
	load([qsave_path qsave_head num2str(jdays(m))],'bp26_dtdn','bp26_dtds','hp_wek_crlg_week')
	load([asave_path asave_head num2str(jdays(m))],'u','v')
	%load([osave_path osave_head num2str(jdays(m))],'bp26_sst')
	%load([OUT_PATH OUT_HEAD num2str(jdays(m))],'mag_t_bar','theta_prime')
	%
	%sst
	
	[yea,mon,day]=jd2jdate(jdays(m));
	hp_wek_sst_week_max=-.002*ff.*bp26_dtds;
	%{
	crl_tau_sst=0.015*mag_t_bar.*sind(theta_prime);
	tt=ff.*crl_tau_sst;
	sm=linx_smooth2d_f(tt,2,2);
	lp=linx_smooth2d_f(sm,6,6);
	hp_wek_sst_week=sm-lp;
	%}
	wek_sst(:,:,m)=hp_wek_sst_week_max;
	
	%
	%crlg
	%{
	tau_x=wind2stress(sm_u_week-u(rs,:));
	tau_y=wind2stress(sm_v_week-v(rs,:));
	crl_tau=dfdx(lat,tau_y,.25)-dfdy(tau_x,.25);
	tt=ff.*crl_tau;
	sm=linx_smooth2d_f(tt,2,2);
	lp=linx_smooth2d_f(sm,6,6);
	hp_wek_crlg_week=sm-lp;
	%}
	wek_crlg(:,:,m)=hp_wek_crlg_week;
	
	
	%drift
	%{
	tau_x=wind2stress(sm_u_week-u_e);
	tau_y=wind2stress(sm_u_week-v_e);
	crl_tau=dfdx(lat,tau_y,.25)-dfdy(tau_x,.25);
	tt=ff.*crl_tau;
	sm=linx_smooth2d_f(tt,2,2);
	lp=linx_smooth2d_f(sm,6,6);
	%hp_wek_drift_week=sm-lp;
	%}
	
	eval(['save -append ',[qsave_path qsave_head num2str(jdays(m))],' hp_*_week*'])
	clear bp26_* hp_*
end
return

%save -v7.3 sst_wek_all lat lon wek_crlg wek_sst


mean_hp_ratio=nanmean(abs(wek_sst)./abs(wek_crlg),3);
median_hp_ratio=nanmedian(abs(wek_sst)./abs(wek_crlg),3);
mean_wek_sst=nanmean(abs(wek_sst),3);
mean_wek_crlg=nanmean(abs(wek_crlg),3);
sm_mean_hp_ratio=smoothn(mean_hp_ratio,20);
sm_median_hp_ratio=smoothn(median_hp_ratio,10);

%}
save sst_wek_maps_max median_* mean_* lat lon sm_*
