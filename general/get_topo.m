function [tout,lonout,latout]=get_topo(lon,lat)

load /matlab/matlab/general/Global_Topography

DOMAIN=[min(lon(:)) max(lon(:)) min(lat(:)) max(lat(:))];
if DOMAIN(1)<0
	DOMAIN(1)=180+(180+DOMAIN(1));
end

if DOMAIN(2)<0
	DOMAIN(2)=180+(180+DOMAIN(2));
end

c=find(tlon(1,:)>=DOMAIN(1) & tlon(1,:)<=DOMAIN(2));
r=find(tlat(:,1)>=DOMAIN(3) & tlat(:,1)<=DOMAIN(4));
lonout=tlon(r,c);
latout=tlat(r,c);
tout=topo(r,c);
%{
tout=topo(r,c);
bout=tout;
ii=find(tout<0);
tout(ii)=nan;
ii=find(bout>=0);
bout(ii)=nan;
%}
