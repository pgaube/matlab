
clear
ssh_path='/Volumes/matlab/data/eddy/V4/mat/';
ssh_head='AVISO_25_W_';

chl_head   = 'SCHL_9_21_';
chl_path   = '/home/mckenzie/data2/data/seawifs/mat/';

%Set range of dates
startyear = 1998;
startmonth = 01;
startday = 07;
endyear= 2008;
endmonth = 12;
endday = 31;

%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:7:endjd];

m=1;

load([ssh_path ssh_head num2str(jdays(m))],'lat','lon')
mean_anom_a=nan(length(lat(:,1)),length(lat(1,:)),length(jdays));
mean_anom_c=nan(length(lat(:,1)),length(lat(1,:)),length(jdays));

load([chl_path chl_head num2str(jdays(m))],'glat','glon')
r=find(glat(:,1)>=min(lat(:,1))-.01 & glat(:,1)<=max(lat(:,1))+.01);

for m=1:length(jdays)
	m
	load([ssh_path ssh_head num2str(jdays(m))],'a_mask','c_mask')
	load([chl_path chl_head num2str(jdays(m))],'gchl_anom')
	gchl_anom=gchl_anom(r,:);
	mean_anom_a(:,:,m)=flipud(gchl_anom).*a_mask;
	mean_anom_c(:,:,m)=flipud(gchl_anom).*c_mask;
end

N_a=nansum(~isnan(mean_anom_a),3);
N_c=nansum(~isnan(mean_anom_c),3);


mean_anom_a=nanmean(mean_anom_a,3);
mean_anom_c=nanmean(mean_anom_c,3);

mean_anom_a(N_a<10)=nan;
mean_anom_c(N_c<10)=nan;

mean_anom_a_2_2=linx_smooth2d_f(mean_anom_a,2,2);
mean_anom_c_2_2=linx_smooth2d_f(mean_anom_c,2,2);

save global_anom_map
return

%the old way
clear all
[glon,glat]=meshgrid([0:.25:360],[-80:.25:80]);
[mean_anom_a,mean_anom_c,num_anom_a,num_anom_c]=deal(nan(size(glat)));

anom_path='/Volumes/matlab/matlab/global/trans_samp/TRANS_TRANS_W_NOR_';
load /Volumes/matlab/data/eddy/V4/global_tracks_v4
startjd=2452431;
endjd=2454811;

% subset eddies to dates where we have samples of all our shit
f1=find(track_jday>=startjd & track_jday<=endjd);

id=id(f1);
x=x(f1);
y=y(f1);
track_jday=track_jday(f1);
jdays=[min(track_jday):7:max(track_jday)];
anom=nan(size(x));
anom_x=anom;
anom_y=anom;
anom_id=anom;
lay=1;

%make mask
mask = nan(81,81);
rad=1.6
zgrid_grid
dist=sqrt(xi.^2+yi.^2);
ii=find(dist<=rad);
mask(ii)=1;

%load global_anom_map

[glon,glat]=meshgrid([0:.25:360],[-80:.25:80]);
ai=find(anom_id>=nneg);
ci=find(anom_id<nneg);


for p=1:length(jdays)
	%first make mean anom array
	fprintf('\r file %3u of %3u \r',p,length(jdays))
	load([anom_path, num2str(jdays(p))],'nranom_sample','id_index','y_index','x_index')
	ited=find(track_jday==jdays(p));
	ted = sames(id(ited),id_index);
	
	for q=1:length(ted)
		anom(lay)=pmean(mask.*nranom_sample(:,:,ted(q)));
		anom_x(lay)=x_index(ted(q));
		anom_y(lay)=y_index(ted(q));
		anom_id(lay)=id_index(ted(q));
		lay=lay+1;
	end
end	
flag=find(isnan(anom));
anom(flag)=[];
anom_x(flag)=[];
anom_y(flag)=[];
anom_id(flag)=[];


	

[grid_anti_2_2,flag_a]=grid2d_loess(anom(ai),anom_x(ai),anom_y(ai),2,2,glon(2,:),glat(:,2));
[grid_cycl_2_2,flag_c]=grid2d_loess(anom(ci),anom_x(ci),anom_y(ci),2,2,glon(2,:),glat(:,2));

mask_grid_anti_2_2=grid_anti_2_2;
mask_grid_anti_2_2(flag_a==0)=nan;

mask_grid_cycl_2_2=grid_cycl_2_2;
mask_grid_cycl_2_2(flag_c==0)=nan;

save global_anom_map mean_* num_* anom anom_* grid_* flag* mask* glon glat nneg ai ci
fprintf('\n')
	
