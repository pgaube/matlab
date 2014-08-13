%loads SeaWiFS CHL data
clear all
close all

lags=0:20;

jdays=[2451395:7:2454461];
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
CAR=CHL;
r0=nan(560,1440,length(lags));
N=r0;
Sig=r0;
decor_time=N(:,:,1);

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([save_path save_head num2str(jdays(m))],'gchl_week','gcar_week')
	%load([asave_path asave_head num2str(jdays(m))],'ssh','mask')
	%load([qsave_path qsave_head num2str(jdays(m))],'w_ek')
	CHL(:,:,m)=flipud(gchl_week(r,:));
	CAR(:,:,m)=flipud(gcar_week(r,:));

end

%save -v7.3 tmp lat lon CHL SSH
%now do correlation


for m=1:560
	for n=1:1440
	%[r0(m,n,:),dum,N(m,n,:),Sig(m,n,:)]=pcor(CHL(m,n,:),CHL(m,n,:),lags);
	[r0(m,n,:),dum,N(m,n,:),Sig(m,n,:)]=pcor(CHL(m,n,:),CAR(m,n,:),lags);	
	end
end	



for n=1:1440
	for m=1:560
	i=find(r0(m,n,:)<=.5);
	if any(i)
	decor_time(m,n)=lags(i(1));
	end
	end
end

save cor_chl_car_out r0 N Sig lat lon decor_time
