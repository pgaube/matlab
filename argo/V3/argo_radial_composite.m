function argo_radial_composite(input_path,input_track_file)

warning('off','all')
%
fprintf('\r loading index - radial')

fname=[input_path input_track_file];

eval(['load ' fname ' id x y k']) 

%estimate prop speed (c)
uid=unique(id);
prop_speed=nan*uid;
for m=1:length(uid);
    ii=find(id==uid(m));
    xx=x(ii);
    yy=y(ii);
    kk=k(ii);
    dist_x=111.11*cosd(pmean(yy))*(xx(2:end)-xx(1:end-1));
    dist_y=111.11*(yy(2:end)-yy(1:end-1));
    dist=sqrt(dist_x.^2+dist_y.^2);
    prop_speed(m)=pmean(dist/7/24/60/60*1000*100);   
end    



%
%load ~/matlab/argo/v3/eddy_argo_prof_index_v5
load /matlab/matlab/argo/v1/eddy_argo_prof_index_v5
warning('off','all')
uid=unique(id);
same_prof=sames(uid,eddy_id);
eddy_pfile=eddy_pfile(same_prof);
eddy_pjday=eddy_pjday(same_prof);
eddy_id=eddy_id(same_prof);
eddy_scale=eddy_scale(same_prof);
eddy_dist_x=eddy_dist_x(same_prof);
eddy_dist_y=eddy_dist_y(same_prof);
eddy_x=eddy_x(same_prof);
eddy_y=eddy_y(same_prof);
eddy_plon=eddy_plon(same_prof);
eddy_plat=eddy_plat(same_prof);
eddy_axial_speed=eddy_axial_speed(same_prof);
eddy_cyc=eddy_cyc(same_prof);
eddy_pjday_round=eddy_pjday_round(same_prof);

[y,eddy_month,d]=jd2jdate(eddy_pjday);
ppres=[0:10:1000]';
tpres=0:1000;

total_number_of_profiles=length(eddy_y)

%{
ia=find(eddy_cyc==1);
ic=find(eddy_cyc==-1);
clf
subplot(311)
scatter(eddy_plon(ia),eddy_plat(ia),'r.')
subplot(312)
scatter(eddy_plon(ic),eddy_plat(ic),'b.')
subplot(313)
scatter(eddy_plon(ia),eddy_plat(ia),'r.')
hold on
scatter(eddy_plon(ic),eddy_plat(ic),'b.')
return
%}

%
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
    if ~exist(['/data/argo/profiles/', fname]) & fname(1)=='D'
        ftp_profile(eddy_pfile(m))
    end    
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

ia=find(eddy_cyc>0);
ic=find(eddy_cyc<0);
ac_t_woa=nanmean(t_woa_tmp(:,ia),2);
ac_s_woa=nanmean(s_woa_tmp(:,ia),2);
cc_t_woa=nanmean(t_woa_tmp(:,ic),2);
cc_s_woa=nanmean(s_woa_tmp(:,ic),2);



eddy_it_anom=eddy_it-t_woa;
eddy_is_anom=eddy_is-s_woa;
eddy_ist=sw_dens(eddy_is,eddy_it,ppres)-1000;
woa_st=sw_dens(s_woa,t_woa,ppres)-1000;
eddy_ist_anom=eddy_ist-woa_st;

warning('off','all')
step=.05;
ri=step:step:2;
km_x=pmean(eddy_scale)*ri;
ff=f_cor(pmean(eddy_y));

eddy_dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);

fprintf('\r interpolating anticyclones')
ac_sigma=smooth2d_loess(eddy_ist(:,ia),eddy_dist(ia)',ppres,2,100,ri,ppres);
ac_t=smooth2d_loess(eddy_it_anom(:,ia),eddy_dist(ia)',ppres,2,100,ri,ppres);
ac_s=smooth2d_loess(eddy_is_anom(:,ia),eddy_dist(ia)',ppres,2,100,ri,ppres);
[ac_v]=geostro_2d(ac_sigma,km_x,ppres,ff);

fprintf('\r now interpolating cyclones')
cc_sigma=smooth2d_loess(eddy_ist(:,ic),eddy_dist(ic)',ppres,2,100,ri,ppres);
cc_t=smooth2d_loess(eddy_it_anom(:,ic),eddy_dist(ic)',ppres,2,100,ri,ppres);
cc_s=smooth2d_loess(eddy_is_anom(:,ic),eddy_dist(ic)',ppres,2,100,ri,ppres);
[cc_v]=geostro_2d(cc_sigma,km_x,ppres,ff);


eval(['save ' input_track_file '_argo_dist_comp.mat ac_* cc_* ppres ri km_x ff eddy_dist ia ic prop_speed eddy_*'])
load chelle.pal
figure(1)
subplot(121)
pcolor(ri,ppres,ac_v);shading flat;axis ij;daspect([1 250 1])
caxis([-.30 .30])
subplot(122)
pcolor(ri,ppres,cc_v);shading flat;axis ij;daspect([1 250 1])
caxis([-.1 .1])
colormap(chelle)

