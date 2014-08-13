function pop_pcomps3d(iso_dat,cont_dat,cont_lev,radi,radc,iso,cax,tit)


load chelle.pal

xi=linspace(-200,200,length(iso_dat.mean(1,:,1)));
yi=xi';
load ~/matlab/pop/mat/pop_model_domain.mat z
zi=-z(1:20);
clear z

[x,y,z]=meshgrid(xi,xi,zi);

dist=sqrt(x.^2+y.^2);
maskc=nan*dist;
maskc(dist<radc)=1;

maski=nan*dist;
maski(dist<radi)=1;

data=iso_dat.mean;
cont_data=double(cont_dat.mean.*maskc);



n=round(cont_dat.n_eddies);

  
%%do some smoothing
sm_data=nan*data;
for m=1:length(zi)
    sm_data(:,:,m)=smoothn(data(:,:,m),15).*maski(:,:,m);
end
    
%%Make slice
% cont_data(5:16,5:16,:)=nan;
       
figure(198)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
slice(x,y,z,cont_data,[],[],[zi(cont_lev)])
shading interp
colormap(chelle)
caxis(cax)
hold on
alpha(.8)
contour(x(:,:,1),y(:,:,1),squeeze(sm_data(:,:,1)),[0 0],'color','k')

for m=1:length(cont_lev)
    line([-200 200],[0 0],[zi(cont_lev(m)) zi(cont_lev(m))],'color','k')
    line([0 0],[-200 200],[zi(cont_lev(m)) zi(cont_lev(m))],'color','k')

end


p = patch(isosurface(x,y,z,sm_data,iso));
isonormals(x,y,z,sm_data,p)
set(p,'FaceColor','red','EdgeColor','none','FaceAlpha',.1)
daspect([1,1,1])
axis tight
camlight 
lighting gouraud

hx=text(-30,-275,min(zi),'km','fontsize',20);
set(hx,'Rotation',30)
hy=text(-275,15,min(zi),'km','fontsize',20);
set(hy,'Rotation',-35)
zlabel('m','fontsize',20);

view(-37.5,17);
title(tit,'fontsize',30)
line([200 200],[-200 200],[0 0],'color','k','linewidth',1)
line([-200 200],[200 200],[0 0],'color','k','linewidth',1)
line([-200 -200],[-200 200],[0 0],'color','k','linewidth',1)
line([-200 200],[-200 -200],[0 0],'color','k','linewidth',1)
% line([0 0],[-200 -200],[-579.3072 0],'color','k','linewidth',1)
% line([-200 -200],[0 0],[-579.3072 0],'color','k','linewidth',1)
line([0 0],[0 0],[-579.3072 0],'color','k')
axis([-200 200 -200 200 -579.3072 0])

