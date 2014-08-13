

%{
%
clear all
warning('off','all')

warning('off','all')
fprintf('\r loading index')
load eddy_argo_prof_index

%load /matlab/data/eddy/V4/full_tracks/VOCALS_lat_lon_tracks.mat id nneg lon lat amp
load /matlab/data/eddy/V4/full_tracks/chaigneau_lat_lon_tracks.mat id nneg lon lat amp
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

tmp_it_anom=tmp_it-t_woa_tmp;
tmp_is_anom=tmp_is-s_woa_tmp;


[flag_t,flag_s]=deal(zeros(size(tmp_it)));
flag_t(isnan(tmp_it))=1;
flag_s(isnan(tmp_is))=1;
s_bad=length(find(flag_s==1));
t_bad=length(find(flag_t==1));

for m=1:length(tpres)
	sigma_it(m,:)=prctile(tmp_it_anom(m,:),[25 75]);
	sigma_is(m,:)=prctile(tmp_is_anom(m,:),[25 75]);
end

for m=1:length(tpres)
	for n=1:length(tmp_it(1,:))
		if tmp_it_anom(m,n)<3*sigma_it(m,1) | tmp_it_anom(m,n)>3*sigma_it(m,2);
			tmp_t(m,n)=nan;
			flag_t(m,n)=1;
		end

		if tmp_is_anom(m,n)<3*sigma_is(m,1) | tmp_is_anom(m,n)>3*sigma_is(m,2)% | abs(tmp_is_anom(m,n))>.15;
			tmp_s(m,n)=nan;
			flag_s(m,n)=1;
		end
	end
end

percent_s_removed=100-(100*(s_bad/length(find(flag_s==1))))
percent_t_removed=100-(100*(t_bad/length(find(flag_t==1))))

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
		ii=find(~isnan(eddy_is(:,m)));
	end
	if length(t)>30
		eddy_it(:,m)=interp1(p,t,ppres,'linear');
		ii=find(~isnan(eddy_it(:,m)));
	end
end



ia=find(eddy_id>=nneg);
ic=find(eddy_id<nneg);

s_good=length(find(~isnan(eddy_is)));
t_good=length(find(~isnan(eddy_it)));

mean_t_cc=nanmean(eddy_it(:,ic),2);
mean_s_cc=nanmean(eddy_is(:,ic),2);
mean_t_ac=nanmean(eddy_it(:,ia),2);
mean_s_ac=nanmean(eddy_is(:,ia),2);

for m=1:length(ppres)
	std_t(m,:)=prctile(eddy_it(m,:),[25 95]);
	std_s(m,:)=prctile(eddy_is(m,:),[25 95]);
end
ibad=0;
!toast figs/test_profiles/*.png

for n=1:length(eddy_it(1,:))
	df_off=eddy_is(:,n)-std_s(:,1);
	i_neg=find(df_off<0);
	sum_off(n)=sum(df_off(i_neg)); 
	if sum_off(n)<=-4
		figure(112)
	 	clf
		plot(eddy_is(:,n),eddy_it(:,n),'k')
	 	hold on
	 	plot(mean_s_cc,mean_t_cc,'b')
	 	plot(mean_s_ac,mean_t_ac,'r') 
		plot(std_s,std_t,'color',[.5 .5 .5])
	 	axis([34 35.8 0 30])
	 	title(['s',char(39),'-<s> = ',num2str(sum_off(n))])
	 	pause(.1)
		ibad=ibad+1;
		eddy_is(:,n)=nan;
		eddy_it(:,n)=nan;
		%eval(['print -dpng -r100 figs/test_profiles/frame_',num2str(ibad)])
	end
end	
percent_profiles_removed=100*(ibad/n)

eddy_it_anom=eddy_it-t_woa;
eddy_is_anom=eddy_is-s_woa;
eddy_ist=sw_dens(eddy_is,sw_ptmp(eddy_is,eddy_it,ppres,0),0)-1000;
woa_st=sw_dens(s_woa,sw_ptmp(s_woa,t_woa,ppres,0),0)-1000;
eddy_ist_anom=eddy_ist-woa_st;

save VOCALS_eddy_argo_prof.mat eddy_* *woa* nneg ppres lat lon ia ic sigma_* tpres

%}

clear
load VOCALS_eddy_argo_prof

xi=[-2.2:.2:2.2];
yi=xi;

[ac_sigma,ac_t,ac_s,ac_t_anom,ac_s_anom,ac_st_anom,ac_dh,ac_v,ac_u,...
cc_sigma,cc_t,cc_s,cc_t_anom,cc_s_anom,cc_st_anom,cc_dh,cc_v,cc_u,...
ac_u,ac_v,cc_u,cc_v,ac_spd,cc_spd,ac_crl,cc_crl]=deal(nan(length(xi),length(yi),length(ppres)));



fprintf('\r interpolating anticyclones')
for m=1:length(ppres);
	ac_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1,1,xi,yi);
	ac_t(:,:,m)=grid2d_loess(eddy_it(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1,1,xi,yi);
	ac_s(:,:,m)=grid2d_loess(eddy_is(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1,1,xi,yi);
	ac_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1,1,xi,yi);
	ac_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1,1,xi,yi);
	ac_st_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1,1,xi,yi);
end

fprintf('\r now interpolating cyclones')
	
for m=1:length(ppres);
	cc_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1,1,xi,yi);
	cc_t(:,:,m)=grid2d_loess(eddy_it(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1,1,xi,yi);
	cc_s(:,:,m)=grid2d_loess(eddy_is(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1,1,xi,yi);
	cc_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1,1,xi,yi);
	cc_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1,1,xi,yi);
	cc_st_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1,1,xi,yi);
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
load bwr.pal
load cha.pal
load chelle.pal

ipc=find(ppres==150);
ipa=find(ppres==400);

figure(30)
clf
%load /matlab/data/eddy/V4/full_tracks/air-sea_eio_lat_lon_tracks.mat lon lat nneg
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
contourf(xi,yi,squeeze(cc_t_anom(:,:,ipc)),[-2:.1:2]);axis image
shading flat
colormap(bwr)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])
title('cyclones 150 m')
ylabel('temperature anomaly')
colorbar
freezecolors
subplot(322)
contourf(xi,yi,squeeze(ac_t_anom(:,:,ipa)),[-2:.1:2]);axis image
shading flat
colormap(bwr)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])
title('anticyclones 400 m')
colorbar
freezecolors

subplot(323)
contourf(xi,yi,squeeze(100*cc_s_anom(:,:,ipc)),[-20:1:20]);axis image
shading flat
colormap(bwr)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])
ylabel('salinity anomaly')
colorbar
freezecolors
subplot(324)
contourf(xi,yi,squeeze(100*ac_s_anom(:,:,ipa)),[-20:1:20]);axis image
shading flat
colormap(bwr)
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
contourf(xi,-ppres,squeeze(ac_ss(flf,:,:))'-1000,[20:.1:30]);shading flat
hold on
line([0 0], [-1000 0])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of smoothed anticyclones')
caxis([24 28])
colorbar
subplot(122)
contourf(xi,-ppres,squeeze(cc_ss(flf,:,:))'-1000,[20:.1:30]);shading flat
hold on
line([0 0], [-1000 0])
caxis([24 28])
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
contourf(xi,-ppres,squeeze(ac_sigma(flf,:,:))'-1000,[20:.1:30]);shading flat
hold on
line([0 0], [-1000 0])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of anticyclones')
caxis([24 28])
colorbar
subplot(122)
contourf(xi,-ppres,squeeze(cc_sigma(flf,:,:))'-1000,[20:.1:30]);shading flat
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
