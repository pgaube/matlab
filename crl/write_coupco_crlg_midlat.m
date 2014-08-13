%{
clear all
%close all
jdays=[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);

N=round(lj/52*4);

dd={'midlat'}
m=1;
ab=-1:.1:1;
tbins=ab;

load /matlab/matlab/crl/all_ls_crls lat lon CRL CRLG

[r1,c]=imap(-45,-15,0,360,lat,lon);
[r2,c]=imap(15,45,0,360,lat,lon);
r=cat(1,r1,r2);


x=squeeze(CRLG(r,c,:));
y=squeeze(-CRL(r,c,:));

	
x=1e5*x(:);
y=1e5*y(:);


[dens_crl,beta_ols,beta,std_samps2,binned_samps2]=pscatter(x,y,1,10,tbins,.1,-1,1,-1,1,'crlg','crl');


y_ols=beta_ols.*ab;
y_lin=beta.*ab;
title(dd{m})
figure(23)
eval(['print -dpng -r300 histo_2d_crlg_crl_midlat_',dd{m}])
dens_crl_t=flipud(dens_crl);
nx=1:length(dens_crl(1,:))
ny=[1:length(dens_crl(:,1))]'
sm_dens_crl=smooth2d_loess(dens_crl,ny,nx,20,20,nx,ny);
dens_crl(isnan(dens_crl))=1e35;
sm_dens_crl(isnan(sm_dens_crl))=1e35;
ci_bin2=std_samps2.*tinv((.05)/2,N)./sqrt(N);
save coupco_crls_midlat_write_out sm_dens_crl ci_bin2 y_ols dens_crl y_lin
return
%}
load coupco_crls_midlat_write_out
cd /Users/gaube/Documents/Publications/gaube_chelton_crl_GRL
ab=-1:.1:1;
save -ascii data/ab ab
save -ascii data/midlat_ols_crl y_ols
save -ascii data/midlat_lin_crl y_lin
tt=(sm_dens_crl);
save -ascii data/midlat_dens_crl_t tt
tt=flipud(sm_dens_crl);
save -ascii data/midlat_dens_crl tt

cd /matlab/matlab/crl
