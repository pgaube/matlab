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
	load([qsave_path qsave_head num2str(jdays(m))],'hp66_dtdn','hp66_dtds')

	%
	
	
	%sst
	%
	
	[yea,mon,day]=jd2jdate(jdays(m));
	wek_sst_125=ff.*(1.25*(abs(beta_n(:,:,mon)).*hp66_dtds)+(abs(1.25*beta_s(:,:,mon)).*hp66_dtdn));
	wek_sst_no_ds=ff.*(abs(beta_s(:,:,mon)).*hp66_dtdn);

	eval(['save -append ',[qsave_path qsave_head num2str(jdays(m))],' wek_sst_125 wek_sst_no_ds'])
	clear wek*
end

