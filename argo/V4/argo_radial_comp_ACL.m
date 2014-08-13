function argo_radial_composite_km(input_track_file,outname)

warning('off','all')
%
fprintf('\r loading index - ext')

fname=[input_track_file];

eval(['load ' fname ' id x y k']) 
%load(input_domain)
%dlat=lat;
%dlon=lon;

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
load ~/matlab/argo/v3/eddy_argo_prof_index_v5_fast
warning('off','all')
uid=unique(id);
same_prof=sames(uid,eddy_id);
% tsame=same_prof;
% 
% %now throw out those profiles that aren't in the domain
% for m=1:length(same_prof)
%     if eddy_plon(tsame(m))>max(lon) | eddy_plon(tsame(m))<min(lon) | eddy_plat(tsame(m))>max(lat) | eddy_plat(tsame(m))<min(lat) | sqrt(eddy_dist_x(m)^2+eddy_dist_y(m)^2)>2
%         same_prof(m)=nan;
%         %display(['outside domain lat = ',num2str(eddy_plat(tsame(m))),' lon = ',num2str(eddy_plon(tsame(m)))])
%     end
% end    
%       
same_prof(isnan(same_prof))=[];
eddy_pfile=eddy_pfile(same_prof);
eddy_pjday=eddy_pjday(same_prof);
eddy_enclosed=eddy_enclosed(same_prof);
eddy_amp=eddy_amp(same_prof);
eddy_eid=eddy_eid(same_prof);
eddy_id=eddy_id(same_prof);
eddy_scale=eddy_scale(same_prof);
eddy_dist_x=eddy_dist_x(same_prof);
eddy_dist_y=eddy_dist_y(same_prof);
eddy_dist_ext_x=eddy_dist_ext_x(same_prof);
eddy_dist_ext_y=eddy_dist_ext_y(same_prof);
eddy_ext_x=eddy_ext_x(same_prof);
eddy_ext_y=eddy_ext_y(same_prof);
eddy_x=eddy_x(same_prof);
eddy_y=eddy_y(same_prof);
eddy_plon=eddy_plon(same_prof);
eddy_ssh=eddy_ssh(same_prof);
eddy_plat=eddy_plat(same_prof);
eddy_axial_speed=eddy_axial_speed(same_prof);
eddy_cyc=eddy_cyc(same_prof);
eddy_pjday_round=eddy_pjday_round(same_prof);
eddy_qual=eddy_qual(same_prof);

[y,eddy_month,d]=jd2jdate(eddy_pjday);
ppres=[0:10:1000]';
tpres=0:1000;

total_number_of_profiles=length(eddy_y)

[eddy_is,eddy_it,eddy_ist]=deal(nan(length(ppres),length(eddy_id)));


lap=length(eddy_y);
pp=1;

fprintf('\r loading floats')
for m=1:lap
    tmp=num2str(eddy_pfile{m});
	ff=find(tmp=='/');
	fname=tmp(ff(3)+1:length(tmp));
    if ~exist(['~/data/argo/profiles/', fname]) & fname(1)=='D'
        %display(['ftping float ',num2str(m),' of ',num2str(lap),' total floats'])
        %ftp_profile(eddy_pfile(m));
        
    end    
	if exist(['~/data/argo/profiles/', fname]) & fname(1)=='D'
		clear pres s t
        [blank,dumb,pres,s,t]=read_profiles2(fname);
		
        if length(s)>2
            eddy_is(:,m)=interp1(pres,s,ppres,'linear');
            eddy_is(1,m)=eddy_is(2,m);
        end
        if length(t)>2
            eddy_it(:,m)=interp1(pres,t,ppres,'linear');
            eddy_it(1,m)=eddy_it(2,m);
        end
	end		
end



fprintf('\r interpolating WOA to float locations')
[t_woa,s_woa,z_woa]=ACL_profile(eddy_y,eddy_x,ppres,eddy_month);
warning('off','all')

ia=find(eddy_cyc==1);
ic=find(eddy_cyc==-1);

%make dh
eddy_dh=nan*eddy_it;
dh_woa=eddy_dh;
for m=1:length(eddy_x)
    eddy_dh(:,m)=sw_dh(eddy_is(:,m),eddy_it(:,m),ppres);
    dh_woa(:,m)=sw_dh(s_woa(:,m),t_woa(:,m),ppres);
    sigma_woa(:,m)=sw_dens(s_woa(:,m),t_woa(:,m),ppres)-1000;
end    

%make anoms
eddy_dh_anom=eddy_dh-dh_woa;
eddy_it_anom=eddy_it-t_woa;
eddy_is_anom=eddy_is-s_woa;
eddy_ist=sw_dens(eddy_is,eddy_it,ppres)-1000;
woa_st=sw_dens(s_woa,t_woa,ppres)-1000;
eddy_ist_anom=eddy_ist-woa_st;

old_rad_average_comps

eval(['save ' outname, '_argo_comp.mat ac_* cc_* *_woa ppres ri km_x step ff eddy_dist ia ic prop_speed nda ndc eddy_*'])
fprintf('\n')

