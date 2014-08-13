
clear all
%close all
jdays=[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);

N=round(lj/52*4);

dd={'midlat'}
m=1;
load /matlab/matlab/air-sea/all_sst_strm

[r1,c]=imap(-45,-15,0,360,lat,lon);
[r2,c]=imap(15,45,0,360,lat,lon);
r=cat(1,r1,r2);

ab=-1:.1:1;
tbins=ab;
x=squeeze(SST(r,c,:));
y=squeeze(WSPD(r,c,:));
	
x=x(:);
y=y(:);

[dens_crl,beta_ols,beta,std_samps2,binned_samps2]=pscatter(x,y,.4,10,tbins,.1,-1,1,-1,1,'sst','wspd');
save tmp_scat dens_crl beta_ols beta std_samps2 binned_samps2
return
%}
load  tmp_scat
y_ols=beta_ols.*ab;
y_lin=beta.*ab;
title(dd{m})
figure(23)
eval(['print -dpng -r300 histo_2d_sst_wspd_midlat_',dd{m}])
dens_crl_t=flipud(dens_crl);
nx=1:length(dens_crl(1,:))
ny=[1:length(dens_crl(:,1))]'
sm_dens_crl=smooth2d_loess(dens_crl,ny,nx,20,20,nx,ny);
dens_crl(isnan(dens_crl))=1e35;
sm_dens_crl(isnan(sm_dens_crl))=1e35;

ci_bin2=std_samps2.*tinv((.05)/2,N)./sqrt(N);
eval(['save -ascii data/sst/ab ab'])
eval(['save -ascii data/sst/',dd{m},'_sst binned_samps2'])
eval(['save -ascii data/sst/',dd{m},'_std_sst ci_bin2'])
eval(['save -ascii data/sst/',dd{m},'_lin_sst y_lin'])
eval(['save -ascii data/sst/',dd{m},'_ols_sst y_ols'])
eval(['save -ascii data/sst/',dd{m},'_dens_sst sm_dens_crl'])
eval(['save -ascii data/sst/',dd{m},'_dens_sst_t dens_crl_t'])

