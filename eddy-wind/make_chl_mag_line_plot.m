clear
load ~/data/gsm/mean_gchl mean_gchl glat glon

[r,c]=imap(-30,-20,60,80,glat,glon);
mean_bg(1)=pmean(mean_gchl(r,c));
[r,c]=imap(-30,-20,80,94,glat,glon);
mean_bg(2)=pmean(mean_gchl(r,c));
[r,c]=imap(-30,-20,94,108,glat,glon);
mean_bg(3)=pmean(mean_gchl(r,c));
[r,c]=imap(-30,-20,108,120,glat,glon);
mean_bg(4)=pmean(mean_gchl(r,c));




for rr=1:4
    eval(['load new_4_zone_comp_season_',num2str(rr)])
    ac=lw_win_chl_a.median;
    mean_ac(rr)=max(ac(:));
    cc=lw_win_chl_c.median;
    mean_cc(rr)=max(abs(cc(:)));
    
    ac=lw_win_ddchl_a.median;
    mean_ddac(rr)=max(ac(:));
    cc=lw_win_ddchl_c.median;
    mean_ddcc(rr)=max(abs(cc(:)));
end

ri=1:4;
ri=linspace(1,4,20);
mean_ac=interp1([1:4],mean_ac,ri,'v5cubic');
mean_cc=interp1([1:4],mean_cc,ri,'v5cubic');
mean_ddac=interp1([1:4],mean_ddac,ri,'v5cubic');
mean_ddcc=interp1([1:4],mean_ddcc,ri,'v5cubic');
mean_bg=interp1([1:4],mean_bg,ri,'v5cubic');

li=linspace(80,120,20);
figure(1)
clf
set(gcf,'PaperPosition',[1 1 15 10])

XXX=[li;li];
YYY=[mean_ac;mean_cc];
[ax,h1,h2]=plotyy(XXX',YYY',li,10.^mean_bg);
set(h1(1),'color','k','linewidth',3)
set(h1(2),'color','k','linewidth',3,'linestyle','--')
set(h2,'color','g','linewidth',3)

set(ax(2),'ycolor','g')
set(ax,'fontsize',20,'fontweight','bold','LineWidth',3,'TickLength',[.01 .01],'layer','top')
legend('anticyclones','cyclones','background','location','northwest')
ylabel('mg m^{-3}','fontsize',25)
xlabel({'longitude'},'fontsize',25)
title({'Regional average'},'fontsize',25)
set(ax,'xlim',[80 120],'xtick',[80:5:120])
set(ax(1),'ylim',[0.004 0.016],'ytick',[0.005:0.002:0.016])
set(ax(2),'ylim',[0.04 0.13],'ytick',[0.05:0.02:0.15])
axes(ax(2))
ylabel('mg m^{-3}','fontsize',25)

print -depsc figs/lon_average_chl_mag


figure(1)
clf
set(gcf,'PaperPosition',[1 1 15 10])

XXX=[li;li];
YYY=[mean_ddac;mean_ddcc];
[ax,h1,h2]=plotyy(XXX',YYY',li,10.^mean_bg);
set(h1(1),'color','k','linewidth',3)
set(h1(2),'color','k','linewidth',3,'linestyle','--')
set(h2,'color','g','linewidth',3)

set(ax(2),'ycolor','g')
set(ax,'fontsize',20,'fontweight','bold','LineWidth',3,'TickLength',[.01 .01],'layer','top')
legend('anticyclones','cyclones','background','location','northwest')
ylabel('mg m^{-3}','fontsize',25)
xlabel({'longitude'},'fontsize',25)
title({'Regional average'},'fontsize',25)
set(ax,'xlim',[80 120],'xtick',[80:5:120])
return
set(ax(1),'ylim',[0.004 0.016],'ytick',[0.005:0.002:0.016])
set(ax(2),'ylim',[0.04 0.13],'ytick',[0.05:0.02:0.15])
axes(ax(2))
ylabel('mg m^{-3}','fontsize',25)

print -depsc figs/lon_average_ddchl_mag

