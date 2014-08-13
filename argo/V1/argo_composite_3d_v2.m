%
clear all
warning('off','all')
fprintf('\r loading index')
load eddy_argo_prof_index_rad

load /matlab/data/eddy/V4/full_tracks/chaigneau_lat_lon_tracks.mat id nneg lon lat amp
%load /matlab/data/eddy/V4/full_tracks/roemmich_lat_lon_tracks.mat
%load /matlab/data/eddy/V4/full_tracks/VOCALS_lat_lon_tracks.mat id nneg lon lat amp
%load /matlab/data/eddy/V4/VOCALS_lat_lon_tracks.mat id nneg lon lat amp
%load /matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks.mat id nneg lon lat amp

%ii=find(amp>=4);
%id=id(ii);

uid=unique(id);
same_prof=sames(uid,eddy_id);
eddy_pfile=eddy_pfile(same_prof);
eddy_pjdays=eddy_pjday(same_prof);
eddy_id=eddy_id(same_prof);
eddy_scale=eddy_scale(same_prof);
eddy_dist_x=eddy_dist_x(same_prof);
eddy_dist_y=eddy_dist_y(same_prof);
eddy_x=eddy_x(same_prof);
eddy_y=eddy_y(same_prof);

dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);
same_prof=find(dist<=5);
eddy_pfile=eddy_pfile(same_prof);
eddy_pjdays=eddy_pjday(same_prof);
eddy_id=eddy_id(same_prof);
eddy_scale=eddy_scale(same_prof);
eddy_dist_x=eddy_dist_x(same_prof);
eddy_dist_y=eddy_dist_y(same_prof);
eddy_x=eddy_x(same_prof);
eddy_y=eddy_y(same_prof);
[y,eddy_month,d]=jd2jdate(eddy_pjdays);
ppres=[10:10:1000]';

tpres=10:1000;
total_number_of_profiles=length(eddy_y)
fprintf('\r interpolating WOA to float locations')
[t_woa,s_woa,z_woa]=WOA_profile(eddy_y,eddy_x,ppres,eddy_month);
[t_woa_tmp,s_woa_tmp,z_woa_tmp]=WOA_profile(eddy_y,eddy_x,tpres,eddy_month);


[eddy_t,eddy_s,eddy_p,eddy_st,tmp_s,tmp_t,tmp_p]=deal(nan(600,length(eddy_id)));
[eddy_ist,eddy_is,eddy_it,eddy_dh]=deal(nan(length(ppres),length(eddy_id)));
[tmp_is,tmp_it]=deal(nan(length(tpres),length(eddy_id)));


lap=length(eddy_y);
pp=1;

%{
%get missing profiles
fobj = ftp('www.usgodae.org')
cd(fobj,'pub/outgoing/argo/dac')
for m=1:lap
	%now look to see if float is in eddy
	tmp=num2str(eddy_pfile{m});
	jj=find(tmp=='/');
	fname=tmp(jj(3)+1:length(tmp));
	if ~exist(['/data/argo/profiles/', fname])
	v=dir(fobj,[tmp(1:jj(3)),tmp(jj(3)+1:length(tmp))]);
	if length(v)>0
		cd(fobj,tmp(1:jj(3)));
		mget(fobj,tmp(jj(3)+1:length(tmp)),'/data/argo/profiles/')
		cd(fobj,'/pub/outgoing/argo/dac');
	end	
	end
end	
close(fobj)
%}

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


tmp_it_anom=tmp_it-t_woa_tmp;
tmp_is_anom=tmp_is-s_woa_tmp;


fprintf('\r filtering profiles using 2*sigma')


ia=find(eddy_id>=nneg);
ic=find(eddy_id<nneg);
[flag_t,flag_s]=deal(zeros(size(tmp_it)));
s_good=length(find(~isnan(tmp_is_anom)));
t_good=length(find(~isnan(tmp_it_anom)));

for m=1:length(tpres)
	sigma_it_ac(m)=pstd(tmp_it_anom(m,ia));
	sigma_it_cc(m)=pstd(tmp_it_anom(m,ic));
	
	sigma_is_ac(m)=pstd(tmp_is_anom(m,ia));
	sigma_is_cc(m)=pstd(tmp_is_anom(m,ic));
end

figure(1)
clf
subplot(121)
plot(sigma_it_ac,-tpres,'r');
hold on
plot(sigma_it_cc,-tpres,'b');

subplot(122)
plot(sigma_is_ac,-tpres,'r');
hold on
plot(sigma_is_cc,-tpres,'b');
drawnow
round_pres=round(tmp_p);

