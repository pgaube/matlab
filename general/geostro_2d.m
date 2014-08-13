function [v]=geostro_3d(rho,x,p,f);
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
[v,dr]=deal(nan(length(p),length(x)));


for m=1:length(p)
	drdx(m,:)=dfdx_m(rho(m,:),dx);
end
whos drdx
for m=1:length(x)
	mean_drdx=squeeze(0.5*(drdx(2:end,m)+drdx(1:end-1,m)));
	top_drdx=drdx(1,m).*p(1);
	delta_drdx=mean_drdx*dz;
	v(:,m)=-(g/(1020*f))*cumsum([top_drdx; delta_drdx]);
	v(:,m)=squeeze(v(:,m))-(ones(length(p),1)*v(end,m));
end	