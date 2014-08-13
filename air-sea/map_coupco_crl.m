%
%loads SeaWiFS CHL data
clear all
close all


jdays=[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);
%lj=58

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
load([qsave_path qsave_head num2str(jdays(1))],'lon','lat')
[ro,co]=imap(min(lat(:)),max(lat(:)),1,1,olat,olon);


[year,month,day]=jd2jdate(jdays(1:lj));
%{

DTDN=single(nan(560,1440,lj));
CRL=DTDN;
DTDS=CRL;


for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([qsave_path qsave_head num2str(jdays(m))],'mask','bp26_crl','bp26_dtdn','bp26_dtds')
	%load([osave_path osave_head num2str(jdays(m))],'bp26_sst')
	
	CRL(:,:,m)=single(bp26_crl.*mask);
	DTDN(:,:,m)=single(bp26_dtdn.*mask);
	DTDS(:,:,m)=single(bp26_dtds.*mask);
	clear bp26*
end

save -v7.3 all_dtdn_crl lat lon CRL DTDN DTDS year month day jdays

%now do coupco
return

%}
load all_dtdn_crl
beta_n=single(nan(560,1440));
beta_s=beta_n;
CI_s=single(nan(560,1440));
CI_n=CI_s;

dist=4 %in native data res

for m=1:560
	fprintf('\r m = %3u',m)
	for n=1:1440
		if m<dist+1
			ros=1:m+dist;
		elseif m>560-dist-1
			ros=m-dist:560;
		else
			ros=m-dist:m+dist;
		end
		if n<dist+1
			col=1:n+dist;
		elseif n>1440-dist-1
			col=n-dist:1440;
		else
			col=n-dist:n+dist;
		end
		x=squeeze(DTDS(ros,col,:));
		y=squeeze(CRL(ros,col,:));
		x=x(:);
		tbins=-1e-5:.1e-5:1e-5;
		
		clear binned_samps2 num_samps2
		for i=1:length(tbins)-1
			bin_est = find(x>=tbins(i) & x<tbins(i+1));
			%binned_samps1(i) = double(pmean(x(bin_est)));
			binned_samps2(i) = double(pmean(y(bin_est)));
			num_samps2(i) = length(y(bin_est));
		end
		
		[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
		beta_n(m,n)=Cor*sdY/sdX;
		if Cor>Sig
			CI_n(m,n)=1;
		end	
		
		x=squeeze(DTDN(ros,col,:));
		x=x(:);		
		clear binned_samps2 num_samps2
		for i=1:length(tbins)-1
			bin_est = find(x>=tbins(i) & x<tbins(i+1));
			%binned_samps1(i) = double(pmean(x(bin_est)));
			binned_samps2(i) = double(pmean(y(bin_est)));
			num_samps2(i) = length(y(bin_est));
		end
		
		[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
		beta_s(m,n)=Cor*sdY/sdX;
		if Cor>Sig
			CI_s(m,n)=1;
		end	
	end
end	
sm_coupco_s=smoothn(beta_s,20);
sm_coupco_n=smoothn(beta_n,20);

a_csn=sm_coupco_n;
a_css=sm_coupco_s;

a_csn(abs(a_csn)>.1)=nan;
a_css(abs(a_css)>.1)=nan;
a_csn(a_csn<.001)=nan;
a_css(a_css<.001)=nan;

save coupco_map_crl beta_* CI_* lat lon sm_coupco_* a_cs*