for n=1:length(ia)
	for m=1:600
		ii=find(tpres==round_pres(m,ia(n)));
		if abs(tmp_it_anom(m,ia(n)))>3*sigma_it_ac(ii);
			tmp_t(m,ia(n))=nan;
			flag_t(m,ia(n))=1;
		end
		if abs(tmp_is_anom(m,ia(n)))>3*sigma_is_ac(ii)
			tmp_s(m,ia(n))=nan;
			flag_s(m,ia(n))=1;
		end
	end
end

for n=1:length(ic)
	for m=1:600
		ii=find(tpres==round_pres(m,ic(n)));
		if abs(tmp_it_anom(m,ic(n)))>3*sigma_it_cc(ii);
			tmp_t(m,ic(n))=nan;
			flag_t(m,ic(n))=1;
		end
		if abs(tmp_is_anom(m,ic(n)))>3*sigma_is_cc(ii)
			tmp_s(m,ic(n))=nan;
			flag_s(m,ic(n))=1;
		end
	end
end

percent_s_removed=100*(length(find(flag_s==1))/s_good)
percent_t_removed=100*(length(find(flag_t==1))/t_good)
warning('off','all')

fprintf('\r interpolating final profiles')
for m=1:lap
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
	if length(s)>2
		eddy_is(:,m)=interp1(p,s,ppres,'linear');
	end
	if length(t)>2
		eddy_it(:,m)=interp1(p,t,ppres,'linear');
	end 
	for zz=length(ppres):-1:1
		eddy_dh(zz,m)=1e5*(nansum(sw_svan(eddy_is(zz:end,m),eddy_it(zz:end,m),ppres(zz:end))));
	end
end

eddy_ist=sw_dens(eddy_is,sw_ptmp(eddy_is,eddy_it,ppres,0),0)-1000;
woa_st=sw_dens(s_woa,sw_ptmp(s_woa,t_woa,ppres,0),0)-1000;
eddy_ist_anom=eddy_ist-woa_st;
eddy_it_anom=eddy_it-t_woa;
eddy_is_anom=eddy_is-s_woa;

%
ii=find(abs(eddy_is_anom)>.2);
eddy_it(ii)=nan;
eddy_is(ii)=nan;
eddy_ist_anom(ii)=nan;
eddy_it_anom(ii)=nan;
eddy_is_anom(ii)=nan;
%}

tt=nansum(eddy_ist,1);
ii=find(tt>0);

for m=1:length(ii)
	 figure(1)
	 clf
	 %subplot(131)
	 %plot(eddy_st(pp,:),-eddy_p(pp,:),'g')
	 %xlabel('\sigma_{\theta}')
	 %axis([25 28 -1000 0])
	 subplot(121)
	 plot(eddy_it_anom(:,ii(m)),-ppres,'r')
	 title(num2str(m))
	 xlabel('^\circ C')
	 axis([-2 2 -1000 0])
	 subplot(122)
	 plot(eddy_is_anom(:,ii(m)),-ppres)
	 xlabel('PSU')
	 axis([-.2 .2 -1000 0])
	 drawnow
	 %eval(['print -dpng -r100 figs/test_profiles/frame_',num2str(m)])
	 %}
end	 
save VOCALS_eddy_argo_prof.mat eddy_* *woa* nneg ppres lat lon ia ic
%



%{
dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);
tt=nansum(eddy_ist,1);
ii=find(tt>0);
xx=eddy_x(ii);
yy=eddy_y(ii);
idid=eddy_id(ii);

figure(3)
clf
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
%
%
%
%}
clear
load VOCALS_eddy_argo_prof

xi=[-3:.125:3];
yi=xi;

[ac_sigma,ac_t,ac_s,ac_t_anom,ac_s_anom,ac_st_anom,ac_comp_dh,ac_comp_v,ac_comp_u,...
cc_sigma,cc_t,cc_s,cc_t_anom,cc_s_anom,cc_st_anom,cc_comp_dh,cc_comp_v,cc_comp_u,...
ac_u,ac_v,cc_u,cc_v,ac_spd,cc_spd]=deal(nan(length(xi),length(yi),length(ppres)));


sp=1000*pmean(eddy_scale)*pmean(diff(xi));
ff=f_cor(pmean(eddy_y));


