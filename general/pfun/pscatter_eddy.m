function pscatter(xa,ya,xc,yc,errx,erry,tbins_a,tbins_c,xlab,ylab,OLD_GRID,OLD_ALL)

load pgray.pal


%screan for nans and remove
ibad=find(isnan(xa));
xa(ibad)=[];
ya(ibad)=[];
ibad=find(isnan(ya));
xa(ibad)=[];
ya(ibad)=[];

ibad=find(isnan(xc));
xc(ibad)=[];
yc(ibad)=[];
ibad=find(isnan(yc));
xc(ibad)=[];
yc(ibad)=[];

if nargin == 10
fprintf('\n     gridding counts \r')
step=abs(tbins_a(2)-tbins_a(1));
[Xa,Ya]=meshgrid([floor(min(xa)./step):.25:ceil(max(xa)./step)],[floor(min(ya)./step):.25:ceil(max(ya)./step)]);
dens_a=zeros(size(Xa));
nxa=xa./step;
nya=ya./step;
for m=1:length(nxa)
	tmpxs=floor(nxa(m))-1:.25:ceil(nxa(m))+1;
	tmpys=floor(nya(m))-1:.25:ceil(nya(m))+1;
    disx = abs(tmpxs-nxa(m));
    disy = abs(tmpys-nya(m));
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cx=tmpxs(iminx(1));
    cy=tmpys(iminy(1));
    r=find(Ya(:,1)>=cy-step/2 & Ya(:,1)<=cy+step/2);
    c=find(Xa(1,:)>=cx-step/2 & Xa(1,:)<=cx+step/2);
    
    if any(r)
    if any(c)
    	dens_a(r,c)=dens_a(r,c)+1;
    end
    end
end
dens_a(dens_a==0)=nan;

[Xc,Yc]=meshgrid([floor(min(xc)./step):.25:ceil(max(xc)./step)],[floor(min(yc)./step):.25:ceil(max(yc)./step)]);
dens_c=zeros(size(Xc));
nxc=xc./step;
nyc=yc./step;
for m=1:length(nxc)
	tmpxs=floor(nxc(m))-1:.25:ceil(nxc(m))+1;
	tmpys=floor(nyc(m))-1:.25:ceil(nyc(m))+1;
    disx = abs(tmpxs-nxc(m));
    disy = abs(tmpys-nyc(m));
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cx=tmpxs(iminx(1));
    cy=tmpys(iminy(1));
    r=find(Yc(:,1)>=cy-step/2 & Yc(:,1)<=cy+step/2);
    c=find(Xc(1,:)>=cx-step/2 & Xc(1,:)<=cx+step/2);
    
    if any(r)
    if any(c)
    	dens_c(r,c)=dens_c(r,c)+1;
    end
    end
end
dens_c(dens_c==0)=nan;
end

if nargin <=11
if nargin ==11
fprintf('\n     loading gridding counts from tmp_pscatter in current dir\r')
load tmp_pscatter Xa Ya Xc Yc *nut* step dens* beta_lin_samps*
end
fprintf('\n     bin averaging\r')
for i=1:length(tbins_a)-1
    bin_est = find(xa>=tbins_a(i) & xa<tbins_a(i+1));
    binned_samps1_a(i) = double(pmean(xa(bin_est)));
    std_samps1_a(i) = double(pstd(xa(bin_est)));
    num_samps1_a(i) = double(length(bin_est));
    binned_samps2_a(i) = double(pmean(ya(bin_est)));
    std_samps2_a(i) = double(pstd(ya(bin_est)));
    num_samps2_a(i) = length(bin_est);
end

for i=1:length(tbins_c)-1
    bin_est = find(xc>=tbins_c(i) & xc<tbins_c(i+1));
    binned_samps1_c(i) = double(pmean(xc(bin_est)));
    std_samps1_c(i) = double(pstd(xc(bin_est)));
    num_samps1_c(i) = double(length(bin_est));
    binned_samps2_c(i) = double(pmean(yc(bin_est)));
    std_samps2_c(i) = double(pstd(yc(bin_est)));
    num_samps2_c(i) = length(bin_est);
end


% linear least squared regession on binned data
fprintf('\n     Linear least squares regression on binned data \r')
[dumb,beta_lin_binned_c,S_lin_binned_c,delta_beta_lin_binned_c,S_crit_lin_binned_c]=reg(tbins_c(1:length(tbins_c)-1),binned_samps2_c,'lin');
newy_lin_binned_c=(beta_lin_binned_c(2).*binned_samps1_c)+beta_lin_binned_c(1);
[dumb,beta_lin_binned_a,S_lin_binned_a,delta_beta_lin_binned_a,S_crit_lin_binned_a]=reg(tbins_a(1:length(tbins_a)-1),binned_samps2_a,'lin');
newy_lin_binned_a=(beta_lin_binned_a(2).*binned_samps1_a)+beta_lin_binned_a(1);

