%
clear all
load eddy_argo_prof_index_rad

load /matlab/data/eddy/V4/full_tracks/chaigneau_lat_lon_tracks id nneg lon lat

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

na=length(find(eddy_id>=nneg));
nc=length(find(eddy_id<nneg));
figure(3)
clf
%lat=min(eddy_y(:)):max(eddy_y(:));
%lon=min(eddy_x(:)):max(eddy_x(:));
pmap(lon,lat,nan(length(lat),length(lon)))
hold on
ii=find(eddy_id>=nneg)
for m=1:length(ii)
	m_plot(eddy_x(m),eddy_y(m),'r.')
end
ii=find(eddy_id<nneg)
for m=1:length(ii)
	m_plot(eddy_x(m),eddy_y(m),'b.')
end
title([num2str(na),' profiles in AC and ',num2str(nc),' profiles in CC'])
drawnow
%
[eddy_t,eddy_s,eddy_p,eddy_st]=deal(nan(length(eddy_id),600));

ppres=[0:10:1000]';
[eddy_ist]=deal(nan(length(eddy_id),length(ppres)));


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
		tt=sw_dens(s',sw_ptmp(s',t',pres',0),0)-1000;
		[tt,fr]=filter_sigma(3,tt);
		pres(~fr)=[];
		t(~fr)=[];
		s(~fr)=[];
		tt(~fr)=[];
				 
		 ii=length(find(isnan(tt)));
		 if length(tt)>ii
			 eddy_t(pp,1:length(t))=t';
			 eddy_s(pp,1:length(t))=s';
			 eddy_st(pp,1:length(t))=tt;
			 eddy_p(pp,1:length(t))=pres';
			 fr=find(isnan(pres));
			 pres(fr)=[];
			 t(fr)=[];
			 s(fr)=[];
			 tt(fr)=[];
			 eddy_ist(pp,:)=interp1(pres',tt,ppres,'linear');
			 %{
			 figure(10)
			 clf
			 plot(eddy_ist(pp,:),-ppres,'g')
			 pause(.1)
			 
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

save VOCALS_eddy_argo_prof.mat eddy_*

dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);
sig_dist=dist;
sig_dist(eddy_dist_x<0)=-sig_dist(eddy_dist_x<0);

psig_dist=sig_dist';
eddy_ist=eddy_ist';
whos psig_dist sig_dist eddy_ist
xi=[-2:.125:2];

ii=find(eddy_id>=nneg);
ac_sigma=smooth2d_loess(eddy_ist(:,ii),sig_dist(ii),ppres,1,30,xi,ppres);

ii=find(eddy_id<nneg);
cc_sigma=smooth2d_loess(eddy_ist(:,ii),sig_dist(ii),ppres,1,30,xi,ppres);

figure(2)
clf
subplot(121)
pcolor(xi,-ppres,ac_sigma);shading flat
hold on
contour(xi,-ppres,ac_sigma,[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([24 28])
subplot(122)
pcolor(xi,-ppres,cc_sigma);shading flat
hold on
contour(xi,-ppres,cc_sigma,[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([24 28])

save test_vert_ *ac* *cc* pres xi
