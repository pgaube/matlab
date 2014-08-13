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
%

DTDN=single(nan(560,1440,lj));
CRL=DTDN;
DTDS=CRL;
%{

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([qsave_path qsave_head num2str(jdays(m))],'mask','bp26_crlstr','bp26_dtdn','bp26_dtds')
	%load([osave_path osave_head num2str(jdays(m))],'bp26_sst')
	
	CRL(:,:,m)=single(bp26_crlstr.*mask);
	DTDN(:,:,m)=single(bp26_dtdn.*mask);
	DTDS(:,:,m)=single(bp26_dtds.*mask);
	clear bp26*
end

save -v7.3 all_dtdn_crlstr lat lon CRL DTDN DTDS year month day jdays
return
%now do coupco


%}
load all_dtdn_crlstr
beta_n=single(nan(560,1440,12));
beta_s=beta_n;
CI_s=single(nan(560,1440,12));
CI_n=CI_s;

dist=4 %in native data res

for p=1:12
p
ii=find(month==p);
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
		x=squeeze(DTDS(ros,col,ii));
		y=squeeze(CRL(ros,col,ii));
		x=x(:);
		y=-y(:);
		tbins=-1e-5:.1e-5:1e-5;
		
		clear binned_samps2 num_samps2
		for i=1:length(tbins)-1
			bin_est = find(x>=tbins(i) & x<tbins(i+1));
			%binned_samps1(i) = double(pmean(x(bin_est)));
			binned_samps2(i) = double(pmean(y(bin_est)));
			num_samps2(i) = length(y(bin_est));
		end
		
		[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
		beta_n(m,n,p)=Cor*sdY/sdX;
		if Cor>Sig
			CI_n(m,n,p)=1;
		end	
		
		x=squeeze(DTDN(ros,col,ii));
		x=x(:);	
		y=-y(:);
		clear binned_samps2 num_samps2
		for i=1:length(tbins)-1
			bin_est = find(x>=tbins(i) & x<tbins(i+1));
			%binned_samps1(i) = double(pmean(x(bin_est)));
			binned_samps2(i) = double(pmean(y(bin_est)));
			num_samps2(i) = length(y(bin_est));
		end
		
		[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
		beta_s(m,n,p)=Cor*sdY/sdX;
		if Cor>Sig
			CI_s(m,n,p)=1;
		end	
	end
end	
sm_coupco_s(:,:,p)=smoothn(squeeze(beta_s(:,:,p)),20);
sm_coupco_n(:,:,p)=smoothn(squeeze(beta_n(:,:,p)),20);
end

save coupco_map_crlstr beta_* CI_* lat lon sm_coupco_*
