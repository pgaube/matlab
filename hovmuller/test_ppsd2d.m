clear
set_hovs
load gline_24_hov
m=24

dt=7; %days
dx=111.11*cosd(lat(m))*.25;


[S,f,k,CI] = ppsd2d(hp_hov,dt,dx,df,WIN)