%
%clear all
%close all


%load /matlab/matlab/air-sea/all_wspd_sst lat lon WSPD SST
mask=ones(size(lat));
mask(abs(lat)<15)=nan;
mask(abs(lat)>45)=nan;
ab=-1.5:.1:1.5;
tbins=-.5:.1:.5;
x=nan*SST;
y=nan*WSPD;
for m=1:length(SST(1,1,:))
	x(:,:,m)=SST(:,:,m).*mask;
	y(:,:,m)=WSPD(:,:,m).*mask;
end	

x(abs(x)>5)=nan;
y(abs(y)>5)=nan;
	

clear binned_samps2 num_samps2 std_samps2
for i=1:length(tbins)-1
	bin_est = find(x>=tbins(i) & x<tbins(i+1));
	%binned_samps1(i) = double(pmean(x(bin_est)));
	binned_samps2(i) = double(pmean(y(bin_est)));
	num_samps2(i) = length(y(bin_est));
	std_samps2(i) = double(pstd(y(bin_est)));
end

[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
beta_eio=Cor*sdY/sdX

tbins=tbins(1:length(tbins)-1);
y_lin=beta_eio.*ab;
binned_samps2=binned_samps2;
std_samps2=std_samps2;

save -ascii data/wspd/mid_tbins tbins
save -ascii data/wspd/ab ab
save -ascii data/wspd/mid_wspd binned_samps2
save -ascii data/wspd/mid_std_wspd std_samps2
save -ascii data/wspd/mid_lin_wspd y_lin

