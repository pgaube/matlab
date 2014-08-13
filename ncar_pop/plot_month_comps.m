% load LW_offshore_obs_comps.mat
load LW_offshore_comps.mat
load chelle.pal
figure(1)
clf
set(gcf,'PaperPosition',[1 1 17 22])
xi=-2:.125:2;
[x,y]=meshgrid(xi,xi);

order=[1 2 5 6 9 10 13 14 17 18 21 22 3 4 7 8 11 12 15 16 19 20 23 24];
% order=[1:24];
txt={'January','February','March','April','May','June','July','August','September','October','November','December'};
ff=1;
cax=[-.015 .015];

[rr,ff,gg]=deal(1);

% order2=[1 6 2 7 3 8 4 9 5 10 6 12];

for m=1:length(order)
    
    subplot(6,4,order(m))
    if rem(m,2)~=0
        eval(['img=chl_',num2str(ff),'_a.mean;'])
        eval(['N=chl_',num2str(ff),'_a.n_max_sample;'])
        eval(['cont=ssh_',num2str(ff),'_a.mean;'])
    else
        eval(['img=chl_',num2str(ff),'_c.mean;'])
        eval(['N=chl_',num2str(ff),'_c.n_max_sample;'])
        eval(['cont=ssh_',num2str(ff),'_c.mean;'])
    end
    
    
    pcolor(x,y,img);shading interp;colormap(chelle);
    caxis(cax)
    hold on
    contour(x,y,cont,[1.5:1.5:100],'k','linewidth',2)
    contour(x,y,cont,[-100:1.5:-1.5],'k--','linewidth',2)
    dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
    set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',...
        [-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,...
        'fontsize',16,'LineWidth',2,'TickLength',[.01 .01],'layer','top')

    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
    
    line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
    line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
    line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
    line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
    line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)
    

    axis([-2 2 -2 2])
    text(-2,2.2,txt{ff},'fontweight','bold')
    text(1.15,2.2,['N=',num2str(N)],'fontweight','bold')

    if order(m)==1 | order(m)==3
        text(-2,2.9,'Anticyclones','color','r','fontsize',35)
    end
    if order(m)==2 | order(m)==4
        text(-1.35,2.9,'Cyclones','color','b','fontsize',35)
    end
    
    
    if rem(rr,2)==0
        ff=ff+1;
    end
    if rem(rr,2)==1
        gg=gg+1;
    end
    rr=rr+1;
end
text(.3,-3,'C.I. 1.5 cm','fontweight','bold','fontsize',17)
cc=colorbar('horiz');
set(cc,'Position',[0.31 0.07 0.4 0.01])
axes(cc)
xlabel('mg m^{-3}')


print -dpng -r300 LW_pop_comps
!open LW_pop_comps.png
% 
% print -dpng -r300 LW_obs_comps
% !open LW_obs_comps.png
% 
