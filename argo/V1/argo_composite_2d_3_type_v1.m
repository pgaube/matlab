clear all
warning('off','all')
fprintf('\r loading index')

load /matlab/data/eddy/V4/full_tracks/pCC_lat_lon_tracks.mat id nneg lon lat amp
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

eddy_dist_y=(111.11*(eddy_plat-eddy_y))./eddy_scale;
eddy_dist_x=((111.11*cosd(eddy_plat)).*(eddy_plon-eddy_x))./eddy_scale;

[y,eddy_month,d]=jd2jdate(eddy_pjday);
ppres=[0:10:1000]';
tpres=0:1000;

total_number_of_profiles=length(eddy_y)
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
	if exist(['/data/argo/profiles/', fname])
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
save pCC_raw_profiles tmp_* t_* eddy_* s_* tpres ppres lap nneg lat lon

fprintf('\r loading trapp index')
load eddy_argo_prof_index_trapped


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
ppres=[0:10:1000]';
tpres=0:1000;

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
save pCC_raw_trapped_profiles tmp_* t_* eddy_* s_* tpres ppres lap nneg lat lon
%}

load pCC_raw_profiles
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

save pCC_full_profile eddy_is eddy_it *woa* sigma_* ia ic
%}

%find CCUC profiles from spicyness
load pCC_full_profile

for m=1:length(eddy_it(1,:))
	eddy_spice(:,m)=spice(ppres,eddy_it(:,m),eddy_is(:,m));
	max_spice(m)=max(eddy_spice(40:end,m));
	min_spice(m)=min(eddy_spice(1:20,m));
end



