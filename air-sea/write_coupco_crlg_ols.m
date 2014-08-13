%
%clear all
%close all


load /matlab/matlab/air-sea/all_crls_mask_half_mask lat lon CRL CRLG

nweek=length(CRL(1,1,:));
nmonth=nweek/4
mask=nan*lat;

mask(abs(lat)>=15 & abs(lat)<=45)=1;

mask=ones(size(lat));

ab=-1.5:.1:1.5;
tbins=-.5e-5:.1e-5:.5e-5;
x=nan*CRLG;
y=nan*CRL;

for m=1:length(x(1,1,:))
	x(:,:,m)=-CRLG(:,:,m).*mask;
	y(:,:,m)=CRL(:,:,m).*mask;
end

	
x=x(:);
y=y(:);



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

[beta_nut_samps(2),beta_nut_samps(1),dud,dud,chiopt,Cab,Calphap]=ols_line(double(x),double(y),1);
beta_nut_samps(2)
y_ols=beta_nut_samps(2).*ab;


tbins=1e5*tbins(1:length(tbins)-1);
y_lin=beta_eio.*ab;
binned_samps2=1e5*binned_samps2;
std_samps2=1e5*std_samps2;


ci=std_samps2.*tinv((.05)/2,(nmonth)-1)./sqrt((nmonth)-1);
return

save -ascii data/crls/ab ab
save -ascii data/crls/midlat_lin_crl y_lin
save -ascii data/crls/midlat_tbins tbins
save -ascii data/crls/midlat_crl binned_samps2
save -ascii data/crls/midlat_std_crl ci
save -ascii data/crls/midlat_lin_crl y_lin
save -ascii data/crls/midlat_ols_crl y_ols
pcoupco(1e5*x(:),1e5*y(:),1,-.5:.1:.5,.25,-2,2,-2,2,'-\nabla \times U_{g}','\nabla \times U_{rel}')



min_x=-2;
max_x=2;
min_y=-2;
max_y=2;
step=.4;
x=1e5*x;
y=1e5*y;
[X,Y]=meshgrid([min_x/step:.25:max_x/step],[min_y/step:.25:max_y/step]);
dens=zeros(size(X));
nx=x./step;
ny=y./step;
for m=1:length(nx)
	tmpxs=floor(nx(m))-1:.25:ceil(nx(m))+1;
	tmpys=floor(ny(m))-1:.25:ceil(ny(m))+1;
    disx = abs(tmpxs-nx(m));
    disy = abs(tmpys-ny(m));
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    if any(iminx & iminy)
    	cx=tmpxs(iminx(1));
    	cy=tmpys(iminy(1));
    	r=find(Y(:,1)>=cy-step/2 & Y(:,1)<=cy+step/2);
    	c=find(X(1,:)>=cx-step/2 & X(1,:)<=cx+step/2);
    
   	 	if any(r)
    	if any(c)
    		dens(r,c)=dens(r,c)+1;
    		index_dens(m)=(c-1)*length(dens(:,1))+r;
    	end
    	end
    end	
end

dens=dens./max(dens(:));
save -ascii data/crls/midlat_dens dens

