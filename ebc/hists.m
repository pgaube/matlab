load tracks/cBG_lat_lon_tracks.mat
%make hsitograms of eddy properties

ai=find(id>=nneg);
ci=find(id<nneg);
aui=unique(id(ai));
cui=unique(id(ci));


for m=1:length(cui)
    ii=find(id==cui(m));
    cdur(m)=length(ii);
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    cydist(m)=abs(111.11*(yii(length(yii))-yii(1)));
    cxdist(m)=abs(111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1))));
end

for m=1:length(aui)
    ii=find(id==aui(m));
    adur(m)=length(ii);
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    aydist(m)=abs(111.11*(yii(length(yii))-yii(1)));
    axdist(m)=abs(111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1))));
end



t_bins=[0:80];

[bar_amp,num_amp]=phist(amp(ci),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
cpdf = h*100;

[bar_amp,num_amp]=phist(amp(ai),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
apdf = h*100;

figure(6)
clf
hax=axes;
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{int2str(t_bins(1:10:81)')})
set(hax,'xtick',1:6:81)
set(hax,'xlim',[1 30])
set(hax,'ylim',[0 28])
text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')
text(14,22.5,['\mu = ' num2str(pmean(amp(ci))) ' cm'],'color','b')
text(14,17.5,['\mu = ' num2str(pmean(amp(ai))) ' cm'],'color','r')


%xlabel({'Eddy Amplitude (cm)'})
xlabel({'Eddy Amplitude (cm)'})
ylabel('Percent of Total')
title('Benguela')
print -dpng -r300 ~/Documents/OSU/figures/ebc/hists/bg

load tracks/cAK_lat_lon_tracks.mat
%make hsitograms of eddy properties

ai=find(id>=nneg);
ci=find(id<nneg);
aui=unique(id(ai));
cui=unique(id(ci));


for m=1:length(cui)
    ii=find(id==cui(m));
    cdur(m)=length(ii);
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    cydist(m)=abs(111.11*(yii(length(yii))-yii(1)));
    cxdist(m)=abs(111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1))));
end

for m=1:length(aui)
    ii=find(id==aui(m));
    adur(m)=length(ii);
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    aydist(m)=abs(111.11*(yii(length(yii))-yii(1)));
    axdist(m)=abs(111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1))));
end



t_bins=[0:80];

[bar_amp,num_amp]=phist(amp(ci),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
cpdf = h*100;

[bar_amp,num_amp]=phist(amp(ai),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
apdf = h*100;

figure(1)
clf
hax=axes;
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{int2str(t_bins(1:10:81)')})
set(hax,'xtick',1:6:81)
set(hax,'xlim',[1 30])
set(hax,'ylim',[0 28])
text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')
text(14,22.5,['\mu = ' num2str(pmean(amp(ci))) ' cm'],'color','b')
text(14,17.5,['\mu = ' num2str(pmean(amp(ai))) ' cm'],'color','r')

%xlabel({'Eddy Amplitude (cm)'})
xlabel({'Eddy Amplitude (cm)'})
ylabel('Percent of Total')
title('Alaska')
print -dpng -r300 ~/Documents/OSU/figures/ebc/hists/ak


load tracks/cLW_lat_lon_tracks.mat
%make hsitograms of eddy properties

ai=find(id>=nneg);
ci=find(id<nneg);
aui=unique(id(ai));
cui=unique(id(ci));


for m=1:length(cui)
    ii=find(id==cui(m));
    cdur(m)=length(ii);
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    cydist(m)=abs(111.11*(yii(length(yii))-yii(1)));
    cxdist(m)=abs(111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1))));
end

for m=1:length(aui)
    ii=find(id==aui(m));
    adur(m)=length(ii);
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    aydist(m)=abs(111.11*(yii(length(yii))-yii(1)));
    axdist(m)=abs(111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1))));
end



t_bins=[0:80];

[bar_amp,num_amp]=phist(amp(ci),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
cpdf = h*100;

[bar_amp,num_amp]=phist(amp(ai),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
apdf = h*100;


figure(2)
clf
hax=axes;
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{int2str(t_bins(1:10:81)')})
set(hax,'xtick',1:6:81)
set(hax,'xlim',[1 30])
set(hax,'ylim',[0 28])
text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')
text(14,22.5,['\mu = ' num2str(pmean(amp(ci))) ' cm'],'color','b')
text(14,17.5,['\mu = ' num2str(pmean(amp(ai))) ' cm'],'color','r')
xlabel({'Eddy Amplitude (cm)'})
xlabel({'Eddy Amplitude (cm)'})
ylabel('Percent of Total')
title('Leeuwin')
print -dpng -r300 ~/Documents/OSU/figures/ebc/hists/lw


load tracks/cCCNS_lat_lon_tracks.mat
%make hsitograms of eddy properties

ai=find(id>=nneg);
ci=find(id<nneg);
aui=unique(id(ai));
cui=unique(id(ci));


for m=1:length(cui)
    ii=find(id==cui(m));
    cdur(m)=length(ii);
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    cydist(m)=abs(111.11*(yii(length(yii))-yii(1)));
    cxdist(m)=abs(111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1))));
end

for m=1:length(aui)
    ii=find(id==aui(m));
    adur(m)=length(ii);
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    aydist(m)=abs(111.11*(yii(length(yii))-yii(1)));
    axdist(m)=abs(111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1))));
