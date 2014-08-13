clear all
close all
%{
load /Volumes/matlab/data/eddy/V4/global_tracks_V4 id eid x nneg y amp efold axial_speed track_jday prop_speed k
load /Volumes/matlab/matlab/domains/ID_eddy_lat_lon

f1=find(y>=min(lat) & y<=max(lat) & x>=min(lon) & x<=max(lon) & amp>=10);
id=id(f1);
eid=eid(f1);
x=x(f1);
y=y(f1);
amp=amp(f1);
axial_speed=axial_speed(f1);
efold=efold(f1);
track_jday=track_jday(f1);
prop_speed=prop_speed(f1);
k=k(f1);

save indian_tracks id eid x y amp efold axial_speed track_jday prop_speed k nneg

[indian_chl_a,indian_chl_c]=mcomps('indian_tracks','nrnbp21_chl_sample','n');
%[indian_car_a,indian_car_c]=mcomps('indian_tracks','nrbp26_car_sample','n');
[indian_wek_a,indian_wek_c]=mcomps('indian_tracks','nrw_ek_sample','n');
%[indian_cc_a,indian_cc_c]=mcomps('indian_tracks','nrbp26_cc_sample','n');
[indian_foi_a,indian_foi_c]=mcomps('indian_tracks','nrfiltered_sst_oi_sample','n');
[indian_wspd_a,indian_wspd_c]=mcomps('indian_tracks','nrbp26_wspd_sample','n');
save -append indian_comps indian*
return
%}

load indian_comps
zgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);
xi=xi(r,c);
yi=yi(r,c);
dist=sqrt(xi.^2+yi.^2);
dist=interp2(dist,2);
ii=find(dist<=1.5);




fnc=['indian_foi_c.N(r,c)'];
fmc=['indian_foi_c.n_max_sample'];
fbc=['indian_foi_c.median(r,c)'];
flc=['indian_foi_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc,'_bg',lab])	

fna=['indian_foi_a.N(r,c)'];
fma=['indian_foi_a.n_max_sample'];
fba=['indian_foi_a.median(r,c)'];
fla=['indian_foi_a'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla,'_bg',lab])	
return

fnc=['indian_wspd_c.N(r,c)'];
fmc=['indian_wspd_c.n_max_sample'];
fbc=['indian_wspd_c.median(r,c)'];
flc=['indian_wspd_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc,'_bg',lab])	

fna=['indian_wspd_a.N(r,c)'];
fma=['indian_wspd_a.n_max_sample'];
fba=['indian_wspd_a.median(r,c)'];
fla=['indian_wspd_a'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla,'_bg',lab])	
	


fnc=['indian_wek_c.N(r,c)'];
fmc=['indian_wek_c.n_max_sample'];
fbc=['indian_wek_c.median(r,c)'];
flc=['indian_wek_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc,'_bg',lab])	

fna=['indian_wek_a.N(r,c)'];
fma=['indian_wek_a.n_max_sample'];
fba=['indian_wek_a.median(r,c)'];
fla=['indian_wek_a'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla,'_bg',lab])	
%}
fnc=['indian_chl_c.N(r,c)'];
fmc=['indian_chl_c.n_max_sample'];
fbc=['indian_chl_c.median(r,c)'];
flc=['indian_chl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.03,.03,.002,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.03,.03,.002,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc,'_bg',lab])	

fna=['indian_chl_a.N(r,c)'];
fma=['indian_chl_a.n_max_sample'];
fba=['indian_chl_a.median(r,c)'];
fla=['indian_chl_a'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.03,.03,.002,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.03,.03,.002,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla,'_bg',lab])	
	
%{
fnc=['indian_car_c.N(r,c)'];
fmc=['indian_car_c.n_max_sample'];
fbc=['indian_car_c.median(r,c)'];
flc=['indian_car_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc,'_bg',lab])	

fna=['indian_car_a.N(r,c)'];
fma=['indian_car_a.n_max_sample'];
fba=['indian_car_a.median(r,c)'];
fla=['indian_car_a'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla,'_bg',lab])	
	
fnc=['indian_cc_c.N(r,c)'];
fmc=['indian_cc_c.n_max_sample'];
fbc=['indian_cc_c.median(r,c)'];
flc=['indian_cc_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.0003,.0003,.00002,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.0003,.0003,.00002,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc,'_bg',lab])	

fna=['indian_cc_a.N(r,c)'];
fma=['indian_cc_a.n_max_sample'];
fba=['indian_cc_a.median(r,c)'];
fla=['indian_cc_a'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.0003,.0003,.00002,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.0003,.0003,.00002,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla,'_bg',lab])		
%}