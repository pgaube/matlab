
clear all
load /matlab/matlab/eddy-wind/tracks/EK_lat_lon_tracks_all.mat
load /matlab/matlab/argo/eddy_argo_prof_index.mat
load /matlab/data/eddy/V4/global_tracks_V4 nneg
%ii=sames(id,eddy_id);
%load coupcoef_amp_mld ii
ii=find(eddy_pjday_round>2451000 & eddy_pjday_round<2453000);
%ii(1131)=[];
%ii=1:length(eddy_id);
eddy_edge_ssh(eddy_edge_ssh>1e20)=nan;

[abs_amp,rel_amp,rel_max_ssh,rel_dist,rel_mld,rel_scale,rel_id]=deal(nan(length(ii),1));


for m=1:length(ii)
	if ~isnan(eddy_pjday_round(ii(m)))
	load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(eddy_pjday_round(ii(m)))],'lat','lon','ssh','idmask')
	
	tmp=num2str(eddy_pfile{ii(m)});
	ff=find(tmp=='/');
	fname=tmp(ff(3)+1:length(tmp));
	
	lii=length(ii);
	if exist(['/data/argo/profiles/', fname])
		fprintf('\r     calculating %6u of %6u \r',m,lii)
		[plat,plon,p,s,t]=read_profiles(fname);
		[r,c]=imap(eddy_y(ii(m))-3,eddy_y(ii(m))+3,eddy_x(ii(m))-3,eddy_x(ii(m))+3,lat,lon);	
		t=filter_sigma(3,t);
		s=filter_sigma(3,s);
		%calc mld
		st=sw_dens(s,sw_ptmp(s,t,p,0),0)-1000;
		i10=find(min(p-10));
		if any(i10)
			imld=find(st-st(i10)>.125);
		if any(imld)
			if p(imld(1))<300
				rel_mld(m)=p(imld(1));
			end	
		end	
		end
		
		
		[pr,pc]=imap(plat-.125,plat+.125,plon-.125,plon+.125,lat,lon);
		rel_max_ssh(m)=eddy_max_ssh(ii(m));
		rel_amp(m)=abs(ssh(pr(1),pc(1)))-eddy_edge_ssh(ii(m));
		rel_id(m)=eddy_id(ii(m));
		rel_dist(m)=eddy_dist(ii(m));
		rel_scale(m)=eddy_efold(ii(m));
		abs_amp(m)=eddy_amp(ii(m));
	end
	end
end
save coupcoef_amp_mld rel_* ii abs_amp nneg

