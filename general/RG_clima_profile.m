function [t_out,s_out,z]=RG_clima_profile(y,x,z_in,month)

lon = ncread('/Users/new_gaube/data/argo/RG_ArgoClim_2012.nc','LONGITUDE');
lat = ncread('/Users/new_gaube/data/argo/RG_ArgoClim_2012.nc','LATITUDE');



t_out=nan(length(z_in),length(x));
s_out=t_out;

for m=1:length(x)
	[r,c]=imap(y(m)-.5,y(m)+.5,x(m)-.5,x(m)+.5,lat,lon);
	r=r(1);
	c=c(1);
	tt=squeeze(T(month(m),:,r,c))';
	ss=squeeze(S(month(m),:,r,c))';
	t_out(:,m)=interp1(z,tt,z_in);
	s_out(:,m)=interp1(z,ss,z_in);
end	
