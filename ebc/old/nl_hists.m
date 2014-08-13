load BG_lat_lon_tracks_16_weeks.mat
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



t_bins=[0:.25:10];

[bar_nlp,num_nlp]=phist(axial_speed(ci)./prop_speed(ci),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
cpdf = h*100;

[bar_nlp,num_nlp]=phist(axial_speed(ai)./prop_speed(ai),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
apdf = h*100;

figure(1)
clf
hax=subplot(434);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{num2str(t_bins(1:4:41)')})
set(hax,'xtick',1:4:41)
set(hax,'xlim',[1 40])
set(hax,'ylim',[0 28])
set(hax,'xticklabel',{int2str(t_bins(1:4:41)')})

text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')

%xlabel({'Nonlinearity ratio (U/c)'})
ylabel('Percent of Total')
title('Benguela')

load LW_lat_lon_tracks_16_weeks.mat
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

t_bins=[0:.25:10];

[bar_nlp,num_nlp]=phist(axial_speed(ci)./prop_speed(ci),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
cpdf = h*100;

[bar_nlp,num_nlp]=phist(axial_speed(ai)./prop_speed(ai),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
apdf = h*100;

hax=subplot(437);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{num2str(t_bins(1:4:41)')})
set(hax,'xtick',1:4:41)
set(hax,'xlim',[1 40])
set(hax,'ylim',[0 28])
set(hax,'xticklabel',{int2str(t_bins(1:4:41)')})

text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')

xlabel({'Nonlinearity ratio (U/c)'})
ylabel('Percent of Total')
title('Leeuwin')

load CCN_lat_lon_tracks_16_weeks.mat
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



t_bins=[0:.25:10];

[bar_nlp,num_nlp]=phist(axial_speed(ci)./prop_speed(ci),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
cpdf = h*100;

[bar_nlp,num_nlp]=phist(axial_speed(ai)./prop_speed(ai),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
apdf = h*100;


hax=subplot(432);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{num2str(t_bins(1:4:41)')})
set(hax,'xtick',1:4:41)
set(hax,'xlim',[1 40])
set(hax,'ylim',[0 28])
set(hax,'xticklabel',{int2str(t_bins(1:4:41)')})

text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')

%xlabel({'Nonlinearity ratio (U/c)'})
ylabel('Percent of Total')
title('North California')

load CCS_lat_lon_tracks_16_weeks.mat
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



t_bins=[0:.25:10];

[bar_nlp,num_nlp]=phist(axial_speed(ci)./prop_speed(ci),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
cpdf = h*100;

[bar_nlp,num_nlp]=phist(axial_speed(ai)./prop_speed(ai),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
apdf = h*100;


hax=subplot(435);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{num2str(t_bins(1:4:41)')})
set(hax,'xtick',1:4:41)
set(hax,'xlim',[1 40])
set(hax,'ylim',[0 28])
set(hax,'xticklabel',{int2str(t_bins(1:4:41)')})

text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')

%xlabel({'Nonlinearity ratio (U/c)'})
%ylabel('Percent of Total')
title('South California')

load PCN_lat_lon_tracks_16_weeks.mat
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


t_bins=[0:.25:10];

[bar_nlp,num_nlp]=phist(axial_speed(ci)./prop_speed(ci),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
cpdf = h*100;

[bar_nlp,num_nlp]=phist(axial_speed(ai)./prop_speed(ai),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
apdf = h*100;


hax=subplot(438);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{num2str(t_bins(1:4:41)')})
set(hax,'xtick',1:4:41)
set(hax,'xlim',[1 40])
set(hax,'ylim',[0 28])
set(hax,'xticklabel',{int2str(t_bins(1:4:41)')})

text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')

%xlabel({'Nonlinearity ratio (U/c)'})
%ylabel('Percent of Total')
title('North Peru-Chile')

load PCS_lat_lon_tracks_16_weeks.mat
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



t_bins=[0:.25:10];

[bar_nlp,num_nlp]=phist(axial_speed(ci)./prop_speed(ci),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
cpdf = h*100;

[bar_nlp,num_nlp]=phist(axial_speed(ai)./prop_speed(ai),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
apdf = h*100;


hax=subplot(4,3,11);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{num2str(t_bins(1:4:41)')})
set(hax,'xtick',1:4:41)
set(hax,'xlim',[1 40])
set(hax,'ylim',[0 28])
set(hax,'xticklabel',{int2str(t_bins(1:4:41)')})

text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')
xlabel({'Nonlinearity ratio (U/c)'})
ylabel('Percent of Total')
title('South Peru-Chile')

load IB_lat_lon_tracks_16_weeks.mat
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



t_bins=[0:.25:10];

[bar_nlp,num_nlp]=phist(axial_speed(ci)./prop_speed(ci),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
cpdf = h*100;

[bar_nlp,num_nlp]=phist(axial_speed(ai)./prop_speed(ai),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
apdf = h*100;


hax=subplot(4,3,3);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{num2str(t_bins(1:4:41)')})
set(hax,'xtick',1:4:41)
set(hax,'xlim',[1 40])
set(hax,'ylim',[0 28])
set(hax,'xticklabel',{int2str(t_bins(1:4:41)')})

text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')

%xlabel({'Nonlinearity ratio (U/c)'})
%ylabel('Percent of Total')
title('Iberian')

load ME_lat_lon_tracks_16_weeks.mat
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



t_bins=[0:.25:10];

[bar_nlp,num_nlp]=phist(axial_speed(ci)./prop_speed(ci),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
cpdf = h*100;

[bar_nlp,num_nlp]=phist(axial_speed(ai)./prop_speed(ai),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
apdf = h*100;


hax=subplot(4,3,6);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{num2str(t_bins(1:4:41)')})
set(hax,'xtick',1:4:41)
set(hax,'xlim',[1 40])
set(hax,'ylim',[0 28])
set(hax,'xticklabel',{int2str(t_bins(1:4:41)')})

text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')

%xlabel({'Nonlinearity ratio (U/c)'})
%ylabel('Percent of Total')
title('Mediterranean')

load CC_lat_lon_tracks_16_weeks.mat
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



t_bins=[0:.25:10];

[bar_nlp,num_nlp]=phist(axial_speed(ci)./prop_speed(ci),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
cpdf = h*100;

[bar_nlp,num_nlp]=phist(axial_speed(ai)./prop_speed(ai),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
apdf = h*100;

hax=subplot(4,3,9);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)
set(hax,'xticklabel',{num2str(t_bins(1:4:41)')})
set(hax,'xtick',1:4:41)
set(hax,'xlim',[1 40])
set(hax,'ylim',[0 28])
set(hax,'xticklabel',{int2str(t_bins(1:4:41)')})

text(14,25,[num2str(length(cui)) ' Cyclones'],'color','b')
text(14,20,[num2str(length(aui)) ' Anticyclones'],'color','r')

xlabel({'Nonlinearity ratio (U/c)'})
%ylabel('Percent of Total')
title('Canary')