ii=find(max_spice(ia)>=.05 & abs(eddy_dist_x(ia)')<.5 & abs(eddy_dist_y(ia))'<.5);

iu = sames(unique(eddy_id(ia(ii))),eddy_id);
uc_ids = unique(eddy_id(ia(ii)));
luc=length(uc_ids)

ii=find(max_spice(ia)<0.05 & abs(eddy_dist_x(ia)')<.5 & abs(eddy_dist_y(ia))'<.5);

io = sames(unique(eddy_id(ia(ii))),eddy_id);
oc_ids = unique(eddy_id(ia(ii)));
loc=length(oc_ids)

ii=find(min_spice(ic)<0 & abs(eddy_dist_x(ic)')<.5 & abs(eddy_dist_y(ic))'<.5);

icc = sames(unique(eddy_id(ic(ii))),eddy_id);
cc_ids = unique(eddy_id(ic(ii)));
lcc=length(cc_ids)


%eddy_is(:,bad_ac_ids)=nan;
%eddy_it(:,bad_ac_ids)=nan;
%%%

sbad_a=length(find(~isnan(eddy_is(:,ia))));
tbad_a=length(find(~isnan(eddy_it(:,ia))));
sbad_c=length(find(~isnan(eddy_is(:,ic))));
tbad_c=length(find(~isnan(eddy_it(:,ic))));
repeats=10;

%%%%%%
%UC
%%%%%%
for nor=1:repeats
	
	clear mean* std*
	eddy_it_core=eddy_it(:,iu);
	eddy_is_core=eddy_is(:,iu);
	
	fl=find(abs(eddy_dist_x(iu))'>1 | abs(eddy_dist_y(iu))'>1);
	eddy_it_core(:,fl)=nan;
	eddy_is_core(:,fl)=nan;
	
	
	uc_it=eddy_it;
	uc_is=eddy_is;
	uc_it(:,ic)=nan;
	uc_is(:,ic)=nan;
	
	tbins_a=7:.2:max(eddy_it_core(:))-.1;
	for m=1:length(tbins_a)-1
		ii=find(eddy_it_core>=tbins_a(m) & eddy_it_core<tbins_a(m+1));
		mean_t_ac(m)=nanmean(eddy_it_core(ii));
		mean_s_ac(m)=nanmean(eddy_is_core(ii));
		std_s_ac(m,:)=prctile(eddy_is_core(ii),[10 90]);
		std_t_ac(m,:)=prctile(eddy_it_core(ii),[10 90]);
	end
	
	std_s_ac(:,1)=smooth1d_loess(std_s_ac(:,1),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_s_ac(:,2)=smooth1d_loess(std_s_ac(:,2),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_t_ac(:,1)=smooth1d_loess(std_t_ac(:,1),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_t_ac(:,2)=smooth1d_loess(std_t_ac(:,2),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	
	mean_t_ac=smooth1d_loess(mean_t_ac,[1:length(tbins_a)-1],30,[1:length(tbins_a)-1]);
	mean_s_ac=smooth1d_loess(mean_s_ac,[1:length(tbins_a)-1],30,[1:length(tbins_a)-1]);
	
	for nn=1:length(uc_it(1,:))
		tag_a=0;
		for m=1:length(tbins_a)-1
			ii=find(uc_it(:,nn)>=tbins_a(m) & uc_it(:,nn)<tbins_a(m+1));
			jj=find(uc_is(ii,nn)<=std_s_ac(m,1) | uc_is(ii,nn)>=std_s_ac(m,2));
			tag_a=tag_a+length(jj);
		end	
		if length(find(uc_ids==eddy_id(nn)))==0
			if tag_a>=round(.1*length(find(~isnan(uc_it(:,nn))))) & abs(eddy_dist_x(nn)')<1 & abs(eddy_dist_y(nn)')<1
				uc_is(:,nn)=nan;
				uc_it(:,nn)=nan;
			end	
		end	
	end
	
	percent_s_retained=100*(length(find(~isnan(uc_is)))/sbad_a);
	percent_t_retained=100*(length(find(~isnan(uc_it)))/tbad_a);
		
	figure(101)
	clf
	subplot(121)
	plot(eddy_is(:,ia),eddy_it(:,ia),'color',[.5 .5 .5],'linewidth',.1)
	hold on
	plot(mean_s_ac,mean_t_ac,'c','linewidth',2)
	plot(std_s_ac,std_t_ac,'k--')
	plot(ac_s_woa,ac_t_woa,'k','linewidth',2)
	axis([31 37 0 30])
	xlabel('raw')
	title(['interation # ',num2str(nor)])
	daspect([1 10 1])
	
	subplot(122)
	plot(uc_is,uc_it,'color',[.5 .5 .5],'linewidth',.1)
	hold on
	plot(mean_s_ac,mean_t_ac,'c','linewidth',2)
	plot(std_s_ac,std_t_ac,'k--')
	plot(ac_s_woa,ac_t_woa,'k','linewidth',2)
	axis([31 37 0 30])
	xlabel('filtered')
	title(['%T = ',num2str(percent_t_retained),'  %S = ',num2str(percent_s_retained)])
	daspect([1 10 1])
	drawnow
	if(percent_s_retained<50 | percent_t_retained<50)
		break
		break
	end	
end

%%%%%%
%OC
%%%%%%
for nor=1:repeats
	
	clear mean* std*
	eddy_it_core=eddy_it(:,io);
	eddy_is_core=eddy_is(:,io);
	
	fl=find(abs(eddy_dist_x(io))'>1 | abs(eddy_dist_y(io))'>1);
	eddy_it_core(:,fl)=nan;
	eddy_is_core(:,fl)=nan;
	
	oc_it=eddy_it;
	oc_is=eddy_is;
	oc_it(:,ic)=nan;
	oc_is(:,ic)=nan;
	
	tbins_a=7:.2:max(eddy_it_core(:))-.1;
	for m=1:length(tbins_a)-1
		ii=find(eddy_it_core>=tbins_a(m) & eddy_it_core<tbins_a(m+1));
		mean_t_ac(m)=nanmean(eddy_it_core(ii));
		mean_s_ac(m)=nanmean(eddy_is_core(ii));
		std_s_ac(m,:)=prctile(eddy_is_core(ii),[10 90]);
		std_t_ac(m,:)=prctile(eddy_it_core(ii),[10 90]);
	end
	
	std_s_ac(:,1)=smooth1d_loess(std_s_ac(:,1),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_s_ac(:,2)=smooth1d_loess(std_s_ac(:,2),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_t_ac(:,1)=smooth1d_loess(std_t_ac(:,1),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_t_ac(:,2)=smooth1d_loess(std_t_ac(:,2),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	
	mean_t_ac=smooth1d_loess(mean_t_ac,[1:length(tbins_a)-1],30,[1:length(tbins_a)-1]);
	mean_s_ac=smooth1d_loess(mean_s_ac,[1:length(tbins_a)-1],30,[1:length(tbins_a)-1]);
	
	for nn=1:length(oc_it(1,:))
		tag_a=0;
		for m=1:length(tbins_a)-1
			ii=find(oc_it(:,nn)>=tbins_a(m) & oc_it(:,nn)<tbins_a(m+1));
			jj=find(oc_is(ii,nn)<=std_s_ac(m,1) | oc_is(ii,nn)>=std_s_ac(m,2));
			tag_a=tag_a+length(jj);
		end	
		%if length(find(oc_ids==eddy_id(nn)))==0
			if tag_a>=round(.1*length(find(~isnan(oc_it(:,nn))))) & abs(eddy_dist_x(nn)')<1 & abs(eddy_dist_y(nn)')<1
				oc_is(:,nn)=nan;
				oc_it(:,nn)=nan;
			end	
		%end	
	end
	
	percent_s_retained=100*(length(find(~isnan(oc_is)))/sbad_a);
	percent_t_retained=100*(length(find(~isnan(oc_it)))/tbad_a);
		
	figure(102)
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
	
	subplot(122)
	plot(oc_is,oc_it,'color',[.5 .5 .5],'linewidth',.1)
	hold on
	plot(mean_s_ac,mean_t_ac,'r','linewidth',2)
	plot(std_s_ac,std_t_ac,'k--')
	plot(ac_s_woa,ac_t_woa,'k','linewidth',2)
	axis([31 37 0 30])
	xlabel('filtered')
	title(['%T = ',num2str(percent_t_retained),'  %S = ',num2str(percent_s_retained)])
	daspect([1 10 1])
	drawnow
	if(percent_s_retained<50 | percent_t_retained<50)
		break
		break
	end	
end

%%%%%%
%CC
%%%%%%
for nor=1:repeats
	
	clear mean* std*
	eddy_it_core=eddy_it(:,ic);
	eddy_is_core=eddy_is(:,ic);
	
	fl=find(abs(eddy_dist_x(ic))'>1 | abs(eddy_dist_y(ic))'>1);
	eddy_it_core(:,fl)=nan;
	eddy_is_core(:,fl)=nan;
	
	cc_it=eddy_it;
	cc_is=eddy_is;
	cc_it(:,ia)=nan;
	cc_is(:,ia)=nan;
	
	tbins_a=7:.2:max(eddy_it_core(:))-.1;
	for m=1:length(tbins_a)-1
		ii=find(eddy_it_core>=tbins_a(m) & eddy_it_core<tbins_a(m+1));
		mean_t_ac(m)=nanmean(eddy_it_core(ii));
		mean_s_ac(m)=nanmean(eddy_is_core(ii));
		std_s_ac(m,:)=prctile(eddy_is_core(ii),[10 90]);
		std_t_ac(m,:)=prctile(eddy_it_core(ii),[10 90]);
	end
	
	std_s_ac(:,1)=smooth1d_loess(std_s_ac(:,1),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_s_ac(:,2)=smooth1d_loess(std_s_ac(:,2),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_t_ac(:,1)=smooth1d_loess(std_t_ac(:,1),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	std_t_ac(:,2)=smooth1d_loess(std_t_ac(:,2),[1:length(tbins_a)-1]',30,[1:length(tbins_a)-1]');
	
	mean_t_ac=smooth1d_loess(mean_t_ac,[1:length(tbins_a)-1],30,[1:length(tbins_a)-1]);
	mean_s_ac=smooth1d_loess(mean_s_ac,[1:length(tbins_a)-1],30,[1:length(tbins_a)-1]);
	
	for nn=1:length(cc_it(1,:))
		tag_a=0;
		for m=1:length(tbins_a)-1
			ii=find(cc_it(:,nn)>=tbins_a(m) & cc_it(:,nn)<tbins_a(m+1));
			jj=find(cc_is(ii,nn)<=std_s_ac(m,1) | cc_is(ii,nn)>=std_s_ac(m,2));
			tag_a=tag_a+length(jj);
		end	
		if length(find(cc_ids==eddy_id(nn)))==0
			if tag_a>=round(.1*length(find(~isnan(cc_it(:,nn))))) & abs(eddy_dist_x(nn)')<1 & abs(eddy_dist_y(nn)')<1
				cc_is(:,nn)=nan;
				cc_it(:,nn)=nan;
			end	
		end	
	end
	
	percent_s_retained=100*(length(find(~isnan(cc_is)))/sbad_c);
	percent_t_retained=100*(length(find(~isnan(cc_it)))/tbad_c);
		
	figure(103)
	clf
	subplot(121)
	plot(eddy_is(:,ic),eddy_it(:,ic),'color',[.5 .5 .5],'linewidth',.1)
	hold on
	plot(mean_s_ac,mean_t_ac,'b','linewidth',2)
	plot(std_s_ac,std_t_ac,'k--')
	plot(ac_s_woa,ac_t_woa,'k','linewidth',2)
	axis([31 37 0 30])
	xlabel('raw')
	title(['interation # ',num2str(nor)])
	daspect([1 10 1])
	
	subplot(122)
	plot(cc_is,cc_it,'color',[.5 .5 .5],'linewidth',.1)
	hold on
	plot(mean_s_ac,mean_t_ac,'b','linewidth',2)
	plot(std_s_ac,std_t_ac,'k--')
	plot(ac_s_woa,ac_t_woa,'k','linewidth',2)
	axis([31 37 0 30])
	xlabel('filtered')
	title(['%T = ',num2str(percent_t_retained),'  %S = ',num2str(percent_s_retained)])
	daspect([1 10 1])
	drawnow
	if(percent_s_retained<50 | percent_t_retained<50)
		break
		break
	end	
end

%start here
cc_ist=sw_dens(cc_is,cc_it,ppres)-1000;
oc_ist=sw_dens(oc_is,oc_it,ppres)-1000;
uc_ist=sw_dens(uc_is,uc_it,ppres)-1000;


save pCC_eddy_argo_prof_3_way.mat eddy_* *woa* nneg ppres lat lon io ia ic iu tpres cc_* uc_* oc_*
%}

clear
load pCC_eddy_argo_prof_3_way
warning('off','all')
step=.1;
ri=[0:step:2.2];
xi=-2.2:step:2.2;
dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);
sig_dist=dist;
sig_dist(eddy_dist_x<0)=-sig_dist(eddy_dist_x<0);

eddy_dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);

cent=find(abs(xi)<=2*step);



fprintf('\r interpolating UC anticyclones')
uc_sigma=smooth2d_loess(uc_ist(:,ia),sig_dist(ia),ppres,2,100,xi,ppres);

fprintf('\r interpolating OC anticyclones')
oc_sigma=smooth2d_loess(oc_ist(:,ia),sig_dist(ia),ppres,2,100,xi,ppres);

fprintf('\r interpolating cyclones')
cc_sigma=smooth2d_loess(cc_ist(:,ic),sig_dist(ic),ppres,1.5,100,xi,ppres);


save pCC_argo_2d_3_way uc_* cc_* oc_* ppres xi

%}
fprintf('\r now calculating velocites')
load pCC_argo_2d_3_way
warning('off','all')
load pCC_eddy_argo_prof eddy_scale eddy_y
km_x=pmean(eddy_scale)*xi;
ff=f_cor(pmean(eddy_y));

[oc_v]=geostro_2d(oc_sigma,km_x,ppres,ff);
[uc_v]=geostro_2d(uc_sigma,km_x,ppres,ff);
[cc_v]=geostro_2d(cc_sigma,km_x,ppres,ff);

figure(1)
clf
subplot(131)
contourf(xi,-ppres,uc_v,[-2:.01:2]);shading flat
hold on
contour(xi,-ppres,uc_v,[-.1 -.05],'k--')
contour(xi,-ppres,uc_v,[.05 .1],'k')
hold on
line([0 0], [-1000 0])
%line([-8 8],[-ppres(i_non_ac) -ppres(i_non_ac)],'color','k','linewidth',2,'linestyle','--')
caxis([-.2 .2])
%contour(xi,-ppres,ac_crl,[0 0],'k','linewidth',1)
cc=colorbar
axis([-2 2 -1000 0])
title('Geostrophic v velocity of UC anticyclones')

subplot(132)
contourf(xi,-ppres,oc_v,[-2:.01:2]);shading flat
hold on
contour(xi,-ppres,oc_v,[-.1 -.05],'k--')
contour(xi,-ppres,oc_v,[.05 .1],'k')
hold on
line([0 0], [-1000 0])
%line([-8 8],[-ppres(i_non_ac) -ppres(i_non_ac)],'color','k','linewidth',2,'linestyle','--')
caxis([-.2 .2])
%contour(xi,-ppres,ac_crl,[0 0],'k','linewidth',1)
cc=colorbar
axis([-2 2 -1000 0])
title('Geostrophic v velocity of OC anticyclones')

subplot(133)
contourf(xi,-ppres,cc_v,[-2:.01:2]);shading flat
hold on
contour(xi,-ppres,cc_v,[-.1 -.05],'k--')
contour(xi,-ppres,cc_v,[.05 .1],'k')
hold on
line([0 0], [-1000 0])
%line([-8 8],[-ppres(i_non_cc) -ppres(i_non_cc)],'color','k','linewidth',2,'linestyle','--')
caxis([-.2 .2])
%contour(xi,-ppres,cc_crl,[0 0],'k','linewidth',1)
axis([-2 2 -1000 0])
%daspect([1 300 1])
title('Geostrophic v veloctiy of cyclones')
xlabel('contour of \nabla \times u = 0')

cc=colorbar;
axes(cc)

ylabel('(m s^{-1})')
fprintf('\n')

