clear
load sargasso_argo_mask_km_ext_comp.mat

thresh=.1

ia=find(eddy_cyc==1);

ac_ist_anom=eddy_ist_anom(:,ia);
   
idepth=find(ppres==100);
i_mwe=find(eddy_ist_anom(idepth,ia)>thresh & eddy_dist(ia)'<=9.5);
i_reg=find(eddy_ist_anom(idepth,ia)<thresh);
for m=1:length(ppres)
    mean_mwe(m)=pmean(ac_ist_anom(m,i_mwe));
end
for m=1:length(ppres)
    mean_ac(m)=pmean(ac_ist_anom(m,i_reg));
end 

%{
figure(1)
clf
set(gcf,'PaperPosition',[1 1 5 8.5])
dd=axes;
hold on
plot(mean_ac,ppres,'r','linewidth',2)
plot(mean_mwe,ppres,'g','linewidth',2)
plot(ac_ist_anom(:,i_mwe),ppres,'color',[.5 .5 .5],'linewidth',.5)
plot(mean_ac,ppres,'r','linewidth',2)
plot(mean_mwe,ppres,'g','linewidth',2)
line([thresh thresh],[0 1000],'color','k','linewidth',1)
line([-2 2],[ppres(idepth) ppres(idepth)],'color','k','linewidth',1)
legend('mean of AC','mean of MWE','MWE profiles','location','southeast')
axis ij
axis([-1.5 1.5 0 1000])
set(dd,'position',[0.22 0.11 0.65 0.75],'xtick',[-2:.5:2],'ytick',[0:200:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'layer','top')
title({['Vertical profiles of'],['desnity anomaly']},'fontsize',25,'fontweight','bold','Interpreter', 'Latex')
ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
xlabel('kg m^{-3}','fontsize',15,'fontweight','bold')
line([0 0],[0 1000],'color','k','linewidth',2)
box
print -dpng -r300 figs/MWE/st_anom
!open figs/MWE/st_anom.png

%
lon=round(min(eddy_x))-5:round(max(eddy_x))+5;
lat=round(min(eddy_y))-5:round(max(eddy_y))+5;
figure(2)
clf
set(gcf,'PaperPosition',[1 1 8.5 11])
m_proj('Equidistant cylindrical','lon',[min(lon) max(lon)],'lat',[min(lat) max(lat)]);   
m_grid('xtick',[round(min(lon)):10:round(max(lon))],'ytick',[round(min(lat)):5:round(max(lat))],'tickdir','in','color','k','lineweight',1.5,'fontsize',15,'fontweight','bold');  
hold on
set(gcf,'clipping','off')
for m=1:length(eddy_x)
	m_plot(eddy_plon(m),eddy_plat(m),'k.','linewidth',1,'color',[.5 .5 .5])
end

for m=1:length(i_mwe)
	m_plot(eddy_plon(ia(i_mwe)),eddy_plat(ia(i_mwe)),'r.','linewidth',50)
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
print -dpng -r300 figs/MWE/map_mwe
!open figs/MWE/map_mwe.png
%}

uid=unique(eddy_id(ia(i_mwe)));
pp=1;
%[mwe_id,mwe_k,mwe_jday]=deal(nan(1,length(eddy_x)));
for m=1:length(uid)
    ii=find(eddy_id==uid(m));
    for n=1:length(ii)
        mwe_id(pp)=eddy_id(ii(n));
        mwe_plon(pp)=eddy_plon(ii(n));
        mwe_plat(pp)=eddy_plat(ii(n));
        mwe_pfile(pp)=eddy_pfile(ii(n));
        mwe_k(pp)=eddy_k(ii(n));
        mwe_jday(pp)=eddy_pjday(ii(n));
        mwe_time_dif(pp)=mwe_jday(pp)-eddy_pjday(ii(1));
        mwe_ist(:,pp)=eddy_ist(:,ii(n));
        mwe_ist_anom(:,pp)=eddy_ist_anom(:,ii(n));
        mwe_dist(pp)=eddy_dist(ii(n));
        pp=pp+1;
    end
end

ii=find(mwe_time_dif>=365);
%%%%
ii=find(mwe_time_dif>=1);
uid=unique(mwe_id(ii));
display(['number of MWE with profile seperated by at leaste 1 year =',num2str(length(uid))])
load ~/data/eddy/V5/global_tracks_v5
lon=round(min(eddy_x))-5:round(max(eddy_x))+5;
lat=round(min(eddy_y))-5:round(max(eddy_y))+5;
rr=1;

for m=1:length(uid)
    ii=find(id==uid(m));
    xx=x(ii);
    yy=y(ii);
    
    pp=find(mwe_id==uid(m));
    
    figure(2)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 11])
    m_proj('Equidistant cylindrical','lon',[min(lon) max(lon)],'lat',[min(lat) max(lat)]);   
    m_grid('xtick',[round(min(lon)):10:round(max(lon))],'ytick',[round(min(lat)):5:round(max(lat))],'tickdir','in','color','k','lineweight',1.5,'fontsize',15,'fontweight','bold');  
    hold on
    set(gcf,'clipping','off')
    m_plot(xx,yy,'r','linewidth',2)
    for d=1:length(pp)
        m_plot(mwe_plon(pp(d)),mwe_plat(pp(d)),'k.','linewidth',15)
    end    
    grid
    m_coast('patch',[0 0 0],'edgecolor','k');
    title(['eddy id = ',num2str(uid(m))])
    pause(1)
    eval(['print -dpng -r300 figs/MWE/track_',num2str(uid(m))])
    %plot profiles
    %
    for d=1:length(pp)
        if mwe_dist(pp(d))<.5  & length(find(isnan(mwe_ist(:,pp(d)))))<length(mwe_ist(:,pp(d)))
            [year,month,day]=jd2jdate(mwe_jday(pp(d)));
            figure(1)
            clf
            set(gcf,'PaperPosition',[1 1 5 8.5])
            dd=axes;
            hold on
            x1=mwe_ist_anom(:,pp(d));
            x2=mwe_ist(:,pp(d));
            y1=ppres;
            hl1 = line(x1,y1,'color','b','linewidth',.5)
            ax1 = gca;
            set(ax1,'XColor','b','YColor','b')
            axis ij
%             axis([-.5 .5 0 400])
            ax2 = axes('Position',get(ax1,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','k','YColor','k');
            
            hl2 = line(x2,y1,'Color','k','Parent',ax2);
            
      
            axis ij
%             axis([25 30 0 400])
%             set(dd,'xtick',[-2:.5:2],'ytick',[0:100:1000]','fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[0 0],'layer','top')
%             title({['eddy id = ',num2str(uid(m))],[num2str(year),'-',num2str(month),'-',num2str(day)]},'fontsize',15)
            ylabel('pressure (dbar)','fontsize',15,'fontweight','bold');
            xlabel('kg m^{-3}','fontsize',15,'fontweight','bold')
%             line([0 0],[0 1000],'color','k','linewidth',2)
%             text(.2,300,['dist = ',num2str(round(10*mwe_dist(pp(d)))/10)],'fontsize',15,'fontweight','bold')
            box
            pause(1)
            eval(['print -depsc figs/MWE/profile_',num2str(uid(m)),'_',num2str(rr)])
            rr=rr+1;
            figure(2)
            m_plot(mwe_plon(pp(d)),mwe_plat(pp(d)),'g.','linewidth',50)
            eval(['print -dpng -r300 figs/MWE/track_',num2str(uid(m))])

        end
    end
    rr=1;
    %}
end

