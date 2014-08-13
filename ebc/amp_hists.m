format short
load tracks/cBG_lat_lon_tracks_16_weeks.mat
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
%gca=subplot(324);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(gca,'xticklabel',{int2str(t_bins(1:10:81)')})
set(gca,'xtick',1:6:81)
set(gca,'xlim',[1 30])
set(gca,'ylim',[0 28])
m1=num2str(nanmean(amp(ci)));
m2=num2str(nanmean(amp(ai)));

text(11,25,['N = ' num2str(length(cui)) '  ' '\mu = ' m1(1:3) ],'color','b')
text(11,20,['N = ' num2str(length(aui)) '  ' '\mu = ' m2(1:3) ],'color','r')

xlabel({'Eddy Amplitude (cm)'})
ylabel('Percent of Total')
title('Benguela')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/hists/bg_amp.png']) 

clf
load tracks/cAK_lat_lon_tracks_16_weeks.mat
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


%gca=subplot(321);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(gca,'xticklabel',{int2str(t_bins(1:10:81)')})
set(gca,'xtick',1:6:81)
set(gca,'xlim',[1 30])
set(gca,'ylim',[0 28])
m1=num2str(nanmean(amp(ci)));
m2=num2str(nanmean(amp(ai)));
text(11,25,['N = ' num2str(length(cui)) '  ' '\mu = ' m1(1:4) ],'color','b')
text(11,20,['N = ' num2str(length(aui)) '  ' '\mu = ' m2(1:4) ],'color','r')
xlabel({'Eddy Amplitude (cm)'})
ylabel('Percent of Total')
title('Alaska')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/hists/ak_amp.png']) 


load tracks/cLW_lat_lon_tracks_16_weeks.mat
clf
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


%gca=subplot(326);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(gca,'xticklabel',{int2str(t_bins(1:10:81)')})
set(gca,'xtick',1:6:81)
set(gca,'xlim',[1 30])
set(gca,'ylim',[0 28])
m1=num2str(nanmean(amp(ci)));
m2=num2str(nanmean(amp(ai)));
text(11,25,['N = ' num2str(length(cui)) '  ' '\mu = ' m1(1:4) ],'color','b')
text(11,20,['N = ' num2str(length(aui)) '  ' '\mu = ' m2(1:4) ],'color','r')
xlabel({'Eddy Amplitude (cm)'})
ylabel('Percent of Total')
title('Leeuwin')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/hists/lw_amp.png']) 


load tracks/cCCNS_lat_lon_tracks_16_weeks.mat
clf
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


%gca=subplot(323);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(gca,'xticklabel',{int2str(t_bins(1:10:81)')})
set(gca,'xtick',1:6:81)
set(gca,'xlim',[1 30])
set(gca,'ylim',[0 28])
m1=num2str(nanmean(amp(ci)));
m2=num2str(nanmean(amp(ai)));
text(11,25,['N = ' num2str(length(cui)) '  ' '\mu = ' m1(1:3) ],'color','b')
text(11,20,['N = ' num2str(length(aui)) '  ' '\mu = ' m2(1:3) ],'color','r')
xlabel({'Eddy Amplitude (cm)'})
ylabel('Percent of Total')
title('California')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/hists/ccns_amp.png']) 


load tracks/cPC_lat_lon_tracks_16_weeks.mat
%make hsitograms of eddy properties
clf
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


%gca=subplot(325);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(gca,'xticklabel',{int2str(t_bins(1:10:81)')})
set(gca,'xtick',1:6:81)
set(gca,'xlim',[1 30])
set(gca,'ylim',[0 28])
m1=num2str(nanmean(amp(ci)));
m2=num2str(nanmean(amp(ai)));
text(11,25,['N = ' num2str(length(cui)) '  ' '\mu = ' m1(1:3) ],'color','b')
text(11,20,['N = ' num2str(length(aui)) '  ' '\mu = ' m2(1:3) ],'color','r')
xlabel({'Eddy Amplitude (cm)'})
%ylabel('Percent of Total')
title('Peru-Chile')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/hists/pc_amp.png']) 

clf
load tracks/cCC_lat_lon_tracks_16_weeks.mat
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


%gca=subplot(322);
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(gca,'xticklabel',{int2str(t_bins(1:10:81)')})
set(gca,'xtick',1:6:81)
set(gca,'xlim',[1 30])
set(gca,'ylim',[0 28])
m1=num2str(nanmean(amp(ci)));
m2=num2str(nanmean(amp(ai)));
text(11,25,['N = ' num2str(length(cui)) '  ' '\mu = ' m1(1:3) ],'color','b')
text(11,20,['N = ' num2str(length(aui)) '  ' '\mu = ' m2(1:3) ],'color','r')
%xlabel({'Eddy Amplitude (cm)'})
%ylabel('Percent of Total')
title('Canary')
eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/hists/cc_amp.png']) 