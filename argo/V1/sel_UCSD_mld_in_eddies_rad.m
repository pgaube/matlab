%
clear all
load /matlab/matlab/argo/UCSD_mld


startjd=2448910; %from mid_week_jdays of eddy files
endjd=2454804;
jdays=startjd:7:endjd;

tt=find(pjday>=startjd-3 & pjday<=endjd);
pjday=pjday(tt);
plat=plat(tt);
plon=plon(tt);
load /matlab/data/eddy/V4/global_tracks_V4

[eddy_dist_x,eddy_dist_y,eddy_id,eddy_pjday,eddy_scale]=deal(nan(length(plat),1));


%
pp=1;
%now go through each float and find out if it is in an eddy
%

lap=length(jdays);

total_number_of_float=lap
n=1;
pl=1;

for m=n:lap
	%interp pjday to closest week
	tmpj=find(pjday>=jdays(m)-3 & pjday<=jdays(m)+3);
	m
	if any(tmpj)
		kk=find(track_jday==jdays(m));
		tmp_x=x(kk);
		tmp_y=y(kk);
		tmp_id=id(kk);
		tmp_scale=scale(kk);
		tmp_plat=plat(tmpj);
		tmp_plon=plon(tmpj);
		for dd=1:length(tmpj)
			dist_x=(111.11*(tmp_plon(dd)-tmp_x).*cosd(tmp_y))./tmp_scale;
			dist_y=(111.11*(tmp_plat(dd)-tmp_y))./tmp_scale;
			dist=sqrt(dist_x.^2+dist_y.^2);
			ii=find(dist==min(dist));
			eddy_pjday(pl)=jdays(m);
			eddy_dist_x(pl)=dist_x(ii);
			eddy_dist_y(pl)=dist_y(ii);
			eddy_id(pl)=tmp_id(ii);
			eddy_scale(pl)=tmp_scale(ii);
			pl=pl+1;
		end
	end
end	

fprintf('\n')

save eddy_UCSD_mld_index_rad eddy_*
    