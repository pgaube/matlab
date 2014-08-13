
function pcolorbar(crange,ticks,align,pal)
load chelle.pal
load bwr.pal
load zissou

figure(10)
clf
set(gcf,'PaperPosition',[1 1 5 3])


set(gca,'xcolor','w','ycolor','w')
if align=='h'
    c=colorbar('horiz');
    caxis(crange)
    set(c,'XTick',ticks,'XTickLabel',ticks,'fontsize',15,'linewidth',1);
    eval(['colormap(',pal,')'])
    eval(['print -dpng -r300 ~/Documents/OSU/figures/matlab_colorbar/h_',pal,'_',num2str(min(crange)),'_',num2str(max(crange)),'.png'])

else
    c=colorbar;
    caxis(crange)
    set(c,'yTick',ticks,'yTickLabel',ticks,'fontsize',15,'linewidth',1);
    eval(['colormap(',pal,')'])
    eval(['print -dpng -r300 ~/Documents/OSU/figures/matlab_colorbar/',pal,'_',num2str(min(crange)),'_',num2str(max(crange)),'.png'])

end



