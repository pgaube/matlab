function plot_rad_comps_km(input_file,output_dir)

if ~exist(output_dir)
    eval(['mkdir ',output_dir])
end

%
load rwp.pal
load cha_bwr.pal
load cha.pal
load chelle.pal
load bwr.pal

load(input_file)
ac_v=ac_v_dh;
cc_v=cc_v_dh;

ac_v=100*ac_v;
cc_v=100*cc_v;
c_spd=pmean(prop_speed);
%c_spd=4.3

iin=find(km_x<=pmean(eddy_scale));
for m=1:length(ppres)
    if pmean(eddy_y)>0
        ac_max_speed(m)=abs(min(ac_v(m,iin)));
        cc_max_speed(m)=max(cc_v(m,iin));
        ac_imax(m)=km_x(find(abs(ac_v(m,iin))==ac_max_speed(m)));
        cc_imax(m)=km_x(find(cc_v(m,iin)==cc_max_speed(m)));
    else
        ac_max_speed(m)=max(ac_v(m,iin))
        cc_max_speed(m)=abs(min(cc_v(m,iin)));
        ac_imax(m)=km_x(find(ac_v(m,iin)==ac_max_speed(m)));
        cc_imax(m)=km_x(find(abs(cc_v(m,iin))==cc_max_speed(m)));
    end    
end

ac_non=ac_max_speed./c_spd;
cc_non=cc_max_speed./c_spd;

i_non_ac=find(ac_non<1);
if any(i_non_ac)
    i_non_ac=i_non_ac(1);
end    
i_non_cc=find(cc_non<1);
if any(i_non_cc)
    i_non_cc=i_non_cc(1);
end 

ac_crl=dfdx_m(smoothn(ac_v,5),.05);
cc_crl=dfdx_m(smoothn(cc_v,5),.05);

%
%map


%figure out if there are all nan profiles
tt_t=eddy_it;
tt_t(isnan(tt_t))=0;
flag_t=sum(tt_t,1);

tt_s=eddy_is;
tt_s(isnan(tt_s))=0;
flag_s=sum(tt_s,1);

ibad=find(flag_s==0 & flag_t==0);
igood=find(flag_s~=0 & flag_t~=0);


%now only find those trapped
ia=find(eddy_cyc==1 & ~isnan(eddy_in_comp) & flag_t'~=0 & flag_s'~=0);
ic=find(eddy_cyc==-1 & ~isnan(eddy_in_comp) & flag_t'~=0 & flag_s'~=0);
igoods=cat(1,ia,ic);
na=length(ia);
nc=length(ic);

%
%first cyclones
figure(1)
clf
set(gcf,'PaperPosition',[1 1 11 8.5])
dd=subplot(3,3,[1 2 4 5]);
pp=get(dd,'position');
pmap(dlon,dlat,nan(length(dlat),length(dlon)))
hold on

for m=1:length(ic)
	m_plot(eddy_plon(ic(m)),eddy_plat(ic(m)),'b.','linewidth',1)
end
title([num2str(nc),' profiles in cyclones'],'fontsize',20,'fontweight','bold')
set(gca,'fontsize',20,'LineWidth',2,'TickLength',[.1 .05],'layer','top')

lon=dlon(1):dlon(end)+1;

if dlat(end)<1;
    lat=dlat(1):-1:dlat(end)-1
else
    lat=dlat(1):dlat(end)+1;
end
    
dd=subplot(3,3,[3 6]);
qq=get(dd,'position');
[b,nlat]=phist(abs(eddy_y(ic)),abs(lat)); 

stairs(nlat,lat(1:end-1),'b','LineWidth',2)
set(dd,'xtick',[0:50:200],'YAxisLocation','right','xAxisLocation','top','position',[qq(1) pp(2)+(pp(2)*.15) qq(3) pp(4)-(pp(4)*.25)])
view(dd,[180 90]);
axis ij
axis tight
set(dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .005],'layer','top')
ylabel('lat','fontsize',20,'fontweight','bold')
xlabel('N','fontsize',20,'fontweight','bold')
grid

