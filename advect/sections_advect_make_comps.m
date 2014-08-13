clear all
%
rgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);

set_advect


for m=1:length(lat)
set_advect
lat=lat(m)-2.5:lat(m)+2.5;
lon=wlon(m):elon(m);
out_name=['advect_section_' num2str(m) '_lat_lon'];
save(['/matlab/matlab/domains/' out_name],'lat','lon')
end

set_advect
DPATH='/matlab/matlab/domains/';

for m=1:length(lat)
set_advect
DOMAIN=['advect_section_' num2str(m) '_lat_lon'];
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

save(['/matlab/matlab/advect/tracks/advect_section_' num2str(m) '_tracks'])

end


set_advect
for m=[5 20 27 43 52]%1:length(lat)
eval(['[section_' num2str(m) '_a,section_' num2str(m) '_c]=mcomps_time_step(id,track_jday);'])	  
save -append advect_section_trans_samp	  
end

return
%}
%}

set_advect
load advect_section_trans_samp
zgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);
xi=xi(r,c);
yi=yi(r,c);
dist=sqrt(xi.^2+yi.^2);
dist=interp2(dist,2);
ii=find(dist<=1.5);


for m=1:length(lat)

fnc=['section_',num2str(m),'_bp26_mu_c.N(r,c)'];
fmc=['section_',num2str(m),'_bp26_mu_c.n_max_sample'];
fbc=['section_',num2str(m),'_bp26_mu_c.median(r,c)'];
flc=['section_',num2str(m),'_bp26_chl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
%cplot_comps_cont_3_3(tmp,tmp,-.03,.03,.005,-1,1,...
%	['~/Documents/OSU/figures/advect/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.004,-1,1,...
	['~/Documents/OSU/figures/advect/comps/',flc,'_bg',lab])	

fna=['section_',num2str(m),'_bp26_mu_a.N(r,c)'];
fma=['section_',num2str(m),'_bp26_mu_a.n_max_sample'];
fba=['section_',num2str(m),'_bp26_mu_a.median(r,c)'];
fla=['section_',num2str(m),'_bp26_chl_a'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
%cplot_comps_cont_3_3(tmp,tmp,-.03,.03,.005,-1,1,...
%	['~/Documents/OSU/figures/advect/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.004,-1,1,...
	['~/Documents/OSU/figures/advect/comps/',fla,'_bg',lab])	
	
%{
fnc=['section_',num2str(m),'_bp21_cc_c.N(r,c)'];
fmc=['section_',num2str(m),'_bp21_cc_c.n_max_sample'];
fbc=['section_',num2str(m),'_bp21_cc_c.median(r,c)'];
flc=['section_',num2str(m),'_bp26_cc_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.0003,.0003,.00005,-1,1,...
	['~/Documents/OSU/figures/advect/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.0003,.0003,.00005,-1,1,...
	['~/Documents/OSU/figures/advect/comps/',flc,'_bg',lab])	

fna=['section_',num2str(m),'_bp26_cc_a.N(r,c)'];
fma=['section_',num2str(m),'_bp26_cc_a.n_max_sample'];
fba=['section_',num2str(m),'_bp26_cc_a.median(r,c)'];
fla=['section_',num2str(m),'_bp26_cc_a'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.0003,.0003,.00005,-1,1,...
	['~/Documents/OSU/figures/advect/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.0003,.0003,.00005,-1,1,...
	['~/Documents/OSU/figures/advect/comps/',fla,'_bg',lab])	
	

fnc=['section_',num2str(m),'_raw_bp26_cc_c.N'];
fmc=['section_',num2str(m),'_raw_bp26_cc_c.n_max_sample'];
fbc=['section_',num2str(m),'_raw_bp26_cc_c.median'];
flc=['section_',num2str(m),'_raw_bp26_cc_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.0003,.0003,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.0003,.0003,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['section_',num2str(m),'_raw_bp26_cc_a.N'];
fma=['section_',num2str(m),'_raw_bp26_cc_a.n_max_sample'];
fba=['section_',num2str(m),'_raw_bp26_cc_a.median'];
fla=['section_',num2str(m),'_raw_bp26_cc_a'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.0003,.0003,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.0003,.0003,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	
	


fnc=['section_',num2str(m),'_bp21_chl_c.N(r,c)'];
fmc=['section_',num2str(m),'_bp21_chl_c.n_max_sample'];
fbc=['section_',num2str(m),'_bp21_chl_c.median(r,c)'];
flc=['section_',num2str(m),'_bp26_chl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
%cplot_comps_cont_3_3(tmp,tmp,-.03,.03,.005,-1,1,...
%	['~/Documents/OSU/figures/advect/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.03,.03,.005,-1,1,...
	['~/Documents/OSU/figures/advect/comps/',flc,'_bg',lab])	

fna=['section_',num2str(m),'_bp21_chl_a.N(r,c)'];
fma=['section_',num2str(m),'_bp21_chl_a.n_max_sample'];
fba=['section_',num2str(m),'_bp21_chl_a.median(r,c)'];
fla=['section_',num2str(m),'_bp26_chl_a'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
%cplot_comps_cont_3_3(tmp,tmp,-.03,.03,.005,-1,1,...
%	['~/Documents/OSU/figures/advect/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.03,.03,.005,-1,1,...
	['~/Documents/OSU/figures/advect/comps/',fla,'_bg',lab])	
	
	
fnc=['section_',num2str(m),'_raw_bp26_chl_c.N'];
fmc=['section_',num2str(m),'_raw_bp26_chl_c.n_max_sample'];
fbc=['section_',num2str(m),'_raw_bp26_chl_c.median'];
flc=['section_',num2str(m),'_raw_bp26_chl_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,...
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
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	

fnc=['section_',num2str(m),'_bp26_car_c.N(r,c)'];
fmc=['section_',num2str(m),'_bp26_car_c.n_max_sample'];
fbc=['section_',num2str(m),'_bp26_car_c.median(r,c)'];
flc=['section_',num2str(m),'_bp26_car_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.005,-1,1,...
	['~/Documents/OSU/figures/advect/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.005,-1,1,...
	['~/Documents/OSU/figures/advect/comps/',flc,'_bg'])	

fna=['section_',num2str(m),'_bp26_car_a.N(r,c)'];
fma=['section_',num2str(m),'_bp26_car_a.n_max_sample'];
fba=['section_',num2str(m),'_bp26_car_a.median(r,c)'];
fla=['section_',num2str(m),'_bp26_car_a'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.005,-1,1,...
	['~/Documents/OSU/figures/advect/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.005,-1,1,...
	['~/Documents/OSU/figures/advect/comps/',fla,'_bg'])	

fnc=['section_',num2str(m),'_bp26_chl_c.N(r,c)'];
fmc=['section_',num2str(m),'_bp26_chl_c.n_max_sample'];
fbc=['section_',num2str(m),'_bp26_chl_old_c.mean(r,c)'];
flc=['section_',num2str(m),'_bp26_chl_c_mean'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['section_',num2str(m),'_bp26_chl_a.N(r,c)'];
fma=['section_',num2str(m),'_bp26_chl_a.n_max_sample'];
fba=['section_',num2str(m),'_bp26_chl_old_a.mean(r,c)'];
fla=['section_',num2str(m),'_bp26_chl_a_mean'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])	
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])		
%}
%}
end

%{

load section_trans_samp
r=1:41;
c=r;

for m=21:length(lat)
fnc=['section_',num2str(m),'_chl_c.N(r,c)'];
fmc=['section_',num2str(m),'_chl_c.n_max_sample'];
fbc=['section_',num2str(m),'_chl_c.median(r,c)'];
flc=['section_',num2str(m),'_chl_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
tmp=tmp./(max(tmp(:)));
cplot_comps_cont_3_3(tmp,tmp,-1.3,-.5,.5,-2,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])

fna=['section_',num2str(m),'_chl_a.N(r,c)'];
fma=['section_',num2str(m),'_chl_a.n_max_sample'];
fba=['section_',num2str(m),'_chl_a.median(r,c)'];
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
		
			

