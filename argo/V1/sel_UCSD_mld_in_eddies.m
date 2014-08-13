%
clear all
load /matlab/matlab/argo/UCSD_mld

 

loadpath='/matlab/data/eddy/V5/mat/';
head='AVISO_25_W_';

startjd=2448910; %from mid_week_jdays of eddy files
endjd=2454804;
jdays=startjd:7:endjd;

tt=find(pjday>=startjd-3 & pjday<=endjd);
pjday=pjday(tt);
plat=plat(tt);
plon=plon(tt);

[eddy_dist,eddy_dist_from_max,eddy_pjday,eddy_pjday_round,eddy_plat,eddy_plon,...
eddy_eid,eddy_id,eddy_x,eddy_y,eddy_scale,eddy_amp,eddy_edge_ssh,...
eddy_axial_speed,eddy_k,eddy_prop_speed,eddy_rel_amp,eddy_max_ssh_lon,...
eddy_max_ssh_lat,eddy_max_ssh,eddy_mld,eddy_dist_from_max]=deal(nan(length(plat),1));

eddy_trap=zeros(length(plat),1);

load /matlab/data/eddy/V5/global_tracks_V5
load([loadpath,head,num2str(jdays(10))],'lon','lat')
%
pp=1;
%now go through each float and find out if it is in an eddy
%

lap=length(pjday);

total_number_of_float=lap
n=1;

lap=length(pjday);
progressbar('Checking MLD')
for m=n:lap
	progressbar(m/lap)
	%interp profile location to 1/4 degree grid
	tx=plon(m);
	ty=plat(m);
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
						eddy_mld(m)=mld(m);
						ieddy_ssh=find(abs(idmask)==eid(ii));
						mask=nan*idmask;
						mask(ieddy_ssh)=1;
						tmp=ssh.*mask;
						eddy_max_ssh(m)=max(abs(tmp(:)));
						i_max=find(abs(tmp)==eddy_max_ssh(m));
						eddy_max_ssh_lat(m)=lat(i_max(1));
						eddy_max_ssh_lon(m)=lon(i_max(1));
						distp=sqrt((111.11*(plat(m)-y(ii)))^2+(111.11*cosd(plat(m))*(plon(m)-x(ii)))^2);
						dist_max=sqrt((111.11*(plat(m)-eddy_max_ssh_lat(m)))^2+(111.11*cosd(plat(m))*(plon(m)-eddy_max_ssh_lon(m)))^2);
						[pr,pc]=imap(plat(m)-.125,plat(m)+.125,plon(m)-.125,plon(m)+.125,lat,lon);
						eddy_dist(m)=distp;
						eddy_dist_from_max(m)=dist_max;
						eddy_pjday(m)=pjday(m);
						eddy_pjday_round(m)=jdays(p);
						eddy_plat(m)=plat(m);
						eddy_plon(m)=plon(m);
						eddy_eid(m)=idmask(r,c);
						eddy_id(m)=id(ii);
						eddy_x(m)=x(ii);
						eddy_y(m)=y(ii);
						eddy_scale(m)=scale(ii);
						eddy_amp(m)=amp(ii);
						eddy_edge_ssh(m)=edge_ssh(ii);
						eddy_axial_speed(m)=axial_speed(ii);
						eddy_k(m)=k(ii);
						eddy_prop_speed(m)=prop_speed(ii);
						eddy_rel_amp(m)=abs(ssh(pr(1),pc(1)))-edge_ssh(ii);   
						%check to see if in trapped fluid
						if idmask(r,c)<0
							eddy_trap(m)=1;
						end	
    				end
    			end
    		end
    	end
    	end
    end
    end
end
fprintf('\n')

save eddy_UCSD_mld_index.mat eddy_*
    