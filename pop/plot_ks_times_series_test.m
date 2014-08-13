load obs_stream_sla
dft=1:12;
tend=12;
std_ts=0.02;
slope_ts=ones(50,1)*linspace(0,.03,12);
mean_st=.02+.015*randn(50,1)*ones(1,12);
add_larg=ones(4,1)*[.1 .2 .5 .01 0 0 0 0 0 0 0 0];
% add_larg=ones(6,1)*linspace(0,.4,12);

rng(3)
%%%make a test of random time series

ts_rn_a=-mean_st+std_ts.*(randn(50,12));
% add trend
ts_rn_a=ts_rn_a+slope_ts;
%%now add one big dchl
% ts_rn_a(end-5:end,:)=[ts_rn_a(end-5:end,1) ts_rn_a(end-5:end,2)-add_larg];

ts_rn_c=mean_st+std_ts.*(randn(50,12));
ts_rn_c=ts_rn_c-slope_ts;
% ts_rn_c(end-5:end,:)=ts_rn_c(end-5:end,:)+add_larg;
ts_rn_c(1:4,:)=ts_rn_c(1:4,:)+add_larg;

%now make length random
knock_out=round(abs(6+3*randn(50,1)));
knock_out(knock_out==0)=1;
% figure(10)
% hist(knock_out)
for m=1:50
    ts_rn_a(m,knock_out(m):end)=nan;
    ts_rn_c(m,knock_out(m):end)=nan;
end

mean_ts_rn_a=nanmean(ts_rn_a,1);
mean_ts_rn_c=nanmean(ts_rn_c,1);

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
for m=1:50
    plot([1:12],ts_rn_a(m,:),'r--','linewidth',.1)
end
plot([1:12],mean_ts_rn_a,'r','linewidth',1)

for m=1:50
    plot([1:12],ts_rn_c(m,:),'b--','linewidth',.1)
end
plot([1:12],mean_ts_rn_c,'b','linewidth',1)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
daspect([15 1 1.5])
text(9,-.1,num2str(mean_ts_rn_a(end)-mean_ts_rn_a(1)),'color','r')
text(9,.1,num2str(mean_ts_rn_c(end)-mean_ts_rn_c(1)),'color','b')
text(9,.2,['|\Delta_c|-|\Delta_a| = ',num2str(abs(mean_ts_rn_c(end)-mean_ts_rn_c(1))-abs(mean_ts_rn_a(end)-mean_ts_rn_a(1)))],'color','k')


print -dpng -r300 figs/stream_obs_ts/rand_ts
% !open figs/stream_obs_ts/rand_ts.png


%%%now normalize to org
for m=1:50
    ts_rn_a(m,:)=ts_rn_a(m,:)-ts_rn_a(m,1);
    ts_rn_c(m,:)=ts_rn_c(m,:)-ts_rn_c(m,1);
end

mean_ts_rn_a=nanmean(ts_rn_a,1);
mean_ts_rn_c=nanmean(ts_rn_c,1);

figure(2)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
for m=1:50
    plot([1:12],ts_rn_a(m,:),'r--','linewidth',.1)
end
plot([1:12],mean_ts_rn_a,'r','linewidth',1)

for m=1:50
    plot([1:12],ts_rn_c(m,:),'b--','linewidth',.1)
end
plot([1:12],mean_ts_rn_c,'b','linewidth',1)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
daspect([15 1 1.5])
text(9,-.1,num2str(mean_ts_rn_a(end)-mean_ts_rn_a(1)),'color','r')
text(9,.1,num2str(mean_ts_rn_c(end)-mean_ts_rn_c(1)),'color','b')
text(9,.2,['|\Delta_c|-|\Delta_a| = ',num2str(abs(mean_ts_rn_c(end)-mean_ts_rn_c(1))-abs(mean_ts_rn_a(end)-mean_ts_rn_a(1)))],'color','k')


print -dpng -r300 figs/stream_obs_ts/org_rand_ts
% !open figs/stream_obs_ts/org_rand_ts.png


return

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
for m=1:12
    ii=find(hp66_chl_a.k==m);
    mean_kso2_a(m)=pmean(test_oks_a(ii));
    ii=find(hp66_chl_c.k==m);
    mean_kso2_c(m)=pmean(test_oks_c(ii));
end

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
uid=unique(hp66_chl_a.id);
% for m=1:length(uid)
%     ii=find(hp66_chl_a.id==uid(m))
%     plot(hp66_chl_a.k(ii),test_oks_a(ii),'r','linewidth',.1)
% end
plot(dft,hp66_chl_a.ks_orgin_05(1:12),'r','linewidth',3)
plot(dft,mean_kso2_a,'r--','linewidth',3)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
daspect([15 1 1.5])
print -dpng -r300 figs/stream_obs_ts/hp66_chl_orgin2_parts_a

