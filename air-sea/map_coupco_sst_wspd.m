%
%loads SeaWiFS CHL data
clear all
close all

lags=-8:8;

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
load([qsave_path qsave_head num2str(jdays(1))],'lon','lat')
[ro,co]=imap(min(lat(:)),max(lat(:)),1,1,olat,olon);
[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);

%
SST=single(nan(560,1440,lj));
WSPD=SST;


for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([qsave_path qsave_head num2str(jdays(m))],'bp26_wspd')
	load([osave_path osave_head num2str(jdays(m))],'bp26_sst')
	load([asave_path asave_head num2str(jdays(m))],'ls_mask')	
	mask=ls_mask(rs,:);
	WSPD(:,:,m)=single(bp26_wspd.*mask);
	SST(:,:,m)=single(bp26_sst(ro,:).*mask);
end

save -v7.3 all_sst_strm lat lon WSPD SST
return
%now do coupco


%}
load all_sst_wspd
tbins=-1:.1:1;
beta=single(nan(560,1440,2));
S=beta;
CI=S;

dist=4 %in native data res

for m=1:560
m
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
		x=squeeze(SST(ros,col,:));
		y=squeeze(WSPD(ros,col,:));
		x=x(:);
		y=y(:);
		for i=1:length(tbins)-1
			bin_est = find(x>=tbins(i) & x<tbins(i+1));
			%binned_samps1(i) = double(pmean(x(bin_est)));
			binned_samps2(i) = double(pmean(y(bin_est)));
		end
		[dumb,beta(m,n,:),S(m,n),dim,CI(m,n,:)]=reg(tbins(1:length(tbins)-1),binned_samps2,'lin');
	end
end	

sm_coupco=smoothn(beta(:,:,2),20);

save coupco_map_sst_strm beta S CI lat lon sm_coupco
