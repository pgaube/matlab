%{
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


SST=single(nan(560,1440,lj));
CRL=SST;


for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([qsave_path qsave_head num2str(jdays(m))],'bp26_crlstr','bp26_dtdn')
	%load([osave_path osave_head num2str(jdays(m))],'bp26_sst')
	
	CRL(:,:,m)=single(bp26_crlstr);
	SST(:,:,m)=single(bp26_dtdn);
end

save -v7.3 all_dtdn_crlstr lat lon CRL SST year month day jdays

%now do coupco


%}
load all_dtdn_crlstr
tbins=-.5e-5:.5e-6:.5e-5;
beta=single(nan(560,1440,2,12));
sm_beta=single(nan(560,1440,12));
CI=sm_beta;

dist=4*2 %in native data res

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
		x=squeeze(SST(ros,col,ii));
		y=squeeze(CRL(ros,col,ii));
		x=x(:);
		y=y(:);
		y(abs(y)>=1e-6)=nan;
		clear binned_samps2 num_samps2
		for i=1:length(tbins)-1
			bin_est = find(x>=tbins(i) & x<tbins(i+1));
			%binned_samps1(i) = double(pmean(x(bin_est)));
			binned_samps2(i) = double(pmean(10*y(bin_est)));;
		end
		[dumb,beta(m,n,:,p),did,dim,CI(m,n,:,p)]=reg(tbins(1:length(tbins)-1),binned_samps2,'lin');
	end
end	
sm_coupco(:,:,p)=smoothn(squeeze(beta(:,:,2,p)),20);
end

save coupco_map_sst_strm beta CI lat lon sm_coupco
%}
%now threshold
load coupco_map_sst_strm

a_crl=squeeze(beta(:,:,2,:));

a_crl(a_crl<0)=0;
a_crl(a_crl>.1)=0;

save -append coupco_map_sst_strm a_crl
