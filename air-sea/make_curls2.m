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
for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	%load([qsave_path qsave_head num2str(jdays(m))],'bp_crl_sst','bp_crl_e')
	load([qsave_path qsave_head num2str(jdays(m))],'sm_u_week','sm_v_week','u_week','v_week','u_e','v_e','wspd_week','bp_crl_sst','bp_crl_e')
	load([asave_path asave_head num2str(jdays(m))],'u','v','bp26_crlg')
	load([osave_path osave_head num2str(jdays(m))],'sst_week')
	
	%{
	ii=find(1e5*abs(bp_crl_sst)>1);
	bp_crl_sst(ii)=nan;
	%}
	
	%sst
	%
	sst=sst_week(ro,:);
	theta=rad2deg(cart2pol(sm_u_week,sm_v_week));	
	ii=find(theta<0);
	theta(ii)=180+(180+theta(ii));
	[u_sst,v_sst]=pol2cart(deg2rad(theta),0.32*sst);		
	crl_sst = dfdx(lat,v_sst,.25)-dfdy(u_sst,.25);
	sm_crl_sst=linx_smooth2d_f(crl_sst,2,2);
	lp=linx_smooth2d_f(sm_crl_sst,6,6);
	bp_crl_sst=sm_crl_sst-lp;
	save test bp_crl_sst
	return
	%drift
	crl_e = dfdx(lat,v_e,.25)-dfdy(u_e,.25);
	sm_crl_e=linx_smooth2d_f(crl_e,2,2);
	lp=linx_smooth2d_f(sm_crl_e,6,6);
	bp_crl_e=sm_crl_e-lp;
	%}
	
	%all the crls
	
	bp_crl_all=bp_crl_sst-bp26_crlg(rssh,:)-bp_crl_e;
	bp_crl_gs=bp_crl_sst-bp26_crlg(rssh,:);
	eval(['save -append ',[qsave_path qsave_head num2str(jdays(m))],' bp_crl_gs bp_crl_all bp_crl_sst'])
	
end
