%
clear all


SSH_HEAD   = 'AVISO_25_W_';
SSH_PATH   = '/matlab/data/eddy/V4/mat/';

Q_HEAD   = 'QSCAT_30_25km_';
Q_PATH   = '/matlab/data/QuickScat/mat/';

OUT_HEAD   = 'SSTWIND_25_W_';
OUT_PATH   = '/matlab/data/SSTWIND/mat/';

startjd=2451556;
endjd=2454797;
jdays=startjd:7:endjd;
jdays=[2452459:7:2454489];
%jdays=jdays(1):7:jdays(200);

load /matlab/matlab/domains/NORTH_lat_lon
%lat=25:40;
%lon=0:360;
llat=lat;
llon=lon;

load([SSH_PATH SSH_HEAD num2str(jdays(1))],'lon','lat')
lat=lat(41:600,:);
lon=lon(41:600,:);
[r,c]=imap(min(llat),max(llat),min(llon),max(llon),lat,lon);

[r1,c]=imap(-45,-15,min(llon),max(llon),lat,lon);
[r2,c]=imap(15,45,min(llon),max(llon),lat,lon);

r=cat(1,r1,r2);

% initalize
[tmp_var1]=single(nan(length(lat(r,1)),length(lon(1,c)),length(jdays)));
tmp_var2=tmp_var1;


for m=1:length(jdays)
    fprintf('\r     sampling week %03u of %03u \r',m,length(jdays))
	%load([OUT_PATH OUT_HEAD num2str(jdays(m))],'bp26_sst_ind_crl')
	load([SSH_PATH SSH_HEAD num2str(jdays(m))],'bp26_crlg','ls_mask')
	load([Q_PATH Q_HEAD num2str(jdays(m))],'bp26_crl','bp26_crle')
   	mask=ls_mask(41:600,:);
   	bp26_crlg=bp26_crlg(41:600,:).*mask;
   	bp26_crl=bp26_crl.*mask;
   	tmp_var1(:,:,m)=-single(bp26_crlg(r,c));
   	tmp_var2(:,:,m)=single(bp26_crl(r,c));   
end     

save coupco_crl_crlg_ls_mask_midlat 
fprintf('\n')
%}
[dens,beta_ols,beta_bin,ci_bin]=pscatter(1e5*tmp_var1(:),1e5*tmp_var2(:),1,0,-1:.1:1,.25,-1,1,-1,1,'-\nabla \times U_{g}','\nabla \times U_{rel}')
%pcoupco(1e5*tmp_var1(:),1e5*tmp_var2(:),1,-1:.1:1,.25,-2,2,-2,2,'-\nabla \times U_{g}','\nabla \times U_{rel}')