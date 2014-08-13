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
[ro,co]=imap(min(slat(:)),max(slat(:)),1,1,olat,olon);

r0=nan(640,1440,length(lags));
N=r0;
Sig=r0;

%{
SST=single(nan(640,1440,lj));
SSH=SST;


for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([asave_path asave_head num2str(jdays(m))],'ssh','mask')
	load([osave_path osave_head num2str(jdays(m))],'bp26_sst')
	
	SSH(:,:,m)=single(ssh);
	SST(:,:,m)=single(bp26_sst(ro,:));
end

save -v7.3 all_sst_ssh lat lon CHL SSH
%now do correlation
%}
load all_sst_ssh

for m=1:640
	for n=1:1440
	[r0(m,n,:),dum,N(m,n,:),Sig(m,n,:)]=pcor(SST(m,n,:),SSH(m,n,:),lags);
	end
end	



for n=1:1440
	for m=1:640
	i=find(r0(m,n,:)==max(r0(m,n,:)));
		if any(i)
		r_max(m,n)=pmean(squeeze(r0(m,n,i)));
		i_max(m,n)=pmean(i);
		end
	end
end

save zonal_phase_shift_out r0 N Sig slat slon r_max i_max
