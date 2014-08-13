
function pcolorbar_log(crange,ticks,align,pal)

load chelle.pal
load bwr.pal

figure(10)
clf
set(gcf,'PaperPosition',[1 1 5 3])


set(gca,'xcolor','w','ycolor','w')
if align=='h'
    c=colorbar('horiz');
    caxis([log10(crange(1)) log10(crange(2))])

    set(c,'XTick',log10(ticks),'XTickLabel',ticks,'fontsize',15,'linewidth',1);
else
    c=colorbar;
    caxis([log10(crange(1)) log10(crange(2))])

    set(c,'yTick',log10(ticks),'yTickLabel',ticks,'fontsize',15,'linewidth',1);
end
eval(['colormap(',pal,')'])


eval(['print -dpng -r300 ~/Documents/OSU/figures/matlab_colorbar/',pal,'_log_',num2str(min(crange)),'_',num2str(max(crange)),'.png'])