figure(4)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
uid=unique(hp66_chl_c.id);
% for m=1:length(uid)
%     ii=find(hp66_chl_c.id==uid(m))
%     plot(hp66_chl_c.k(ii),test_oks_c(ii),'b','linewidth',.1)
% end
plot(dft,hp66_chl_c.ks_orgin_05(1:12),'b','linewidth',3)
plot(dft,mean_kso2_c,'b--','linewidth',3)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
daspect([15 1 1.5])
print -dpng -r300 figs/stream_obs_ts/hp66_chl_orgin2_parts_c


return



figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
uid=unique(hp66_chl_a.id);
for m=1:length(uid)
    ii=find(hp66_chl_a.id==uid(m))
    plot(hp66_chl_a.k(ii),hp66_chl_a.ks_mean_all(ii),'r','linewidth',.1)
end
plot(dft,hp66_chl_a.ks_05(1:12),'r','linewidth',3)
plot(dft,hp66_chl_a.ks_05_median(1:12),'r--','linewidth',3)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
daspect([15 1 1.5])
print -dpng -r300 figs/stream_obs_ts/hp66_chl_parts_a


figure(2)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
uid=unique(hp66_chl_c.id);
for m=1:length(uid)
    ii=find(hp66_chl_c.id==uid(m))
    plot(hp66_chl_c.k(ii),hp66_chl_c.ks_mean_all(ii),'b','linewidth',.1)
end
plot(dft,hp66_chl_c.ks_05(1:12),'b','linewidth',3)
plot(dft,hp66_chl_c.ks_05_median(1:12),'b--','linewidth',3)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
daspect([15 1 1.5])
print -dpng -r300 figs/stream_obs_ts/hp66_chl_parts_c



figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
uid=unique(hp66_chl_a.id);
for m=1:length(uid)
    ii=find(hp66_chl_a.id==uid(m))
    plot(hp66_chl_a.k(ii),hp66_chl_a.ks_orgin_all(ii),'r','linewidth',.1)
end
plot(dft,hp66_chl_a.ks_orgin_05(1:12),'r','linewidth',3)
plot(dft,hp66_chl_a.ks_orgin_05_median(1:12),'r--','linewidth',3)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
daspect([15 1 1.5])
print -dpng -r300 figs/stream_obs_ts/hp66_chl_orgin_parts_a

figure(4)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
uid=unique(hp66_chl_c.id);
for m=1:length(uid)
    ii=find(hp66_chl_c.id==uid(m))
    plot(hp66_chl_c.k(ii),hp66_chl_c.ks_orgin_all(ii),'b','linewidth',.1)
end
plot(dft,hp66_chl_c.ks_orgin_05(1:12),'b','linewidth',3)
plot(dft,hp66_chl_c.ks_orgin_05_median(1:12),'b--','linewidth',3)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
daspect([15 1 1.5])
print -dpng -r300 figs/stream_obs_ts/hp66_chl_orgin_parts_c

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
uid=unique(hp66_chl_a.id);
% for m=1:length(uid)
%     ii=find(hp66_chl_a.id==uid(m))
%     plot(hp66_chl_a.k(ii),hp66_chl_a.ks_mean_all(ii),'r','linewidth',.1)
% end
plot(dft,hp66_chl_a.ks_05(1:12),'r','linewidth',3)
plot(dft,hp66_chl_a.ks_05_median(1:12),'r--','linewidth',3)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
% daspect([15 1 1.5])
print -dpng -r300 figs/stream_obs_ts/hp66_chl_parts_thick_a


figure(2)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
uid=unique(hp66_chl_c.id);
% for m=1:length(uid)
%     ii=find(hp66_chl_c.id==uid(m))
%     plot(hp66_chl_c.k(ii),hp66_chl_c.ks_mean_all(ii),'b','linewidth',.1)
% end
plot(dft,hp66_chl_c.ks_05(1:12),'b','linewidth',3)
plot(dft,hp66_chl_c.ks_05_median(1:12),'b--','linewidth',3)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
% daspect([15 1 1.5])
print -dpng -r300 figs/stream_obs_ts/hp66_chl_parts_thick_c



figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
uid=unique(hp66_chl_a.id);
% for m=1:length(uid)
%     ii=find(hp66_chl_a.id==uid(m))
%     plot(hp66_chl_a.k(ii),hp66_chl_a.ks_orgin_all(ii),'r','linewidth',.1)
% end
plot(dft,hp66_chl_a.ks_orgin_05(1:12),'r','linewidth',3)
plot(dft,hp66_chl_a.ks_orgin_05_median(1:12),'r--','linewidth',3)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
% daspect([15 1 1.5])
print -dpng -r300 figs/stream_obs_ts/hp66_chl_orgin_parts_thick_a

figure(4)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
uid=unique(hp66_chl_c.id);
% for m=1:length(uid)
%     ii=find(hp66_chl_c.id==uid(m))
%     plot(hp66_chl_c.k(ii),hp66_chl_c.ks_orgin_all(ii),'b','linewidth',.1)
% end
plot(dft,hp66_chl_c.ks_orgin_05(1:12),'b','linewidth',3)
plot(dft,hp66_chl_c.ks_orgin_05_median(1:12),'b--','linewidth',3)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
% daspect([15 1 1.5])
print -dpng -r300 figs/stream_obs_ts/hp66_chl_orgin_parts_thick_c