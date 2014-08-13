function [t_out,s_out,z]=ACL_profile(y,x,z_in,month)

load /Users/new_gaube/data/argo/argo_climatology T_clima S_clima lat lon pres

%x=x+20;  %this adjust x to the fucking weird ass 20:380 lon grid from the climatology
z=pres;

ii=find(x<20);
x(ii)=360+x(ii);
t_out=nan(length(z_in),length(x));
s_out=t_out;

for m=1:length(x)
	[r,c]=imap(y(m)-.5,y(m)+.5,x(m)-.5,x(m)+.5,lat,lon);
	if any(c) & any(r)
        r=r(1);
        c=c(1);
        tt=squeeze(T_clima(c,r,:,month(m)));
        ss=squeeze(S_clima(c,r,:,month(m)));
        t_out(:,m)=fillnans(interp1(z,tt,z_in));
        s_out(:,m)=fillnans(interp1(z,ss,z_in));
    else
        display(['profile out of bounds of Argo climatotlogy, lat=',num2str(y(m)),' lon=',num2str(x(m))])
    end
end	
