


clear all
warning('off','all')
%
%{
warning('off','all')
fprintf('\r loading index')
load eddy_argo_prof_index

load /matlab/data/eddy/V4/full_tracks/VOCALS_lat_lon_tracks.mat id nneg lon lat amp
%load /matlab/data/eddy/V4/full_tracks/chaigneau_lat_lon_tracks.mat id nneg lon lat amp
%load /matlab/data/eddy/V4/full_tracks/air-sea_eio_lat_lon_tracks.mat id nneg lon lat amp

uid=unique(id);
same_prof=sames(uid,eddy_id);
eddy_pfile=eddy_pfile(same_prof);
eddy_pjday=eddy_pjday(same_prof);
eddy_id=eddy_id(same_prof);
eddy_scale=eddy_efold(same_prof);
eddy_dist_x=eddy_dist_x(same_prof);
eddy_dist_y=eddy_dist_y(same_prof);
eddy_x=eddy_x(same_prof);
eddy_y=eddy_y(same_prof);
eddy_plon=eddy_plon(same_prof);
eddy_plat=eddy_plat(same_prof);

eddy_dist_y=(111.11*(eddy_plat-eddy_y))./eddy_scale;
eddy_dist_x=((111.11*cosd(eddy_plat)).*(eddy_plon-eddy_x))./eddy_scale;

[y,eddy_month,d]=jd2jdate(eddy_pjday);
ppres=[10:10:1000]';
tpres=10:1000;

total_number_of_profiles=length(eddy_y)

[tmp_is,tmp_it,tmp_ip,tmp_t,tmp_s,tmp_p]=deal(nan(length(tpres),length(eddy_id)));


lap=length(eddy_y);
pp=1;

fprintf('\r loading floats')
for m=1:lap
    tmp=num2str(eddy_pfile{m});
	ff=find(tmp=='/');
	fname=tmp(ff(3)+1:length(tmp));
	if exist(['/data/argo/profiles/', fname])
		[blank,dumb,pres,s,t]=read_profiles(fname);
		tmp_t(1:length(t),m)=t';
		tmp_s(1:length(t),m)=s';
		tmp_p(1:length(t),m)=pres';
		fr=find(isnan(pres));
		pres(fr)=[];
		t(fr)=[];
		s(fr)=[];
		dd=diff(pres);
		fr=find(dd==0);
		pres(fr)=[];
		t(fr)=[];
		s(fr)=[];
		if length(s)>2
			tmp_is(:,m)=interp1(pres,s,tpres,'linear');
		end
		if length(t)>2
			tmp_it(:,m)=interp1(pres,t,tpres,'linear');
		end 
	end		
end

[t_woa_tmp,s_woa_tmp,z_woa_tmp]=WOA_profile(eddy_y,eddy_x,tpres,eddy_month);
save VOCALS_raw_profiles tmp_* t_* eddy_* s_* tpres ppres lap nneg lat lon
%}
load VOCALS_raw_profiles
warning('off','all')
%
tmp_it_anom=tmp_it-t_woa_tmp;
tmp_is_anom=tmp_is-s_woa_tmp;
sbad=length(find(isnan(tmp_s)));
tbad=length(find(isnan(tmp_t)));


for m=1:length(tpres)
	sigma_it(m,:)=prctile(tmp_it_anom(m,:),[5 95]);
	sigma_is(m,:)=prctile(tmp_is_anom(m,:),[5 95]);
end

round_pres=round(tmp_p);
for m=1:length(tpres)
	for n=1:length(tmp_it(1,:))
		ii=find(round_pres(:,n)==tpres(m));
		if tmp_it_anom(m,n)<=sigma_it(m,1) | tmp_it_anom(m,n)>=sigma_it(m,2);
			tmp_t(ii,n)=nan;
		end

		if tmp_is_anom(m,n)<=sigma_is(m,1) | tmp_is_anom(m,n)>=sigma_is(m,2);
			tmp_s(ii,n)=nan;
		end
	end
end
percent_s_retained=100*(sbad/length(find(isnan(tmp_s))))
percent_t_retained=100*(tbad/length(find(isnan(tmp_t))))
%}

[eddy_is,eddy_it,eddy_ist]=deal(nan(length(ppres),length(eddy_id)));

