function [u,v]=geostro_3d(rho,x,y,p,f);
%input 
% x in eddy scale (km)
% y same as x
% p in dbars

%first make sure non nans
ii=length(find(isnan(rho(:))));
if ii>0
	fprintf('\r rho has nans, interpolating')
	rho=fillnans(rho);
end	

g=9.8;

dz=-pmean(diff(p));
dx=1000*pmean(diff(x));
dy=1000*pmean(diff(y));
[v,u,dr]=deal(nan(length(x),length(y),length(p)));


for m=1:length(p)
	drdy(:,:,m)=dfdy_m(rho(:,:,m),dy);
	drdx(:,:,m)=dfdx_m(rho(:,:,m),dx);
end

for m=1:length(x)
	for n=1:length(y)
		mean_drdx=squeeze(0.5*(drdx(m,n,2:end)+drdx(m,n,1:end-1)));
		mean_drdy=squeeze(0.5*(drdy(m,n,2:end)+drdy(m,n,1:end-1)));
		top_drdx=drdx(m,n,1).*p(1);
		top_drdy=drdy(m,n,1).*p(1);
		delta_drdx=mean_drdx*dz;
		delta_drdy=mean_drdy*dz;
		u(m,n,:)=(g/(1020*f))*cumsum([top_drdy; delta_drdy]);
		v(m,n,:)=-(g/(1020*f))*cumsum([top_drdx; delta_drdx]);

		u(m,n,:)=squeeze(u(m,n,:))-(ones(length(p),1)*u(m,n,end));
		v(m,n,:)=squeeze(v(m,n,:))-(ones(length(p),1)*v(m,n,end));
	end
end	