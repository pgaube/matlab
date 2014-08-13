%loads SeaWiFS CHL data
clear all
close all

lags=-8:8;

jdays=[2451556:7:2454797];
jdays=jdays(1:300);
lj=length(jdays);

save_path='/matlab/data/gsm/mat/';
save_head='GSM_9_21_';
asave_path='/matlab/data/eddy/V4/mat/';
asave_head='AVISO_25_W_';
qsave_path='/matlab/data/QuickScat/mat/';
qsave_head='QSCAT_30_25km_';


load([save_path save_head num2str(jdays(1))],'glon','glat')
load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;
load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')


[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
[r,c]=imap(min(lat(:)),max(lat(:)),1,1,glat,glon);

CHL=nan(560,1440,lj);
SSH=CHL;
r0=nan(560,1440,length(lags));
N=r0;
Sig=r0;

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([save_path save_head num2str(jdays(m))],'sp66_chl')
	load([asave_path asave_head num2str(jdays(m))],'ssh','mask')
	load([qsave_path qsave_head num2str(jdays(m))],'hp_wek_crlg_week','w_ek')
	%CHL(:,:,m)=flipud(bp21_chl(r,:)).*mask(rs,:);
	%SSH(:,:,m)=ssh(rs,:).*mask(rs,:);
	CHL(:,:,m)=flipud(sp66_chl(r,:)).*mask(rs,:);
	%SSH(:,:,m)=ssh(rs,:);
	SSH(:,:,m)=w_ek.*mask(rs,:);
end

%save -v7.3 tmp lat lon CHL SSH
%now do correlation


for m=1:560
	for n=1:1440
	[r0(m,n,:),dum,N(m,n,:),Sig(m,n,:)]=pcor(CHL(m,n,:),SSH(m,n,:),lags);
	end
end	



for n=1:1440
	for m=1:560
	i=find(abs(r0(m,n,:))==max(abs(r0(m,n,:))));
		if any(i)
		r_max(m,n)=pmean(squeeze(r0(m,n,i)));
		i_max(m,n)=pmean(i);
		end
	end
end

save cor_raw_wek_out r0 N Sig lat lon r_max i_max
