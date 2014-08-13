clear all
warning('off','all')
%{

load /matlab/data/eddy/V4/full_tracks/pCC_lat_lon_tracks.mat id nneg lon lat amp
%load /matlab/data/eddy/V4/full_tracks/chaigneau_lat_lon_tracks.mat id nneg lon lat amp
%load /matlab/data/eddy/V4/full_tracks/air-sea_eio_lat_lon_tracks.mat id nneg lon lat amp

fprintf('\r loading index')
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
%
%
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

for m=1:length(eddy_it(1,:))
	eddy_spice(:,m)=spice(ppres,eddy_it(:,m),eddy_is(:,m));
end

ii=find(eddy_spice(41,:)>=.05 & abs(eddy_dist_x)'<1 & abs(eddy_dist_y)'<1);

tmp_ids = unique(eddy_id(ii));
uc_ids = tmp_ids(find(tmp_ids>=nneg));
iu = sames(uc_ids,eddy_id);


tmp_ids = eddy_id(eddy_id>=nneg);
ii=sames(uc_ids,tmp_ids);
tmp_ids(ii)=nan;
uni_id=unique(tmp_ids);
ia = sames(uni_id,eddy_id);

ic=find(eddy_id<nneg);

ac_t_woa=nanmean(t_woa_tmp(:,ia),2);
ac_s_woa=nanmean(s_woa_tmp(:,ia),2);
uc_t_woa=nanmean(t_woa_tmp(:,iu),2);
uc_s_woa=nanmean(s_woa_tmp(:,iu),2);
cc_t_woa=nanmean(t_woa_tmp(:,ic),2);
cc_s_woa=nanmean(s_woa_tmp(:,ic),2);

save pCC_full_profile eddy_is eddy_it *woa* sigma_* ia ic iu

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

for m=1:length(eddy_it(1,:))
	eddy_spice(:,m)=spice(ppres,eddy_it(:,m),eddy_is(:,m));
end

ii=find(eddy_spice(41,:)>=.05 & abs(eddy_dist_x)'<1 & abs(eddy_dist_y)'<1);

tmp_ids = unique(eddy_id(ii));
uc_ids = tmp_ids(find(tmp_ids>=nneg));
iu = sames(uc_ids,eddy_id);


tmp_ids = eddy_id(eddy_id>=nneg);
ii=sames(uc_ids,tmp_ids);
tmp_ids(ii)=nan;
uni_id=unique(tmp_ids);
ia = sames(uni_id,eddy_id);

ic=find(eddy_id<nneg);

ac_t_woa=nanmean(t_woa_tmp(:,ia),2);
ac_s_woa=nanmean(s_woa_tmp(:,ia),2);
uc_t_woa=nanmean(t_woa_tmp(:,iu),2);
uc_s_woa=nanmean(s_woa_tmp(:,iu),2);
cc_t_woa=nanmean(t_woa_tmp(:,ic),2);
cc_s_woa=nanmean(s_woa_tmp(:,ic),2);

save pCC_full_trapped_profile eddy_is eddy_it *woa* sigma_* ia ic iu
%

%make mean of cores 
load pCC_full_trapped_profile
uc_it=eddy_it(:,iu);
uc_is=eddy_is(:,iu);

tbins=min(uc_it(:))+.1:.2:max(uc_it(:))-.1;
for m=1:length(tbins)-1
	ii=find(uc_it>=tbins(m) & uc_it<tbins(m+1));
	mean_t_uc(m)=nanmean(uc_it(ii));
	mean_s_uc(m)=nanmean(uc_is(ii));
	std_s_uc(m,:)=prctile(uc_is(ii),[25 75]);
	std_t_uc(m,:)=prctile(uc_it(ii),[25 75]);
end
mean_t_uc=smooth1d_loess(mean_t_uc,[1:length(tbins)-1],30,[1:length(tbins)-1]);
mean_s_uc=smooth1d_loess(mean_s_uc,[1:length(tbins)-1],30,[1:length(tbins)-1]);
std_s_uc(:,1)=smooth1d_loess(std_s_uc(:,1),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
std_s_uc(:,2)=smooth1d_loess(std_s_uc(:,2),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
std_t_uc(:,1)=smooth1d_loess(std_t_uc(:,1),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
std_t_uc(:,2)=smooth1d_loess(std_t_uc(:,2),[1:length(tbins)-1]',30,[1:length(tbins)-1]');

ac_it=eddy_it(:,ia);
ac_is=eddy_is(:,ia);

tbins=min(ac_it(:))+.1:.2:max(ac_it(:))-.1;
for m=1:length(tbins)-1
	ii=find(ac_it>=tbins(m) & ac_it<tbins(m+1));
	mean_t_ac(m)=nanmean(ac_it(ii));
	mean_s_ac(m)=nanmean(ac_is(ii));
	std_s_ac(m,:)=prctile(ac_is(ii),[25 75]);
	std_t_ac(m,:)=prctile(ac_it(ii),[25 75]);
end
mean_t_ac=smooth1d_loess(mean_t_ac,[1:length(tbins)-1],30,[1:length(tbins)-1]);
mean_s_ac=smooth1d_loess(mean_s_ac,[1:length(tbins)-1],30,[1:length(tbins)-1]);
std_s_ac(:,1)=smooth1d_loess(std_s_ac(:,1),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
std_s_ac(:,2)=smooth1d_loess(std_s_ac(:,2),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
std_t_ac(:,1)=smooth1d_loess(std_t_ac(:,1),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
std_t_ac(:,2)=smooth1d_loess(std_t_ac(:,2),[1:length(tbins)-1]',30,[1:length(tbins)-1]');

cc_it=eddy_it(:,ic);
cc_is=eddy_is(:,ic);

tbins=min(cc_it(:))+.1:.2:max(cc_it(:))-.1;
for m=1:length(tbins)-1
	ii=find(cc_it>=tbins(m) & cc_it<tbins(m+1));
	mean_t_cc(m)=nanmean(cc_it(ii));
	mean_s_cc(m)=nanmean(cc_is(ii));
	std_s_cc(m,:)=prctile(cc_is(ii),[25 75]);
	std_t_cc(m,:)=prctile(cc_it(ii),[25 75]);
end
mean_t_cc=smooth1d_loess(mean_t_cc,[1:length(tbins)-1],30,[1:length(tbins)-1]);
mean_s_cc=smooth1d_loess(mean_s_cc,[1:length(tbins)-1],30,[1:length(tbins)-1]);
std_s_cc(:,1)=smooth1d_loess(std_s_cc(:,1),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
std_s_cc(:,2)=smooth1d_loess(std_s_cc(:,2),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
std_t_cc(:,1)=smooth1d_loess(std_t_cc(:,1),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
std_t_cc(:,2)=smooth1d_loess(std_t_cc(:,2),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
	
save core_means mean_* std_*
%}

load pCC_raw_profiles
load pCC_full_profile
load core_means

sbad_a=length(find(~isnan(eddy_is(:,ia))));
tbad_a=length(find(~isnan(eddy_it(:,ia))));
sbad_u=length(find(~isnan(eddy_is(:,iu))));
tbad_u=length(find(~isnan(eddy_it(:,iu))));
sbad_c=length(find(~isnan(eddy_is(:,ic))));
tbad_c=length(find(~isnan(eddy_it(:,ic))));
repeats=5;



ac_it=eddy_it(:,iu);
ac_is=eddy_is(:,iu);

tbins=min(ac_it(:))+.1:.2:max(ac_it(:))-.1;
tbins=7:.2:max(ac_it(:))-.1;
for nn=1:length(ac_it(1,:))
	tag_a=0;
	for m=1:length(tbins)-1
		ii=find(ac_it(:,nn)>=tbins(m) & ac_it(:,nn)<tbins(m+1));
		jj=find(ac_is(ii,nn)<=std_s_uc(m,1) | ac_is(ii,nn)>=std_s_uc(m,2));
		tag_a=tag_a+length(jj);
	end	
	if tag_a>=round(.1*length(find(~isnan(ac_it(:,nn))))) & abs(eddy_dist_x(iu(nn))')<.5 & abs(eddy_dist_y(iu(nn))')<.5 
		ac_is(:,nn)=nan;
		ac_it(:,nn)=nan;
	end	
end


eddy_is(:,iu)=ac_is;
eddy_it(:,iu)=ac_it;

percent_s_retained=100*(length(find(~isnan(ac_is)))/sbad_u);
percent_t_retained=100*(length(find(~isnan(ac_it)))/tbad_u);

save pCC_tmp_prof_for_plot eddy_is eddy_it ppres iu ia ic tpres std_* sigma_* mean_* *woa*
load pCC_full_profile eddy_it eddy_is

figure(103)
clf
subplot(121)
plot(eddy_is(:,iu),eddy_it(:,iu),'color',[.5 .5 .5],'linewidth',.1)
hold on
plot(mean_s_uc,mean_t_uc,'c','linewidth',2)
plot(std_s_uc,std_t_uc,'k--')
plot(uc_s_woa,uc_t_woa,'k','linewidth',2)
axis([31 37 0 30])
xlabel('raw')
daspect([1 10 1])

load pCC_tmp_prof_for_plot eddy_it eddy_is
subplot(122)
plot(eddy_is(:,iu),eddy_it(:,iu),'color',[.5 .5 .5],'linewidth',.1)
hold on
plot(mean_s_uc,mean_t_uc,'c','linewidth',2)
plot(std_s_uc,std_t_uc,'k--')
plot(uc_s_woa,uc_t_woa,'k','linewidth',2)
axis([31 37 0 30])
xlabel('filtered')
title(['%T = ',num2str(percent_t_retained),'  %S = ',num2str(percent_s_retained)])
daspect([1 10 1])
drawnow


%ac

ac_it=eddy_it(:,ia);
ac_is=eddy_is(:,ia);

tbins=min(ac_it(:))+.1:.2:max(ac_it(:))-.1;
tbins=7:.2:max(ac_it(:))-.1;
for nn=1:length(ac_it(1,:))
	tag_a=0;
	for m=1:length(tbins)-1
		ii=find(ac_it(:,nn)>=tbins(m) & ac_it(:,nn)<tbins(m+1));
		jj=find(ac_is(ii,nn)<=std_s_ac(m,1) | ac_is(ii,nn)>=std_s_ac(m,2));
		tag_a=tag_a+length(jj);
	end	
	if tag_a>=round(.1*length(find(~isnan(ac_it(:,nn))))) & abs(eddy_dist_x(ia(nn))')<.5 & abs(eddy_dist_y(ia(nn))')<.5 
		ac_is(:,nn)=nan;
		ac_it(:,nn)=nan;
	end	
end


eddy_is(:,ia)=ac_is;
eddy_it(:,ia)=ac_it;

percent_s_retained=100*(length(find(~isnan(ac_is)))/sbad_a);
percent_t_retained=100*(length(find(~isnan(ac_it)))/tbad_a);

save pCC_tmp_prof_for_plot eddy_is eddy_it ppres ia ic tpres std_* sigma_* mean_* *woa*
load pCC_full_profile eddy_it eddy_is

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
daspect([1 10 1])

load pCC_tmp_prof_for_plot eddy_it eddy_is
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


%cc
ac_it=eddy_it(:,ic);
ac_is=eddy_is(:,ic);

tbins=min(ac_it(:))+.1:.2:max(ac_it(:))-.1;
tbins=5:.2:max(ac_it(:))-.1;
for nn=1:length(ac_it(1,:))
	tag_a=0;
	for m=1:length(tbins)-1
		ii=find(ac_it(:,nn)>=tbins(m) & ac_it(:,nn)<tbins(m+1));
		jj=find(ac_is(ii,nn)<=std_s_cc(m,1) | ac_is(ii,nn)>=std_s_cc(m,2));
		tag_a=tag_a+length(jj);
	end	
	if tag_a>=round(.1*length(find(~isnan(ac_it(:,nn))))) & abs(eddy_dist_x(ic(nn))')<.5 & abs(eddy_dist_y(ic(nn))')<.5 
		ac_is(:,nn)=nan;
		ac_it(:,nn)=nan;
	end	
end


eddy_is(:,ic)=ac_is;
eddy_it(:,ic)=ac_it;

percent_s_retained=100*(length(find(~isnan(ac_is)))/sbad_c);
percent_t_retained=100*(length(find(~isnan(ac_it)))/tbad_c);

save pCC_tmp_prof_for_plot eddy_is eddy_it ppres ia ic tpres std_* sigma_* mean_* *woa*
load pCC_full_profile eddy_it eddy_is

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
daspect([1 10 1])

load pCC_tmp_prof_for_plot eddy_it eddy_is
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

if(percent_s_retained<10 | percent_t_retained<10)
	break
	break
end	

eddy_it_anom=eddy_it-t_woa;
eddy_is_anom=eddy_is-s_woa;
eddy_ist=sw_dens(eddy_is,eddy_it,ppres)-1000;
woa_st=sw_dens(s_woa,t_woa,ppres)-1000;
eddy_ist_anom=eddy_ist-woa_st;

save pCC_eddy_argo_prof.mat eddy_* *woa* nneg ppres lat lon ia ic iu tpres
%save pCC_eddy_argo_prof.mat eddy_* *woa* nneg ppres lat lon ia ic tpres std_* sigma_* mean_*

%}

clear
load pCC_eddy_argo_prof
warning('off','all')
xi=[-2.2:.1:2.2];
yi=xi;

[ac_sigma,ac_t,ac_s,ac_t_anom,ac_s_anom,ac_st_anom,ac_dh,ac_v,ac_u,ac_spd,ac_crl,...
cc_sigma,cc_t,cc_s,cc_t_anom,cc_s_anom,cc_st_anom,cc_dh,cc_v,cc_u,cc_spd,cc_crl,...
uc_sigma,uc_t,uc_s,uc_t_anom,uc_s_anom,uc_st_anom,uc_dh,uc_v,uc_u,uc_spd,uc_crl]=deal(nan(length(xi),length(yi),length(ppres)));



fprintf('\r interpolating under current anticyclones')
for m=1:length(ppres);
	uc_sigma(:,:,m)=grid2d_loess(eddy_ist(m,iu)',eddy_dist_x(iu),eddy_dist_y(iu),2,2,xi,yi);
	uc_t(:,:,m)=grid2d_loess(eddy_it(m,iu)',eddy_dist_x(iu),eddy_dist_y(iu),2,2,xi,yi);
	uc_s(:,:,m)=grid2d_loess(eddy_is(m,iu)',eddy_dist_x(iu),eddy_dist_y(iu),2,2,xi,yi);
	uc_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,iu)',eddy_dist_x(iu),eddy_dist_y(iu),2,2,xi,yi);
	uc_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,iu)',eddy_dist_x(iu),eddy_dist_y(iu),2,2,xi,yi);
	uc_sigma_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,iu)',eddy_dist_x(iu),eddy_dist_y(iu),2,2,xi,yi);
end

fprintf('\r interpolating anticyclones')
for m=1:length(ppres);
	ac_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),2,2,xi,yi);
	ac_t(:,:,m)=grid2d_loess(eddy_it(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),2,2,xi,yi);
	ac_s(:,:,m)=grid2d_loess(eddy_is(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),2,2,xi,yi);
	ac_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),2,2,xi,yi);
	ac_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),2,2,xi,yi);
	ac_sigma_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),2,2,xi,yi);
end

fprintf('\r now interpolating cyclones')
	
for m=1:length(ppres);
	cc_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),2,2,xi,yi);
	cc_t(:,:,m)=grid2d_loess(eddy_it(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),2,2,xi,yi);
	cc_s(:,:,m)=grid2d_loess(eddy_is(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),2,2,xi,yi);
	cc_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),2,2,xi,yi);
	cc_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),2,2,xi,yi);
	cc_sigma_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),2,2,xi,yi);
