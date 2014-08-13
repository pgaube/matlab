clear all
load bwr.pal
load chelle.pal

curs = {'new_SP',...
    'AGR',...
    'HAW',...
    'EIO',...
    'CAR',...
    'AGU',...
    'new_EIO',...
    'new_SEA'};

mm=4;
load(['~/data/eddy/V6/',curs{mm},'_lat_lon_tracks_V6'])
ii=find(track_jday>=2452466 & track_jday<=2455159 & amp>=30 & cyc==1);
x=ext_x(ii);
y=ext_y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);

for m=[12 26 39 44 65 65]%1:length(id)
    m
    load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(track_jday(m))],'lat','lon','u','v','ssh')
    slat=lat;
    slon=lon;
    load(['~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',num2str(track_jday(m))],'lat','lon','wek')
    load(['~/data/QuickScat/new_mat/QSCAT_30_25km_',num2str(track_jday(m))],'sm_u_week','sm_v_week','u_week','v_week')
    [rs,cs]=imap(y(m)-2,y(m)+2,x(m)-2,x(m)+2,slat,slon);
    [r,c]=imap(y(m)-2,y(m)+2,x(m)-2,x(m)+2,lat,lon);
    figure(1)
    clf
    pcolor(lon(r,c),lat(r,c),double(wek(r,c)));shading interp;axis image;caxis([-20 20]);colormap(bwr)
    hold on
    contour(slon(rs,cs),slat(rs,cs),double(ssh(rs,cs)),[3:2:50],'k')
    title(num2str(m))
    pause(.2)
    
    wek=smoothn(double(interp2(wek(r,c),3)),100);
    ua=smoothn(double(interp2(sm_u_week(r,c),3)),3000);
    va=smoothn(double(interp2(sm_v_week(r,c),3)),3000);
%     ssh=double(interp2(ssh(rs,cs),3));
%     u=smoothn(double(interp2(sm_u_week(r,c)-u_week(r,c),3)),3000);
%     v=smoothn(double(interp2(sm_v_week(r,c)-v_week(r,c),3)),3000);
    u=double(interp2(u(rs,cs),3));
    v=double(interp2(v(rs,cs),3));
    xi=linspace(-2,2,length(wek(1,:)));
    yi=linspace(-2,2,length(wek(:,1)));
    [xi,yi]=meshgrid(xi,yi);
    
    x0=linspace(-2,2,length(ssh(rs,cs)));
    y0=linspace(-2,2,length(ssh(rs,cs)));
    [x0,y0]=meshgrid(x0,y0);
    
    %%%U_a
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(xi,yi,nan*wek);shading interp;axis image;caxis([-20 20]);colormap(bwr)
    hold on
    contour(x0,y0,ssh(rs,cs),[4:4:50],'k','linewidth',2)
    contour(x0,y0,ssh(rs,cs),[-50:4:-4],'k--','linewidth',2)
    quiver(xi(5:10:end-5,5:10:end-5),yi(5:10:end-5,5:10:end-5),ua(5:10:end-5,5:10:end-5),va(5:10:end-5,5:10:end-5),1,'color','k','linewidth',2)
    dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
    box
    set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
        'LineWidth',2,'TickLength',[0 0],'layer','top')
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
%     [x,y]=cylinder(1,100);
%     plot(x(1,:),y(1,:),'k','linewidth',1.5)
    box
    eval(['print -dpng -r300 /Users/new_gaube/Documents/Proposals/OVWST/2013/figs/wek_example/vec_scam_u_a_',num2str(m)])

    %%%U_o
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(xi,yi,nan*wek);shading interp;axis image;caxis([-20 20]);colormap(bwr)
    hold on
    contour(x0,y0,ssh(rs,cs),[4:4:50],'k','linewidth',2)
    contour(x0,y0,ssh(rs,cs),[-50:4:-4],'k--','linewidth',2)
    quiver(xi(5:10:end-5,5:10:end-5),yi(5:10:end-5,5:10:end-5),u(5:10:end-5,5:10:end-5),v(5:10:end-5,5:10:end-5),'color','k','linewidth',2)
    dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
    box
    set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
        'LineWidth',2,'TickLength',[0 0],'layer','top')
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
%     [x,y]=cylinder(1,100);
%     plot(x(1,:),y(1,:),'k','linewidth',1.5)
    box
    eval(['print -dpng -r300 /Users/new_gaube/Documents/Proposals/OVWST/2013/figs/wek_example/vec_scam_u_o_',num2str(m)])
    
    %%%U_r
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(xi,yi,nan*wek);shading interp;axis image;caxis([-20 20]);colormap(bwr)
    hold on
    contour(x0,y0,ssh(rs,cs),[4:4:50],'k','linewidth',2)
    contour(x0,y0,ssh(rs,cs),[-50:4:-4],'k--','linewidth',2)
    quiver(xi(5:10:end-5,5:10:end-5),yi(5:10:end-5,5:10:end-5),ua(5:10:end-5,5:10:end-5)-u(5:10:end-5,5:10:end-5),va(5:10:end-5,5:10:end-5)-v(5:10:end-5,5:10:end-5),1,'color','k','linewidth',2)
    dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
    box
    set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
        'LineWidth',2,'TickLength',[0 0],'layer','top')
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
%     [x,y]=cylinder(1,100);
%     plot(x(1,:),y(1,:),'k','linewidth',1.5)
    box
    eval(['print -dpng -r300 /Users/new_gaube/Documents/Proposals/OVWST/2013/figs/wek_example/vec_scam_u_r_',num2str(m)])
    
    %%%wek
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(xi,yi,wek);shading interp;axis image;caxis([-20 20]);colormap(bwr)
    hold on
    contour(x0,y0,ssh(rs,cs),[4:4:50],'k','linewidth',2)
    contour(x0,y0,ssh(rs,cs),[-50:4:-4],'k--','linewidth',2)
%     quiver(xi(5:10:end-5,5:10:end-5),yi(5:10:end-5,5:10:end-5),ua(5:10:end-5,5:10:end-5)-u(5:10:end-5,5:10:end-5),va(5:10:end-5,5:10:end-5)-v(5:10:end-5,5:10:end-5),'color','k','linewidth',2)
    dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
    box
    set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
        'LineWidth',2,'TickLength',[0 0],'layer','top')
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
%     [x,y]=cylinder(1,100);
%     plot(x(1,:),y(1,:),'k','linewidth',1.5)
    box
    eval(['print -dpng -r300 /Users/new_gaube/Documents/Proposals/OVWST/2013/figs/wek_example/vec_scam_wek_',num2str(m)])
end