fprintf('\r interpolating WOA to float locations')
[t_woa,s_woa,z_woa]=WOA_profile(eddy_y,eddy_x,ppres,eddy_month);
warning('off','all')


fprintf('\r interpolating final profiles')
for m=1:length(eddy_id)
	s=tmp_s(:,m);
	p=tmp_p(:,m);
	t=tmp_t(:,m);
	fl=find(isnan(p));
	s(fl)=[];
	t(fl)=[];
	p(fl)=[];
	dd=diff(p);
	fr=find(dd==0);
	p(fr)=[];
	t(fr)=[];
	s(fr)=[];
	if length(s)>30
		eddy_is(:,m)=interp1(p,s,ppres,'linear');
	end
	if length(t)>30
		eddy_it(:,m)=interp1(p,t,ppres,'linear');
	end
end



eddy_it_anom=eddy_it-t_woa;
eddy_is_anom=eddy_is-s_woa;
ia=find(eddy_id>=nneg);
ic=find(eddy_id<nneg);



mean_t_cc=nanmean(eddy_it(:,ic),2);
mean_s_cc=nanmean(eddy_is(:,ic),2);
mean_t_ac=nanmean(eddy_it(:,ia),2);
mean_s_ac=nanmean(eddy_is(:,ia),2);

tbins=0:.5:40;
ac_it=eddy_it;
ac_it(:,ic)=nan;
cc_it=eddy_it;
cc_it(:,ia)=nan;
ac_is=eddy_is;
ac_is(:,ic)=nan;
cc_is=eddy_is;
cc_is(:,ia)=nan;

sbad=length(find(isnan(eddy_is)));
tbad=length(find(isnan(eddy_it)));

for m=1:length(tbins)-1
	ii=find(ac_it>=tbins(m) & ac_it<tbins(m+1));
	std_t_ac(m,:)=prctile(ac_it(ii),[25 75]);
	jj=find(ac_it(ii)<=std_t_ac(m,1) | ac_it(ii)>=std_t_ac(m,2));
	ac_it(ii(jj))=nan;
	std_s_ac(m,:)=prctile(ac_is(ii),[25 75]);
	jj=find(ac_is(ii)<=std_s_ac(m,1) | ac_is(ii)>=std_s_ac(m,2));
	ac_is(ii(jj))=nan;
	
	ii=find(cc_it>=tbins(m) & cc_it<tbins(m+1));	
	std_t_cc(m,:)=prctile(cc_it(ii),[25 75]);
	jj=find(cc_it(ii)<=std_t_cc(m,1) | cc_it(ii)>=std_t_cc(m,2));
	cc_it(ii(jj))=nan;
	std_s_cc(m,:)=prctile(cc_is(ii),[25 75]);	
	jj=find(cc_is(ii)<=std_s_cc(m,1) | cc_is(ii)>=std_s_cc(m,2));
	cc_is(ii(jj))=nan;
end	

eddy_is(:,ia)=ac_is(:,ia);
eddy_it(:,ia)=ac_it(:,ia);
eddy_is(:,ic)=cc_is(:,ic);
eddy_it(:,ic)=cc_it(:,ic);

percent_s_retained=100*(sbad/length(find(isnan(eddy_is))))
percent_t_retained=100*(tbad/length(find(isnan(eddy_it))))


eddy_it_anom=eddy_it-t_woa;
eddy_is_anom=eddy_is-s_woa;
eddy_ist=sw_dens(eddy_is,sw_ptmp(eddy_is,eddy_it,ppres,0),0)-1000;
woa_st=sw_dens(s_woa,sw_ptmp(s_woa,t_woa,ppres,0),0)-1000;
eddy_ist_anom=eddy_ist-woa_st;


save VOCALS_eddy_argo_prof.mat eddy_* *woa* nneg ppres lat lon ia ic tpres std_* sigma_*
plot_profiles
%

clear
load VOCALS_eddy_argo_prof

xi=[-2.2:.2:2.2];
yi=xi;

[ac_sigma,ac_t,ac_s,ac_t_anom,ac_s_anom,ac_st_anom,ac_dh,ac_v,ac_u,...
cc_sigma,cc_t,cc_s,cc_t_anom,cc_s_anom,cc_st_anom,cc_dh,cc_v,cc_u,...
ac_u,ac_v,cc_u,cc_v,ac_spd,cc_spd,ac_crl,cc_crl]=deal(nan(length(xi),length(yi),length(ppres)));



