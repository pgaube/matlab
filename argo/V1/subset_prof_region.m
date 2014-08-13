clear all

location='GLOBAL'

load /Volumes/matlab/matlab/argo/anom_profiles
load /home/bettong/data2/data/argo/eddy_profiles plat plon pjday pT pP pS
load /home/bettong/data2/data/argo/eddy_argo_prof_index eddy*
load /Volumes/matlab/data/eddy/V4/global_tracks_V4 nneg
eval(['load /Volumes/matlab/matlab/domains/',location,'_lat_lon']);


r=find(plat>=min(lat) & plat<=max(lat) & ...
		plon>=min(lon) & plon<=max(lon) & ...
		eddy_amp>=4 & ...
		pjday >= 2452459 & pjday<= 2454489);

tlat=plat(r);
tlon=plon(r);
tjday=pjday(r);
tS=aS(r,:);
tT=aT(r,:);
tiS=ipS(r,:);
tiT=ipT(r,:);
ptS=pS(r,:);
ptT=pT(r,:);
stS=sS(r,:);
stT=sT(r,:);
tjday_round=eddy_pjday_round(r);
tid=eddy_id(r);
teid=eddy_eid(r);
tefold=eddy_efold(r);
tx=eddy_x(r);
ty=eddy_y(r);
tlon=eddy_plon(r);
tlat=eddy_plat(r);
tamp=eddy_amp(r);
tpfile=eddy_pfile(r);
tedge_ssh=eddy_edge_ssh(r);
taxial_speed=eddy_axial_speed(r);
tk=eddy_k(r);
tprop_speed=eddy_prop_speed(r);

eval(['save ',location,'_anom_prof t* pt* st* nneg z_prime'])



