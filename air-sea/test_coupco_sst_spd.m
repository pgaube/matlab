%
%clear all
%close all

load /matlab/matlab/domains/LW_lat_lon.mat
llat=lat;
llon=lon;
load all_spd_str lat lon
load all_spd_str lat lon SST SPD
[r,c]=imap(min(llat),max(llat),min(llon),max(llon),lat,lon);
%{
x=DTDN(r,c,60);
y=CRL(r,c,60);
y(abs(y)>=1e-6)=nan;
save test_dtdn x y lat lon r c
%}



tbins=-2:.1:2;
x=squeeze(SST(r,c,:));
y=squeeze(SPD(r,c,:));

%{
pp=1;
clear xx yy
for m=3:length(x(1,1,:))-3
	xx(:,:,pp)=nanmean(x(:,:,m-2:m+2),3);
	yy(:,:,pp)=nanmean(y(:,:,m-2:m+2),3);
	pp=pp+1;
end	
%}	
	
x=x(:);
y=y(:);
%y(abs(y)>=1e-6)=nan;
%x(abs(x)>=1e-4)=nan;
%
clear binned_samps2 num_samps2
for i=1:length(tbins)-1
	bin_est = find(x>=tbins(i) & x<tbins(i+1));
	%binned_samps1(i) = double(pmean(x(bin_est)));
	binned_samps2(i) = double(pmean(y(bin_est)));
	num_samps2(i) = length(y(bin_est));
end
%[dum,beta,did,dim,CI]=reg(tbins(1:length(tbins)-1),binned_samps2,'lin');
%beta
%}
[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
beta_bin=Cor*sdY/sdX

[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(x,y);
beta_all=Cor*sdY/sdX

%save test_coupco_dtdn_AGU_2 beta CI lat lon tbins binned_samps2 num_samps2
