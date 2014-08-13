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
RAND_HEAD   = 'RAND_W_';
RAND_PATH   = '/matlab/data/rand/';


load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;
load([qsave_path qsave_head num2str(jdays(1))],'lon','lat')
[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);

[year,month,day]=jd2jdate(jdays(1:lj));
%

CRLG=single(nan(560,1440,lj));
CRL=CRLG;


for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([RAND_PATH RAND_HEAD num2str(jdays(m))],'off_crlg')
	load([asave_path asave_head num2str(jdays(m))],'bp26_crlg','ls_5_cm_mask')
	mask=ls_5_cm_mask;
	
	CRL(:,:,m)=single(off_crlg(rs,:).*mask(rs,:));
	CRLG(:,:,m)=single(bp26_crlg(rs,:).*mask(rs,:));
	clear bp26* na*
end

save -v7.3 all_off_crlg lat lon CRL CRLG year month day jdays
return
%now do coupco

%}
load all_off_crlg
beta_n=single(nan(640,1440));
CI_n=single(nan(640,1440));

dist=4 %in native data res

for m=1:640
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
		x=squeeze(CRLG(ros,col,:));
		y=squeeze(CRL(ros,col,:));
		x=x(:);
		y=y(:);
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
	end
end	
sm_coupco_n=smoothn(beta_n,20);


save coupco_map_off_crlg beta_* CI_* lat lon sm_coupco_*