fprintf('\r interpolating anticyclones')
for m=1:length(ppres);
	ac_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_t(:,:,m)=grid2d_loess(eddy_it(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_s(:,:,m)=grid2d_loess(eddy_is(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_st_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
end

fprintf('\r now interpolating cyclones')
	
for m=1:length(ppres);
	cc_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_t(:,:,m)=grid2d_loess(eddy_it(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_s(:,:,m)=grid2d_loess(eddy_is(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_st_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
end

fprintf('\n now smoothing in vertical\r')

span_z=50;
for m=1:length(xi)
	for n=1:length(yi)
		ac_s(m,n,:)=smooth1d_loess(squeeze(ac_s(m,n,:)),ppres,span_z,ppres);
		ac_t(m,n,:)=smooth1d_loess(squeeze(ac_t(m,n,:)),ppres,span_z,ppres);
		cc_s(m,n,:)=smooth1d_loess(squeeze(cc_s(m,n,:)),ppres,span_z,ppres);
		cc_t(m,n,:)=smooth1d_loess(squeeze(cc_t(m,n,:)),ppres,span_z,ppres);
		ac_s_anom(m,n,:)=smooth1d_loess(squeeze(ac_s_anom(m,n,:)),ppres,span_z,ppres);
		ac_t_anom(m,n,:)=smooth1d_loess(squeeze(ac_t_anom(m,n,:)),ppres,span_z,ppres);
		cc_s_anom(m,n,:)=smooth1d_loess(squeeze(cc_s_anom(m,n,:)),ppres,span_z,ppres);
		cc_t_anom(m,n,:)=smooth1d_loess(squeeze(cc_t_anom(m,n,:)),ppres,span_z,ppres);
		cc_sigma(m,n,:)=smooth1d_loess(squeeze(cc_sigma(m,n,:)),ppres,span_z,ppres);
		ac_sigma(m,n,:)=smooth1d_loess(squeeze(ac_sigma(m,n,:)),ppres,span_z,ppres);
		cc_sigma_anom(m,n,:)=smooth1d_loess(squeeze(cc_st_anom(m,n,:)),ppres,span_z,ppres);
		ac_sigma_anom(m,n,:)=smooth1d_loess(squeeze(ac_st_anom(m,n,:)),ppres,span_z,ppres);
	end
end	

save VOCALS_argo_3d ac_* cc_* ppres xi yi

%
fprintf('\r now calculating velocites')
load VOCALS_argo_3d
[X,Y,P]=meshgrid(xi,yi,ppres);
load VOCALS_eddy_argo_prof eddy_scale eddy_y
km_x=pmean(eddy_scale)*xi;
km_y=km_x';
ff=f_cor(pmean(eddy_y));

[ac_u,ac_v]=geostro_3d(ac_sigma,km_x,km_y,ppres,ff);
[cc_u,cc_v]=geostro_3d(cc_sigma,km_x,km_y,ppres,ff);

%
%
%
%ac_ss=sw_dens(ac__s,sw_ptmp(ac__s,ac__t,P,zeros(size(P))),zeros(size(P)))-1000;
%cc_ss=sw_dens(cc__s,sw_ptmp(cc__s,cc__t,P,zeros(size(P))),zeros(size(P)))-1000;
ac_ss=sw_dens(35*ones(size(ac_t)),ac_t,P);
cc_ss=sw_dens(35*ones(size(cc_t)),cc_t,P);
%
%
%


[ac_u_t,ac_v_t]=geostro_3d(ac_ss,km_x,km_y,ppres,ff);
[cc_u_t,cc_v_t]=geostro_3d(cc_ss,km_x,km_y,ppres,ff);


dx=1000*pmean(diff(km_x));
dy=1000*pmean(diff(km_y));


for m=1:length(ppres);
	ac_crl(:,:,m)=dfdy_m(ac_u(:,:,m),dy)-dfdx_m(ac_v(:,:,m),dy);
	cc_crl(:,:,m)=dfdy_m(cc_u(:,:,m),dy)-dfdx_m(cc_v(:,:,m),dy);
end	

ac_spd=sqrt(ac_u.^2+ac_v.^2);
cc_spd=sqrt(cc_u.^2+cc_v.^2);

save VOCALS_argo_3d -append  ac_* cc_* ppres xi yi

fprintf('\n')

%}
clear
load VOCALS_argo_3d
flf=find(yi==min(abs(yi)));
%
load rwp.pal
load cha_bwr.pal
load cha.pal
load chelle.pal

ipc=find(ppres==150);
ipa=find(ppres==400);

figure(30)
clf
%load /matlab/data/eddy/V4/full_tracks/VOCALS_lat_lon_tracks.mat lon lat nneg
load /matlab/data/eddy/V4/full_tracks/chaigneau_lat_lon_tracks.mat lon lat nneg

load VOCALS_eddy_argo_prof eddy_dist_x eddy_dist_y eddy_ist eddy_x eddy_y eddy_id
dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);
tt=nansum(eddy_ist,1);
ii=find(tt>0);
xx=eddy_x(ii);
yy=eddy_y(ii);
idid=eddy_id(ii);
%lat=min(eddy_y(:)):max(eddy_y(:));
%lon=min(eddy_x(:)):max(eddy_x(:));
pmap(lon,lat,nan(length(lat),length(lon)))
hold on
ii=find(idid>=nneg);
for m=1:length(ii)
	m_plot(xx(ii(m)),yy(ii(m)),'r.')
end
ii=find(idid<nneg);
for m=1:length(ii)
	m_plot(xx(ii(m)),yy(ii(m)),'b.')
end
na=length(find(idid>=nneg));
nc=length(find(idid<nneg));
title([num2str(na),' profiles in AC and ',num2str(nc),' profiles in CC'])
drawnow
print -dpng -r300 figs/VOCALS_profile_map


figure(8)
clf
subplot(321)
contourf(xi,yi,fillnans(squeeze(cc_t_anom(:,:,ipc))),[-2:.2:2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(cc_t_anom(:,:,ipc))),[-2:.2:2],'k');axis image
shading flat
colormap(cha_bwr)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])
title('cyclones 150 m')
ylabel('temperature anomaly')
colorbar
freezecolors
subplot(322)
contourf(xi,yi,fillnans(squeeze(ac_t_anom(:,:,ipa))),[-2:.2:2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(ac_t_anom(:,:,ipa))),[-2:.2:2],'k');axis image
shading flat
colormap(cha_bwr)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])
title('anticyclones 400 m')
colorbar
freezecolors

subplot(323)
contourf(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,ipc))),[-20:2:20]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,ipc))),[-20:2:20],'k');axis image
shading flat
colormap(cha_bwr)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])
ylabel('salinity anomaly')
colorbar
freezecolors
subplot(324)
contourf(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,ipa))),[-20:2:20]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,ipa))),[-20:2:20],'k');axis image
shading flat
colormap(cha_bwr)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])
colorbar
freezecolors

