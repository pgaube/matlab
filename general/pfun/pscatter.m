function [pdens,beta_ols,beta_bin,ci_bin,binned_samps2]=pscatter(x,y,slope_guess,perc,tbins,step,min_x,max_x,min_y,max_y,xlab,ylab,OLD_GRID,OLD_ALL)
%function pscatter(x,y,slope_guess,perc,tbins,step,min_x,max_x,min_y,max_y,xlab,ylab,OLD_GRID,OLD_ALL)

load pgray.pal
%screan for nans and remove
%{
ibad=find(isnan(x));
x(ibad)=[];
y(ibad)=[];
ibad=find(isnan(y));
x(ibad)=[];
y(ibad)=[];
%}
index_dens=nan*x;


if nargin == 12
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
    if any(iminy)
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
    end
end
dens(dens==0)=nan;
end

if nargin <=13
if nargin ==13
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
sdx=pstd(x);
sdy=pstd(y);
fprintf('\n     sdx = %03u sdy = %03u \r',sdx,sdy)


fprintf('\n     bin averaging\r')
for i=1:length(tbins)-1
    bin_est = find(x>=tbins(i) & x<tbins(i+1));
    binned_samps1(i) = double(pmean(x(bin_est)));
    std_samps1(i) = double(pstd(x(bin_est)));
    num_samps1(i) = double(length(bin_est));
    binned_samps2(i) = double(pmean(y(bin_est)));
    std_samps2(i) = double(pstd(y(bin_est)));
    num_samps2(i) = length(bin_est);
end

% linear least squared regession on binned data
fprintf('\n     Linear least squares regression \r')
[dumb,beta_lin,S_lin,delta_beta_lin,S_crit_lin]=reg(double(x),double(y),'lin');
newy_lin=(beta_lin(2).*[min_x:step:max_x])+beta_lin(1);

[dumb,beta_lin_binned,S_lin_binned,delta_beta_lin_binned,S_crit_lin_binned]=reg(tbins(1:length(tbins)-1),binned_samps2,'lin');
newy_lin_binned=(beta_lin_binned(2).*[min_x:step:max_x])+beta_lin_binned(1);
beta_bin=beta_lin_binned(2)

fprintf('\n     Neutral least squares regression on samples \n')
beta_nut_samps=ols_pca(double(x),double(y));
newy_nut_samps=(beta_nut_samps.*[min_x:step:max_x])+beta_nut_samps(1);

beta_old=beta_nut_samps;
[beta_wnut_samps(2),beta_wnut_samps(1),dud,dud,chiopt,Cab,Calphap]=wtls_line(double(x),double(y),sdx,sdy);
newy_wnut_samps=(beta_wnut_samps(2).*[min_x:step:max_x])+beta_wnut_samps(1);

beta_wols=beta_wnut_samps(2)

end

if nargin ==14
	fprintf('\n     loading gridding counts from tmp_pscatter in current dir\n')
	load tmp_pscatter
end	

if nargin < 14
save tmp_pscatter dens beta* X Y step index_dens *samps1 *samps2 newy* tbins min* max* sdx sdy
end


figure(22)
clf
pdens=(dens./max(dens(:))).*100;
pcolor(X.*step,Y.*step,pdens);shading interp
hold on
contour(X.*step,Y.*step,pdens,[10:10:100],'color',[.8 .8 .8]);
%contour(X.*step,Y.*step,pdens,[perc+1 perc+1],'color','r');
colormap(pgray)
caxis([0 50])
line([0 0],[min_y max_y],'color','k')
line([min_x max_x],[0 0],'color','k')
axis image
axis([min_x max_x min_y max_y])
box
shading flat
%daspect([1 2 1])
%axes(cc)
%ylabel('N')

figure(23)
clf
pdens=(dens./max(dens(:))).*100;
pcolor(X.*step,Y.*step,pdens);shading interp
hold on
contour(X.*step,Y.*step,pdens,[10:10:100],'color',[.8 .8 .8]);
%contour(X.*step,Y.*step,pdens,[perc+1 perc+1],'color','r');
colormap(pgray)
caxis([0 20])
line([0 0],[min_y max_y],'color','k')
line([min_x max_x],[0 0],'color','k')
errorbar(binned_samps1,binned_samps2,std_samps2,'r.')
plot([min_x:step:max_x],newy_lin,'k')
plot([min_x:step:max_x],newy_lin_binned,'k--')

plot([min_x:step:max_x],newy_nut_samps,'g','linewidth',2)
%plot([min_x:step:max_x],newy_wnut_samps,'g--','linewidth',2)
%legend('Observation Density','Observation Desity','linear','Binned Linear','Orthogonal','Weighted Orthogonal')
xlabel({xlab,'', ...
[' \beta_{ols} = ',num2str(beta_nut_samps)],...
[' \beta_{binned} = ',num2str(beta_lin_binned(2))]});
ylabel(ylab)
axis image
axis([min_x max_x min_y max_y])
box
%daspect([1 2 1])
%axes(cc)
%ylabel('N')
box
shading flat
colorbar


%{
figure(24)
clf
pdens=(dens./max(dens(:))).*100;
pcolor(X.*step,Y.*step,pdens);shading interp
hold on
contour(X.*step,Y.*step,pdens,[10:10:100],'color',[.8 .8 .8]);
contour(X.*step,Y.*step,pdens,[perc+1 perc+1],'color','r');
colormap(pgray)
caxis([0 50])
line([0 0],[min_y max_y],'color','k')
line([min_x max_x],[0 0],'color','k')
errorbar(binned_samps1,binned_samps2,std_samps2,'k.')
plot([min_x:step:max_x],newy_lin_binned,'k')

%cc=colorbar;
xlabel({xlab,'', ...
[' \beta_{binned} = ',num2str(beta_lin_binned(2))]});
ylabel(ylab)
axis image
axis([min_x max_x min_y max_y])
box
%daspect([1 2 1])
%axes(cc)
%ylabel('N')
box
shading flat
%}

beta_ols=beta_nut_samps;
ci_bin=std_samps2;
