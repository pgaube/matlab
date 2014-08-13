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


load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;
load([osave_path osave_head num2str(jdays(1))],'lon','lat')
olat=lat;
olon=lon;
load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')


[rssh,cssh]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
[ro,co]=imap(min(lat(:)),max(lat(:)),1,1,olat,olon);


ff=f_cor(lat);
denom=1020*sqrt(abs(ff));
[rn,cn]=imap(0,90,0,360,lat,lon);
[rs,cs]=imap(-90,0,0,360,lat,lon);
for m=1%:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([qsave_path qsave_head num2str(jdays(m))],'sm_u_week','sm_v_week','u_week','v_week','u_e','v_e','u_sst','v_sst')
	load([asave_path asave_head num2str(jdays(m))],'u','v')
	load([osave_path osave_head num2str(jdays(m))],'sst_week','bp26_sst')
	
	sst=bp26_sst(ro,:);
	theta=cart2pol(sm_u_week,sm_v_week);
	[u_sst,v_sst]=pol2cart(theta,0.32*sst);
	
	u_all=u_sst-u(rssh,:)-u_e;
	v_all=v_sst-v(rssh,:)-v_e;
	crl_all = dfdx(lat,v_all,.25)-dfdy(u_all,.25);
	sm_crl_all=linx_smooth2d_f(crl_all,2,2);
	lp=linx_smooth2d_f(sm_crl_all,6,6);
	bp_crl_all=sm_crl_all-lp;
	
	u_gs=u_sst-u(rssh,:);
	v_gs=v_sst-v(rssh,:);
	crl_gs = dfdx(lat,v_gs,.25)-dfdy(u_gs,.25);
	sm_crl_gs=linx_smooth2d_f(crl_gs,2,2);
	lp=linx_smooth2d_f(sm_crl_gs,6,6);
	bp_crl_gs=sm_crl_gs-lp;
	crl_sst = dfdx(lat,v_sst,.25)-dfdy(u_sst,.25);

	sm_crl_sst=linx_smooth2d_f(crl_sst,2,2);
	lp=linx_smooth2d_f(sm_crl_sst,6,6);
	bp_crl_sst=sm_crl_sst-lp;
	
	crl_e = dfdx(lat,v_e,.25)-dfdy(u_e,.25);
	sm_crl_e=linx_smooth2d_f(crl_e,2,2);
	lp=linx_smooth2d_f(sm_crl_e,6,6);
	bp_crl_e=sm_crl_e-lp;
	eval(['save -append ',[qsave_path qsave_head num2str(jdays(m))],' u_* v_* *_crl_*'])
	
end
