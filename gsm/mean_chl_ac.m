%loads SeaWiFS CHL data
clear all
close all


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


for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([save_path save_head num2str(jdays(m))],'bp21_chl','bp21_car')
	load([asave_path asave_head num2str(jdays(m))],'ssh','a_mask')
	%load([qsave_path qsave_head num2str(jdays(m))],'w_ek')
	CHL(:,:,m)=flipud(bp21_chl(r,:)).*a_mask(rs,:);

end

%save -v7.3 tmp lat lon CHL SSH
%now do correlation

mean_chl=nanmean(CHL,3);
med_chl=nanmedian(CHL,3);

save mean_chl_ac_out mean_* med_* lat lon 
