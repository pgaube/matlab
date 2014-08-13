function dens=phisto2d(x,y,xstep,ystep,min_x,max_x,min_y,max_y,xlab,ylab)
%function phisto2d(x,y,xstep,ystep,da,min_x,max_x,min_y,max_y,xlab,ylab)

load pgray.pal
%screan for nans and remove
ibad=find(isnan(x));
x(ibad)=[];
y(ibad)=[];
ibad=find(isnan(y));
x(ibad)=[];
y(ibad)=[];

index_dens=nan*x;


fprintf('\n     gridding counts \r')
[X,Y]=meshgrid([min_x/xstep:.25:max_x/xstep],[min_y/ystep:.25:max_y/ystep]);
dens=zeros(size(X));
nx=x./xstep;
ny=y./ystep;
for m=1:length(nx)
	tmpxs=floor(nx(m))-1:.25:ceil(nx(m))+1;
	tmpys=floor(ny(m))-1:.25:ceil(ny(m))+1;
    disx = abs(tmpxs-nx(m));
    disy = abs(tmpys-ny(m));
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cx=tmpxs(iminx(1));
    cy=tmpys(iminy(1));
    r=find(Y(:,1)>=cy-ystep/2 & Y(:,1)<=cy+ystep/2);
    c=find(X(1,:)>=cx-xstep/2 & X(1,:)<=cx+xstep/2);
    
    if any(r)
    if any(c)
    	dens(r,c)=dens(r,c)+1;
    	%index_dens(m)=(c-1)*length(dens(:,1))+r;
    end
    end
end
dens(dens==0)=nan;

figure(23)
clf
pdens=(dens./max(dens(:))).*100;
pcolor(X.*xstep,Y.*ystep,pdens);shading flat
hold on
contour(X.*xstep,Y.*ystep,pdens,[10:10:100],'color',[.8 .8 .8]);
colormap(pgray)
caxis([10 90])
line([0 0],[min_y max_y],'color','k')
line([min_x max_x],[0 0],'color','k')


xlabel(xlab);
ylabel(ylab)
axis image
axis([min_x max_x min_y max_y])
box
%daspect([1 2 1])
%axes(cc)
%ylabel('N')
box
%daspect(da)
pp=gca;
cc=colorbar
axes(cc)
ylabel('%')
axes(pp)


