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


crl_sst=nan(length(lat(:,1)),1440,lj);
crlg=crl_sst;


load coupco_map_crl a_crl sm_coupco_* CI

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	%load([qsave_path qsave_head num2str(jdays(m))],'wspd_week','u_week','v_week','wspd_week','crlstr_week','sm_crlstr_week','w_ek')
	load([qsave_path qsave_head num2str(jdays(m))],'bp26_dtdn','bp26_dtds','u_e','v_e','sm_u_week','sm_v_week')
	load([asave_path asave_head num2str(jdays(m))],'bp26_crlg')
	%load([osave_path osave_head num2str(jdays(m))],'bp26_sst')
	%load([OUT_PATH OUT_HEAD num2str(jdays(m))],'mag_t_bar','theta_prime')
	%
	%sst
	
	[yea,mon,day]=jd2jdate(jdays(m));
	bp26_crl_sst=(-sm_coupco_n.*bp26_dtds)+(-sm_coupco_s.*bp26_dtdn);
	crl_sst=bp26_crl_sst;
	crlg=bp26_crlg(rs,:);
	bp_crl_gs=crlg+crl_sst;
	
	eval(['save -append ',[qsave_path qsave_head num2str(jdays(m))],' bp26_crl_sst bp_crl_gs'])
	clear bp26_* hp_*
end

mean_hp_ratio=nanmean(abs(crl_sst)./abs(crlg),3);
median_hp_ratio=nanmedian(abs(crl_sst)./abs(crlg),3);
mean_crl_sst=nanmean(abs(crl_sst),3);
mean_crlg=nanmean(abs(crlg),3);
sm_mean_hp_ratio=smoothn(mean_hp_ratio,20);
sm_median_hp_ratio=smoothn(median_hp_ratio,10);

save sst_crl_maps median_* mean_* lat lon sm_*
