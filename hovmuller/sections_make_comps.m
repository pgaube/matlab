
clear all
rgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);

set_hovs
%{

for m=[24 30 31]%1:length(lat)
set_hovs
lat=lat(m)-2:lat(m)+2;
lon=wlon(m):elon(m);
out_name=['section_' num2str(m) '_lat_lon'];
save(['/matlab/matlab/domains/' out_name],'lat','lon')
end

set_hovs
DPATH='/matlab/matlab/domains/';

for m=[24 30 31]%1:length(lat)
DOMAIN=['section_' num2str(m) '_lat_lon'];
load /matlab/data/eddy/V4/global_tracks_V4
load([DPATH,DOMAIN])

min_lon=min(lon(:));
max_lon=max(lon(:));
max_lat=max(lat(:));
min_lat=min(lat(:));

%subset by space
ii = find(x>=min_lon & x<=max_lon & y>=min_lat & y<=max_lat);

    
%Now subset data
id=id(ii);
eid=eid(ii);
x=x(ii);
y=y(ii);
gx=gx(ii);
gy=gy(ii);
amp=amp(ii);
axial_speed=axial_speed(ii);
efold=efold(ii);
scale=scale(ii);
radius=radius(ii);
track_jday=track_jday(ii);
prop_speed=prop_speed(ii);
k=k(ii);
edge_ssh=edge_ssh(ii);
day=day(ii);
month=month(ii);
year=year(ii);
unique_id=unique(id);
ai=find(id>=nneg);
ci=find(id<nneg);

save(['/matlab/matlab/hovmuller/tracks/section_' num2str(m) '_tracks'])
end

%

%
set_hovs
for m=[24 30 31]%1:length(lat)
%eval(['[section_' num2str(m) '_bp26_chl_old_a,section_' num2str(m) '_bp26_chl_old_c]=comps(' char(39) ...
%	  '/Volumes/matlab/matlab/hovmuller/tracks/section_' num2str(m) '_tracks' char(39) ',' char(39) 'nrbp26_chl_sample' char(39) ',' char(39) 'n' char(39) ');'])
%eval(['[section_' num2str(m) '_ssh_a,section_' num2str(m) '_ssh_c]=mcomps(' char(39) ...
%	  '/matlab/matlab/hovmuller/tracks/section_' num2str(m) '_tracks' char(39) ',' char(39) 'nrssh_sample' char(39) ',' char(39) 'n' char(39) ');'])
load(['/matlab/matlab/hovmuller/tracks/section_' num2str(m) '_tracks'])
eval(['[section_' num2str(m) '_bp26_chl_rot_N_c,section_' num2str(m) '_bp26_chl_rot_N_cc]=dir_clock_comps(id,track_jday,y,' ...
	   char(39) 'nrbp26_chl_sample' char(39) ',' char(39) 'N' char(39) ',' char(39) 't' char(39) ');'])
%eval(['[section_' num2str(m) '_wek_a,section_' num2str(m) '_wek_c]=mcomps(' char(39) ...
%	  '/matlab/matlab/hovmuller/tracks/section_' num2str(m) '_tracks' char(39) ',' char(39) 'nrw_ek_sample' char(39) ',' char(39) 'n' char(39) ');'])	  
%eval(['[section_' num2str(m) '_raw_bp26_chl_a,section_' num2str(m) '_raw_bp26_chl_c]=mcomps(' char(39) ...
%	  '/matlab/matlab/hovmuller/tracks/section_' num2str(m) '_tracks' char(39) ',' char(39) 'nrraw_bp26_chl_sample' char(39) ',' char(39) 'n' char(39) ');'])
%eval(['[section_' num2str(m) '_bp26_car_a,section_' num2str(m) '_bp26_car_c]=mcomps(' char(39) ...
%	  '/matlab/matlab/hovmuller/tracks/section_' num2str(m) '_tracks' char(39) ',' char(39) 'nrbp26_car_sample' char(39) ',' char(39) 'n' char(39) ');'])
%eval(['[section_' num2str(m) '_bp26_chl_a,section_' num2str(m) '_bp26_chl_c]=mcomps(' char(39) ...
%	  '/matlab/matlab/hovmuller/tracks/section_' num2str(m) '_tracks' char(39) ',' char(39) 'nrnbp26_chl_sample' char(39) ',' char(39) 'n' char(39) ');'])
%eval(['[section_' num2str(m) '_rot_bp26_chl_a,section_' num2str(m) '_rot_bp26_chl_c]=mcomps(' char(39) ...
%	  '/matlab/matlab/hovmuller/tracks/section_' num2str(m) '_tracks' char(39) ',' char(39) 'nrnbp26_chl_sample' char(39) ',' char(39) 't' char(39) ');'])
save -append section_trans_samp  
end
%
return
%}

