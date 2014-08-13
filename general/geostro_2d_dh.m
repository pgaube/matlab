function [v]=geostro_2d_dh(dh,x,p,f);
%input 
% x in eddy scale (km)
% y same as x
% p in dbars


%first make sure no nans
ii=length(find(isnan(dh(:))));
if ii>0
	fprintf('\r rho has nans, interpolating')
	rho=fillnans(dh);
end	

dz=-pmean(diff(p)); %could be a problem if diff(p) isn't constant
dx=1000*pmean(diff(x));
[v,dr]=deal(nan(length(p),length(x)));

g=9.81;
for m=1:length(p)
	drdx(m,:)=dfdx_m(dh(m,:),dx);
end

v=(g/f)*drdx;