fprintf('\n interpolating anticyclones \r')
for m=1:length(ppres);
	ac_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_t(:,:,m)=grid2d_loess(eddy_it(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_s(:,:,m)=grid2d_loess(eddy_is(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_st_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_dh(:,:,m)=grid2d_loess(eddy_dh(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_v(:,:,m)=dfdx_m(ac_dh(:,:,m),sp)./ff;
	ac_u(:,:,m)=-dfdy_m(ac_dh(:,:,m),sp)./ff;
end

fprintf('\n now interpolating cyclones \r')
	
for m=1:length(ppres);
	cc_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_t(:,:,m)=grid2d_loess(eddy_it(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_s(:,:,m)=grid2d_loess(eddy_is(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_st_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_dh(:,:,m)=grid2d_loess(eddy_dh(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_v(:,:,m)=dfdx_m(cc_dh(:,:,m),sp)./ff;
	cc_u(:,:,m)=-dfdy_m(cc_dh(:,:,m),sp)./ff;
end
%

%
fprintf('\n now smoothing \r')
%{
span_z=50;
span_x=1.5;
for m=1:length(xi)
	ac_sigma(m,:,:)=smooth2d_loess(squeeze(ac_sigma(m,:,:))',xi,ppres,span_x,span_z,xi,ppres)';
	ac_s(m,:,:)=smooth2d_loess(squeeze(ac_s(m,:,:))',xi,ppres,span_x,span_z,xi,ppres)';
	ac_t(m,:,:)=smooth2d_loess(squeeze(ac_t(m,:,:))',xi,ppres,span_x,span_z,xi,ppres)';
	ac_t_anom(m,:,:)=smooth2d_loess(squeeze(ac_t_anom(m,:,:))',xi,ppres,span_x,span_z,xi,ppres)';
	ac_s_anom(m,:,:)=smooth2d_loess(squeeze(ac_s_anom(m,:,:))',xi,ppres,span_x,span_z,xi,ppres)';
	ac_st_anom(m,:,:)=smooth2d_loess(squeeze(ac_st_anom(m,:,:))',xi,ppres,span_x,span_z,xi,ppres)';
	
	cc_sigma(m,:,:)=smooth2d_loess(squeeze(cc_sigma(m,:,:))',xi,ppres,span_x,span_z,xi,ppres)';
	cc_s(m,:,:)=smooth2d_loess(squeeze(cc_s(m,:,:))',xi,ppres,span_x,span_z,xi,ppres)';
	cc_t(m,:,:)=smooth2d_loess(squeeze(cc_t(m,:,:))',xi,ppres,span_x,span_z,xi,ppres)';
	cc_t_anom(m,:,:)=smooth2d_loess(squeeze(cc_t_anom(m,:,:))',xi,ppres,span_x,span_z,xi,ppres)';
	cc_s_anom(m,:,:)=smooth2d_loess(squeeze(cc_s_anom(m,:,:))',xi,ppres,span_x,span_z,xi,ppres)';
	cc_st_anom(m,:,:)=smooth2d_loess(squeeze(cc_st_anom(m,:,:))',xi,ppres,span_x,span_z,xi,ppres)';
end	
%}

%
for m=1:length(xi)
for n=1:length(yi)
for zz=length(ppres):-1:1
	ac_comp_dh(m,n,zz)=(1e5*nansum(sw_svan(squeeze(ac_s(m,n,zz:end)),squeeze(ac_t(m,n,zz:end)),ppres(zz:end))));
	ac_intg_sigma(m,n,zz)=10*nansum(ac_sigma(m,n,zz:end));
end
end
end

for m=1:length(ppres)
	ac_comp_v(:,:,m)=dfdx_m(ac_comp_dh(:,:,m),sp)./ff;
	ac_comp_u(:,:,m)=-dfdy_m(ac_comp_dh(:,:,m),sp)./ff;
	ac_sigma_v(:,:,m)=dfdx_m(ac_intg_sigma(:,:,m),sp)./ff;
	ac_sigma_u(:,:,m)=dfdy_m(ac_intg_sigma(:,:,m),sp)./ff;	
end

for m=1:length(xi)
for n=1:length(yi)
for zz=length(ppres):-1:1
	cc_comp_dh(m,n,zz)=(1e5*nansum(sw_svan(squeeze(cc_s(m,n,zz:end)),squeeze(cc_t(m,n,zz:end)),ppres(zz:end))));
	cc_intg_sigma(m,n,zz)=10*nansum(cc_sigma(m,n,zz:end));
end
end
end

for m=1:length(ppres)
	cc_comp_v(:,:,m)=dfdx_m(cc_comp_dh(:,:,m),sp)./ff;
	cc_comp_u(:,:,m)=-dfdy_m(cc_comp_dh(:,:,m),sp)./ff;
	cc_sigma_v(:,:,m)=dfdx_m(cc_intg_sigma(:,:,m),sp)./ff;
	cc_sigma_u(:,:,m)=dfdy_m(cc_intg_sigma(:,:,m),sp)./ff;	
end	
ac_spd=sqrt(ac_comp_u.^2+ac_comp_v.^2);
cc_spd=sqrt(cc_comp_u.^2+cc_comp_v.^2);


save VOCALS_argo_3d ac_* cc_* ppres xi yi
%}
clear
load VOCALS_argo_3d

%
load chelle.pal
figure(2)
clf
subplot(121)
pcolor(xi,-ppres,squeeze(ac_sigma(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(ac_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of anticyclones')
caxis([24 28])
colorbar
subplot(122)
pcolor(xi,-ppres,squeeze(cc_sigma(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(cc_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([24 28])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of cyclones')
cc=colorbar
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
colormap(chelle)
print -dpng -r300 figs/VOCALS_sigma_theta

figure(4)
clf
subplot(121)
pcolor(xi,-ppres,squeeze(ac_t_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(ac_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Temperature anomalies of anticyclones')
subplot(122)
pcolor(xi,-ppres,squeeze(cc_t_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(cc_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
load rwp.pal
colormap(chelle)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Temperature anomalies of cyclones')
cc=colorbar
axes(cc)
ylabel('^\circ C')
print -dpng -r300 figs/VOCALS_t_anom

figure(12)
clf
subplot(121)
pcolor(xi,-ppres,squeeze(ac_t_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,100*squeeze(ac_comp_v(17,:,:))',[4 8 12 16],'k')
contour(xi,-ppres,100*squeeze(ac_comp_v(17,:,:))',[-16 -12 -8 -4],'k--')
line([0 0], [-800 0])
caxis([-1.2 1.2])
colorbar
axis([-2.5 2.5 -800 0])
daspect([1 200 1])
title('Temperature anomalies of anticyclones')
subplot(122)
pcolor(xi,-ppres,squeeze(cc_t_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,100*squeeze(cc_comp_v(17,:,:))',[4 8 12 16],'k')
contour(xi,-ppres,100*squeeze(cc_comp_v(17,:,:))',[-16 -12 -8 -4],'k--')
line([0 0], [-800 0])
caxis([-1.2 1.2])
colorbar
axis([-2.5 2.5 -800 0])
daspect([1 200 1])
title('Temperature anomalies of cyclones')
cc=colorbar
axes(cc)
ylabel('^\circ C')
colormap(chelle)
print -dpng -r300 figs/VOCALS_t_anom


figure(5)
clf
subplot(121)
pcolor(xi,-ppres,squeeze(ac_s_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(ac_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Salinity anomalies of anticyclones')
subplot(122)
pcolor(xi,-ppres,squeeze(cc_s_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(cc_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(chelle)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Salinity anomalies of cyclones')
cc=colorbar
axes(cc)
ylabel('PSU')
print -dpng -r300 figs/VOCALS_s_anom

figure(6)
clf
subplot(121)
pcolor(xi,-ppres,squeeze(ac_st_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(ac_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density anomalies of anticyclones')
subplot(122)
pcolor(xi,-ppres,squeeze(cc_st_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(cc_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(chelle)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density anomalies of cyclones')
cc=colorbar
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
print -dpng -r300 figs/VOCALS_st_anom


figure(7)
clf
subplot(121)
pcolor(xi,-ppres,squeeze(ac_comp_v(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(ac_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic velocity of anticyclones')
subplot(122)
pcolor(xi,-ppres,squeeze(cc_comp_v(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(cc_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(chelle)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Geostrophic veloctiy of cyclones')
cc=colorbar
axes(cc)
ylabel('(m s^{-1})')
print -dpng -r300 figs/VOCALS_vel
warning('on','all')


figure(10)
clf
subplot(322)
pcolor(xi,-ppres,squeeze(ac_t_anom(17,:,:))');shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Temperature anomalies of anticyclones')
subplot(321)
pcolor(xi,-ppres,squeeze(cc_t_anom(17,:,:))');shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
load rwp.pal
colormap(chelle)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Temperature anomalies of cyclones')
cc=colorbar
axes(cc)
ylabel('^\circ C')

subplot(324)
pcolor(xi,-ppres,squeeze(ac_s_anom(17,:,:))');shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Salinity anomalies of anticyclones')
subplot(323)
pcolor(xi,-ppres,squeeze(cc_s_anom(17,:,:))');shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(chelle)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Salinity anomalies of cyclones')
cc=colorbar
axes(cc)
ylabel('PSU')

subplot(326)
pcolor(xi,-ppres,squeeze(ac_comp_v(17,:,:))');shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Geostrophic velocity of anticyclones')
subplot(325)
pcolor(xi,-ppres,squeeze(cc_comp_v(17,:,:))');shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(chelle)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Geostrophic veloctiy of cyclones')
cc=colorbar
axes(cc)
ylabel('(m s^{-1})')
print -dpng -r300 figs/VOCALS_chan_fig_5