set_hovs
load section_trans_samp
zgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);
xi=xi;
yi=yi;
dist=sqrt(xi.^2+yi.^2);
dist=interp2(dist,2);
ii=find(dist<=1.5);


for m=[24 30 31]%:length(lat)

%
fnc=['section_',num2str(m),'_bp26_chl_rot_N_c.N'];
fmc=['section_',num2str(m),'_bp26_chl_rot_N_c.n_max_sample'];
fbc=['section_',num2str(m),'_bp26_chl_rot_N_c.mean'];
flc=['section_',num2str(m),'_bp26_chl_rot_N_c_mean'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_2_2(tmp,tmp,-.04,.04,.01,-1,1,'CHL cyclones',...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])


fna=['section_',num2str(m),'_bp26_chl_rot_N_cc.N'];
fma=['section_',num2str(m),'_bp26_chl_rot_N_cc.n_max_sample'];
fba=['section_',num2str(m),'_bp26_chl_rot_N_cc.mean'];
fla=['section_',num2str(m),'_bp26_chl_rot_N_cc_mean'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_2_2(tmp,tmp,-.04,.04,.01,-1,1,'CHL anticyclones',...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])	
	
	
%{
fnc=['section_',num2str(m),'_ssh_c.N'];
fmc=['section_',num2str(m),'_ssh_c.n_max_sample'];
fbc=['section_',num2str(m),'_ssh_c.median'];
flc=['section_',num2str(m),'_ssh_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-5,5,.5,-10,10,'SSH cyclones',...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])


fna=['section_',num2str(m),'_ssh_a.N'];
fma=['section_',num2str(m),'_ssh_a.n_max_sample'];
fba=['section_',num2str(m),'_ssh_a.median'];
fla=['section_',num2str(m),'_ssh_a'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-5,5,.5,-10,10,'SSH anticyclones',...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
fnc=['section_',num2str(m),'_raw_bp26_chl_c.N'];
fmc=['section_',num2str(m),'_raw_bp26_chl_c.n_max_sample'];
fbc=['section_',num2str(m),'_raw_bp26_chl_c.median'];
flc=['section_',num2str(m),'_bp26_chl_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.005,.005,.001,-1,1,'raw CHL cyclones'...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.005,.005,.001,-1,1,'raw CHL cyclones'...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['section_',num2str(m),'_raw_bp26_chl_a.N'];
fma=['section_',num2str(m),'_raw_bp26_chl_a.n_max_sample'];
fba=['section_',num2str(m),'_raw_bp26_chl_a.median'];
fla=['section_',num2str(m),'_bp26_chl_a'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.005,.005,.001,-1,1,'raw CHL anticyclones'...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.005,.005,.001,-1,1,'raw CHL anticyclones'...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	
	

%
fnc=['section_',num2str(m),'_raw_bp26_chl_c.N'];
fmc=['section_',num2str(m),'_raw_bp26_chl_c.n_max_sample'];
fbc=['section_',num2str(m),'_raw_bp26_chl_c.median'];
flc=['section_',num2str(m),'_raw_bp26_chl_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.06,.06,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.06,.06,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['section_',num2str(m),'_raw_bp26_chl_a.N'];
fma=['section_',num2str(m),'_raw_bp26_chl_a.n_max_sample'];
fba=['section_',num2str(m),'_raw_bp26_chl_a.median'];
fla=['section_',num2str(m),'_raw_bp26_chl_a'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.06,.06,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.06,.06,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	

fnc=['section_',num2str(m),'_bp26_car_c.N'];
fmc=['section_',num2str(m),'_bp26_car_c.n_max_sample'];
fbc=['section_',num2str(m),'_bp26_car_c.median'];
flc=['section_',num2str(m),'_bp26_car_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['section_',num2str(m),'_bp26_car_a.N'];
fma=['section_',num2str(m),'_bp26_car_a.n_max_sample'];
fba=['section_',num2str(m),'_bp26_car_a.median'];
fla=['section_',num2str(m),'_bp26_car_a'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	
%
fnc=['section_',num2str(m),'_bp26_chl_c.N'];
fmc=['section_',num2str(m),'_bp26_chl_c.n_max_sample'];
fbc=['section_',num2str(m),'_bp26_chl_c.median'];
flc=['section_',num2str(m),'_bp21_chl_c_median'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,'CHL cyclones',...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])


fna=['section_',num2str(m),'_bp26_chl_a.N'];
fma=['section_',num2str(m),'_bp26_chl_a.n_max_sample'];
fba=['section_',num2str(m),'_bp26_chl_a.median'];
fla=['section_',num2str(m),'_bp21_chl_a_median'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,'CHL anticyclones',...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])	


fnc=['section_',num2str(m),'_bp26_chl_c.N'];
fmc=['section_',num2str(m),'_bp26_chl_c.n_max_sample'];
fbc=['section_',num2str(m),'_bp26_chl_c.median'];
fbq=['section_',num2str(m),'_wek_c.median'];
flc=['section_',num2str(m),'_bp26_chl_wek_c_median'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
eval(['tmp2 = double(interp2(',fbq,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp2,-.04,.04,.006,-1,.006,'CHL cyclones',...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['section_',num2str(m),'_bp26_chl_a.N'];
fma=['section_',num2str(m),'_bp26_chl_a.n_max_sample'];
fba=['section_',num2str(m),'_bp26_chl_a.median'];
fbq=['section_',num2str(m),'_wek_a.median'];
fla=['section_',num2str(m),'_bp26_chl_wek_a_median'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
eval(['tmp2 = double(interp2(',fbq,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp2,-.04,.04,.005,.1,1,'CHL anticyclones',...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])	
	
fna=['section_',num2str(m),'_wek_a.N'];
fma=['section_',num2str(m),'_wek_a.n_max_sample'];
fba=['section_',num2str(m),'_wek_a.median'];
fbq=['section_',num2str(m),'_bp26_chl_a.median'];
fla=['section_',num2str(m),'_wek_bp26_chl_a_median'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
eval(['tmp2 = double(interp2(',fbq,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp2,-.03,.03,.01,-1,1,'CHL anticyclones',...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])	
	
%}
end

%{

load section_trans_samp
r=1:41;
c=r;

for m=21:length(lat)
fnc=['section_',num2str(m),'_chl_c.N'];
fmc=['section_',num2str(m),'_chl_c.n_max_sample'];
fbc=['section_',num2str(m),'_chl_c.median'];
flc=['section_',num2str(m),'_chl_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
tmp=tmp./(max(tmp(:)));
cplot_comps_cont_3_3(tmp,tmp,-1.3,-.5,.5,-2,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])

fna=['section_',num2str(m),'_chl_a.N'];
fma=['section_',num2str(m),'_chl_a.n_max_sample'];
fba=['section_',num2str(m),'_chl_a.median'];
fla=['section_',num2str(m),'_chl_a'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=nan*ttt;
mask_maj=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
tmp=tmp./(max(tmp(:)));
cplot_comps_cont_3_3(tmp,tmp,-1.3,-.5,.5,-2,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	


end
%}
return
		
			