subplot(325)
contourf(xi,yi,squeeze(100*cc_spd(:,:,ipc)),[-20:1:20]);axis image
shading flat
colormap(jet)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-0 10])
ylabel('geostro velocity')
colorbar
subplot(326)
contourf(xi,yi,squeeze(100*ac_spd(:,:,ipa)),[-20:1:20]);axis image
shading flat
colormap(jet)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-0 10])
colorbar
print -dpng -r300 figs/VOCALS_horz_tmp_sal

figure(7)
clf
subplot(221)
contourf(xi,-ppres,squeeze(ac_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic velocity of anticyclones')
subplot(222)
contourf(xi,-ppres,squeeze(cc_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
title('Geostrophic veloctiy of cyclones')
cc=colorbar;
axes(cc)
ylabel('(m s^{-1})')
subplot(223)
contourf(xi,-ppres,squeeze(ac_v_t(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic velocity from T of anticyclones')
subplot(224)
contourf(xi,-ppres,squeeze(cc_v_t(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
title('Geostrophic veloctiy from T of cyclones')
cc=colorbar;
axes(cc)
ylabel('(m s^{-1})')

figure(10)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_ss(flf,:,:))',[20:.1:30]);shading flat
hold on
line([0 0], [ 0])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of smoothed anticyclones')
caxis([24 30])
colorbar
subplot(122)
contourf(xi,-ppres,squeeze(cc_ss(flf,:,:))',[20:.1:30]);shading flat
hold on
line([0 0], [ 0])
caxis([24 30])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of smoothed cyclones')
cc=colorbar;
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
colormap(cha)

figure(1)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_sigma(flf,:,:))'-1000,[2:.1:40]);shading flat
hold on
line([0 0], [-1000 0])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of anticyclones')
caxis([24 28])
colorbar
subplot(122)
contourf(xi,-ppres,squeeze(cc_sigma(flf,:,:))'-1000,[2:.1:40]);shading flat
hold on
line([0 0], [-1000 0])
caxis([24 28])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of cyclones')
cc=colorbar;
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
colormap(cha)

figure(2)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_t_anom(flf,:,:))',[-2:.1:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-1 1])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Temperature anomalies of anticyclones')
subplot(122)
contourf(xi,-ppres,squeeze(cc_t_anom(flf,:,:))',[-2:.1:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-1 1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Temperature anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('^\circ C')
print -dpng -r300 figs/VOCALS_tmp_anom


figure(3)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_s_anom(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Salinity anomalies of anticyclones')
subplot(122)
contourf(xi,-ppres,squeeze(cc_s_anom(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Salinity anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('PSU')
print -dpng -r300 figs/VOCALS_sal_anom

figure(4)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_st_anom(flf,:,:))',[-2:.01:2]);shading flat
hold on
contour(xi,-ppres,squeeze(ac_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.2 .2])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density anomalies of anticyclones')
subplot(122)
contourf(xi,-ppres,squeeze(cc_st_anom(flf,:,:))',[-2:.01:2]);shading flat
hold on
contour(xi,-ppres,squeeze(cc_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.2 .2])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
print -dpng -r300 figs/VOCALS_sigma_anom


figure(5)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic velocity of anticyclones')
subplot(122)
contourf(xi,-ppres,squeeze(cc_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
colormap(cha)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Geostrophic veloctiy of cyclones')
cc=colorbar;
axes(cc)
ylabel('(m s^{-1})')
print -dpng -r300 figs/VOCALS_gvel

figure(9)
clf
subplot(322)
contourf(xi,-ppres,squeeze(ac_t_anom(:,flf,:))',[-2:.1:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(:,flf,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Temperature anomalies of anticyclones')
subplot(321)
contourf(xi,-ppres,squeeze(cc_t_anom(:,flf,:))',[-2:.1:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(:,flf,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Temperature anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('^\circ C')


subplot(324)
contourf(xi,-ppres,squeeze(ac_s_anom(:,flf,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(:,flf,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Salinity anomalies of anticyclones')
subplot(323)
contourf(xi,-ppres,squeeze(cc_s_anom(:,flf,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(:,flf,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Salinity anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('PSU')


subplot(326)
contourf(xi,-ppres,squeeze(ac_u(:,flf,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(:,flf,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Geostrophic velocity of anticyclones')
subplot(325)
contourf(xi,-ppres,squeeze(cc_u(:,flf,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(:,flf,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Geostrophic veloctiy of cyclones')
cc=colorbar;
axes(cc)
ylabel('(m s^{-1})')
warning('on','all')
print -dpng -r300 figs/VOCALS_chan_fig_5_merid

figure(6)
clf
subplot(322)
contourf(xi,-ppres,squeeze(ac_t_anom(flf,:,:))',[-2:.1:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Temperature anomalies of anticyclones')
subplot(321)
contourf(xi,-ppres,squeeze(cc_t_anom(flf,:,:))',[-2:.1:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Temperature anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('^\circ C')


subplot(324)
contourf(xi,-ppres,squeeze(ac_s_anom(flf,:,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Salinity anomalies of anticyclones')
subplot(323)
contourf(xi,-ppres,squeeze(cc_s_anom(flf,:,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Salinity anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('PSU')


subplot(326)
contourf(xi,-ppres,squeeze(ac_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Geostrophic velocity of anticyclones')
subplot(325)
contourf(xi,-ppres,squeeze(cc_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Geostrophic veloctiy of cyclones')
cc=colorbar;
axes(cc)
ylabel('(m s^{-1})')
warning('on','all')
print -dpng -r300 figs/VOCALS_chan_fig_5


