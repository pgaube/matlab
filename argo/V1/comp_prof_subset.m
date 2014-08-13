clear all
load /Volumes/matlab/matlab/argo/timor_anom_prof

ai=find(tid>=nneg);
ci=find(tid<nneg);

x=[-5:.2:5];
y=x';
[X,Y]=meshgrid(x,y);

density_prof_a=zeros(size(X));
density_prof_c=zeros(size(X));



ppp=1;
qqq=1;
for m=1:length(tid)
	dist_x = ((tx(m)-tlon(m)).*(111.1*cosd(ty(m))))./tefold(m);
	dist_y = ((ty(m)-tlat(m)).*111.1)./tefold(m);
	tmpxs=floor(dist_x)-1:.2:ceil(dist_x)+1;
	tmpys=floor(dist_y)-1:.2:ceil(dist_y)+1;
    disx = abs(tmpxs-dist_x);
    disy = abs(tmpys-dist_y);
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cx=tmpxs(iminx(1));
    cy=tmpys(iminy(1));
    r=find(y>=cy-.09 & y<=cy+.09); %added this because FUCKING MATLAB has some sort of inharent rounding error!
    c=find(x>=cx-.09 & x<=cx+.09);
    
    if any(r)
    if any(c)
    	if tid(m)>=nneg;
    		density_prof_a(r,c)=density_prof_a(r,c)+1;
    		
    	else
    		density_prof_c(r,c)=density_prof_c(r,c)+1;
    	end	
    else
    missing_r(ppp)=m;
    ppp=ppp+1;
    end
    end
end    

density_prof_a(density_prof_a==0)=nan;
density_prof_c(density_prof_c==0)=nan;

figure(69)
clf
subplot(121)
pcolor(X,Y,density_prof_c);shading flat;axis equal
title('Cyclones  ')
colorbar
subplot(122)
pcolor(X,Y,density_prof_a);shading flat;axis equal
title('Anticyclones  ')
colorbar

%{
cplot_comps_pos_scale(log10(density_prof_a),0,2.75, ...
'~/Documents/OSU/figures/argo/prof_density_a')

cplot_comps_pos_scale(log10(density_prof_c),0,2.75, ...
'~/Documents/OSU/figures/argo/prof_density_c')
%}




	