end

save pCC_argo_3d ac_* cc_* uc_* ppres xi yi

%
fprintf('\r now calculating velocites')
load pCC_argo_3d
warning('off','all')
[X,Y,P]=meshgrid(xi,yi,ppres);
load pCC_eddy_argo_prof eddy_scale eddy_y
km_x=pmean(eddy_scale)*xi;
km_y=km_x';
ff=f_cor(pmean(eddy_y));

[ac_u,ac_v]=geostro_3d(ac_sigma,km_x,km_y,ppres,ff);
[cc_u,cc_v]=geostro_3d(cc_sigma,km_x,km_y,ppres,ff);
[uc_u,uc_v]=geostro_3d(uc_sigma,km_x,km_y,ppres,ff);


%
%
%
%ac_ss=sw_dens(ac_s,sw_ptmp(ac_s,ac_t,P,zeros(size(P))),zeros(size(P)))-1000;
%cc_ss=sw_dens(cc_s,sw_ptmp(cc_s,cc_t,P,zeros(size(P))),zeros(size(P)))-1000;
ac_ss=sw_dens(35*ones(size(ac_t)),ac_t,P)-1000;
cc_ss=sw_dens(35*ones(size(cc_t)),cc_t,P)-1000;
uc_ss=sw_dens(35*ones(size(uc_t)),uc_t,P)-1000;
%
%
%


[uc_u_t,uc_v_t]=geostro_3d(uc_ss,km_x,km_y,ppres,ff);
[ac_u_t,ac_v_t]=geostro_3d(ac_ss,km_x,km_y,ppres,ff);
[cc_u_t,cc_v_t]=geostro_3d(cc_ss,km_x,km_y,ppres,ff);


dx=1000*pmean(diff(km_x));
dy=1000*pmean(diff(km_y));


for m=1:length(ppres);
	uc_crl(:,:,m)=dfdy_m(uc_u(:,:,m),dy)-dfdx_m(uc_v(:,:,m),dy);
	ac_crl(:,:,m)=dfdy_m(ac_u(:,:,m),dy)-dfdx_m(ac_v(:,:,m),dy);
	cc_crl(:,:,m)=dfdy_m(cc_u(:,:,m),dy)-dfdx_m(cc_v(:,:,m),dy);
end	

uc_spd=sqrt(uc_u.^2+uc_v.^2);
ac_spd=sqrt(ac_u.^2+ac_v.^2);
cc_spd=sqrt(cc_u.^2+cc_v.^2);

save pCC_argo_3d -append  ac_* cc_* uc_* ppres xi yi

fprintf('\n')
return
plot_3d_3_type_comps


