clear all
tend=12
dft=1:tend;
xp=[dft dft(end) fliplr(dft) dft(1)];

load pop_rings_comps ssh_a ssh_c norm_*

%%%%
% CHL
%%%%
ts_a=norm_hp66_chl_a.ks_05(1:tend);
std_ts_a=norm_hp66_chl_a.ks_std_05(1:tend);
n_ts_a=norm_hp66_chl_a.ks_n(1:tend);

ts_c=norm_hp66_chl_c.ks_05(1:tend);
std_ts_c=norm_hp66_chl_c.ks_std_05(1:tend);
n_ts_c=norm_hp66_chl_c.ks_n(1:tend);

ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['normlized'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top','ylim',[-1 1])
set(gca,'xtick',[0:2:20])
box
title(['POP CHL'])
print -dpng -r300 figs/norm_hp66_chl_ts
% return

clearallbut tend dft xp

%%%%NOW AVISO
load obs_rings_comps obs_*

%%%%
% CHL
%%%%
ts_a=obs_chl_a.ks_05(1:tend);
std_ts_a=obs_chl_a.ks_std_05(1:tend);
n_ts_a=obs_chl_a.ks_n(1:tend);

ts_c=obs_chl_c.ks_05(1:tend);
std_ts_c=obs_chl_c.ks_std_05(1:tend);
n_ts_c=obs_chl_c.ks_n(1:tend);

ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['normlized'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top','ylim',[-1 1])
set(gca,'xtick',[0:2:20])
box
title(['SeaWiFS CHL'])
print -dpng -r300 figs/aviso_chl_ts


%%%%
%%Now do amp
%%%%
%%%pop
clearallbut tend dft xp

load GS_rings_cor_tracks_jan_5

for m=1:tend
    ts_a(m)=pmean(amp(find(k==m & cyc==1)));
    std_ts_a(m)=pstd(amp(find(k==m & cyc==1)));
    n_ts_a(m)=length(find(k==m & cyc==1));
    
    ts_c(m)=-pmean(amp(find(k==m & cyc==-1)));
    std_ts_c(m)=pstd(amp(find(k==m & cyc==-1)));
    n_ts_c(m)=length(find(k==m & cyc==-1));
end

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['cm'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top','ylim',[-40 40])
set(gca,'xtick',[0:2:20])
box
title(['POP amp'])
print -dpng -r300 figs/pop_amp_ts

%%%AVISO
clearallbut tend dft xp
load AVISO_GS_rings_cor_tracks_jan_5

for m=1:tend
    ts_a(m)=pmean(amp(find(k==m & cyc==1)));
    std_ts_a(m)=pstd(amp(find(k==m & cyc==1)));
    n_ts_a(m)=length(find(k==m & cyc==1));
    
    ts_c(m)=-pmean(amp(find(k==m & cyc==-1)));
    std_ts_c(m)=pstd(amp(find(k==m & cyc==-1)));
    n_ts_c(m)=length(find(k==m & cyc==-1));
end

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['cm'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top','ylim',[-40 40])
set(gca,'xtick',[0:2:20])
box
title(['AVISO amp'])
print -dpng -r300 figs/aviso_amp_ts



