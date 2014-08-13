cd ~/data/eddy/V5/
load maurtitus_lat_lon_tracks
cd ~/matlab/mauritius/

figure(1)
clf
set(gcf,'PaperPosition',[1 1 6 20])
subplot1(4,1,'Gap',[.03 .08],'XTickL','All')
subplot1(1)

%amp
%%%%%
[na,bins]=hist(amp(cyc==1),10);
nc=hist(amp(cyc==-1),bins);
cnc=fliplr(cumsum(fliplr(nc)));
cna=fliplr(cumsum(fliplr(na)));

stairs(bins,100*(nc./nansum(nc)),'b','linewidth',2)
hold on
stairs(bins,100*(na./nansum(na)),'r','linewidth',2)
axis tight
D=axis;
axis([D(1) D(2) D(3) D(4)+5])
text(10.5,26,[num2str(round(pmean(amp(cyc==1)))),' cm'],'color','r','fontsize',20,'fontweight','bold')
text(10.5,23,[num2str(round(pmean(amp(cyc==-1)))),' cm'],'color','b','fontsize',20,'fontweight','bold')

set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top')
xlabel('eddy amplitude','fontsize',25,'fontweight','bold')
title('Mauritius Eddies','fontsize',35,'fontweight','bold')

%%%%%
%scale
%%%%%
[na,bins]=hist(scale(cyc==1),8);
nc=hist(scale(cyc==-1),bins);
cnc=fliplr(cumsum(fliplr(nc)));
cna=fliplr(cumsum(fliplr(na)));

subplot1(2)
stairs(bins,100*(nc./nansum(nc)),'b','linewidth',2)
hold on
stairs(bins,100*(na./nansum(na)),'r','linewidth',2)
axis tight
D=axis;
axis([D(1) D(2) D(3) D(4)+5])
text(145,24,[num2str(round(pmean(scale(cyc==1)))),' km'],'color','r','fontsize',20,'fontweight','bold')
text(145,21,[num2str(round(pmean(scale(cyc==-1)))),' km'],'color','b','fontsize',20,'fontweight','bold')

set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top')
text(-37,-8,'percentage of observations','Rotation',90,'fontsize',25,'fontweight','bold')
xlabel('radius scale','fontsize',25,'fontweight','bold')

%%%%%
%U
%%%%%
[na,bins]=hist(axial_speed(cyc==1),10);
nc=hist(axial_speed(cyc==-1),bins);
cnc=fliplr(cumsum(fliplr(nc)));
cna=fliplr(cumsum(fliplr(na)));

subplot1(3)
stairs(bins,100*(nc./nansum(nc)),'b','linewidth',2)
hold on
stairs(bins,100*(na./nansum(na)),'r','linewidth',2)
axis tight
D=axis;
axis([D(1) D(2) D(3) D(4)+5])
text(22,24,[num2str(round(pmean(axial_speed(cyc==1)))),' cm s^{-1}'],'color','r','fontsize',20,'fontweight','bold')
text(22,21,[num2str(round(pmean(axial_speed(cyc==-1)))),' cm s^{-1}'],'color','b','fontsize',20,'fontweight','bold')

set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top')
xlabel('rotational speed','fontsize',25,'fontweight','bold')


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

[na,bins]=hist(lt(cc==1),6);
nc=hist(lt(cc==-1),bins);
na=100*(na./sum(na));
nc=100*(nc./sum(nc));
subplot1(4)
stairs(bins,100*(nc./nansum(nc)),'b','linewidth',2)
hold on
stairs(bins,100*(na./nansum(na)),'r','linewidth',2)
axis tight
D=axis;
axis([D(1) D(2) D(3) D(4)+5])
text(40,32,[num2str(round(pmean(lt(cc==1)))),' weeks'],'color','r','fontsize',20,'fontweight','bold')
text(40,29,[num2str(round(pmean(lt(cc==-1)))),' weeks'],'color','b','fontsize',20,'fontweight','bold')

set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top')
xlabel('lifetime','fontsize',25,'fontweight','bold')
print -dpng -r300 mau_eddy_hists.png
!open mau_eddy_hists.png

