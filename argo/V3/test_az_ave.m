%
load chaigneau_lat_lon_orgin_tracks.mat_argo_mask_km_comp.mat

step=10;
ri=step/2:step:250;
km_x=ri;
ff=f_cor(pmean(eddy_y));

eddy_dist_km=sqrt(eddy_dist_x.^2+eddy_dist_y.^2).*eddy_scale;

for m=1:length(km_x)-1
    ii=find(eddy_dist_km(ia)>=km_x(m) & eddy_dist_km(ia)<km_x(m+1));
    for n=1:length(ppres)
            ac_sigma(n,m)=pmean(eddy_ist(n,ia(ii)));
    end        
end   

ac_sigma=smooth2d_loess(eddy_ist(:,ia),eddy_dist_km(ia)',ppres,250,50,km_x,ppres);
cc_sigma=smooth2d_loess(eddy_ist(:,ic),eddy_dist_km(ic)',ppres,250,50,km_x,ppres);
[ac_v]=100*geostro_2d(ac_sigma,km_x(1:end-1),ppres,ff);
[cc_v]=100*geostro_2d(cc_sigma,km_x(1:end-1),ppres,ff);

%}
%make histograms
tbins=0:step:200;
[ba,nda]=phist(eddy_dist_km(ia),tbins);
[bc,ndc]=phist(eddy_dist_km(ic),tbins);
area=pi*tbins.^2;
narea=area(2:end)-area(1:end-1);
na=nda./narea;
nc=ndc./narea;

apdf=100*na./sum(na);
acpdf=cumsum(apdf);
cpdf=100*nc./sum(nc);
ccpdf=cumsum(cpdf);

load cha.pal
load bwr_min_w.pal
figure(7)
clf
set(gcf,'PaperPosition',[1 1 8.5 12])

dd=subplot(321);
stairs(tbins(1:end-1),nda,'r','linewidth',2)
ylabel('#','fontsize',15,'fontweight','bold');
set(dd,'position',[0.1300 0.8 0.33 0.1],'xtick',[0:50:200],'xticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.02 .02],'layer','top')
%text(100,300,'Geostrophic velocity','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
dd=axis;
text(0,dd(4)+20,'(a) anticyclones','fontsize',15,'fontweight','bold');

dd=subplot(323);
max_ac=max(abs(ac_v));
max_cc=max(abs(cc_v));
plot(km_x(1:end-1),max_ac,'r','linewidth',2)
ylabel('max spd (cm/s)','fontsize',15,'fontweight','bold');
set(dd,'position',[0.13 0.67 0.33 0.1],'xtick',[0:50:200],'xticklabel',[],'ytick',[0:5:50]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.02 .02],'layer','top')
axis([0 200 0 15])

dd=subplot(325);
contourf(km_x(1:end-1),ppres,ac_v,[-20:.5:20]);shading flat
axis ij
hold on
%contour(ri,ppres,ac_crl,[0 0],'k','linewidth',2,'color',[.5 .5 .5])
contour(km_x(1:end-1),ppres,ac_v,[-30:.5:-.05],'k--','linewidth',1)
contour(km_x(1:end-1),ppres,ac_v,[.05:.5:30],'k','linewidth',1)
caxis([-10 10])
axis([0 200 0 1000])
set(dd,'xtick',[0:50:200],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
set(dd,'position',[0.1300 0.15 0.33 0.5],'xtick',[0:50:200],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
get(dd,'position')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('km','fontsize',15,'fontweight','bold');
%text(2.26,960,'m s^{-1}','fontsize',15,'fontweight','bold');
text(175,1130,'contour interval 0.5 cm s^{-1}','fontsize',15);
colormap(cha)
text(100,-650,'Geostrophic velocity','fontsize',25,'fontweight','bold','Interpreter', 'Latex')

dd=subplot(322);
stairs(tbins(1:end-1),ndc,'b','linewidth',2)
set(dd,'position',[0.57 0.8 0.33 0.1],'xtick',[0:50:200],'xticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.02 .02],'layer','top')
dd=axis;
text(0,dd(4)+20,'(b) cyclones','fontsize',15,'fontweight','bold');

dd=subplot(324);
plot(km_x(1:end-1),max_cc,'b','linewidth',2)
set(dd,'position',[0.57 0.67 0.33 0.1],'xtick',[0:50:200],'xticklabel',[],'ytick',[0:5:50]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.02 .02],'layer','top')
axis([0 200 0 15])

dd=subplot(326);
contourf(km_x(1:end-1),ppres,cc_v,[-20:.5:20]);shading flat
axis ij
hold on
contour(km_x(1:end-1),ppres,cc_v,[-30:.5:-.05],'k--','linewidth',1)
contour(km_x(1:end-1),ppres,cc_v,[.05:.5:30],'k','linewidth',1)
caxis([-10 10])
axis([0 200 0 1000])
cc=colorbar;
set(dd,'position',[0.57 0.15 0.33 0.5],'xtick',[0:50:200],'ytick',[0:200:1000]','yticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
set(cc,'position',[0.5 0.15 0.025 0.5],'YAxisLocation','right','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'fontweight','bold','layer','top')
xlabel('km','fontsize',15,'fontweight','bold');
colormap(bwr_min_w)
print -dpng -r300 test;!open test.png