fprintf('\n     Neutral least squares regression on samples \r')
igood=find(xa>=min(tbins_a) & xa<=max(tbins_a));
tx=xa(igood);
ty=ya(igood);
[beta_nut_samps_a(2),beta_nut_samps_a(1)]=wtls_line(double(tx),double(ty),ones(size(ty)).*errx,ones(size(ty)).*erry);

b=polyfit(tx,ty,1);
beta_lin_samps_a(2)=b(1);
beta_lin_samps_a(1)=b(2);

igood=find(xc>=min(tbins_c) & xc<=max(tbins_c));
tx=xc(igood);
ty=yc(igood);
[beta_nut_samps_c(2),beta_nut_samps_c(1)]=wtls_line(double(tx),double(ty),ones(size(ty)).*errx,ones(size(ty)).*erry);

fprintf('\n     Ordinary least squares regression on samples \r')
b=polyfit(tx,ty,1);
beta_lin_samps_c(2)=b(1);
beta_lin_samps_c(1)=b(2);
newy_nut_samps_a=(beta_nut_samps_a(2).*[min(xa):step:max(xa)])+beta_nut_samps_a(1);
newy_lin_samps_c=(beta_lin_samps_c(2).*[min(xc):step:max(xc)])+beta_lin_samps_c(1);
newy_nut_samps_c=(beta_nut_samps_c(2).*[min(xc):step:max(xc)])+beta_nut_samps_c(1);
newy_lin_samps_a=(beta_lin_samps_a(2).*[min(xa):step:max(xa)])+beta_lin_samps_a(1);

end

if nargin ==12
	fprintf('\n     loading gridding counts from tmp_pscatter in current dir\n')
	load tmp_pscatter
end	

if nargin < 12
save tmp_pscatter dens* new* beta* binned_samps* num_samps* std_samps* Xa Ya Xc Yc tbins* step
end


figure(23)
clf
hold on
pdens=(dens_a./max(dens_a(:))).*100;
pcolor(Xa.*step,Ya.*step,pdens);shading flat
contour(X.*step,Y.*step,pdens,[10:10:100],'color',[.8 .8 .8]);
colormap(pgray)
caxis([0 10])
errorbar(binned_samps1_a,binned_samps2_a,std_samps2_a,'r.')
%plot(tbins_a(1:length(tbins_a)-1),newy_lin_binned_a,'r')
plot([min(xa):step:max(xa)],newy_nut_samps_a,'k--')
%plot([min(x):step:max(x)],newy_lin_samps_a,'g--')
cc=colorbar;
ylabel(ylab)
xlabel({xlab,'',['\beta_{binned} = ',num2str(beta_lin_binned_a(2)),'  \beta_{lin} = ',num2str(beta_lin_samps_a(2)),'  \beta_{ort} = ',num2str(beta_nut_samps_a(2))]})
axis([min(cat(2,tbins_a,tbins_c))-2*step max(cat(2,tbins_a,tbins_c))+2*step min(cat(2,tbins_a,tbins_c))-2*step max(cat(2,tbins_a,tbins_c))+2*step])
%axes(cc)
%ylabel('N')

figure(24)
clf
hold on
pdens=(dens_c./max(dens_c(:))).*100;
pcolor(Xc.*step,Yc.*step,pdens);shading flat
contour(X.*step,Y.*step,pdens,[10:10:100],'color',[.8 .8 .8]);
colormap(pgray)
caxis([0 10])
errorbar(binned_samps1_c,binned_samps2_c,std_samps2_c,'b.')
%plot(tbins_c(1:length(tbins_c)-1),newy_lin_binned_c,'r')
plot([min(xc):step:max(xc)],newy_nut_samps_c,'k--')
%plot([min(xc):step:max(xc)],newy_lin_samps_c,'g--')
cc=colorbar;
ylabel(ylab)
xlabel({xlab,'',['\beta_{binned} = ',num2str(beta_lin_binned_c(2)),'  \beta_{lin} = ',num2str(beta_lin_samps_c(2)),'  \beta_{ort} = ',num2str(beta_nut_samps_c(2))]})
axis([min(cat(2,tbins_a,tbins_c))-2*step max(cat(2,tbins_a,tbins_c))+2*step min(cat(2,tbins_a,tbins_c))-2*step max(cat(2,tbins_a,tbins_c))+2*step])
%axes(cc)
%ylabel('N')
