
clear all
% 

%%
% %MIDLAT
%%%%
load tracks/midlat_tracks k x y id cyc track_jday age scale
ii=find(track_jday>=2452427 & track_jday<=2455159 & age>=12);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);

num_a=length(find(cyc==1))
num_c=length(find(cyc==-1))
[ssh_a,ssh_c]=comps(x,y,cyc,k,id,track_jday,scale,'ssh','~/data/eddy/V5/mat/AVISO_25_W_','n');

save GAUBE_midlat_ssh_comps
