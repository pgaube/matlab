
clear all
load mean_gulf_stream
load ~/matlab/pop/mat/pop_model_domain.mat mask1
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
load ~/matlab/pop/mat/mean_chl mean_chl mean_lat mean_lon
load ~/matlab/pop/mat/mean_mdt_run14
[mean_u,mean_v]=geostro(lon,lat,mean_mdt,0.1);

chl_bar=interp2(mean_lon,mean_lat,mean_chl,lon,lat,'linear');
% % 
[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
lat=lat(r,c);
lon=lon(r,c);
mask=mask1(r,c);
mask(mask==0)=nan;
% %  
% % 
% u=mean_u(r,c);
% v=mean_v(r,c);
% su=smooth2d_loess(u,lon(1,:),lat(:,1),3,3,lon(1,:),lat(:,1)).*mask;
% sv=smooth2d_loess(v,lon(1,:),lat(:,1),3,3,lon(1,:),lat(:,1)).*mask;
% chl_bar=chl_bar(r,c);
% chl_bar=smooth2d_loess(chl_bar,lon(1,:),lat(:,1),2,2,lon(1,:),lat(:,1)).*mask;
% 
% % % 
% % % 
% % 
% 
% dcdx=smooth2d_loess(dfdx(lat,10.^chl_bar,.1),lon(1,:),lat(:,1),3,3,lon(1,:),lat(:,1)).*mask;
% dcdy=smooth2d_loess(dfdy(10.^chl_bar,.1),lon(1,:),lat(:,1),3,3,lon(1,:),lat(:,1)).*mask;
% mag_grad=smooth2d_loess(sqrt(dcdx.^2+dcdy.^2),lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1)).*mask;
% 
% % % % % % now caclulate cross stream grad chl
% theta=cart2pol(su,sv);
% % % 
% dcdn=-(sin(theta).*dcdx)+(cos(theta).*dcdy);
% dcdn=smooth2d_loess(dcdn,lon(1,:),lat(:,1),3,3,lon(1,:),lat(:,1));
% 
% save tmp_dcdn_run14 dcdn chl_bar su sv dcdx dcdy mag_grad
% 
% load tmp_dcdn_run14
% 
% % % return
% st=10;
% % streamline(lon,lat,u,v,lon(1:st:end,1:st:end),lat(1:st:end,1:st:end));
% figure(1)
% clf
% pmap(lon,lat,real(log10(chl_bar)),'gs');
% [xx,yy]=m_ll2xy(lon,lat);
% [verts averts] = streamslice(xx,yy,su.*mask,sv.*mask,2); 
% %pcolor(lon,lat,spd);shading flat;axis image
% caxis([log10(.03) log10(1)])
% hold on
% h=streamline([verts averts]);
% set(h,'color','k','linewidth',.5)
% print -dpng -r300 figs/mean_gchl_and_streamlines_run14

load tmp_dcdn_run14
load pop_bec_cor_0_run14_gridded slon slat tr0
rref=.12
[rp,cp]=imap(minlat,maxlat,minlon,maxlon,slat,slon);
slon=slon(rp,cp);slat=slat(rp,cp);
rmask=interp2(lon,lat,mask,slon,slat,'nearest');
sm_r0=smoothn(tr0(rp,cp,6),3).*rmask;

% tt=1e6.*dcdn.*mask;
% tt=1e6.*dcdn./(10.^chl_bar).*mask;
tt=1e6.*dcdn./(1e6*mag_grad).*mask;
figure(2)
clf
pmap(lon,lat,tt,'gs');
hold on
% m_contour(slon,slat,sm_r0,[rref rref],'k','linewidth',1)
m_contour(slon,slat,sm_r0,[-rref -rref],'k--','linewidth',1)
caxis([-4 4])
load bwr.pal
colormap(bwr)

print -dpng -r300 figs/dcdn_run_14
