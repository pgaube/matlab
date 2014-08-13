%loads SeaWiFS CHL data
clear all
close all


jdays=[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);


save_path='/matlab/data/gsm/mat/';
save_head='GSM_9_21_';
asave_path='/matlab/data/eddy/V4/mat/';
asave_head='AVISO_25_W_';
qsave_path='/matlab/data/QuickScat/mat/';
qsave_head='QSCAT_30_25km_';
osave_path='/matlab/data/ReynoldsSST/mat/';
osave_head='OI_25_30_';


load([save_path save_head num2str(jdays(1))],'glon','glat')
load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;
load([osave_path osave_head num2str(jdays(1))],'lon','lat')
olat=lat;
olon=lon;
load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')


[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
[r,c]=imap(min(lat(:)),max(lat(:)),1,1,glat,glon);
[ro,co]=imap(min(lat(:)),max(lat(:)),1,1,olat,olon);

wek_total=nan(length(lat(:,1)),1440,lj);
wek_sst=wek_total;
wek_crlg=wek_total;
hp_sst=wek_total;
hp_crlg=wek_total;
hp_total=wek_total;

ff=f_cor(lat);
ff=(8640000./(1020.*ff));
alpha=0.32;


for m=44:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	%load([qsave_path qsave_head num2str(jdays(m))],'wspd_week','u_week','v_week','wspd_week','crlstr_week','sm_crlstr_week','w_ek')
	load([qsave_path qsave_head num2str(jdays(m))],'sm_u_week','sm_v_week')
	load([asave_path asave_head num2str(jdays(m))],'bp26_crlg','u','v')
	load([osave_path osave_head num2str(jdays(m))],'bp26_sst')
	sst=bp26_sst(ro,:);
	
	
	%sst
	theta=cart2pol(sm_u_week,sm_v_week);
	[u_sst,v_sst]=pol2cart(theta,alpha*sst);
	tau_x_sst=wind2stress(sm_u_week-u_sst);
	tau_y_sst=wind2stress(sm_v_week-v_sst);
	crl_tau_sst=dfdx(lat,tau_y_sst,.25)-dfdy(tau_x_sst,.25);
	wek_sst(:,:,m)=ff.*crl_tau_sst;
	wek_sst_week=wek_sst(:,:,m);
	sm_wek_sst_week=linx_smooth2d_f(wek_sst_week,6,6);
	hp_wek_sst_week=wek_sst_week-sm_wek_sst_week;
	hp_sst(:,:,m)=hp_wek_sst_week;
	save test_sst_wek hp_wek_sst_week
	return
	
	%crlg
	crl=bp26_crlg(rs,:);
	u_rel=sm_u_week-u(rs,:);
	v_rel=sm_v_week-v(rs,:);
	crl_rel=dfdx(lat,v_rel,.25)-dfdy(u_rel,.25);
	tau_x=wind2stress(u_rel);
	tau_y=wind2stress(v_rel);
	crl_tau=dfdx(lat,tau_y,.25)-dfdy(tau_x,.25);
	wek_crlg(:,:,m)=ff.*crl_tau;
	wek_crlg_week=wek_crlg(:,:,m);
	sm_wek_crlg_week=linx_smooth2d_f(wek_crlg_week,6,6);
	hp_wek_crlg_week=wek_crlg_week-sm_wek_crlg_week;
	hp_crlg(:,:,m)=hp_wek_crlg_week;
	
	%both
	u_rel=sm_u_week-(u(rs,:)+u_sst);
	v_rel=sm_v_week-(v(rs,:)+v_sst);
	crl_rel_tot=dfdx(lat,v_rel,.25)-dfdy(u_rel,.25);
	tau_x=wind2stress(u_rel);
	tau_y=wind2stress(v_rel);
	crl_tau_tot=dfdx(lat,tau_y,.25)-dfdy(tau_x,.25);
	wek_total(:,:,m)=ff.*crl_tau_tot;
	wek_total_week=wek_total(:,:,m);
	sm_wek_total_week=linx_smooth2d_f(wek_total_week,6,6);
	hp_wek_total_week=wek_total_week-sm_wek_total_week;
	hp_total(:,:,m)=hp_wek_total_week;
	
	eval(['save -append ',[qsave_path qsave_head num2str(jdays(m))],' sm_*_week hp_*_week wek_*_week'])
end

%save -v7.3 tmp lat lon CHL SSH
%now do correlation
mean_hp_ratio=nanmean(abs(hp_wek_crlg)./abs(hp_wek_sst),3);
median_hp_ratio=nanmedian(abs(hp_crlg)./abs(hp_sst),3);
mean_ratio=nanmean(abs(wek_crlg)./abs(wek_sst),3);
median_ratio=nanmedian(abs(wek_crlg)./abs(wek_sst),3);
mean_wek_sst=nanmean(wek_sst,3);
mean_wek_crlg=nanmean(wek_crlg,3);
mean_wek_tot=nanmean(wek_total,3);

save -append sst_wek_maps median_* mean_* lat lon
