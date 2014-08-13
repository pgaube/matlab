%{
load /matlab/matlab/argo/eddy_UCSD_mld_index eddy_id eddy_x eddy_y eddy_plat eddy_scale eddy_plon
dist_x=nan*eddy_x;
dist_y=nan*eddy_y;

ii=find(~isnan(eddy_id));
for m=1:length(ii)
	dist_x(ii(m)) = (eddy_plon(ii(m))-eddy_x(ii(m)))...
	*(111.1*cosd(eddy_plat(ii(m))))/eddy_scale(ii(m));
	dist_y(ii(m)) = (eddy_plat(ii(m))-eddy_y(ii(m)))*111.1/eddy_scale(ii(m));
end


load /matlab/matlab/argo/eddy_UCSD_mld_index eddy_id eddy_x eddy_y eddy_plat eddy_scale eddy_plon

OUT_HEAD   = 'TRANS_W_NOR_';
OUT_PATH   = '/matlab/matlab/global/trans_samp/';

startjd=2451395; %from mid_week_jdays of eddy files
endjd=2454804;
jdays=startjd:7:endjd;

eddy_ssh=nan(81,81,length(find(~isnan(eddy_id))));
whos eddy_ssh
qq=1;
for p=315:length(jdays)
	p
	load([OUT_PATH,OUT_HEAD,num2str(jdays(p))],'nrssh_sample','id_index')
	ii=sames(eddy_id,id_index);
	for m=1:length(ii)
		eddy_ssh(:,:,qq)=nrssh_sample(:,:,ii(m));
		qq=qq+1;
	end
	qq
end	
	
save eddy_ssh eddy_ssh
%}

load  /matlab/matlab/argo/eddy_UCSD_mld_index_rad
tbins=0:.25:5
area=pi*tbins.^2
narea=area(2:end)-area(1:end-1)

dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);

[b,n]=phist(dist,tbins)

nn=n./narea;
pdf=100*nn./sum(nn);
cpdf=cumsum(pdf)
figure(1)
clf
stairs(tbins(1:end-1),pdf,'k','linewidth',2)
title('Number of ARGO profiles per unit area')
ylabel('%')
xlabel('eddy radi (L_s)')
grid
niceplot
print -dpng -r300 figs/histo_prof_log_rad
figure(2)
title('Cumulative PDF of ARGO profiles per unit area')
stairs(tbins(1:end-1),cpdf,'k')


return



tbins=0:.25:3
zgrid_grid
tmp=nan(1,length(eddy_ssh(1,1,:)));

for m=1:length(tbins)-1
	if m==1
		ii=find(dist<=tbins(m));
	else
		ii=find(dist<=tbins(m) & dist>tbins(m-1));
	end
	for n=1:length(eddy_ssh(1,1,:))
		tt=eddy_ssh(:,:,n);
		tmp(n)=length(find(~isnan(tt(ii))));
	end	
	count_eddy(m)=sum(tmp);
	count_per_area_eddy(m)=sum(tmp)./length(ii);
end	

save eddy_area tbins dist count_*

load comps_prog_loc

[b,n]=phist(cat(1,abs(dist_x),abs(dist_y)),tbins)


return

dist_x=nan*eddy_x;
dist_y=nan*eddy_y;

ii=find(~isnan(eddy_id));
for m=1:length(ii)
	dist_x(ii(m)) = (eddy_plon(ii(m))-eddy_x(ii(m)))...
	*(111.1*cosd(eddy_plat(ii(m))))/eddy_scale(ii(m));
	dist_y(ii(m)) = (eddy_plat(ii(m))-eddy_y(ii(m)))*111.1/eddy_scale(ii(m));
end

save comps_prog_loc dist_x dist_y eddy_*