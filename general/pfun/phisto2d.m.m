function pscatter(x,y,step,min_x,max_x,min_y,max_y,xlab,ylab)

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
    cx=tmpxs(iminx(1));
    cy=tmpys(iminy(1));
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

fprintf('\n     Linear least squares regression \r')
[dumb,beta_lin,S_lin,delta_beta_lin,S_crit_lin]=reg(double(x),double(y),'lin');
newy_lin=(beta_lin(2).*[min_x:step:max_x])+beta_lin(1);


fprintf('\n     Neutral least squares regression on samples \n')
[beta_nut_samps(2),beta_nut_samps(1),dud,dud,chiopt,Cab,Calphap]=ols_line(double(x),double(y),beta_lin);
newy_nut_samps=(beta_nut_samps(2).*[min_x:step:max_x])+beta_nut_samps(1);

figure(22)
clf
pdens=(dens./max(dens(:))).*100;
pcolor(X.*step,Y.*step,pdens);shading interp
hold on
contour(X.*step,Y.*step,pdens,[10:10:100],'color',[.8 .8 .8]);
colormap(pgray)
caxis([0 50])
line([0 0],[min_y max_y],'color','k')
line([min_x max_x],[0 0],'color','k')
axis image
axis([min_x max_x min_y max_y])
box
%daspect([1 2 1])
%axes(cc)
%ylabel('N')

figure(23)
clf
pdens=(dens./max(dens(:))).*100;
pcolor(X.*step,Y.*step,pdens);shading interp
hold on
contour(X.*step,Y.*step,pdens,[10:10:100],'color',[.8 .8 .8]);
colormap(pgray)
caxis([0 50])
line([0 0],[min_y max_y],'color','k')
line([min_x max_x],[0 0],'color','k')

plot([min_x:step:max_x],newy_nut_samps,'k','linewidth',2)
%plot([min_x:step:max_x],newy_wnut_samps,'g--','linewidth',2)
%legend('Observation Density','Observation Desity','linear','Binned Linear','Orthogonal','Weighted Orthogonal')

%cc=colorbar;
xlabel({xlab,'',['  \beta_{ols} = ',num2str(beta_nut_samps(2))]});
ylabel(ylab)
axis image
axis([min_x max_x min_y max_y])
box
%daspect([1 2 1])
%axes(cc)
%ylabel('N')
box



