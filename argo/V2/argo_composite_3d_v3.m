clear all
warning('off','all')
fprintf('\r loading index')

load /matlab/data/eddy/V4/full_tracks/LW_lat_lon_tracks.mat id nneg lon lat amp
%load /matlab/data/eddy/V4/full_tracks/chaigneau_lat_lon_tracks.mat id nneg lon lat amp
%load /matlab/data/eddy/V4/full_tracks/air-sea_eio_lat_lon_tracks.mat id nneg lon lat amp

%
load eddy_argo_prof_index

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
eddy_pjday_round=eddy_pjday_round(same_prof);


eddy_dist_y=(111.11*(eddy_plat-eddy_y))./eddy_scale;
eddy_dist_x=((111.11*cosd(eddy_plat)).*(eddy_plon-eddy_x))./eddy_scale;

[y,eddy_month,d]=jd2jdate(eddy_pjday);
ppres=[0:10:1000]';
tpres=0:1000;

total_number_of_profiles=length(eddy_y)
return
%
%{
%{
[tmp_is,tmp_it,tmp_ip,tmp_t,tmp_s,tmp_p]=deal(nan(length(tpres),length(eddy_id)));


lap=length(eddy_y);
pp=1;

fprintf('\r loading floats')
for m=1:lap
    tmp=num2str(eddy_pfile{m});
	ff=find(tmp=='/');
	fname=tmp(ff(3)+1:length(tmp));
	if exist(['/data/argo/profiles/', fname]) & fname(1)=='D'
		[blank,dumb,pres,s,t]=read_profiles(fname);
		tmp_t(1:length(t),m)=t';
		tmp_s(1:length(s),m)=s';
		tmp_p(1:length(pres),m)=pres';
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
save LW_raw_profiles tmp_* t_* eddy_* s_* tpres ppres lap nneg lat lon
%}

load LW_raw_profiles
warning('off','all')
repeats=3;
sbad=length(find(~isnan(tmp_s)));
tbad=length(find(~isnan(tmp_t)));
for der=1:repeats
	warning('off','all')
	fprintf('\r filtering profiles using 3*sigma, pass %02u of %02u',der,repeats)
	tmp_it_anom=tmp_it-t_woa_tmp;
	tmp_is_anom=tmp_is-s_woa_tmp;
	tmp_woa_st=sw_dens(s_woa_tmp,sw_ptmp(s_woa_tmp,t_woa_tmp,tpres',0),0)-1000;
	tmp_st=sw_dens(tmp_is,sw_ptmp(tmp_is,tmp_it,tpres',0),0)-1000;
	tmp_st_anom=tmp_st-tmp_woa_st;
	clear sigma_it sigma_is
	for m=1:length(tpres)
		sigma_ist(m)=pstd(tmp_st_anom(m,:));
		sigma_is(m)=pstd(tmp_is_anom(m,:));
		sigma_it(m)=pstd(tmp_it_anom(m,:));
	end
	
	round_pres=round(tmp_p);
	for m=1:length(tpres)
		for n=1:length(tmp_it(1,:))
			ii=find(round_pres(:,n)==tpres(m));
			if any(ii)
				if tmp_is_anom(m,n)<-3*sigma_is(m) | tmp_is_anom(m,n)>3*sigma_is(m)
					tmp_s(ii,n)=nan;
					flag_s(ii,n)=1;
				end
				if tmp_it_anom(m,n)<-3*sigma_it(m) | tmp_it_anom(m,n)>3*sigma_it(m)
					tmp_t(ii,n)=nan;
					flag_t(ii,n)=1;
				end
			end
		end
	end
	
	percent_s_retained(der)=100*(length(find(~isnan(tmp_s)))/sbad)
	percent_t_retained(der)=100*(length(find(~isnan(tmp_t)))/tbad)

	warning('off','all')
	for m=1:lap
		p=tmp_p(:,m);
		s=tmp_s(:,m);
		t=tmp_t(:,m);
		fr=find(isnan(p));
		p(fr)=[];
		t(fr)=[];
		s(fr)=[];
		dd=diff(p);
		fr=find(dd==0);
		p(fr)=[];
		t(fr)=[];
		s(fr)=[];
		fr=find(p==0);
		if length(fr>1)
			p(fr)=[];
			t(fr)=[];
			s(fr)=[];
		end	
		if length(s)>2
			tmp_is(:,m)=interp1(p,s,tpres,'linear');
		end
		if length(t)>2
			tmp_it(:,m)=interp1(p,t,tpres,'linear');
		end 
	end		
end
%

tmp_it_anom=tmp_it-t_woa_tmp;
tmp_is_anom=tmp_is-s_woa_tmp;
tmp_woa_st=sw_dens(s_woa_tmp,sw_ptmp(s_woa_tmp,t_woa_tmp,tpres',0),0)-1000;
tmp_st=sw_dens(tmp_is,sw_ptmp(tmp_is,tmp_it,tpres',0),0)-1000;
tmp_st_anom=tmp_st-tmp_woa_st;

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
	fr=find(p==0);
	if length(fr>1)
		p(fr)=[];
		t(fr)=[];
		s(fr)=[];
	end	
	if length(s)>2
		eddy_is(:,m)=interp1(p,s,ppres,'linear');
	end
	if length(t)>2
		eddy_it(:,m)=interp1(p,t,ppres,'linear');
	end
end

ia=find(eddy_id>=nneg);
ic=find(eddy_id<nneg);
ac_t_woa=nanmean(t_woa_tmp(:,ia),2);
ac_s_woa=nanmean(s_woa_tmp(:,ia),2);
cc_t_woa=nanmean(t_woa_tmp(:,ic),2);
cc_s_woa=nanmean(s_woa_tmp(:,ic),2);

save LW_full_profile eddy_is eddy_it *woa* sigma_* ia ic
%}

%find CCUC profiles from spicyness
load LW_full_profile


for m=1:length(eddy_it(1,:))
	eddy_spice(:,m)=spice(ppres,eddy_it(:,m),eddy_is(:,m));
	max_spice(m)=max(eddy_spice(40:end,m));
end



ii=find(max_spice(ia)>=.05 & abs(eddy_dist_x(ia)')<.5 & abs(eddy_dist_y(ia))'<.5);

iu = sames(unique(eddy_id(ia(ii))),eddy_id);
uc_ids = unique(eddy_id(ia(ii)));

sbad_a=length(find(~isnan(eddy_is(:,ia))));
tbad_a=length(find(~isnan(eddy_it(:,ia))));
sbad_c=length(find(~isnan(eddy_is(:,ic))));
tbad_c=length(find(~isnan(eddy_it(:,ic))));
repeats=10;


for nor=1:repeats
	
	clear mean* std*
	eddy_it_core=eddy_it(:,ia);
	eddy_is_core=eddy_is(:,ia);
	
	fl=find(abs(eddy_dist_x(ia))'>.5 | abs(eddy_dist_y(ia))'>.5);
	eddy_it_core(:,fl)=nan;
	eddy_is_core(:,fl)=nan;
	
	ac_it=eddy_it_core;
	ac_is=eddy_is_core;

	tbins_a=min(ac_it(:))+1:.2:max(ac_it(:))-1;
	for m=1:length(tbins_a)-1
		ii=find(ac_it>=tbins_a(m) & ac_it<tbins_a(m+1));
		mean_t_ac(m)=nanmean(ac_it(ii));
		mean_s_ac(m)=nanmean(ac_is(ii));
		std_s_ac(m,:)=prctile(ac_is(ii),[5 95]);
		std_t_ac(m,:)=prctile(ac_it(ii),[5 95]);
	end
	
	std_s_ac(:,1)=smooth1d_loess(std_s_ac(:,1),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_s_ac(:,2)=smooth1d_loess(std_s_ac(:,2),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_t_ac(:,1)=smooth1d_loess(std_t_ac(:,1),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_t_ac(:,2)=smooth1d_loess(std_t_ac(:,2),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	
	mean_t_ac=smooth1d_loess(mean_t_ac,[1:length(tbins_a)-1],30,[1:length(tbins_a)-1]);
	mean_s_ac=smooth1d_loess(mean_s_ac,[1:length(tbins_a)-1],30,[1:length(tbins_a)-1]);
	
	ac_it=eddy_it(:,ia);
	ac_is=eddy_is(:,ia);
	
	for nn=1:length(ac_it(1,:))
		tag_a=0;
		for m=1:length(tbins_a)-1
			ii=find(ac_it(:,nn)>=tbins_a(m) & ac_it(:,nn)<tbins_a(m+1));
			jj=find(ac_is(ii,nn)<=std_s_ac(m,1) | ac_is(ii,nn)>=std_s_ac(m,2));
			tag_a=tag_a+length(jj);
		end	
		%if length(find(uc_ids==eddy_id(ia(nn))))==0
			if tag_a>=round(.3*length(find(~isnan(ac_it(:,nn))))) & abs(eddy_dist_x(ia(nn))')<1 & abs(eddy_dist_y(ia(nn))')<1
				ac_is(:,nn)=nan;
				ac_it(:,nn)=nan;
			end	
		%end	
	end
	
	
	eddy_is(:,ia)=ac_is;
	eddy_it(:,ia)=ac_it;
	
	percent_s_retained=100*(length(find(~isnan(ac_is)))/sbad_a);
	percent_t_retained=100*(length(find(~isnan(ac_it)))/tbad_a);
	
	save LW_tmp_prof_for_plot eddy_is eddy_it ppres ia ic tpres std_* sigma_* mean_* *woa*
	load LW_full_profile eddy_it eddy_is
	
	figure(101)
	clf
	subplot(121)
	plot(eddy_is(:,ia),eddy_it(:,ia),'color',[.5 .5 .5],'linewidth',.1)
	hold on
	plot(mean_s_ac,mean_t_ac,'r','linewidth',2)
	plot(std_s_ac,std_t_ac,'k--')
	plot(ac_s_woa,ac_t_woa,'k','linewidth',2)
	axis([31 37 0 30])
	xlabel('raw')
	title(['interation # ',num2str(nor)])
	daspect([1 10 1])
	
	load LW_tmp_prof_for_plot eddy_it eddy_is
	subplot(122)
	plot(eddy_is(:,ia),eddy_it(:,ia),'color',[.5 .5 .5],'linewidth',.1)
	hold on
	plot(mean_s_ac,mean_t_ac,'r','linewidth',2)
	plot(std_s_ac,std_t_ac,'k--')
	plot(ac_s_woa,ac_t_woa,'k','linewidth',2)
	axis([31 37 0 30])
	xlabel('filtered')
	title(['%T = ',num2str(percent_t_retained),'  %S = ',num2str(percent_s_retained)])
	daspect([1 10 1])
	drawnow
	if(percent_s_retained<70 | percent_t_retained<70)
		break
		break
	end	
end

%
for nor=1:repeats
	
	clear mean* std*
	eddy_it_core=eddy_it(:,ic);
	eddy_is_core=eddy_is(:,ic);
	
	fl=find(abs(eddy_dist_x(ic))'>.5 | abs(eddy_dist_y(ic))'>.5);
	eddy_it_core(:,fl)=nan;
	eddy_is_core(:,fl)=nan;
	
	ac_it=eddy_it_core;
	ac_is=eddy_is_core;
	
	tbins_a=min(ac_it(:))+1:.2:max(ac_it(:))-1;	
	for m=1:length(tbins_a)-1
		ii=find(ac_it>=tbins_a(m) & ac_it<tbins_a(m+1));
		mean_t_cc(m)=nanmean(ac_it(ii));
		mean_s_cc(m)=nanmean(ac_is(ii));
		std_s_cc(m,:)=prctile(ac_is(ii),[5 95]);
		std_t_cc(m,:)=prctile(ac_it(ii),[5 95]);
	end
	
	std_s_cc(:,1)=smooth1d_loess(std_s_cc(:,1),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_s_cc(:,2)=smooth1d_loess(std_s_cc(:,2),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_t_cc(:,1)=smooth1d_loess(std_t_cc(:,1),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_t_cc(:,2)=smooth1d_loess(std_t_cc(:,2),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	
	mean_t_cc=smooth1d_loess(mean_t_cc,[1:length(tbins_a)-1],30,[1:length(tbins_a)-1]);
	mean_s_cc=smooth1d_loess(mean_s_cc,[1:length(tbins_a)-1],30,[1:length(tbins_a)-1]);
	
	ac_it=eddy_it(:,ic);
	ac_is=eddy_is(:,ic);
	
	for nn=1:length(ac_it(1,:))
		tag_a=0;
		for m=1:length(tbins_a)-1
			ii=find(ac_it(:,nn)>=tbins_a(m) & ac_it(:,nn)<tbins_a(m+1));
			jj=find(ac_is(ii,nn)<=std_s_cc(m,1) | ac_is(ii,nn)>=std_s_cc(m,2));
			tag_a=tag_a+length(jj);
		end	
		if tag_a>=round(.1*length(find(~isnan(ac_it(:,nn))))) & abs(eddy_dist_x(ic(nn))')<1 & abs(eddy_dist_y(ic(nn))')<1
			ac_is(:,nn)=nan;
			ac_it(:,nn)=nan;
		end	
	end
	
	
	eddy_is(:,ic)=ac_is;
	eddy_it(:,ic)=ac_it;
	
	percent_s_retained=100*(length(find(~isnan(ac_is)))/sbad_c);
	percent_t_retained=100*(length(find(~isnan(ac_it)))/tbad_c);
	
	save LW_tmp_prof_for_plot eddy_is eddy_it ppres ia ic tpres std_* sigma_* mean_* *woa*
	load LW_full_profile eddy_it eddy_is
	
	figure(102)
	clf
	subplot(121)
	plot(eddy_is(:,ic),eddy_it(:,ic),'color',[.5 .5 .5],'linewidth',.1)
	hold on
	plot(mean_s_cc,mean_t_cc,'b','linewidth',2)
	plot(std_s_cc,std_t_cc,'k--')
	plot(cc_s_woa,cc_t_woa,'k','linewidth',2)
	axis([31 37 0 30])
	xlabel('raw')
	title(['interation # ',num2str(nor)])
	daspect([1 10 1])
	
	load LW_tmp_prof_for_plot eddy_it eddy_is
	subplot(122)
	plot(eddy_is(:,ic),eddy_it(:,ic),'color',[.5 .5 .5],'linewidth',.1)
	hold on
	plot(mean_s_cc,mean_t_cc,'B','linewidth',2)
	plot(std_s_cc,std_t_cc,'k--')
	plot(cc_s_woa,cc_t_woa,'k','linewidth',2)
	axis([31 37 0 30])
	xlabel('filtered')
	title(['%T = ',num2str(percent_t_retained),'  %S = ',num2str(percent_s_retained)])
	daspect([1 10 1])
	drawnow
	
	if(percent_s_retained<70 | percent_t_retained<70)
		break
		break
	end	
end
%


eddy_it_anom=eddy_it-t_woa;
eddy_is_anom=eddy_is-s_woa;
eddy_ist=sw_dens(eddy_is,eddy_it,ppres)-1000;
woa_st=sw_dens(s_woa,t_woa,ppres)-1000;
eddy_ist_anom=eddy_ist-woa_st;

save LW_eddy_argo_prof.mat eddy_* *woa* nneg ppres lat lon ia ic tpres
%save LW_eddy_argo_prof.mat eddy_* *woa* nneg ppres lat lon ia ic tpres std_* sigma_* mean_*

%}

clear
load LW_eddy_argo_prof
warning('off','all')
step=.1;
xi=-2.2:step:2.2;
yi=xi;

fprintf('\r interpolating anticyclones')
for m=1:length(ppres);
	ac_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),3,3,xi,yi);
end

fprintf('\r now interpolating cyclones')
for m=1:length(ppres);
	cc_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),3,3,xi,yi);
end

span_z=500;
for m=1:length(xi)
	for n=1:length(yi)
		ac_sigma(m,n,:)=smooth1d_loess(squeeze(ac_sigma(m,n,:)),ppres,span_z,ppres);
		cc_sigma(m,n,:)=smooth1d_loess(squeeze(cc_sigma(m,n,:)),ppres,span_z,ppres);
	end
end	

fprintf('\r now calculating velocites')
warning('off','all')
[X,Y,P]=meshgrid(xi,yi,ppres);
load LW_eddy_argo_prof eddy_scale eddy_y
km_x=pmean(eddy_scale)*xi;
km_y=km_x';
ff=f_cor(pmean(eddy_y));

[ac_u,ac_v]=geostro_3d(ac_sigma,km_x,km_y,ppres,ff);
[cc_u,cc_v]=geostro_3d(cc_sigma,km_x,km_y,ppres,ff);

dx=1000*pmean(diff(km_x));
dy=1000*pmean(diff(km_y));

for m=1:length(ppres);
	ac_crl(:,:,m)=dfdx_m(ac_v(:,:,m),dx)-dfdy_m(ac_u(:,:,m),dy);
	cc_crl(:,:,m)=dfdx_m(cc_v(:,:,m),dx)-dfdy_m(cc_u(:,:,m),dy);
end	

ac_spd=sqrt(ac_u.^2+ac_v.^2);
cc_spd=sqrt(cc_u.^2+cc_v.^2);

save LW_argo_3d ac_* cc_* ppres xi xi yi

plot_3d_comps