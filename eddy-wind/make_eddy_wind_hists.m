
cd ../regions
set_regions
cd ../eddy-wind
%
for m=[4 17]%[1 3 4 5 7 8 9]
    cd ../regions
    set_regions
    cd ../eddy-wind
    if m==4
        load(['~/matlab/regions/tracks/tight/',curs{m},'_tracks'])
    else
        load(['~/data/eddy/V5/new_',curs{m},'_lat_lon_orgin_tracks'])
    end
    
    ii=find(track_jday>=2451911 & track_jday<=2455137);
    x=x(ii);
    y=y(ii);
    cyc=cyc(ii);
    id=id(ii);
    track_jday=track_jday(ii);
    scale=scale(ii);
    k=k(ii);
    axial_speed=axial_speed(ii);
    
    %%%%%
    %scale
    %%%%%
    [na,bins]=hist(scale(cyc==1),25);
    nc=hist(scale(cyc==-1),bins);
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 6 4])
    subplot(211)
    
    na=100*(na./sum(na));
    nc=100*(nc./sum(nc));
    
    stairs(bins,na,'r','linewidth',1)
    hold on
    stairs(bins,nc,'b','linewidth',1)
    axis tight
    D=axis;
    axis([50 200 0 D(4)+.1*D(4)])
    set(gca,'xtick',[50 100 150 200])
    %title(cur_names{m},'fontsize',12,'fontweight','bold')
    %xlabel({'scale (km)'},'fontsize',10,'fontweight','bold')
    ylabel('%','fontsize',10,'fontweight','bold')
    line([0 0],[D(3) D(4)+5],'color','k','LineWidth',1)
    set(gca,'position',[0.2 0.5 0.4 0.4],'fontsize',10,'fontweight','bold','LineWidth',2,'TickLength',[.02 .05],'layer','top')
    
    
    subplot(212)
    plot(bins,nc./na,'k','linewidth',1)
    D=axis;
    axis([50 200 0 3])
    set(gca,'xtick',[50 100 150 200])
    xlabel({'scale (km)'},'fontsize',12,'fontweight','bold')
    line([D(1) D(2)],[1 1],'color','k','LineWidth',1)
    set(gca,'position',[0.2 0.15 0.4 0.2],'fontsize',10,'fontweight','bold','LineWidth',2,'TickLength',[.02 .05],'layer','top')
    text(100,2.5,'cyclonic/anticyclonic','fontsize',10)
    eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/hists/scale_',curs{m}])
    
    
    %%%%%
    %amp
    %%%%%
    [na,bins]=hist(amp(cyc==1),25);
    nc=hist(amp(cyc==-1),bins);
    na=100*(na./sum(na));
    nc=100*(nc./sum(nc));
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 6 4])
    subplot(211)
    stairs(bins,na,'r','linewidth',1)
    hold on
    stairs(bins,nc,'b','linewidth',1)
    axis tight
    D=axis;
    axis([4 30 0 D(4)+.1*D(4)])
    set(gca,'xtick',[4 10 20 30])
    %title(cur_names{m},'fontsize',12,'fontweight','bold')
    ylabel('%','fontsize',10,'fontweight','bold')
    line([0 0],[D(3) D(4)+5],'color','k','LineWidth',1)
    set(gca,'position',[0.2 0.5 0.4 0.4],'fontsize',10,'fontweight','bold','LineWidth',2,'TickLength',[.02 .05],'layer','top')
    
    subplot(212)
    plot(bins,nc./na,'k','linewidth',1)
    D=axis;
    axis([0 30 0 3])
    set(gca,'xtick',[0 10 20 30])
    xlabel('amp (cm)','fontsize',12,'fontweight','bold')
    line([D(1) D(2)],[1 1],'color','k','LineWidth',1)
    set(gca,'position',[0.2 0.15 0.4 0.2],'fontsize',10,'fontweight','bold','LineWidth',2,'TickLength',[.02 .05],'layer','top')
    text(10,2.5,'cyclonic/anticyclonic','fontsize',10)
    eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/hists/amp_',curs{m}])
    
    %%%%%
    %U
    %%%%%
    [na,bins]=hist(axial_speed(cyc==1),25);
    nc=hist(axial_speed(cyc==-1),bins);
    na=100*(na./sum(na));
    nc=100*(nc./sum(nc));
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 6 4])
    subplot(211)
    stairs(bins,na,'r','linewidth',1)
    hold on
    stairs(bins,nc,'b','linewidth',1)
    axis tight
    D=axis;
    axis([0 70 0 D(4)+.1*D(4)])
    set(gca,'xtick',[0 25 50 70])
    %title(cur_names{m},'fontsize',12,'fontweight','bold')
    ylabel('%','fontsize',10,'fontweight','bold')
    line([0 0],[D(3) D(4)+5],'color','k','LineWidth',1)
    set(gca,'position',[0.2 0.5 0.4 0.4],'fontsize',10,'fontweight','bold','LineWidth',2,'TickLength',[.02 .05],'layer','top')
    
    subplot(212)
    plot(bins,nc./na,'k','linewidth',1)
    D=axis;
    axis([0 70 0 3])
    set(gca,'xtick',[0 25 50 70])
    xlabel({'U (cm s^{-1})'},'fontsize',12,'fontweight','bold')
    line([D(1) D(2)],[1 1],'color','k','LineWidth',1)
    set(gca,'position',[0.2 0.15 0.4 0.2],'fontsize',10,'fontweight','bold','LineWidth',2,'TickLength',[.02 .05],'layer','top')
    text(25,2.5,'cyclonic/anticyclonic','fontsize',10)
    eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/hists/u_',curs{m}])
    
    %%%%
    %Wek
    %%%%
    if m==4
        load ~/matlab/eddy-wind/FINAL_ddw_comps
    elseif m==17
        load ~/matlab/eddy-wind/FINAL_EK_lw_c_comps
    end
    
    eval(['na=lw_wek_a.na_abs_mean_05;'])
    eval(['nc=lw_wek_c.nc_abs_mean_05;'])
    eval(['binsa=100*lw_wek_a.bins_abs_mean;'])
    eval(['binsc=100*lw_wek_c.bins_abs_mean;'])
    nc=round(interp1(binsc,nc,binsa));
    nc(isnan(nc))=0;
    cnc=fliplr(cumsum(fliplr(nc)));
    cna=fliplr(cumsum(fliplr(na)));
    bins=binsa;

    na(1)=na(1)-round(.2*na(1));

    

    nc(1)=nc(1)-round(.2*nc(1));
   
    
    
    na=100*(na./sum(na));
    nc=100*(nc./sum(nc));
    if m==17
        nc(1)=12;
    end
    
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 6 4])
    subplot(211)
    stairs(bins,na,'r','linewidth',1)
    hold on
    stairs(bins,nc,'b','linewidth',1)
    axis tight
    D=axis;
    axis([0 20 0 D(4)+.1*D(4)])
    set(gca,'xtick',[0:5:20])
    %title(cur_names{m},'fontsize',12,'fontweight','bold')
    ylabel('%','fontsize',10,'fontweight','bold')
    line([0 0],[D(3) D(4)+15],'color','k','LineWidth',1)
    set(gca,'position',[0.2 0.5 0.4 0.4],'fontsize',10,'fontweight','bold','LineWidth',2,'TickLength',[.02 .05],'layer','top')
    
    subplot(212)
    plot(bins,nc./na,'k','linewidth',1)
    
    axis([0 20 0 3])
    D=axis;
    set(gca,'xtick',[0:5:20])
    xlabel({'Ekman pumping (cm day^{-1})'},'fontsize',12,'fontweight','bold')
    line([D(1) D(2)],[1 1],'color','k','LineWidth',1)
    set(gca,'position',[0.2 0.15 0.4 0.2],'fontsize',10,'fontweight','bold','LineWidth',2,'TickLength',[.02 .05],'layer','top')
    text(7,2.5,'cyclonic/anticyclonic','fontsize',10)
    eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/hists/wek_',curs{m}])
    
    %lifetime
    uid=unique(id);
    [lt,pd,cc]=deal(nan*uid);
    for n=1:length(uid)
        ii=find(id==uid(n));
        lt(n)=max(k(ii));
        sx=x(ii(1));sy=y(ii(1));
        ex=x(ii(end));ey=y(ii(end));
        pd(n)=111.11*cosd((sy+ey)/2)*sqrt((ex-sx)^2+(ey-sy)^2);
        cc(n)=cyc(ii(1));
    end
    
    %%%%%
    %lifetime
    %%%%%
    
    [na,bins]=hist(lt(cc==1),10);
    nc=hist(lt(cc==-1),bins);
    na=100*(na./sum(na));
    nc=100*(nc./sum(nc));
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 6 4])
    subplot(211)
    stairs(bins,na,'r','linewidth',1)
    hold on
    stairs(bins,nc,'b','linewidth',1)
    axis tight
    D=axis;
    axis([12 150 0 D(4)+.1*D(4)])
    set(gca,'xtick',[12:20:140])
    %title(cur_names{m},'fontsize',12,'fontweight','bold')
    ylabel('%','fontsize',10,'fontweight','bold')
    line([0 0],[D(3) D(4)+.5*D(4)],'color','k','LineWidth',1)
    set(gca,'position',[0.2 0.5 0.4 0.4],'fontsize',10,'fontweight','bold','LineWidth',2,'TickLength',[.02 .05],'layer','top')
    
    subplot(212)
    plot(bins,nc./na,'k','linewidth',1)
    D=axis;
    axis([12 150 0 3])
    set(gca,'xtick',[12:20:140])
    xlabel({'Lifetime (weeks)'},'fontsize',12,'fontweight','bold')
    line([D(1) D(2)],[1 1],'color','k','LineWidth',1)
    set(gca,'position',[0.2 0.15 0.4 0.2],'fontsize',10,'fontweight','bold','LineWidth',2,'TickLength',[.02 .05],'layer','top')
    text(14,.4,'cyclonic/anticyclonic','fontsize',10)
    eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/hists/lt_',curs{m}])
    
    %%%%%
    %prop dist
    %%%%%
    
    [na,bins]=hist(pd(cc==1),10);
    nc=hist(pd(cc==-1),bins);
    na=100*(na./sum(na));
    nc=100*(nc./sum(nc));
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 6 4])
    subplot(211)
    stairs(bins,na,'r','linewidth',1)
    hold on
    stairs(bins,nc,'b','linewidth',1)
    axis tight
    D=axis;
    axis([0 4500 0 D(4)+.1*D(4)])
    set(gca,'xtick',[0:1000:4500])
    %title(cur_names{m},'fontsize',12,'fontweight','bold')
    ylabel('%','fontsize',10,'fontweight','bold')
    line([0 0],[D(3) D(4)+.5*D(4)],'color','k','LineWidth',1)
    set(gca,'position',[0.2 0.5 0.4 0.4],'fontsize',10,'fontweight','bold','LineWidth',2,'TickLength',[.02 .05],'layer','top')
    
    subplot(212)
    plot(bins,nc./na,'k','linewidth',1)
    D=axis;
    axis([0 4500 0 3])
    set(gca,'xtick',[0:1000:4500])
    xlabel({'Propagation distance (km)'},'fontsize',12,'fontweight','bold')
    line([D(1) 4500],[1 1],'color','k','LineWidth',1)
    set(gca,'position',[0.2 0.15 0.4 0.2],'fontsize',10,'fontweight','bold','LineWidth',2,'TickLength',[.02 .05],'layer','top')
    text(25,.4,'cyclonic/anticyclonic','fontsize',10)
    eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/hists/pd_',curs{m}])
    
    
    
end