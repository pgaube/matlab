%{
clear all
warning('off','all')
load eddy_argo_prof_index_rad

load /matlab/data/eddy/V4/full_tracks/chaigneau_lat_lon_tracks.mat id nneg lon lat
%load /matlab/data/eddy/V4/full_tracks/VOCALS_lat_lon_tracks.mat id nneg lon lat
%load /matlab/data/eddy/V4/VOCALS_lat_lon_tracks.mat id nneg lon lat
%load /matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks.mat id nneg lon lat

uid=unique(id);
same_prof=sames(uid,eddy_id);
save tmp_same_id same_prof
%load tmp_same_id

eddy_pfile=eddy_pfile(same_prof);
eddy_pjdays=eddy_pjday(same_prof);
eddy_id=eddy_id(same_prof);
eddy_scale=eddy_scale(same_prof);
eddy_dist_x=eddy_dist_x(same_prof);
eddy_dist_y=eddy_dist_y(same_prof);
eddy_x=eddy_x(same_prof);
eddy_y=eddy_y(same_prof);
[y,eddy_month,d]=jd2jdate(eddy_pjdays);
ppres=[0:10:1000]';

[t_woa,s_woa,z_woa]=WOA_profile(eddy_y,eddy_x,ppres,eddy_month);

[eddy_t,eddy_s,eddy_p,eddy_st]=deal(nan(600,length(eddy_id)));
[eddy_ist,eddy_is,eddy_it,eddy_dh]=deal(nan(length(ppres),length(eddy_id)));

lap=length(same_prof);
pp=1;

%{
%get missing profiles
fobj = ftp('www.usgodae.org')
cd(fobj,'pub/outgoing/argo/dac')
return
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

for m=1:lap
	fprintf('\r checking float %6u of %6u, found %6u good profiles ',m,lap,pp)
	%now look to see if float is in eddy
    tmp=num2str(eddy_pfile{m});
	ff=find(tmp=='/');
	fname=tmp(ff(3)+1:length(tmp));
	if exist(['/data/argo/profiles/', fname])
		[blank,dumb,pres,s,t]=read_profiles(fname);
		%if length(find(~isnan(pres)))>30 
		
		%check delt pres
		dp=diff(pres);
		dp(end+1)=1;
		ii=find(pres<100);
		fr=find(dp(ii)>25);
		dp(fr)=[];
		pres(fr)=[];
		t(fr)=[];
		s(fr)=[];
		ii=find(pres>=100 & pres<=300);
		fr=find(dp(ii)>50);
		dp(fr)=[];
		pres(fr)=[];
		t(fr)=[];
		s(fr)=[];
		ii=find(pres>300);
		fr=find(dp(ii)>150);
		dp(fr)=[];
		pres(fr)=[];
		t(fr)=[];
		s(fr)=[];
		
		%find too deep measurmets, and bad ones
		fr=find(pres>2000);
		pres(fr)=[];
		t(fr)=[];
		s(fr)=[];
		
		%screen for crazy sal values
		fr=find(s<20 | s>50);
		pres(fr)=[];
		t(fr)=[];
		s(fr)=[];
		
		%screen for crazy temp values
		fr=find(t<-10 | t>50);
		pres(fr)=[];
		t(fr)=[];
		s(fr)=[];
		
		%
		[tt,fr]=filter_sigma(3,t);
		pres(~fr)=[];
		t(~fr)=[];
		s(~fr)=[];
		tt(~fr)=[];
		[tt,fr]=filter_sigma(3,s);
		pres(~fr)=[];
		t(~fr)=[];
		s(~fr)=[];
		tt(~fr)=[];
		%
		tt=sw_dens(s,sw_ptmp(s,t,pres,0),0)-1000;

		 eddy_t(1:length(t),m)=t';
		 eddy_s(1:length(t),m)=s';
		 eddy_st(1:length(t),m)=tt;
		 eddy_p(1:length(t),m)=pres';
		 fr=find(isnan(pres));
		 pres(fr)=[];
		 t(fr)=[];
		 s(fr)=[];
		 tt(fr)=[];
		 if length(tt)>2
			eddy_ist(:,m)=interp1(pres,tt,ppres,'linear');
		 end
		 if length(s)>2
			eddy_is(:,m)=interp1(pres,s,ppres,'linear');
		 end
		 if length(t)>2
			eddy_it(:,m)=interp1(pres,t,ppres,'linear');
		 end
		 
		 for zz=length(ppres):-1:1
			eddy_dh(zz,m)=1e5*(nansum(sw_svan(eddy_is(zz:end,m),eddy_it(zz:end,m),ppres(zz:end))));
		 end
	
	
		 %{
		 figure(10)
		 clf
		 plot(eddy_ist(:,m),-ppres,'g')
		 pause(.1)
		 %
		 figure(1)
		 clf
		 subplot(131)
		 plot(eddy_ist(:,m),-ppres,'g')
		 xlabel('\sigma_{\theta}')
		 axis([25 28 -1000 0])
		 subplot(132)
		 plot(eddy_it(:,m),-ppres,'r')
		 title(num2str(m))
		 xlabel('^\circ C')
		 axis([0 40 -1000 0])
		 subplot(133)
		 plot(eddy_is(:,m),-ppres)
		 xlabel('PSU')
		 axis([33 38 -1000 0])
		 drawnow%pause(.1)
		 %eval(['print -dpng -r100 figs/test_profiles/frame_',num2str(m)])
		 %}
		 pp=pp+1;
		%end	 
	end			
	
end

fprintf('\n')

eddy_it_anom=eddy_it-t_woa;
eddy_is_anom=eddy_is-s_woa;

%filter based off of 25 and 75 percentil
%
for m=1:length(ppres)
%{
ff=3*prctile(eddy_it_anom(m,:),[25 75]);
ibad=find(eddy_it_anom(m,:)<=ff(1) | eddy_it_anom(m,:)>=ff(2));
eddy_it_anom(m,ibad)=nan;
eddy_is_anom(m,ibad)=nan;
eddy_it(m,ibad)=nan;
eddy_is(m,ibad)=nan;
eddy_ist(m,ibad)=nan;
%}
ff=3*prctile(eddy_is_anom(m,:),[25 75]);
ibad=find(eddy_is_anom(m,:)<=ff(1) | eddy_is_anom(m,:)>=ff(2));
eddy_it_anom(m,ibad)=nan;
eddy_is_anom(m,ibad)=nan;
eddy_it(m,ibad)=nan;
eddy_is(m,ibad)=nan;
eddy_ist(m,ibad)=nan;
end

eddy_ist_anom=real(sw_dens(eddy_is_anom,sw_ptmp(eddy_is_anom,eddy_it_anom,ppres,0),0)-1000);

warning('on','all')

save VOCALS_eddy_argo_prof.mat eddy_* *woa* nneg ppres
%
dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);
tt=nansum(eddy_ist,1);
ii=find(tt>0 & dist'<=2);
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
%}

%}
%
clear
load VOCALS_eddy_argo_prof

