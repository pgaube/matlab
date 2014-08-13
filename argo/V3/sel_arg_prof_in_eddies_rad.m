clear all
load argo_profile_index.mat pjday plat plon pfile


startjd=2448910; %from mid_week_jdays of eddy files
endjd=2455581;
jdays=startjd:7:endjd;

tt=find(pjday>=startjd-3 & pjday<=endjd+3);
pjday=pjday(tt);
plat=plat(tt);
plon=plon(tt);
pfile=pfile(tt);

tt=find(jdays>=min(pjday)&jdays<=max(pjday));
jdays=jdays(tt);
load /matlab/data/eddy/V5/global_tracks_V5
[eddy_cyc,eddy_plat,eddy_plon,eddy_pjday_round,eddy_k,eddy_dist_x,eddy_dist_y,eddy_id,eddy_pjday,eddy_scale,eddy_x,eddy_y,eddy_axial_speed,eddy_amp]=deal(nan(length(plat),1));
eddy_pfile=cell(length(plat),1);

tofar=0;
no_profile_day=0;
%
pp=1;
%now go through each float and find out if it is in an eddy
%

lap=length(jdays);

total_number_of_weeks=lap
n=1;
pl=1;

for m=n:lap
	%interp pjday to closest week
	fprintf('\r checking float %6u of %6u  \r',pl,length(plat))
	
	tmpj=find(pjday>=jdays(m)-3 & pjday<=jdays(m)+3);
	%round(pjday(tmpj(1)))
	kk=find(track_jday==jdays(m));
	%track_jday(kk(1))
	tmp_x=x(kk);
	tmp_y=y(kk);
    tmp_k=k(kk);
	tmp_id=id(kk);
    tmp_cyc=cyc(kk);
	tmp_axial_speed=axial_speed(kk);
    tmp_scale=scale(kk);
	tmp_plat=plat(tmpj);
	tmp_plon=plon(tmpj);
	tmp_pfile=pfile(tmpj);
    tmp_pjday=pjday(tmpj);
	for dd=1:length(tmpj)
		dist_x=(111.11*(tmp_plon(dd)-tmp_x).*cosd(tmp_y))./tmp_scale;
		dist_y=(111.11*(tmp_plat(dd)-tmp_y))./tmp_scale;
		dist=sqrt(dist_x.^2+dist_y.^2);
		
        ii=find(dist==min(dist));
		
        eddy_pjday_round(pl)=jdays(m);
        
        eddy_pjday(pl)=tmp_pjday(dd);
		eddy_pfile(pl)=tmp_pfile(dd);
        eddy_plon(pl)=tmp_plon(dd);
		eddy_plat(pl)=tmp_plat(dd);
		
        
		eddy_dist_x(pl)=dist_x(ii(1));
		eddy_dist_y(pl)=dist_y(ii(1));
        
        eddy_scale(pl)=tmp_scale(ii(1));
		eddy_id(pl)=tmp_id(ii(1));
        eddy_axial_speed(pl)=tmp_axial_speed(ii(1));
        eddy_k(pl)=tmp_k(ii(1));
        eddy_cyc(pl)=tmp_cyc(ii(1));
        eddy_x(pl)=tmp_x(ii(1));
		eddy_y(pl)=tmp_y(ii(1));
        
        
        
		
		pl=pl+1;
	end
end	

fprintf('\n')
ii=find(isnan(eddy_x));
eddy_x(ii)=[];
eddy_y(ii)=[];
eddy_id(ii)=[];
eddy_scale(ii)=[];
eddy_plat(ii)=[];
eddy_plon(ii)=[];
eddy_dist_x(ii)=[];
eddy_dist_y(ii)=[];
eddy_pjday(ii)=[];
eddy_pjday_round(ii)=[];
eddy_pfile(ii)=[];
eddy_cyc(ii)=[];


save eddy_argo_prof_index_rad.mat eddy_*
    
