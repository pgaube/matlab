clear all
load /Volumes/matlab/data/eddy/V4/global_tracks_V4_16_weeks id eid efold track_jday nneg
load eddy_argo_prof_index eddy_*

loc=nan(101000,2);
locg=loc;
loc_id=nan(101000,1);
abs_dist=loc_id;
loc_jday=loc_id;
loc_x=loc_id;
loc_y=loc_id;
loc_pfile{:}=deal(loc_id);
qqq=1;
jdays=unique(track_jday);
for m=1:length(jdays)
fprintf('\r jday %03u of %03u',m,length(jdays))
	dd=find(eddy_pjday_round==jdays(m));
	for n=1:length(dd)
		x=eddy_x(dd(n));
		y=eddy_y(dd(n));
		l=eddy_efold(dd(n));
		px=eddy_plon(dd(n));
		py=eddy_plat(dd(n));
		
		locg_x = (x-px);
		locg_y = (y-py);
		dist_x = (x-px).*(111.1*cosd(y));
		dist_y = (y-py).*111.1;
		dist_xi = (dist_x./l);
		dist_yi = (dist_y./l);
		loc(qqq,:)=[dist_xi dist_yi];
		locg(qqq,:)=[locg_x locg_y];
		loc_id(qqq)=eddy_id(dd(n));
		loc_pfile(qqq)=eddy_pfile(dd(n));
		loc_jday(qqq)=eddy_pjday_round(dd(n));
		loc_y(qqq)=eddy_plat(dd(n));
		loc_x(qqq)=eddy_plon(dd(n));
		abs_dist(qqq) = sqrt(dist_xi^2+dist_yi^2);
		qqq=qqq+1;
	end
end	
ii=find(isnan(loc_id));
loc_id(ii)=[];
loc(ii,:)=[];
locg(ii,:)=[];
loc_jday(ii,:)=[];
abs_dist(ii,:)=[];

ii=find(isnan(loc(:,1)));
loc_id(ii)=[];
loc(ii,:)=[];
locg(ii,:)=[];
abs_dist(ii,:)=[];
loc_jday(ii,:)=[];

ai=find(loc_id>=nneg);
ci=find(loc_id<nneg);

x=[-5:.2:5];
y=x';
[X,Y]=meshgrid(x,y);

xc=-8:.25:8;
yc=xc';
[Xc,Yc]=meshgrid(xc,yc);

density_prof_a=zeros(size(X));
density_prof_c=zeros(size(X));

loc_density_prof_a=zeros(size(Xc));
loc_density_prof_c=zeros(size(Xc));


ppp=1;
qqq=1;
for m=1:length(loc_id)
	tx=loc(m,1);
	ty=loc(m,2);
	tmpxs=floor(tx)-1:.2:ceil(tx)+1;
	tmpys=floor(ty)-1:.2:ceil(ty)+1;
    disx = abs(tmpxs-tx);
    disy = abs(tmpys-ty);
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cx=tmpxs(iminx(1));
    cy=tmpys(iminy(1));
    r=find(y>=cy-.09 & y<=cy+.09); %added this because FUCKING MATLAB has some sort of inharent rounding error!
    c=find(x>=cx-.09 & x<=cx+.09);
    
    tx=locg(m,1);
	ty=locg(m,2);
	tmpxs=floor(tx)-1:.25:ceil(tx)+1;
	tmpys=floor(ty)-1:.25:ceil(ty)+1;
    disx = abs(tmpxs-tx);
    disy = abs(tmpys-ty);
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cx=tmpxs(iminx(1));
    cy=tmpys(iminy(1));
    rg=find(yc>=cy-.09 & yc<=cy+.09); %added this because FUCKING MATLAB has some sort of inharent rounding error!
    cg=find(xc>=cx-.09 & xc<=cx+.09);
    
    if any(r)
    if any(c)
    	if loc_id(m)>=nneg;
    		density_prof_a(r,c)=density_prof_a(r,c)+1;
    		loc_density_prof_a(rg,cg)=loc_density_prof_a(rg,cg)+1;
    		
    	else
    		density_prof_c(r,c)=density_prof_c(r,c)+1;
    		loc_density_prof_c(rg,cg)=loc_density_prof_c(rg,cg)+1;
    	end	
    else
    missing_r(ppp)=m;
    ppp=ppp+1;
    end
    end
end    

density_prof_a(density_prof_a==0)=nan;
density_prof_c(density_prof_c==0)=nan;
loc_density_prof_a(loc_density_prof_a==0)=nan;
loc_density_prof_c(loc_density_prof_c==0)=nan;


save norm_prof_to_centroid nneg ai ci dens* loc* abs_dist


fprintf('\n')
figure(69)
clf
subplot(221)
pcolor(X,Y,density_prof_c);shading flat;axis equal
title('Cyclones, normalized distance  ')
caxis([1 50])
subplot(223)
pcolor(Xc,Yc,loc_density_prof_c);shading flat;axis equal
title('Cyclones, locations  ')
caxis([1 400])
subplot(222)
pcolor(X,Y,density_prof_a);shading flat;axis equal
title('Anticyclones, normalized distance  ')
caxis([1 50])
cc1=colorbar;
subplot(224)
pcolor(Xc,Yc,loc_density_prof_a);shading flat;axis equal
title('Anticyclones, locations  ')
caxis([1 400])
cc2=colorbar;
axes(cc1)
ylabel('number of profiles')
axes(cc2)
ylabel('number of profiles')

cplot_comps_pos_scale(log10(density_prof_a),0,2.75, ...
'~/Documents/OSU/figures/argo/prof_density_a')

cplot_comps_pos_scale(log10(density_prof_c),0,2.75, ...
'~/Documents/OSU/figures/argo/prof_density_c')




	