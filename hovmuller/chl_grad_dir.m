%{
spath='/matlab/data/gsm/mat/GSM_9_21_';
asave='/matlab/data/eddy/V4/mat/AVISO_25_W_';
load([spath '2450884'],'glon','glat','jdays')
load([asave '2454769'],'lon','lat','ssh')
slon=lon;
slat=lat;
startjd=2450884;
endjd=2454832;
jdays=[startjd:7:endjd];
load /matlab/matlab/domains/section_30_lat_lon.mat
	
[r,c]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);
[rssh,cssh]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);

grad_dir=nan(length(r),length(c),length(jdays));


for m=1:length(jdays)
	load([spath num2str(jdays(m))],'sm_gchl_200_day')
	chl=double(flipud(sm_gchl_200_day(r,c)));
	dx=dfdx(glat(r,c),chl,.25);
	dy=dfdy(chl,.25);
	thet=double(rad2deg(cart2pol(dx,dy)));
	%{
	if thet>=0
		thet=-(thet-90);
	else
		thet=thet-90;
	end	
	%}
	grad_dir(:,:,m)=thet;
end

save chl_grad_dir_out grad_dir
%}
load chl_grad_dir_out
figure(203)
bins=[0:5:180]
[bar_est,num_est]=phist(grad_dir(:),bins);
stairs(bins(1:end-1),100*(num_est./sum(num_est)))
line([90 90],[0 15],'color','k')
line([135 135],[0 15],'color',[.5 .5 .5])
axis tight
title('Histogram of direction on \nabla CHL  0=E, 90=N, 180=W   ')
print -dpng -r300 ~/Documents/OSU/figures/hovmuller/figs/grad_chl_degrees_histo