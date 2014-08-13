


clear all
warning('off','all')
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
ppres=[0:10:1000]';
tpres=0:1000;

total_number_of_profiles=length(eddy_y)
%
%
[tmp_is,tmp_it,tmp_t,tmp_s,tmp_p]=deal(nan(length(tpres),length(eddy_id)));


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
tmp_it_anom=tmp_it-t_woa_tmp;
tmp_is_anom=tmp_is-s_woa_tmp;
tmp_woa_st=sw_dens(s_woa_tmp,t_woa_tmp,tpres')-1000;
tmp_st=sw_dens(tmp_is,tmp_it,tpres')-1000;
tmp_st_anom=tmp_st-tmp_woa_st;

save VOCALS_raw_profiles tmp_* t_* eddy_* s_* tpres ppres lap nneg lat lon
%}

%}
load VOCALS_raw_profiles
ia=find(eddy_id>=nneg);
ic=find(eddy_id<nneg);

sbad=length(find(~isnan(tmp_is)));
tbad=length(find(~isnan(tmp_it)));
repeats=5
for nor=1:repeats
	fprintf('\r filtering profiles using 3*sigma and percent of T/S dist, pass %02u of %02u',nor,repeats)
	tmp_it_anom=tmp_it-t_woa_tmp;
	tmp_is_anom=tmp_is-s_woa_tmp;
	clear sigma_it sigma_is
	for m=1:length(tpres)
		sigma_is(m)=pstd(tmp_is_anom(m,:));
		sigma_it(m)=pstd(tmp_it_anom(m,:));
	end
	%{
	for m=1:length(tpres)
		for n=1:length(tmp_it(1,:))
			if tmp_is_anom(m,n)<-3*sigma_is(m) | tmp_is_anom(m,n)>3*sigma_is(m)
				tmp_is(m,n)=nan;
			end
			if tmp_it_anom(m,n)<-3*sigma_it(m) | tmp_it_anom(m,n)>3*sigma_it(m)
				tmp_it(m,n)=nan;
			end
		end
	end

	%}
	tbins=min(tmp_it(:)):.2:max(tmp_it(:));
	clear mean* std*
	eddy_it_core=tmp_it;
	eddy_is_core=tmp_is;
	
	fl=find(abs(eddy_dist_x)>.25 | abs(eddy_dist_y)>.25);
	fl=find(eddy_dist_x>.5 | eddy_dist_y>.5);
	eddy_it_core(:,fl)=nan;
	eddy_is_core(:,fl)=nan;
	
	ac_it=eddy_it_core;
	ac_it(:,ic)=nan;
	cc_it=eddy_it_core;
	cc_it(:,ia)=nan;
	ac_is=eddy_is_core;
	ac_is(:,ic)=nan;
	cc_is=eddy_is_core;
	cc_is(:,ia)=nan;
	
	for m=1:length(tbins)-1
		ii=find(ac_it>=tbins(m) & ac_it<tbins(m+1));
		mean_t_ac(m)=nanmean(ac_it(ii));
		mean_s_ac(m)=nanmean(ac_is(ii));
		std_s_ac(m,:)=prctile(ac_is(ii),[15 99]);
		std_t_ac(m,:)=prctile(ac_it(ii),[15 99]);
	
		ii=find(cc_it>=tbins(m) & cc_it<tbins(m+1));
		mean_t_cc(m)=nanmean(cc_it(ii));
		mean_s_cc(m)=nanmean(cc_is(ii));
		std_s_cc(m,:)=prctile(cc_is(ii),[15 99]);
		std_t_cc(m,:)=prctile(cc_it(ii),[15 99]);
	end
	%15 95
	
	std_s_ac(:,1)=smooth1d_loess(std_s_ac(:,1),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
	std_s_ac(:,2)=smooth1d_loess(std_s_ac(:,2),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
	std_s_cc(:,1)=smooth1d_loess(std_s_cc(:,1),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
	std_s_cc(:,2)=smooth1d_loess(std_s_cc(:,2),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
	std_t_ac(:,1)=smooth1d_loess(std_t_ac(:,1),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
	std_t_ac(:,2)=smooth1d_loess(std_t_ac(:,2),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
	std_t_cc(:,1)=smooth1d_loess(std_t_cc(:,1),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
	std_t_cc(:,2)=smooth1d_loess(std_t_cc(:,2),[1:length(tbins)-1]',30,[1:length(tbins)-1]');
	
	mean_t_cc=smooth1d_loess(mean_t_cc,[1:length(tbins)-1],30,[1:length(tbins)-1]);
	mean_s_cc=smooth1d_loess(mean_s_cc,[1:length(tbins)-1],30,[1:length(tbins)-1]);
	mean_t_ac=smooth1d_loess(mean_t_ac,[1:length(tbins)-1],30,[1:length(tbins)-1]);
	mean_s_ac=smooth1d_loess(mean_s_ac,[1:length(tbins)-1],30,[1:length(tbins)-1]);
	
	clear ac_it ac_is cc_it cc_is
	ac_it=tmp_it;
	ac_it(:,ic)=nan;
	cc_it=tmp_it;
	cc_it(:,ia)=nan;
	ac_is=tmp_is;
	ac_is(:,ic)=nan;
	cc_is=tmp_is;
	cc_is(:,ia)=nan;
	
	for nn=1:length(tmp_it(1,:))
		tag_a=0;
		tag_c=0;
		for m=1:length(tbins)-1
			ii=find(ac_it(:,nn)>=tbins(m) & ac_it(:,nn)<tbins(m+1));
			jj=find(ac_is(ii,nn)<=std_s_ac(m,1) | ac_is(ii,nn)>=std_s_ac(m,2));
			tag_a=tag_a+length(jj);
			
			ii=find(cc_it(:,nn)>=tbins(m) & cc_it(:,nn)<tbins(m+1));
			jj=find(cc_is(ii,nn)<=std_s_cc(m,1) | cc_is(ii,nn)>=std_s_cc(m,2));
			tag_c=tag_c+length(jj);
		end
		if tag_c>=round(.4*length(find(~isnan(cc_it(:,nn))))) %| length(find(~isnan(cc_it(:,nn))))<30
			cc_is(:,nn)=nan;
			cc_it(:,nn)=nan;
		end	
		if tag_a>=round(.4*length(find(~isnan(ac_it(:,nn))))) %| length(find(~isnan(ac_it(:,nn))))<30
			ac_is(:,nn)=nan;
			ac_it(:,nn)=nan;
		end	
	end

	
	tmp_is(:,ia)=ac_is(:,ia);
	tmp_it(:,ia)=ac_it(:,ia);
	tmp_is(:,ic)=cc_is(:,ic);
	tmp_it(:,ic)=cc_it(:,ic);
	
	percent_s_retained=100*(length(find(~isnan(tmp_is)))/sbad)
	percent_t_retained=100*(length(find(~isnan(tmp_it)))/tbad)
	
	save VOCALS_tmp_prof_for_plot tmp_is tmp_it ppres ia ic tpres std_* sigma_* mean_* *woa*

	plot_profiles
	figure(101)
	title(['%T = ',num2str(percent_t_retained),'  %S = ',num2str(percent_s_retained)])
	drawnow

end


fprintf('\r interpolating final profiles')
[eddy_is,eddy_it,eddy_ist]=deal(nan(length(ppres),length(eddy_id)));
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

fprintf('\r interpolating WOA to float locations')
[t_woa,s_woa,z_woa]=WOA_profile(eddy_y,eddy_x,ppres,eddy_month);
warning('off','all')

eddy_it_anom=eddy_it-t_woa;
eddy_is_anom=eddy_is-s_woa;
eddy_ist=sw_dens(eddy_is,eddy_it,ppres)-1000;
woa_st=sw_dens(s_woa,t_woa,ppres)-1000;
eddy_ist_anom=eddy_ist-woa_st;


save VOCALS_eddy_argo_prof.mat eddy_* *woa* nneg ppres lat lon ia ic tpres std_* sigma_* mean_*

%}

clear
load VOCALS_eddy_argo_prof
warning('off','all')
xi=[-2.2:.2:2.2];
yi=xi;

[ac_sigma,ac_t,ac_s,ac_t_anom,ac_s_anom,ac_st_anom,ac_dh,ac_v,ac_u,...
cc_sigma,cc_t,cc_s,cc_t_anom,cc_s_anom,cc_st_anom,cc_dh,cc_v,cc_u,...
ac_u,ac_v,cc_u,cc_v,ac_spd,cc_spd,ac_crl,cc_crl]=deal(nan(length(xi),length(yi),length(ppres)));



fprintf('\r interpolating anticyclones')
for m=1:length(ppres);
	ac_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.75,1.75,xi,yi);
	ac_t(:,:,m)=grid2d_loess(eddy_it(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.75,1.75,xi,yi);
	ac_s(:,:,m)=grid2d_loess(eddy_is(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.75,1.75,xi,yi);
	ac_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.75,1.75,xi,yi);
	ac_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.75,1.75,xi,yi);
	ac_sigma_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.75,1.75,xi,yi);
end

fprintf('\r now interpolating cyclones')
	
for m=1:length(ppres);
	cc_sigma(:,:,m)=grid2d_loess(eddy_ist(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.75,1.75,xi,yi);
	cc_t(:,:,m)=grid2d_loess(eddy_it(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.75,1.75,xi,yi);
	cc_s(:,:,m)=grid2d_loess(eddy_is(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.75,1.75,xi,yi);
	cc_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.75,1.75,xi,yi);
	cc_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.75,1.75,xi,yi);
	cc_sigma_anom(:,:,m)=grid2d_loess(eddy_ist_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.75,1.75,xi,yi);
end

fprintf('\r now smoothing in vertical')
%{
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
		cc_sigma_anom(m,n,:)=smooth1d_loess(squeeze(cc_sigma_anom(m,n,:)),ppres,span_z,ppres);
		ac_sigma_anom(m,n,:)=smooth1d_loess(squeeze(ac_sigma_anom(m,n,:)),ppres,span_z,ppres);
	end
end	
%}
save VOCALS_argo_3d ac_* cc_* ppres xi yi

%
fprintf('\r now calculating velocites')
load VOCALS_argo_3d
warning('off','all')
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
%ac_ss=sw_dens(ac_s,sw_ptmp(ac_s,ac_t,P,zeros(size(P))),zeros(size(P)))-1000;
%cc_ss=sw_dens(cc_s,sw_ptmp(cc_s,cc_t,P,zeros(size(P))),zeros(size(P)))-1000;
ac_ss=sw_dens(35*ones(size(ac_t)),ac_t,P)-1000;
cc_ss=sw_dens(35*ones(size(cc_t)),cc_t,P)-1000;
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

plot_3d_comps