end



t_bins=[0:80];

[bar_amp,num_amp]=phist(amp(ci),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
cpdf = h*100;

[bar_amp,num_amp]=phist(amp(ai),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
apdf = h*100;


figure(3)
clf
hax=axes;
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{int2str(t_bins(1:10:81)')})
set(hax,'xtick',1:6:81)
set(hax,'xlim',[1 30])
set(hax,'ylim',[0 28])
text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')
text(14,22.5,['\mu = ' num2str(pmean(amp(ci))) ' cm'],'color','b')
text(14,17.5,['\mu = ' num2str(pmean(amp(ai))) ' cm'],'color','r')
%xlabel({'Eddy Amplitude (cm)'})
xlabel({'Eddy Amplitude (cm)'})
ylabel('Percent of Total')
title('California')
print -dpng -r300 ~/Documents/OSU/figures/ebc/hists/ccns



load tracks/cPC_lat_lon_tracks.mat
%make hsitograms of eddy properties

ai=find(id>=nneg);
ci=find(id<nneg);
aui=unique(id(ai));
cui=unique(id(ci));


for m=1:length(cui)
    ii=find(id==cui(m));
    cdur(m)=length(ii);
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    cydist(m)=abs(111.11*(yii(length(yii))-yii(1)));
    cxdist(m)=abs(111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1))));
end

for m=1:length(aui)
    ii=find(id==aui(m));
    adur(m)=length(ii);
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    aydist(m)=abs(111.11*(yii(length(yii))-yii(1)));
    axdist(m)=abs(111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1))));
end



t_bins=[0:80];

[bar_amp,num_amp]=phist(amp(ci),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
cpdf = h*100;

[bar_amp,num_amp]=phist(amp(ai),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
apdf = h*100;


figure(4)
clf
hax=axes;
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{int2str(t_bins(1:10:81)')})
set(hax,'xtick',1:6:81)
set(hax,'xlim',[1 30])
set(hax,'ylim',[0 28])
text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')
text(14,22.5,['\mu = ' num2str(pmean(amp(ci))) ' cm'],'color','b')
text(14,17.5,['\mu = ' num2str(pmean(amp(ai))) ' cm'],'color','r')
%xlabel({'Eddy Amplitude (cm)'})
%xlabel({'Eddy Amplitude (cm)'})
ylabel('Percent of Total')
title('Peru-Chile')
print -dpng -r300 ~/Documents/OSU/figures/ebc/hists/pc


load tracks/cCC_lat_lon_tracks.mat
%make hsitograms of eddy properties

ai=find(id>=nneg);
ci=find(id<nneg);
aui=unique(id(ai));
cui=unique(id(ci));


for m=1:length(cui)
    ii=find(id==cui(m));
    cdur(m)=length(ii);
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    cydist(m)=abs(111.11*(yii(length(yii))-yii(1)));
    cxdist(m)=abs(111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1))));
end

for m=1:length(aui)
    ii=find(id==aui(m));
    adur(m)=length(ii);
    xii=x(ii);
    yii=abs(y(ii));
    xp = xii-xii(1);
    yp = yii-yii(1);
    aydist(m)=abs(111.11*(yii(length(yii))-yii(1)));
    axdist(m)=abs(111.11*((xii(length(xii))-(xii(1)))*cosd(yii(1))));
end



t_bins=[0:80];

[bar_amp,num_amp]=phist(amp(ci),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
cpdf = h*100;

[bar_amp,num_amp]=phist(amp(ai),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
apdf = h*100;


figure(5)
clf
hax=axes;
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{int2str(t_bins(1:10:81)')})
set(hax,'xtick',1:6:81)
set(hax,'xlim',[1 30])
set(hax,'ylim',[0 28])
text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')
text(14,22.5,['\mu = ' num2str(pmean(amp(ci))) ' cm'],'color','b')
text(14,17.5,['\mu = ' num2str(pmean(amp(ai))) ' cm'],'color','r')
%xlabel({'Eddy Amplitude (cm)'})
%xlabel({'Eddy Amplitude (cm)'})
ylabel('Percent of Total')
title('Canary')
print -dpng -r300 ~/Documents/OSU/figures/ebc/hists/cc
