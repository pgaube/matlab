function plot_rad_comps(input_file)

%
load rwp.pal
load cha_bwr.pal
load cha.pal
load chelle.pal
load bwr.pal

load(input_file)
c_spd=pmean(prop_speed)/100;


for m=1:length(ppres)
	ac_max_speed(m)=max(abs(ac_v(m,:)));
	cc_max_speed(m)=max(abs(cc_v(m,:)));
end

ac_non=ac_max_speed./c_spd;
cc_non=cc_max_speed./c_spd;

i_non_ac=find(ac_non<1);
i_non_ac=i_non_ac(1);
i_non_cc=find(cc_non<1);
i_non_cc=i_non_cc(1);

ac_crl=dfdx_m(ac_v,.05);
cc_crl=dfdx_m(cc_v,.05);


%
%map
lon=min(eddy_x)-5:max(eddy_x)+5;
lat=min(eddy_y)-5:max(eddy_y)+5;
figure(1)
clf
pmap(lon,lat,nan(length(lat),length(lon)))
hold on
iia=find(eddy_dist(ia)<=2);
iic=find(eddy_dist(ic)<=2);
na=length(iia);
nc=length(iic);
for m=1:length(iia)
	m_plot(eddy_plon(iia(m)),eddy_plat(iia(m)),'r.')
end

for m=1:length(iic)
	m_plot(eddy_plon(iic(m)),eddy_plat(iic(m)),'b.')
end
title([num2str(na),' profiles in AC and ',num2str(nc),' profiles in CC'])
drawnow

%

%scatter of profiles within eddy
xx=eddy_dist_x(ia);
yy=eddy_dist_y(ia);
figure(2)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
scatter(xx,yy,'r.','linewidth',3)
hold on
dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
[x,y]=cylinder(1,100);
plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
title([num2str(na),' profiles in AC'],'fontsize',35,'fontweight','bold','Interpreter', 'Latex')
axis([-2 2 -2 2])

xx=eddy_dist_x(ic);
yy=eddy_dist_y(ic);
figure(3)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
scatter(xx,yy,'b.','linewidth',3)
dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
hold on
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
[x,y]=cylinder(1,100);
plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
title([num2str(nc),' profiles in CC'],'fontsize',35,'fontweight','bold','Interpreter', 'Latex')
axis([-2 2 -2 2])