dd=subplot(3,3,[7 8]);
[b,nlon]=phist(eddy_x(ic),lon);
stairs(lon(1:end-1),nlon,'b','LineWidth',2)
%set(dd,'YAxisLocation','right')
%view(dd,[180 90]);
axis tight
set(dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .005],'layer','top')
xlabel('lat','fontsize',20,'fontweight','bold')
ylabel('N','fontsize',20,'fontweight','bold')
grid

dd=subplot(3,3,[9]);
[yea,mnm,dnd]=jd2jdate(eddy_pjday(ic));
yea=yea-2000;
tyears=min(yea):max(yea)+1;
[b,ntime]=phist(yea,tyears);
stairs(tyears(1:end-1),ntime,'b','LineWidth',2)
set(dd,'xtick',[01:2:12],'fontsize',20,'YAxisLocation','right','LineWidth',2,'TickLength',[.01 .005],'layer','top')
xlabel('year since 2000','fontsize',20,'fontweight','bold')
ylabel('N','fontsize',20,'fontweight','bold')
grid
axis tight
eval(['print -dpng -r300  ',output_dir '/map_and_hist_cyclones'])

%now anticyclones
figure(1)
clf
set(gcf,'PaperPosition',[1 1 11 8.5])
dd=subplot(3,3,[1 2 4 5]);
pp=get(dd,'position');
pmap(dlon,dlat,nan(length(dlat),length(dlon)))
hold on

for m=1:length(ia)
	m_plot(eddy_plon(ia(m)),eddy_plat(ia(m)),'r.','linewidth',1)
end
title([num2str(na),' profiles in anticyclones'],'fontsize',20,'fontweight','bold')
set(gca,'fontsize',20,'LineWidth',2,'TickLength',[.1 .05],'layer','top')

dd=subplot(3,3,[3 6]);
qq=get(dd,'position');
[b,nlat]=phist(abs(eddy_y(ia)),abs(lat));
stairs(nlat,lat(1:end-1),'r','LineWidth',2)
set(dd,'xtick',[0:50:200],'YAxisLocation','right','xAxisLocation','top','position',[qq(1) pp(2)+(pp(2)*.15) qq(3) pp(4)-(pp(4)*.25)])
view(dd,[180 90]);
axis ij
axis tight
set(dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .005],'layer','top')
ylabel('lat','fontsize',20,'fontweight','bold')
xlabel('N','fontsize',20,'fontweight','bold')
grid

dd=subplot(3,3,[7 8]);
[b,nlon]=phist(eddy_x(ia),lon);
stairs(lon(1:end-1),nlon,'r','LineWidth',2)
%set(dd,'YAxisLocation','right')
%view(dd,[180 90]);
axis tight
set(dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .005],'layer','top')
xlabel('lat','fontsize',20,'fontweight','bold')
ylabel('N','fontsize',20,'fontweight','bold')
grid

dd=subplot(3,3,[9]);
[yea,mnm,dnd]=jd2jdate(eddy_pjday(ia));
yea=yea-2000;
tyears=min(yea):max(yea)+1;
[b,ntime]=phist(yea,tyears);
stairs(tyears(1:end-1),ntime,'r','LineWidth',2)
set(dd,'xtick',[01:2:12],'fontsize',20,'YAxisLocation','right','LineWidth',2,'TickLength',[.01 .005],'layer','top')
xlabel('year since 2000','fontsize',20,'fontweight','bold')
ylabel('N','fontsize',20,'fontweight','bold')
grid
axis tight
eval(['print -dpng -r300  ',output_dir '/map_and_hist_anticyclones'])



