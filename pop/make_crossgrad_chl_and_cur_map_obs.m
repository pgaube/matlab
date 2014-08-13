
clear all
load mean_gulf_stream
mean(:,1)=180+(180+mean(:,1));
%%%overide for obs
lons=mean(:,1);
lats=mean(:,2);
std_lats=std;

minlat=30;
maxlat=50;
minlon=290;
maxlon=max(mean(:,1));

% close all
load ~/data/gsm/mean_gchl.mat mean_gchl glon glat
load ~/data/aviso/mean_totat_geovel
rs_s=0.09
chl_bar=interp2(glon,glat,mean_gchl,lon,lat,'linear');
% 
[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
lat=lat(r,c);
lon=lon(r,c);
mask=nan*lat;
mask(abs(lat)>5)=1;
 

u=u(r,c);
v=v(r,c);
su=smooth2d_loess(u,lon(1,:),lat(:,1),3,3,lon(1,:),lat(:,1)).*mask;
sv=smooth2d_loess(v,lon(1,:),lat(:,1),3,3,lon(1,:),lat(:,1)).*mask;
chl_bar=chl_bar(r,c);
chl_bar=smooth2d_loess(chl_bar,lon(1,:),lat(:,1),2,2,lon(1,:),lat(:,1)).*mask;

% chl_bar=smoothn(chl_bar,40);
ff=f_cor(lat);
% 
% 

% 
% figure(1)
% clf
% pmap(lon,lat,1e5*(mag_grad./(10.^chl_bar)).*mask,'gs');
% return
% print -dpng -r300 figs/mag_grad_obs


dcdx=smooth2d_loess(dfdx(lat,10.^chl_bar,.25),lon(1,:),lat(:,1),3,3,lon(1,:),lat(:,1)).*mask;
dcdy=smooth2d_loess(dfdy(10.^chl_bar,.25),lon(1,:),lat(:,1),3,3,lon(1,:),lat(:,1)).*mask;
mag_grad=smooth2d_loess(sqrt(dcdx.^2+dcdy.^2),lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1)).*mask;

% % % % now caclulate cross stream grad chl
theta=cart2pol(su,sv);
% 
dcdn=-(sin(theta).*dcdx)+(cos(theta).*dcdy);
save tmp_dcdn dcdn chl_bar
% return
st=10;
% streamline(lon,lat,u,v,lon(1:st:end,1:st:end),lat(1:st:end,1:st:end));
figure(1)
clf
pmap(lon,lat,chl_bar,'gs');
[xx,yy]=m_ll2xy(lon,lat);
[verts averts] = streamslice(xx,yy,su,sv,2); 
%pcolor(lon,lat,spd);shading flat;axis image
caxis([log10(.03) log10(1)])
hold on
h=streamline([verts averts]);
set(h,'color','k','linewidth',.5)
print -dpng -r300 figs/mean_gchl_and_streamlines


load obs_cor_0 slon slat tr0
load tmp_dcdn
rref=.12
[rp,cp]=imap(minlat,maxlat,minlon,maxlon,slat,slon);
slon=slon(rp,cp);slat=slat(rp,cp);
rmask=ones(size(tr0(rp,cp,1)));
rmask(find(isnan(tr0(rp,cp,6))))=nan;
sm_r0=smoothn(tr0(rp,cp,6),3).*rmask;


dcdn=smooth2d_loess(dcdn,lon(1,:),lat(:,1),3,3,lon(1,:),lat(:,1));

tt=1e6.*dcdn./(1e6*mag_grad).*mask;
% tt=1e6.*dcdn.*mask;
figure(2)
clf
pmap(lon,lat,tt,'gs');
hold on
% m_contour(slon,slat,sm_r0,[rref rref],'k','linewidth',1)
m_contour(slon,slat,sm_r0,[-rref -rref],'k--','linewidth',1)
% caxis([-2.5 2.5])
caxis([-4 4])
load bwr.pal
colormap(bwr)

print -dpng -r300 figs/dcdn_obs
