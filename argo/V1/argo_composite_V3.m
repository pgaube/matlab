%{
clear all
load eddy_argo_prof_index_rad

load /matlab/data/eddy/V4/full_tracks/chaigneau_lat_lon_tracks.mat id nneg lon lat
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

na=length(find(eddy_id>=nneg));
nc=length(find(eddy_id<nneg));

%{
figure(3)
clf
%lat=min(eddy_y(:)):max(eddy_y(:));
%lon=min(eddy_x(:)):max(eddy_x(:));
pmap(lon,lat,nan(length(lat),length(lon)))
hold on
ii=find(eddy_id>=nneg);
for m=1:length(ii)
	m_plot(eddy_x(ii(m)),eddy_y(ii(m)),'r.')
end
ii=find(eddy_id<nneg);
for m=1:length(ii)
	m_plot(eddy_x(ii(m)),eddy_y(ii(m)),'b.')
end
title([num2str(na),' profiles in AC and ',num2str(nc),' profiles in CC'])
drawnow
print -dpng -r300 figs/VOCALS_profile_map
%}
[eddy_t,eddy_s,eddy_p,eddy_st]=deal(nan(600,length(eddy_id)));


[eddy_ist,eddy_is,eddy_it]=deal(nan(length(ppres),length(eddy_id)));


lap=length(same_prof);
pp=1;
%progressbar('Checking Float')
for m=1:lap
	fprintf('\r checking float %6u or %6u found %6u good profiles \r',m,lap,pp)
	%now look to see if float is in eddy
    tmp=num2str(eddy_pfile{m});
	ff=find(tmp=='/');
	fname=tmp(ff(3)+1:length(tmp));
	if exist(['/data/argo/profiles/', fname])
		[blank,dumb,pres,s,t]=read_profiles(fname);

		fr=find(pres>2000);
		pres(fr)=[];
		t(fr)=[];
		s(fr)=[];
		fr=find(s<20 | s>50);
		pres(fr)=[];
		t(fr)=[];
		s(fr)=[];
		fr=find(t<0 | s>50);
		pres(fr)=[];
		t(fr)=[];
		s(fr)=[];
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
		tt=sw_dens(s',sw_ptmp(s',t',pres',0),0)-1000;
		[tt,fr]=filter_sigma(3,tt);
		pres(~fr)=[];
		t(~fr)=[];
		s(~fr)=[];
		tt(~fr)=[];
				 
		 ii=length(find(isnan(tt)));
		 if length(tt)>ii
			 eddy_t(1:length(t),pp)=t';
			 eddy_s(1:length(t),pp)=s';
			 eddy_st(1:length(t),pp)=tt;
			 eddy_p(1:length(t),pp)=pres';
			 fr=find(isnan(pres));
			 pres(fr)=[];
			 t(fr)=[];
			 s(fr)=[];
			 tt(fr)=[];
			 eddy_ist(:,pp)=interp1(pres',tt,ppres,'linear');
 			 eddy_is(:,pp)=interp1(pres',s,ppres,'linear');
			 eddy_it(:,pp)=interp1(pres',t,ppres,'linear');

			 %{
			 figure(10)
			 clf
			 plot(eddy_ist(pp,:),-ppres,'g')
			 pause(.1)
			 %
			 figure(1)
			 clf
			 subplot(131)
			 plot(eddy_st(pp,:),-eddy_p(pp,:),'g')
			 xlabel('\sigma_{\theta}')
			 axis([25 28 -1000 0])
			 subplot(132)
			 plot(eddy_t(pp,:),-eddy_p(pp,:),'r')
			 title(num2str(m))
			 xlabel('^\circ C')
			 axis([0 40 -1000 0])
			 subplot(133)
			 plot(eddy_s(pp,:),-eddy_p(pp,:))
			 xlabel('PSU')
			 axis([33 38 -1000 0])
			 eval(['print -dpng -r100 figs/test_profiles/frame_',num2str(m)])
			 %}
		 end	 
		
		 
	end			
	pp=pp+1;
end

fprintf('\n')

eddy_it_anom=eddy_it-t_woa;
eddy_is_anom=eddy_is-s_woa;

eddy_ist_anom=real(sw_dens(eddy_is_anom,sw_ptmp(eddy_is_anom,eddy_it_anom,ppres,0),0)-1000);

eddy_ga=sw_gpan(eddy_is,eddy_it,ppres);
eddy_gvel=sw_gvel(eddy_ga,eddy_x',eddy_y');

save VOCALS_eddy_argo_prof.mat eddy_* *woa* nneg ppres
%return
%}
load VOCALS_eddy_argo_prof
ff=find(abs(eddy_it_anom)>2);
eddy_it_anom(ff)=nan;
eddy_is_anom(ff)=nan;
eddy_ist_anom(ff)=nan;
eddy_it(ff)=nan;
eddy_is(ff)=nan;


dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);
sig_dist=dist;
sig_dist(eddy_dist_x<0)=-sig_dist(eddy_dist_x<0);


xi=[-2:.125:2];


y=pmean(eddy_y);
x=1000*pmean(eddy_scale)*.125;
f=f_cor(y);
ac_ga=sw_gpan(ac_s,ac_t,ppres);
bot_ga=ones(length(ppres),1)*ac_ga(end,:);
ac_ga=ac_ga-bot_ga;

ac_gvel= -(ac_ga(:,2:end)-ac_ga(:,1:end-1)) ./(f*x);
ac_gvel(:,length(ac_ga(1,:)))=nan*ac_gvel(:,1);


ii=find(eddy_id>=nneg);
ac_sigma=smooth2d_loess(eddy_ist(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);
ac_t=smooth2d_loess(eddy_it(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);
ac_s=smooth2d_loess(eddy_is(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);
ac_t_anom=smooth2d_loess(eddy_it_anom(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);
ac_s_anom=smooth2d_loess(eddy_is_anom(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);
ac_st_anom=smooth2d_loess(eddy_ist_anom(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);
%ac_gvel=smooth2d_loess(eddy_gvel(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);

ii=find(eddy_id<nneg);
cc_sigma=smooth2d_loess(eddy_ist(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);
cc_t_anom=smooth2d_loess(eddy_it_anom(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);
cc_s_anom=smooth2d_loess(eddy_is(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);
cc_s_anom=smooth2d_loess(eddy_is_anom(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);
cc_st_anom=smooth2d_loess(eddy_ist_anom(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);
%cc_gvel=smooth2d_loess(eddy_gvel(:,ii),sig_dist(ii),ppres,1,50,xi,ppres);


%}
load chelle.pal
figure(2)
clf
subplot(121)
pcolor(xi,-ppres,ac_sigma);shading flat
hold on
contour(xi,-ppres,ac_sigma,[20:.1:30],'k')
line([0 0], [-1000 0])
title('Density strucutre of anticyclones')
caxis([24 28])
colorbar
subplot(122)
pcolor(xi,-ppres,cc_sigma);shading flat
hold on
contour(xi,-ppres,cc_sigma,[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([24 28])
title('Density strucutre of cyclones')
cc=colorbar
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
colormap(chelle)
print -dpng -r300 figs/VOCALS_sigma_theta

figure(4)
clf
subplot(121)
pcolor(xi,-ppres,ac_t_anom);shading flat
hold on
contour(xi,-ppres,ac_sigma,[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
colorbar
title('Temperature anomalies of anticyclones')
subplot(122)
pcolor(xi,-ppres,cc_t_anom);shading flat
hold on
contour(xi,-ppres,cc_sigma,[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
load rwp.pal
colormap(rwp)
title('Temperature anomalies of cyclones')
cc=colorbar
axes(cc)
ylabel('^\circ C')
print -dpng -r300 figs/VOCALS_t_anom

figure(5)
clf
subplot(121)
pcolor(xi,-ppres,ac_s_anom);shading flat
hold on
contour(xi,-ppres,ac_sigma,[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.2 .2])
colorbar
title('Salinity anomalies of anticyclones')
subplot(122)
pcolor(xi,-ppres,cc_s_anom);shading flat
hold on
contour(xi,-ppres,cc_sigma,[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.2 .2])
load rwp.pal
colormap(rwp)
title('Salinity anomalies of cyclones')
cc=colorbar
axes(cc)
ylabel('PSU')
print -dpng -r300 figs/VOCALS_s_anom

figure(6)
clf
subplot(121)
pcolor(xi,-ppres,ac_st_anom);shading flat
hold on
contour(xi,-ppres,ac_sigma,[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.3 -.07])
colorbar
title('Density anomalies of anticyclones')
subplot(122)
pcolor(xi,-ppres,cc_gvel);shading flat
hold on
contour(xi,-ppres,cc_sigma,[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-10 10])
load rwp.pal
colormap(rwp)
title('Density anomalies of cyclones')
cc=colorbar
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
print -dpng -r300 figs/VOCALS_st_anom

return
figure(7)
clf
subplot(121)
pcolor(xi,-ppres,ac_gvel);shading flat
hold on
contour(xi,-ppres,ac_sigma,[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-10 10])
colorbar
title('Geostrophic velocity of anticyclones')
subplot(122)
pcolor(xi,-ppres,cc_st_anom);shading flat
hold on
contour(xi,-ppres,cc_sigma,[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.3 -.07])
load rwp.pal
colormap(rwp)
title('Geostrophic veloctiy of cyclones')
cc=colorbar
axes(cc)
ylabel('(cm s^{-1})')
print -dpng -r300 figs/VOCALS_vel
save test_vert_ *ac* *cc* ppres xi
