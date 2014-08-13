load obs_stream_sla
dft=1:12;
tend=12;
sm_tspan=6

%%%make normalixed to orgin from ks 

test_oks_a=nan*hp66_chl_a.ks_mean_all;
test_oks_c=nan*hp66_chl_c.ks_mean_all;

uid=unique(hp66_chl_a.id);
for m=1:length(uid)
    ii=find(hp66_chl_a.id==uid(m));
    io=find(hp66_chl_a.k(ii)==1);
    if any(io)
        test_oks_a(ii)=hp66_chl_a.ks_mean_all(ii)-hp66_chl_a.ks_mean_all(ii(io));
    end
    clear io
end

uid=unique(hp66_chl_c.id);
for m=1:length(uid)
    ii=find(hp66_chl_c.id==uid(m));
    io=find(hp66_chl_c.k(ii)==1);
    if any(io)
        test_oks_c(ii)=hp66_chl_c.ks_mean_all(ii)-hp66_chl_c.ks_mean_all(ii(io));
    end
    clear io
end



%%make mean
for m=1:20
    ii=find(hp66_chl_a.k==m);
    mean_kso2_a(m)=pmean(test_oks_a(ii));
    std_kso2_a(m)=pstd(test_oks_a(ii));
    n_kso2_a(m)=length(ii);
    mean_ks2_a(m)=pmean(hp66_chl_a.ks_mean_all(ii));
    std_ks2_a(m)=pstd(hp66_chl_a.ks_mean_all(ii));

    ii=find(hp66_chl_c.k==m);
    mean_kso2_c(m)=pmean(test_oks_c(ii));
    std_kso2_c(m)=pstd(test_oks_c(ii));
    n_kso2_c(m)=length(ii);
    mean_ks2_c(m)=pmean(hp66_chl_c.ks_mean_all(ii));
    std_ks2_c(m)=pstd(hp66_chl_c.ks_mean_all(ii));
end


%make mean w/out outlier

ii=find(test_oks_c<-.3);
badid=unique(hp66_chl_c.id(ii))

ii=find(hp66_chl_c.id==badid);
test_oks_c(ii)=nan;
hp66_chl_c.ks_mean_all(ii)=nan;

for m=1:20
    ii=find(hp66_chl_c.k==m);
    mean_kso3_c(m)=pmean(test_oks_c(ii));
    mean_ks3_c(m)=pmean(hp66_chl_c.ks_mean_all(ii));
    std_kso3_c(m)=pstd(test_oks_c(ii));
    std_ks3_c(m)=pstd(hp66_chl_c.ks_mean_all(ii));
    n_kso3_c(m)=length(ii);
end


ci_a=abs(std_kso2_a./sqrt(n_kso2_a-1));
ci_c=abs(std_kso2_c./sqrt(n_kso2_c-1));
ci_c3=abs(std_kso3_c./sqrt(n_kso3_c-1));

kci_a=abs(std_ks2_a./sqrt(n_kso2_a-1));
kci_c=abs(std_ks2_c./sqrt(n_kso2_c-1));
kci_c3=abs(std_ks3_c./sqrt(n_kso3_c-1));

mean_kso2_a=smooth1d_loess(mean_kso2_a,1:20,sm_tspan,1:tend);
mean_kso2_c=smooth1d_loess(mean_kso2_c,1:20,sm_tspan,1:tend);
mean_kso3_c=smooth1d_loess(mean_kso3_c,1:20,sm_tspan,1:tend);

mean_ks2_a=smooth1d_loess(mean_ks2_a,1:20,sm_tspan,1:tend);
mean_ks2_c=smooth1d_loess(mean_ks2_c,1:20,sm_tspan,1:tend);
mean_ks3_c=smooth1d_loess(mean_ks3_c,1:20,sm_tspan,1:tend);

ci_a=smooth1d_loess(ci_a,1:20,sm_tspan,1:tend);
ci_c=smooth1d_loess(ci_c,1:20,sm_tspan,1:tend);
ci_c3=smooth1d_loess(ci_c3,1:20,sm_tspan,1:tend);

kci_a=smooth1d_loess(kci_a,1:20,sm_tspan,1:tend);
kci_c=smooth1d_loess(kci_c,1:20,sm_tspan,1:tend);
kci_c3=smooth1d_loess(kci_c3,1:20,sm_tspan,1:tend);


figure(2)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on

plot(dft,mean_ks2_a,'r','linewidth',3)
for dd=1:tend
    plot([dft(dd)-.1 dft(dd)-.1],[mean_ks2_a(dd)-kci_a(dd) mean_ks2_a(dd)+kci_a(dd)],'r','linewidth',5)
end

plot(dft,mean_ks2_c,'b','linewidth',3)
for dd=1:tend
    plot([dft(dd)+.1 dft(dd)+.1],[mean_ks2_c(dd)-kci_c(dd) mean_ks2_c(dd)+kci_c(dd)],'b','linewidth',5)
end
plot(dft,mean_ks3_c,'b--','linewidth',3)
for dd=1:tend
    plot([dft(dd)-.2 dft(dd)-.2],[mean_ks3_c(dd)-kci_c3(dd) mean_ks3_c(dd)+kci_c3(dd)],'b','linewidth',5)
end
xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
box
print -dpng -r300 figs/stream_obs_ts/hp66_chl_2_with


figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on

plot(dft,mean_kso2_a,'r','linewidth',3)
for dd=1:tend
    plot([dft(dd)-.1 dft(dd)-.1],[mean_kso2_a(dd)-ci_a(dd) mean_kso2_a(dd)+ci_a(dd)],'r','linewidth',5)
end

plot(dft,mean_kso2_c,'b','linewidth',3)
for dd=1:tend
    plot([dft(dd)+.1 dft(dd)+.1],[mean_kso2_c(dd)-ci_c(dd) mean_kso2_c(dd)+ci_c(dd)],'b','linewidth',5)
end
plot(dft,mean_kso3_c,'b--','linewidth',3)
for dd=1:tend
    plot([dft(dd)-.2 dft(dd)-.2],[mean_kso3_c(dd)-ci_c3(dd) mean_kso3_c(dd)+ci_c3(dd)],'b','linewidth',5)
end
xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
box
print -dpng -r300 figs/stream_obs_ts/hp66_chl_orgin2_with



return
%%now plot track of bad eddy
load GS_core_eddies_observed_sla
ii=find(stream_eddies.id==1907);
figure(1)
clf
lon=min(stream_eddies.x(ii))-10:max(stream_eddies.x(ii))+10;
lat=min(stream_eddies.y(ii))-5:max(stream_eddies.y(ii))+5;

pmap(lon,lat,nan(length(lat),length(lon)),'gs')
hold on
m_plot(stream_eddies.x(ii),stream_eddies.y(ii),'b','linewidth',2)
m_plot(stream_eddies.x(ii(1)),stream_eddies.y(ii(1)),'b.','markersize',8)
print -dpng -r300 figs/stream_obs_ts/track_of_cyclone_1907


