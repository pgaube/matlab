function pscatter(x,y,slope_guess,perc,step,min_x,max_x,min_y,max_y,xlab,ylab,OLD_GRID,OLD_ALL)

load pgray.pal



%screan for nans and remove
ibad=find(isnan(x));
x(ibad)=[];
y(ibad)=[];
ibad=find(isnan(y));
x(ibad)=[];
y(ibad)=[];


index_dens=nan*x;


if nargin == 11
fprintf('\n     gridding counts \r')
[X,Y]=meshgrid([min_x/step:.25:max_x/step],[min_y/step:.25:max_y/step]);
dens=zeros(size(X));
nx=x./step;
ny=y./step;
for m=1:length(nx)
	tmpxs=floor(nx(m))-1:.25:ceil(nx(m))+1;
	tmpys=floor(ny(m))-1:.25:ceil(ny(m))+1;
    disx = abs(tmpxs-nx(m));
    disy = abs(tmpys-ny(m));
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    if any(iminx)
    	cx=tmpxs(iminx(1));
    	cy=tmpys(iminy(1));
    end
    r=find(Y(:,1)>=cy-step/2 & Y(:,1)<=cy+step/2);
    c=find(X(1,:)>=cx-step/2 & X(1,:)<=cx+step/2);
    
    if any(r)
    if any(c)
    	dens(r,c)=dens(r,c)+1;
    	index_dens(m)=(c-1)*length(dens(:,1))+r;
    end
    end
end
dens(dens==0)=nan;
end

if nargin <=12
if nargin ==12
fprintf('\n     loading gridding counts from tmp_pscatter in current dir\r')
load tmp_pscatter X Y *nut* step dens index_dens beta*
end

%now screen samples based off of density of obs
fprintf('\n     flagging values by observation density\r')
pdens=(dens./max(dens(:))).*100;
i=find(pdens>=perc);
go=sames(i,index_dens);
x=x(go);
y=y(go);


fprintf('\n     Neutral least squares regression on samples \n')
[beta_nut_samps(2),beta_nut_samps(1),dud,dud,chiopt,Cab,Calphap]=ols_line(double(x),double(y),slope_guess);

end

if nargin ==13
	fprintf('\n     loading gridding counts from tmp_pscatter in current dir\n')
	load tmp_pscatter
end	

if nargin < 13
save tmp_pscatter dens beta* X Y step index_dens
end

newy_nut_samps=(beta_nut_samps(2).*[min_x:step:max_x])+beta_nut_samps(1);

pdens=(dens./max(dens(:))).*100;

figure(23)
clf
pcolor(X.*step,Y.*step,pdens);shading interp
hold on
contour(X.*step,Y.*step,pdens,[0:10:100],'color',[.8 .8 .8]);
contour(X.*step,Y.*step,pdens,[perc perc],'color','r');
colormap(pgray)
caxis([0 50])
plot([min_x:step:max_x],newy_nut_samps,'k','linewidth',2)
cc=colorbar;
xlabel({xlab,'', ...
['\beta_{ort} = ',num2str(beta_nut_samps(2))]});
ylabel(ylab)
axis([min_x max_x min_y max_y])
%daspect([1 2 1])
%axes(cc)
%ylabel('N')