xi=[-2:.125:2];
yi=xi;

[ac_sigma,ac_t,ac_s,ac_t_anom,ac_s_anom,ac_st_anom,ac_comp_dh,ac_comp_v,ac_comp_u,...
cc_sigma,cc_t,cc_s,cc_t_anom,cc_s_anom,cc_st_anom,cc_comp_dh,cc_comp_v,cc_comp_u,...
ac_u,ac_v,cc_u,cc_v,ac_spd,cc_spd]=deal(nan(length(xi),length(yi),length(ppres)));

sp=1000*pmean(eddy_scale)*.125;
ff=f_cor(pmean(eddy_y));

ii=find(eddy_id>=nneg);
fprintf('\n interpolating anticyclones \r')
for m=1:length(ppres);
	ac_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	ac_t(:,:,m)=grid2d_loess(eddy_it(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	ac_s(:,:,m)=grid2d_loess(eddy_is(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	ac_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	ac_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	ac_st_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	ac_dh(:,:,m)=grid2d_loess(eddy_dh(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	ac_v(:,:,m)=dfdx_m(ac_dh(:,:,m),sp)./ff;
	ac_u(:,:,m)=-dfdy_m(ac_dh(:,:,m),sp)./ff;
end

fprintf('\n now interpolating cyclones \r')
	
ii=find(eddy_id<nneg);
for m=1:length(ppres);
	cc_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	cc_t(:,:,m)=grid2d_loess(eddy_it(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	cc_s(:,:,m)=grid2d_loess(eddy_is(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	cc_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	cc_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	cc_st_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	cc_dh(:,:,m)=grid2d_loess(eddy_dh(m,ii)',eddy_dist_x(ii),eddy_dist_y(ii),1,1,xi,yi);
	cc_v(:,:,m)=dfdx_m(cc_dh(:,:,m),sp)./ff;
	cc_u(:,:,m)=-dfdy_m(cc_dh(:,:,m),sp)./ff;
end

ac_spd=sqrt(ac_u.^2+ac_v.^2);
cc_spd=sqrt(cc_u.^2+cc_v.^2);
%
fprintf('\n now smoothing \r')

span_z=50;
span_x=1;
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
for m=1:length(xi)
for n=1:length(yi)
for zz=length(ppres):-1:1
	ac_comp_dh(m,n,zz)=(1e5*nansum(sw_svan(squeeze(ac_s(m,n,zz:101)),squeeze(ac_t(m,n,zz:101)),ppres(zz:101))));
end
end
end

for m=1:length(ppres)
	ac_comp_v(:,:,m)=dfdx_m(ac_comp_dh(:,:,m),sp)./ff;
	ac_comp_u(:,:,m)=-dfdy_m(ac_comp_dh(:,:,m),sp)./ff;
end

for m=1:length(xi)
for n=1:length(yi)
for zz=length(ppres):-1:1
	cc_comp_dh(m,n,zz)=(1e5*nansum(sw_svan(squeeze(cc_s(m,n,zz:101)),squeeze(cc_t(m,n,zz:101)),ppres(zz:101))));
end
end
end

for m=1:length(ppres)
	cc_comp_v(:,:,m)=dfdx_m(cc_comp_dh(:,:,m),sp)./ff;
	cc_comp_u(:,:,m)=-dfdy_m(cc_comp_dh(:,:,m),sp)./ff;
end	

%thermal wind method

numer=-9.8/1020/ff;
for m=1:length(ppres)
	ac_slope(:,:,m)=dfdx_m(ac_sigma(17,:,m),sp)./ff;
end
for zz=length(ppres):-1:1
	ac_comp_v_tw(zz,:)=numer*nansum(1000+ac_sigma(17,:,zz:101));
end

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
title('Temperature anomalies of cyclones')
cc=colorbar
axes(cc)
ylabel('^\circ C')
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
caxis([-.3 -.07])
colorbar
axis([-1.5 1.5 -1000 0])
title('Density anomalies of anticyclones')
subplot(122)
pcolor(xi,-ppres,squeeze(cc_st_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(cc_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.3 -.07])
load rwp.pal
colormap(chelle)
axis([-1.5 1.5 -1000 0])
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
title('Geostrophic veloctiy of cyclones')
cc=colorbar
axes(cc)
ylabel('(m s^{-1})')
print -dpng -r300 figs/VOCALS_vel
