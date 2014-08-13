clear all
load argo_prof_index.mat pjday plat plon pfile
head   = 'AVISO_25_W_';
loadpath   = '/matlab/data/eddy/V4/mat/';

%first make mask matrix


startjd=2448910; %from mid_week_jdays of eddy files
endjd=2454832;
jdays=startjd:7:endjd;

tt=find(pjday>=startjd-3 & pjday<=endjd+3);
pjday=pjday(tt);
plat=plat(tt);
plon=plon(tt);
pfile=pfile(tt);

tt=find(jdays>=min(pjday)&jdays<=max(pjday));
jdays=jdays(tt);
load /matlab/data/eddy/V4/global_tracks_V4
[eddy_dist_x,eddy_dist_y,eddy_id,eddy_pjday,eddy_scale,eddy_x,eddy_y,...
eddy_pjday_round,eddy_plat,eddy_plon,eddy_eid,eddy_prop_speed,eddy_k,eddy_efold]=deal(nan(length(plat),1));
eddy_pfile=cell(length(plat),1);

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
   				load([loadpath,head,num2str(jdays(p))],'idmask')
    			if idmask(r,c)<0
    				ii=find(track_jday==jdays(p) & eid==abs(idmask(r,c)));
    				if any(ii)
					ieddy_ssh=find(abs(idmask)==eid(ii));
    				mask=nan*idmask;
    				mask(ieddy_ssh)=1;
    				eddy_dist_x(pp)=(111.11*(plat(m)-x(ii)))./scale(ii);
    				eddy_dist_y(pp)=((111.11*cosd(plat(m))*(plon(m)-y(ii))))./scale(ii);
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
    				eddy_scale(pp)=scale(ii);
    				eddy_amp(pp)=amp(ii);
    				eddy_axial_speed(pp)=axial_speed(ii);
    				eddy_k(pp)=k(ii);
    				eddy_prop_speed(pp)=prop_speed(ii);
    				pp=pp+1;
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

save eddy_argo_prof_index_trapped.mat eddy_*
    