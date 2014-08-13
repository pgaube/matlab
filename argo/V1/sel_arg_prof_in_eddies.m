%
clear all
load /matlab/matlab/argo/argo_prof_index.mat pfile pjday plat plon

%{
[s_pjday,s_i]=sort(pjday);
pfile=pfile(s_i);
plat=plat(s_i);
plon=plon(s_i);
%}

loadpath='/matlab/data/eddy/V4/mat/';
head='AVISO_25_W_';

startjd=2448910; %from mid_week_jdays of eddy files
endjd=2454804;
jdays=startjd:7:endjd;

tt=find(pjday>=startjd-3 & pjday<=endjd);
pfile=pfile(tt);
pjday=pjday(tt);
plat=plat(tt);
plon=plon(tt);

[eddy_dist,eddy_pjday,eddy_pjday_round,eddy_plat,eddy_plon,...
eddy_eid,eddy_id,eddy_x,eddy_y,eddy_efold,eddy_amp,eddy_edge_ssh,...
eddy_axial_speed,eddy_k,eddy_prop_speed,eddy_rel_amp,eddy_max_ssh_lon,...
eddy_max_ssh_lat,eddy_max_ssh,eddy_mld,eddy_dist_from_max,eddy_z26]=deal(nan(300000,1));

eddy_pfile=cell(size(eddy_plat));
%load /Volumes/matlab/data/eddy/V3/eid_mask_matrix
load /matlab/data/eddy/V4/global_tracks_V4
load([loadpath,head,num2str(jdays(10))],'lon','lat')
%
pp=1;
%now go through each float and find out if it is in an eddy
%

lap=length(pjday);

total_number_of_float=lap
n=1;

lap=length(pjday);
progressbar('Checking Float')
for m=n:lap
	progressbar(m/lap)
	%interp profile location to 1/4 degree grid
	tx=plon(m);
	ty=plat(m);
	tmp=num2str(pfile{m});
	jj=find(tmp=='/');
	tmpp=tmp(jj(3)+1:length(tmp));
	if strcmp(tmpp(1),'D')
	if ~isnan(tx)
	if ~isnan(ty)
		% interp tx and ty to 1/4 degree grid using min dist
    	tmpxs=floor(tx)-2.125:.25:ceil(tx)+2.125;
    	tmpys=floor(ty)-2.125:.25:ceil(ty)+2.125;
    	disx = abs(tmpxs-tx);
    	disy = abs(tmpys-ty);
    	iminx=find(disx==min(disx));
    	iminy=find(disy==min(disy));
    	cx=tmpxs(iminx(1));
    	cy=tmpys(iminy(1));
    	r=find(lat(:,1)==cy);
    	c=find(lon(1,:)==cx);
    
    	if any(r)
    	if any(c)
    		%interp pjday to closest week
    		tj=round(pjday(m));
    		tmpj=tj-3:tj+3;
    		p=sames(tmpj,jdays);
    	
    		if any(p)
    			%now look to see if float is in eddy
   				load([loadpath,head,num2str(jdays(p))],'idmask','ssh')
    			if ~isnan(idmask(r,c))
    				ii=find(track_jday==jdays(p) & eid==abs(idmask(r,c)));
    				if any(ii)
    				tmp=num2str(pfile{m});
					ff=find(tmp=='/');
					fname=tmp(ff(3)+1:length(tmp));
					if exist(['/data/argo/profiles/', fname])
						[blank,dumb,pres,s,t]=read_profiles(fname);
						%t=filter_sigma(3,t);
						%s=filter_sigma(3,s);
						%calc mld
						st=sw_dens(s,sw_ptmp(s,t,pres,0),0)-1000;
						i26=find(st-26==min(st-26));
						i10=find(abs(pres-10)==min(abs(pres-10)));
						if any(i10)
							imld=find(st-st(i10(1))>.125);
						if any(imld)
						%if pres(imld(1))<300
							eddy_mld(pp)=pres(imld(1));
						%end	
						if any (i26)
						  	eddy_z26(pp)=pres(i26(1));
						  	end

						end	
						end
					end
					ieddy_ssh=find(abs(idmask)==eid(ii));
    				mask=nan*idmask;
    				mask(ieddy_ssh)=1;
    				tmp=ssh.*mask;
    				eddy_max_ssh(pp)=max(abs(tmp(:)));
    				i_max=find(abs(tmp)==eddy_max_ssh(pp));
    				eddy_max_ssh_lat(pp)=lat(i_max(1));
    				eddy_max_ssh_lon(pp)=lon(i_max(1));
    				distp=sqrt((111.11*(plat(m)-y(ii)))^2+(111.11*cosd(plat(m))*(plon(m)-x(ii)))^2);
    				dist_max=sqrt((111.11*(plat(m)-eddy_max_ssh_lat(pp)))^2+(111.11*cosd(plat(m))*(plon(m)-eddy_max_ssh_lon(pp)))^2);
    				[pr,pc]=imap(plat(m)-.125,plat(m)+.125,plon(m)-.125,plon(m)+.125,lat,lon);
					eddy_dist(pp)=distp;
					eddy_dist_from_max(pp)=dist_max;
    				eddy_pfile(pp)=pfile(m);
    				eddy_pjday(pp)=pjday(m);
    				eddy_pjday_round(pp)=jdays(p);
    				eddy_plat(pp)=plat(m);
    				eddy_plon(pp)=plon(m);
    				eddy_eid(pp)=idmask(r,c);
    				eddy_id(pp)=id(ii);
    				eddy_x(pp)=x(ii);
    				eddy_y(pp)=y(ii);
    				eddy_efold(pp)=efold(ii);
    				eddy_amp(pp)=amp(ii);
    				eddy_edge_ssh(pp)=edge_ssh(ii);
    				eddy_axial_speed(pp)=axial_speed(ii);
    				eddy_k(pp)=k(ii);
    				eddy_prop_speed(pp)=prop_speed(ii);
					eddy_rel_amp(pp)=abs(ssh(pr(1),pc(1)))-edge_ssh(ii);    				
    				pp=pp+1;
    				end
    			end
    		end
    	end
    	end
    end
    end
    end
    n=n+1;
end
fprintf('\n')

save eddy_argo_prof_index.mat eddy_*
    