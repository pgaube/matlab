clear
load /matlab/matlab/regions/tracks/tight/lw_tracks
load /matlab/matlab/argo/eddy_UCSD_mld_index
ii=sames(unique(id),eddy_id);
ex=eddy_x(ii);
ey=eddy_y(ii);
epx=eddy_plon(ii);
epy=eddy_plat(ii);
escale=eddy_scale(ii);
ecyc=eddy_cyc(ii);

jj=find(~isnan(ex));
ex=ex(jj);
ey=ey(jj);
epx=epx(jj);
epx=epx(jj);
escale=escale(jj);
ecyc=ecyc(jj);
dist_x=111.11*sqrt((ex-epx).^2).*cosd(ey);
dist_x=111.11*sqrt((ex-epx).^2).*cosd(ey);

clearallbut ex ey epx epy escale ecyc

ai=find(ecyc==1);
ci=find(ecyc==-1);

dist_x_c=


save 