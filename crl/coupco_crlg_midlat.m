%
clear all
%close all
jdays=[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);

N=round(lj/52*4);

dd={'midlat'}
m=1;
load /matlab/matlab/air-sea/all_off_crlg CRL
OFF=CRL;
load /matlab/matlab/air-sea/all_hp_10_cm_crls lat lon CRL CRLG

[r1,c]=imap(-45,-15,0,360,lat,lon);
[r2,c]=imap(15,45,0,360,lat,lon);
r=cat(1,r1,r2);

ab=-1:.1:1;
tbins=ab;
x=squeeze(CRLG(r,c,:));
y=squeeze(-CRL(r,c,:));
z=squeeze(OFF(r,c,:));
	
x=1e5*x(:);
y=1e5*y(:);
z=1e5*z(:);

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

[dens_off,beta_ols,beta,std_samps3,binned_samps3]=pscatter(x,z,1,10,tbins,.1,-1,1,-1,1,'crl','crl_off');
y_ols_off=beta_ols.*ab;
y_lin_off=beta.*ab;
title(dd{m})
figure(23)
eval(['print -dpng -r300 histo_2d_crlg_off_midlat_',dd{m}])
dens_off_t=flipud(dens_off);
sm_dens_off=smooth2d_loess(dens_off,ny,nx,20,20,nx,ny);
dens_off(isnan(dens_off))=1e35;
sm_dens_off(isnan(sm_dens_off))=1e35;
return
ci_bin2=std_samps2.*tinv((.05)/2,N)./sqrt(N);
ci_bin3=std_samps3.*tinv((.05)/2,N)./sqrt(N);
eval(['save -ascii data/crls/ab ab'])
eval(['save -ascii data/crls/',dd{m},'_crl binned_samps2'])
eval(['save -ascii data/crls/',dd{m},'_std_crl ci_bin2'])
eval(['save -ascii data/crls/',dd{m},'_lin_crl y_lin'])
eval(['save -ascii data/crls/',dd{m},'_off binned_samps3'])
eval(['save -ascii data/crls/',dd{m},'_std_off ci_bin3'])
eval(['save -ascii data/crls/',dd{m},'_lin_off y_lin_off'])
eval(['save -ascii data/crls/',dd{m},'_ols_crl y_ols'])
eval(['save -ascii data/crls/',dd{m},'_ols_off y_ols_off'])
eval(['save -ascii data/crls/',dd{m},'_dens_crl sm_dens_crl'])
eval(['save -ascii data/crls/',dd{m},'_dens_off sm_dens_off'])
eval(['save -ascii data/crls/',dd{m},'_dens_crl_t dens_crl_t'])
eval(['save -ascii data/crls/',dd{m},'_dens_off_t dens_off_t'])

