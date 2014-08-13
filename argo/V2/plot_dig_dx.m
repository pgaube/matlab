clear
load dCC_eddy_argo_prof
warning('off','all')
step=.1;
xi=-2.2:step:2.2;
yi=xi;

[r,c]=imap(-2,2,-2,2,xi,yi)
cc=10;
%{
for m=2:.1:6
ss=grid2d_loess(eddy_ist(14,ic)',eddy_dist_x(ic),eddy_dist_y(ic),m,m,xi,yi);
load dCC_eddy_argo_prof eddy_scale eddy_y
km_x=pmean(eddy_scale)*xi;
km_y=km_x';
ff=f_cor(pmean(eddy_y));
u=dfdy_m(ss,.1);
v=dfdx_m(ss,.1);
spd=sqrt(u.^2+v.^2);
figure(cc)
clf
contourf(xi(r),yi(c),spd(r,c),[0:.01:2]);shading flat
hold on
contour(xi(r),yi(c),spd(r,c),[0:.05:2],'k')
caxis([0 .5])
title(num2str(m))
end
%}


for m=1:60
	ss=grid2d_loess(eddy_ist(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),5,5,xi,yi);
	u=dfdy_m(ss,.1);
	v=dfdx_m(ss,.1);
	spd=sqrt(u.^2+v.^2);
	figure(cc)
	clf
	contourf(xi(r),yi(c),spd(r,c),[0:.01:2]);shading flat
	hold on
	contour(xi(r),yi(c),spd(r,c),[0:.05:2],'k')
	title(num2str(m))
	caxis([0 .5])
	pause(.3)
end