figure(4)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
dd=subplot(121);
contourf(ri,ppres,ac_sigma,[2:.5:40]);shading flat
axis ij
hold on
axis([0 2 0 1000])
text(0,-40,'(a) anticyclones','fontsize',15,'fontweight','bold');
caxis([24 32])
set(dd,'position',[0.13 0.11 0.26 0.75],'xtick',[-2 -1 0 1 2],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'layer','top')
text(1,-150,'Pontential density structure','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('normlized radial distance','fontsize',15,'fontweight','bold');
text(2.26,960,'(kg m^{-3})','fontsize',15,'fontweight','bold');

bb=subplot(122);
contourf(ri,ppres,cc_sigma,[2:.5:40]);shading flat
axis ij
hold on
axis([0 2 0 1000])
text(0,-40,'(b) cyclones','fontsize',15,'fontweight','bold');
cc=colorbar;
set(cc,'position',[0.45 0.17 0.0317 0.65],'YAxisLocation','right','fontsize',20,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'fontweight','bold','layer','top')
colormap(chelle)
set(bb,'position',[0.570341 0.11 0.26 0.75],'xtick',[-2 -1 0 1 2],'ytick',[],'fontsize',15,'LineWidth',2,'fontweight','bold','TickLength',[0 0],'layer','top')
xlabel('normlized radial distance','fontsize',15,'fontweight','bold');
colormap(cha)

%
figure(5)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
dd=subplot(121);
contourf(ri,ppres,ac_t,[-2:.1:2]);shading flat
axis ij
hold on
caxis([-1 1])
axis([0 2 0 1000])
text(0,-40,'(a) anticyclones','fontsize',15,'fontweight','bold');
set(dd,'position',[0.13 0.11 0.26 0.75],'xtick',[-2 -1 0 1 2],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'layer','top')
text(1,-150,'Temperature anomalies','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('normlized radial distance','fontsize',15,'fontweight','bold');
text(2.26,960,'^\circC','fontsize',15,'fontweight','bold');

bb=subplot(122);
contourf(ri,ppres,cc_t,[-2:.1:2]);shading flat
axis ij
hold on
caxis([-1 1])
axis([0 2 0 1000])
text(0,-40,'(b) cyclones','fontsize',15,'fontweight','bold');
cc=colorbar;
set(cc,'position',[0.45 0.17 0.0317 0.65],'YAxisLocation','right','fontsize',20,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'fontweight','bold','layer','top')
colormap(chelle)
set(bb,'position',[0.570341 0.11 0.26 0.75],'xtick',[-2 -1 0 1 2],'ytick',[],'fontsize',15,'LineWidth',2,'fontweight','bold','TickLength',[0 0],'layer','top')
xlabel('normlized radial distance','fontsize',15,'fontweight','bold');
colormap(cha)

figure(6)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
dd=subplot(121);
contourf(ri,ppres,ac_s,[-2:.01:2]);shading flat
axis ij
hold on
caxis([-.1 .1])
axis([0 2 0 1000])
text(0,-40,'(a) anticyclones','fontsize',15,'fontweight','bold');
set(dd,'position',[0.13 0.11 0.26 0.75],'xtick',[-2 -1 0 1 2],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'layer','top')
text(1,-150,'Salinity anomalies','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('normlized radial distance','fontsize',15,'fontweight','bold');
text(2.26,960,'PSU','fontsize',15,'fontweight','bold');

bb=subplot(122);
contourf(ri,ppres,cc_s,[-2:.01:2]);shading flat
axis ij
hold on
caxis([-.1 .1])
axis([0 2 0 1000])
text(0,-40,'(b) cyclones','fontsize',15,'fontweight','bold');
cc=colorbar;
set(cc,'position',[0.45 0.17 0.0317 0.65],'YAxisLocation','right','fontsize',20,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'fontweight','bold','layer','top')
colormap(chelle)
set(bb,'position',[0.570341 0.11 0.26 0.75],'xtick',[-2 -1 0 1 2],'ytick',[],'fontsize',15,'LineWidth',2,'fontweight','bold','TickLength',[0 0],'layer','top')
xlabel('normlized radial distance','fontsize',15,'fontweight','bold');
colormap(cha)

figure(7)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
dd=subplot(121);
contourf(ri,ppres,ac_v,[-2:.005:2]);shading flat
axis ij
hold on
contour(ri,ppres,ac_crl,[0 0],'k','linewidth',2,'color',[.5 .5 .5])
contour(ri,ppres,ac_v,[-.3:.05:-.05],'k--','linewidth',1)
contour(ri,ppres,ac_v,[.05:.05:.3],'k','linewidth',1)
caxis([-.1 .1])
axis([0 2 0 1000])
text(0,-40,'(a) anticyclones','fontsize',15,'fontweight','bold');
set(dd,'position',[0.13 0.11 0.26 0.75],'xtick',[-2 -1 0 1 2],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'layer','top')
text(1,-150,'Geostrophic velocity','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('normlized radial distance','fontsize',15,'fontweight','bold');
text(2.26,960,'m s^{-1}','fontsize',15,'fontweight','bold');
text(2,1130,'contour interval 5 cm s^{-1}','fontsize',15);
colormap(cha)

bb=subplot(122);
contourf(ri,ppres,cc_v,[-2:.005:2]);shading flat
axis ij
hold on
contour(ri,ppres,cc_crl,[0 0],'k','linewidth',2,'color',[.5 .5 .5])
contour(ri,ppres,cc_v,[-.3:.05:-.05],'k--','linewidth',1)
contour(ri,ppres,cc_v,[.05:.05:.3],'k','linewidth',1)
caxis([-.1 .1])
axis([0 2 0 1000])
text(0,-40,'(b) cyclones','fontsize',15,'fontweight','bold');
cc=colorbar;
set(cc,'position',[0.45 0.17 0.0317 0.65],'YAxisLocation','right','fontsize',20,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'fontweight','bold','layer','top')
colormap(chelle)
set(bb,'position',[0.570341 0.11 0.26 0.75],'xtick',[-2 -1 0 1 2],'ytick',[],'fontsize',15,'LineWidth',2,'fontweight','bold','TickLength',[0 0],'layer','top')
xlabel('normlized radial distance','fontsize',15,'fontweight','bold');
colormap(cha)


figure(8)
clf
set(gcf,'PaperPosition',[1 1 5 8.5])
dd=axes;
plot(cc_max_speed./c_spd,ppres,'b','linewidth',2)
hold on
plot(ac_max_speed./c_spd,ppres,'r','linewidth',2)
axis ij
line([1 1],[0 1000],'color','k','linewidth',1)
line([0 8],[ppres(i_non_ac) ppres(i_non_ac)],'color','r','linewidth',1)
line([0 8],[ppres(i_non_cc) ppres(i_non_cc)],'color','b','linewidth',1)
text(4,ppres(i_non_ac)+30,[num2str(ppres(i_non_ac)) ' m'],'fontsize',15,'fontweight','bold','color','r');
text(4,ppres(i_non_cc)+30,[num2str(ppres(i_non_cc)) ' m'],'fontsize',15,'fontweight','bold','color','b');
set(dd,'position',[0.22 0.11 0.65 0.75],'xtick',[0:5],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'layer','top')
text(-.06,-118,'Vertical profiles of  U/c','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
text(.51,-60,['$c=$',num2str(round(10000*c_spd)/100),' $cm \ s^{-1}$'],'fontsize',25,'fontweight','bold','Interpreter', 'Latex')

ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('U/c','fontsize',15,'fontweight','bold');
axis([0 5 0 1000])
%}

figure(9)
clf
set(gcf,'PaperPosition',[1 1 5 8.5])
dd=axes;
plot(100*cc_max_speed,ppres,'b','linewidth',2)
hold on
plot(100*ac_max_speed,ppres,'r','linewidth',2)
axis ij

line([100*c_spd 100*c_spd],[0 1000],'color','k','linewidth',1)
line([0 8],[ppres(i_non_ac) ppres(i_non_ac)],'color','r','linewidth',1)
line([0 8],[ppres(i_non_cc) ppres(i_non_cc)],'color','b','linewidth',1)
text(4,ppres(i_non_ac)+30,[num2str(ppres(i_non_ac)) ' m'],'fontsize',15,'fontweight','bold','color','r');
text(4,ppres(i_non_cc)+30,[num2str(ppres(i_non_cc)) ' m'],'fontsize',15,'fontweight','bold','color','b');
set(dd,'position',[0.22 0.11 0.65 0.75],'xtick',[0:100],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'layer','top')
text(-.06,-118,'Vertical profiles of  U/c','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
text(.51,-60,['$c=$',num2str(round(10000*c_spd)/100),' $cm \ s^{-1}$'],'fontsize',25,'fontweight','bold','Interpreter', 'Latex')

ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('U/c','fontsize',15,'fontweight','bold');
axis([0 12 0 1000])


%make histograms
step=.1;
tbins=0:step:2;
[ba,nda]=phist(eddy_dist(ia),tbins);
[bc,ndc]=phist(eddy_dist(ic),tbins);
area=pi*tbins.^2;
narea=area(2:end)-area(1:end-1);
na=nda./narea;
nc=ndc./narea;

apdf=100*na./sum(na);
acpdf=cumsum(apdf);
cpdf=100*nc./sum(nc);
ccpdf=cumsum(cpdf);

figure(10)
clf
set(gcf,'PaperPosition',[1 1 10 5])
dd=subplot(121);
stairs(tbins(1:end-1),na,'r','linewidth',2)
hold on
stairs(tbins(1:end-1),nc,'b','linewidth',2)
title('profiles per unit area','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
ylabel('N(r)/area(r)','fontsize',15,'fontweight','bold');
xlabel('eddy radi (L_s)','fontsize',15,'fontweight','bold');
set(dd,'xtick',[0:.5:5],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .05],'layer','top')

dd=subplot(122);
stairs(tbins(1:end-1),acpdf,'r','linewidth',2)
hold on
stairs(tbins(1:end-1),ccpdf,'b','linewidth',2)
title('CPDF','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
ylabel('%','fontsize',15,'fontweight','bold');
xlabel('eddy radi (L_s)','fontsize',15,'fontweight','bold');
set(dd,'xtick',[0:.5:5],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .05],'layer','top')

return
