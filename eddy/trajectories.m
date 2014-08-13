clear atheta ctheta
aui=unique(id(ai));
cui=unique(id(ci));

fig=figure(1);
clf
subplot(2,3,[4:5])
hold on
for m=1:length(cui)
    ii=find(id==cui(m));
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    ydist=111.11*(yii(length(yii))-yii(1));
    xdist=111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1)));
    if xdist <= -100
        ctheta(m)=atand(-ydist/xdist);
        h=plot(xp,-yp,'b');
        set(h,'clipping','off')
    end
end
set(gca,'box','on')
axis([-30 0 -7 7])
text(-25.5,5,['Number  of  Cyclonic  Eddies     =   ' num2str(length(cui))])
set(gca,'xtick',-30:5:0)
set(gca,'ytick',-6:2:6)
%set(gca,'position',[0.15 .55 .6 .34])
set(gca,'layer','top')
line([-50 0],[0 0],'color','k')
ylabel('     Poleward       Equatorward')


subplot(2,3,[1:2])
hold on
for m=1:length(aui)
    ii=find(id==aui(m));
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    ydist=111.11*(yii(length(yii))-yii(1));
    xdist=111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1)));
    if xdist <= -100
        atheta(m)=atand(-ydist/xdist);
        h=plot(xp,-yp,'r');
        set(h,'clipping','off')
    end
end
set(gca,'box','on')
axis([-30 0 -7 7])
text(-25.5,-5,['Number of Anticyclonic Eddies  =  ' num2str(length(aui))])
set(gca,'xtick',-30:5:0)
set(gca,'ytick',-6:2:6)
%set(gca,'position',[0.15 .1 .6 .34])
set(gca,'layer','top')
line([-50 0],[0 0],'color','k')
ylabel('     Poleward       Equatorward')
xlabel('Longitude')
title('Eddy Tracks Normalized to Origination Point')

t_bin=[-41:4:40];

hax=subplot(2,3,6);
[bar_est,num_est]=phist(ctheta,t_bin);
h = num_est./sum(num_est);
cpdf = h*100;
stairs(t_bin(1:length(t_bin)-1),cpdf,'linewidth',2)
line([0 0],[0 20],'color','k')
set(hax,'xtick',-30:15:30,'xminortick','on','YAxisLocation','right')
axis([-40 40 0 20])
text(-27,18,'Cyclonic Eddies')
ylabel('% of Observations in Each Bin')
text(-22,16,[num2str(round((length(find(ctheta<0))/length(ctheta))*100)),'%'])
text(15,16,[num2str(round((length(find(ctheta>0))/length(ctheta))*100)),'%'])
xlabel({'Equatorward       Poleward','Azimuth Relative to','West (degrees)'})

hax=subplot(2,3,3);
[bar_est,num_est]=phist(atheta,t_bin);
h = num_est./sum(num_est);
apdf = h*100;
stairs(t_bin(1:length(t_bin)-1),apdf,'r','linewidth',2)
line([0 0],[0 20],'color','k')
set(hax,'xtick',-30:15:30,'xminortick','on','YAxisLocation','right')
axis([-40 40 0 20])
text(-36,18,'Anticyclonic Eddies')
text(-22,16,[num2str(round((length(find(atheta<0))/length(atheta))*100)),'%'])
text(15,16,[num2str(round((length(find(atheta>0))/length(atheta))*100)),'%'])
ylabel('% of Observations in Each Bin')
xlabel('Equatorward       Poleward')