%scatter of profiles within eddy
xx=eddy_dist_x(ia);
yy=eddy_dist_y(ia);
figure(2)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
scatter(xx,yy,'r.','linewidth',5)
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
eval(['print -dpng -r300  ',output_dir '/profiles_in_anticyclones'])

xx=eddy_dist_x(ic);
yy=eddy_dist_y(ic);
figure(3)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
scatter(xx,yy,'b.','linewidth',10)
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
eval(['print -dpng -r300  ',output_dir '/profiles_in_cyclones'])


%}
%make histograms
%step=10;
tbins=km_x;
%[ba,nda]=phist(eddy_dist_km(ia),tbins)
%[bc,ndc]=phist(eddy_dist_km(ic),tbins)
area=pi*tbins.^2;
narea=area(2:end)-area(1:end-1);
%na=nda./narea;
%nc=ndc./narea;

apdf=100*na./sum(na);
acpdf=cumsum(apdf);
cpdf=100*nc./sum(nc);
ccpdf=cumsum(cpdf);

%maxes
rmax_ac=max(abs(ac_v));
rmax_cc=max(abs(cc_v));



%plot gvel
figure(7)
clf
set(gcf,'PaperPosition',[1 1 8.5 12])

dd=subplot(321);
stairs(tbins,ndc,'b','linewidth',2)
ylabel('#','fontsize',15,'fontweight','bold');
set(dd,'position',[0.1300 0.8 0.33 0.1],'xlim',[0 150],'xtick',[0:50:200],'ytick',[0:50:200],'ylim',[0 200],'xlim',[0 200],'xticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.02 .02],'layer','top')
%text(100,300,'Geostrophic velocity','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
line([pmean(eddy_scale(ic)),pmean(eddy_scale(ic))],[0 200],'color',[.5 .5 .5],'linestyle','--','linewidth',2)
dd=axis;
text(0,dd(4)+20,'(a) cyclones','fontsize',15,'fontweight','bold');

dd=subplot(323);
plot(km_x,rmax_cc,'b','linewidth',2)
ylabel('max spd (cm/s)','fontsize',15,'fontweight','bold');
line([pmean(eddy_scale(ic)),pmean(eddy_scale(ic))],[0 30],'color',[.5 .5 .5],'linestyle','--','linewidth',2)
set(dd,'position',[0.13 0.67 0.33 0.1],'xtick',[0:50:200],'xticklabel',[],'ytick',[0:5:50]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.02 .02],'layer','top')
axis([0 200 0 30])

dd=subplot(325);
contourf(km_x,ppres,cc_v,[-100:100]);shading flat
axis ij
hold on
%contour(km_x(iin),ppres,cc_crl(:,iin),[0 0],'k','linewidth',4,'color','k');
plot(cc_imax,ppres,'k','linewidth',4)
[cs,h]=contour(km_x,ppres,cc_v,[-100:-1],'k--','linewidth',1);
clabel(cs,h,'fontsize',12);
[cs,h]=contour(km_x,ppres,cc_v,[1:100],'k','linewidth',1);
clabel(cs,h,'fontsize',12)
caxis([-20 20])
axis([0 200 0 1000])
set(dd,'xtick',[0:50:200],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
set(dd,'position',[0.1300 0.15 0.33 0.5],'xtick',[0:50:200],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('km','fontsize',15,'fontweight','bold');
%text(2.26,960,'m s^{-1}','fontsize',15,'fontweight','bold');
text(175,1130,'contour interval 1 cm s^{-1}','fontsize',15);
text(100,-650,'Geostrophic velocity','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
line([pmean(eddy_scale(ia)),pmean(eddy_scale(ia))],[0 1000],'color',[.5 .5 .5],'linestyle','--','linewidth',2)

dd=subplot(322);
stairs(tbins,nda,'r','linewidth',2)
set(dd,'position',[0.57 0.8 0.33 0.1],'xlim',[0 150],'xtick',[0:50:200],'ytick',[0:50:200],'ylim',[0 200],'xlim',[0 200],'xticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.02 .02],'layer','top')
dd=axis;
line([pmean(eddy_scale(ia)),pmean(eddy_scale(ia))],[0 200],'color',[.5 .5 .5],'linestyle','--','linewidth',2)
text(0,dd(4)+20,'(b) anticyclones','fontsize',15,'fontweight','bold');

dd=subplot(324);
plot(km_x,rmax_ac,'r','linewidth',2)
line([pmean(eddy_scale(ic)),pmean(eddy_scale(ic))],[0 30],'color',[.5 .5 .5],'linestyle','--','linewidth',2)
set(dd,'position',[0.57 0.67 0.33 0.1],'xtick',[0:50:200],'xticklabel',[],'ytick',[0:5:50]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.02 .02],'layer','top')
axis([0 200 0 30])

dd=subplot(326);
contourf(km_x,ppres,ac_v,[-100:100]);shading flat
axis ij
hold on
%contour(km_x(iin),ppres,ac_crl(:,iin),[0 0],'linewidth',4,'color','k');
plot(ac_imax,ppres,'k','linewidth',4)
[cs,h]=contour(km_x,ppres,ac_v,[-100:-1],'k--','linewidth',1);
clabel(cs,h,'fontsize',12);
[cs,h]=contour(km_x,ppres,ac_v,[1:100],'k','linewidth',1);
clabel(cs,h,'fontsize',12);
caxis([-20 20])
axis([0 200 0 1000])
cc=colorbar;
set(dd,'position',[0.57 0.15 0.33 0.5],'xtick',[0:50:200],'ytick',[0:200:1000]','yticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
set(cc,'position',[0.5 0.15 0.025 0.5],'YAxisLocation','right','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'fontweight','bold','layer','top')
text(-50,1040,'cm/s','fontsize',15,'fontweight','bold');
xlabel('km','fontsize',15,'fontweight','bold');
line([pmean(eddy_scale(ic)),pmean(eddy_scale(ic))],[0 1000],'color',[.5 .5 .5],'linestyle','--','linewidth',2)
colormap(chelle)
eval(['print -dpng -r300  ',output_dir '/gvel_comps'])

%
%sigma
figure(4)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
dd=subplot(121);
contourf(km_x,ppres,cc_sigma,[2:.5:40]);shading flat
axis ij
hold on
axis([0 200 0 1000])
text(0,-40,'(a) cyclones','fontsize',15,'fontweight','bold');
caxis([24 32])
set(dd,'position',[0.13 0.11 0.26 0.75],'xtick',[0:50:200],'ytick',[0:200:1000]','yticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
text(100,-150,'Pontential density structure','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('km','fontsize',15,'fontweight','bold');
text(226,960,'(kg m^{-3})','fontsize',15,'fontweight','bold');

bb=subplot(122);
contourf(km_x,ppres,ac_sigma,[2:.5:40]);shading flat
axis ij
hold on
axis([0 200 0 1000])
text(0,-40,'(b) anticyclones','fontsize',15,'fontweight','bold');
cc=colorbar;
set(cc,'position',[0.45 0.17 0.0317 0.65],'YAxisLocation','right','fontsize',20,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'fontweight','bold','layer','top')
colormap(chelle)
set(bb,'position',[0.570341 0.11 0.26 0.75],'xtick',[0:50:200],'ytick',[0:200:1000]','yticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
xlabel('km','fontsize',15,'fontweight','bold');
colormap(chelle)
eval(['print -dpng -r300  ',output_dir '/sigma_comps'])

%DH
figure(4)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
dd=subplot(121);
contourf(km_x,ppres,100*cc_dh,[0:10:500]);shading flat
hold on
[cs,h]=contour(km_x,ppres,100*cc_dh,[0:10:500],'k');
clabel(cs,h,'fontsize',12);
axis ij
hold on
axis([0 200 0 1000])
text(0,-40,'(a) cyclones','fontsize',15,'fontweight','bold');
caxis([24 32])
set(dd,'position',[0.13 0.11 0.26 0.75],'xtick',[0:50:200],'ytick',[0:200:1000]','yticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
text(100,-150,'Dynamic height','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('km','fontsize',15,'fontweight','bold');
text(226,960,'(cm)','fontsize',15,'fontweight','bold');
caxis([0 150])

bb=subplot(122);
contourf(km_x,ppres,100*ac_dh,[0:10:500]);shading flat
axis ij
hold on
[cs,h]=contour(km_x,ppres,100*ac_dh,[0:10:500],'k');
clabel(cs,h,'fontsize',12);
axis([0 200 0 1000])
text(0,-40,'(b) anticyclones','fontsize',15,'fontweight','bold');
cc=colorbar;
set(cc,'position',[0.45 0.17 0.0317 0.65],'YAxisLocation','right','fontsize',20,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'fontweight','bold','layer','top')
colormap(chelle)
set(bb,'position',[0.570341 0.11 0.26 0.75],'xtick',[0:50:200],'ytick',[0:200:1000]','yticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
xlabel('km','fontsize',15,'fontweight','bold');
colormap(chelle)
caxis([0 150])

eval(['print -dpng -r300  ',output_dir '/dh_comps'])
%{
%DH STD
figure(4)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
dd=subplot(121);
contourf(km_x,ppres,100*ac_std_dh,[0:1:500]);shading flat
hold on
[cs,h]=contour(km_x,ppres,100*ac_std_dh,[0:1:500],'k');
clabel(cs,h,'fontsize',12);
axis ij
hold on
axis([0 200 0 1000])
text(0,-40,'(a) anticyclones','fontsize',15,'fontweight','bold');
caxis([24 32])
set(dd,'position',[0.13 0.11 0.26 0.75],'xtick',[0:50:200],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
text(100,-150,'STD of Dynamic height','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('km','fontsize',15,'fontweight','bold');
text(226,960,'(cm)','fontsize',15,'fontweight','bold');
caxis([0 15])

bb=subplot(122);
contourf(km_x,ppres,100*cc_std_dh,[0:1:500]);shading flat
axis ij
hold on
[cs,h]=contour(km_x,ppres,100*cc_std_dh,[0:1:500],'k');
clabel(cs,h,'fontsize',12);
axis([0 200 0 1000])
text(0,-40,'(b) cyclones','fontsize',15,'fontweight','bold');
cc=colorbar;
set(cc,'position',[0.45 0.17 0.0317 0.65],'YAxisLocation','right','fontsize',20,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'fontweight','bold','layer','top')
colormap(chelle)
set(bb,'position',[0.570341 0.11 0.26 0.75],'xtick',[0:50:200],'ytick',[0:200:1000]','yticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
xlabel('km','fontsize',15,'fontweight','bold');
colormap(chelle)
caxis([0 15])

eval(['print -dpng -r300  ',output_dir '/dh_std_comps'])
%}
%
%dh anom
%
figure(12)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
dd=subplot(122);
contourf(km_x,ppres,100*ac_dh_anom,[-20:.5:20]);shading flat
hold on
[cs,h]=contour(km_x,ppres,100*ac_dh_anom,[-20:.5:-.5],'k--','linewidth',1);
clabel(cs,h,'fontsize',12);
[cs,h]=contour(km_x,ppres,100*ac_dh_anom,[0:.5:20],'k','linewidth',1);
clabel(cs,h,'fontsize',12);
axis ij
hold on
axis([0 200 0 1000])
text(0,-40,'(b) anticyclones','fontsize',15,'fontweight','bold');
caxis([-10 10])
cc=colorbar;
set(cc,'position',[0.45 0.17 0.0317 0.65],'YAxisLocation','right','fontsize',20,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'fontweight','bold','layer','top')
colormap(chelle)
set(dd,'position',[0.570341 0.11 0.26 0.75],'xtick',[0:50:200],'ytick',[0:200:1000]','yticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('km','fontsize',15,'fontweight','bold');

bb=subplot(121);
contourf(km_x,ppres,100*cc_dh_anom,[-20:.5:20]);shading flat
hold on
[cs,h]=contour(km_x,ppres,100*cc_dh_anom,[-20:.5:-.5],'k--','linewidth',1);
clabel(cs,h,'fontsize',12);
[cs,h]=contour(km_x,ppres,100*cc_dh_anom,[0:.5:20],'k','linewidth',1);
clabel(cs,h,'fontsize',12);
axis ij
hold on
axis([0 200 0 1000])
text(0,-40,'(a) cyclones','fontsize',15,'fontweight','bold');
set(bb,'position',[0.13 0.11 0.26 0.75],'xtick',[0:50:200],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
text(100,-150,'Dynamic height anomaly','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
xlabel('km','fontsize',15,'fontweight','bold');
colormap(chelle)
caxis([-10 10])
text(226,960,'cm','fontsize',15,'fontweight','bold');
eval(['print -dpng -r300  ',output_dir '/dh_anom_comps'])


%temp
figure(5)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
dd=subplot(121);
contourf(km_x,ppres,cc_t,[-20:.1:20]);shading flat
axis ij
hold on
axis([0 200 0 1000])
text(0,-40,'(a) cyclones','fontsize',15,'fontweight','bold');
caxis([-1 1])
set(dd,'position',[0.13 0.11 0.26 0.75],'xtick',[0:50:200],'ytick',[0:200:1000]','yticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
text(100,-150,'Temperature anomaly','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('km','fontsize',15,'fontweight','bold');
text(226,960,'^\circC','fontsize',15,'fontweight','bold');


bb=subplot(122);
contourf(km_x,ppres,ac_t,[-20:.1:20]);shading flat
axis ij
hold on
caxis([-1 1])
axis([0 200 0 1000])
text(0,-40,'(b) anticyclones','fontsize',15,'fontweight','bold');
cc=colorbar;
caxis([-1 1])
set(cc,'position',[0.45 0.17 0.0317 0.65],'YAxisLocation','right','fontsize',20,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'fontweight','bold','layer','top')
colormap(chelle)
set(bb,'position',[0.570341 0.11 0.26 0.75],'xtick',[0:50:200],'ytick',[0:200:1000]','yticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
xlabel('km','fontsize',15,'fontweight','bold');
colormap(chelle)
eval(['print -dpng -r300  ',output_dir '/temp_comps'])

%salinity
figure(6)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
dd=subplot(121);
contourf(km_x,ppres,cc_s,[-20:.01:20]);shading flat
axis ij
hold on
axis([0 200 0 1000])
text(0,-40,'(a) cyclones','fontsize',15,'fontweight','bold');
caxis([-.1 .1])
set(dd,'position',[0.13 0.11 0.26 0.75],'xtick',[0:50:200],'ytick',[0:200:1000]','yticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
text(100,-150,'Salinty anomaly','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('km','fontsize',15,'fontweight','bold');
text(226,960,'PSU','fontsize',15,'fontweight','bold');

bb=subplot(122);
contourf(km_x,ppres,ac_s,[-20:.01:20]);shading flat
axis ij
hold on
caxis([-.1 .1])
axis([0 200 0 1000])
text(0,-40,'(b) anticyclones','fontsize',15,'fontweight','bold');
cc=colorbar;
set(cc,'position',[0.45 0.17 0.0317 0.65],'YAxisLocation','right','fontsize',20,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'fontweight','bold','layer','top')
colormap(chelle)
set(bb,'position',[0.570341 0.11 0.26 0.75],'xtick',[0:50:200],'ytick',[0:200:1000]','yticklabel',[],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.01 .01],'layer','top')
xlabel('km','fontsize',15,'fontweight','bold');
colormap(chelle)
eval(['print -dpng -r300  ',output_dir '/sal_comps'])

%}
%speed
figure(9)
clf
set(gcf,'PaperPosition',[1 1 5 8.5],'clipping','off')
dd=axes;
plot(cc_max_speed,ppres,'b','linewidth',2)
hold on
plot(ac_max_speed,ppres,'r','linewidth',2)
axis ij

line([0 20],[ppres(i_non_ac) ppres(i_non_ac)],'color','r','linewidth',1)
line([0 20],[ppres(i_non_cc) ppres(i_non_cc)],'color','b','linewidth',1)
line([c_spd c_spd],[ppres(1) ppres(end)],'color','k','linewidth',1,'LineStyle','--')

text(20.3,ppres(i_non_ac),[num2str(ppres(i_non_ac))],'fontsize',15,'fontweight','bold','color','r');
text(20.3,ppres(i_non_cc),[num2str(ppres(i_non_cc))],'fontsize',15,'fontweight','bold','color','b');
text(c_spd+.1,900,['c = ',num2str(round(100*c_spd)/100),' cm/s'],'fontsize',15,'fontweight','bold');
set(dd,'clipping','off','position',[0.22 0.11 1.3 0.75],'xtick',[0:2:100],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'layer','top')
text(1,-118,'Vertical profiles of','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
text(3,-60,'axial speed','fontsize',25,'fontweight','bold','Interpreter', 'Latex')
axis([0 40 0 1000])
hAx1=gca;
hAx2 = copyobj(hAx1,gcf);
set(hAx2, 'Position',get(hAx1,'Position').*[1 1 .5 1], ...
    'XLimMode','manual', 'YLimMode','manual', ...
    'XLim',get(hAx1,'XLim').*[1 0.5])
delete(get(hAx2,'Children'))
axis(hAx1,'off')
uistack(hAx1,'top')
ylabel(hAx2,'pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel(hAx2,'axial speed','fontsize',15,'fontweight','bold');
eval(['print -dpng -r300  ',output_dir '/spd_section'])


%
%make histograms
tbins=0:.1:2;
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
eval(['print -dpng -r300  ',output_dir '/hists'])

%

figure(11)
clf
set(gcf,'PaperPosition',[1 1 8.5 11])
m_proj('Equidistant cylindrical','lon',[min(lon) max(lon)],'lat',[min(lat) max(lat)]);   
m_grid('xtick',[round(min(lon)):10:round(max(lon))],'ytick',[round(min(lat)):5:round(max(lat))],'tickdir','in','color','k','lineweight',1.5,'fontsize',15,'fontweight','bold');  
hold on
set(gcf,'clipping','off')
[jdays,is]=sort(eddy_pjday);
x=eddy_x(is);
y=eddy_y(is);
id=eddy_id(is);
k=eddy_k(is);
cyc=eddy_cyc(is);
ujd=unique(jdays);
for qq=1:length(ujd)
    dd=find(jdays==ujd(qq) & k==1);
    uid=unique(id(dd));
    for m=1:length(uid)
        ii=find(id==uid(m));
        if cyc(ii(1))>=1
            m_plot(x(ii),y(ii),'r','linewidth',1)
        else
            m_plot(x(ii),y(ii),'b','linewidth',1)
        end
        if cyc(ii(1))>=1
            m_plot(x(ii(1)),y(ii(1)),'r.','markersize',10)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',3)
        else
            m_plot(x(ii(1)),y(ii(1)),'b.','markersize',10)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',3)
        end
    end
end  	
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
iat=find(cyc==1);
ict=find(cyc==-1);
na=length(unique(id(iat)));
nc=length(unique(id(ict)));
title([num2str(na),' anticyclones and ',num2str(nc),' cyclones'],'fontsize',25,'fontweight','bold')
eval(['print -dpng -r300  ',output_dir '/tracks'])
%}
