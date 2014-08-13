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
hax=subplot(231)
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{int2str(t_bins(1:10:81)')})
set(hax,'xtick',1:10:81)
set(hax,'xlim',[1 20])
set(hax,'ylim',[0 max([cpdf,apdf])+2])
xlabel({'Eddy Amplitude (cm)'})
ylabel('Percent of Total')
%xlabel('Amplitude (cm)')



t_bins=[20:10:220];

[bar_rad,num_rad]=phist(radius(ci),t_bins);
h = num_rad./sum(num_rad);
%pdf = h/.5;
cpdf = h*100;

[bar_rad,num_rad]=phist(radius(ai),t_bins);
h = num_rad./sum(num_rad);
%pdf = h/.5;
apdf = h*100;

hax=subplot(232)
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{int2str(t_bins(1:5:21)')})
set(hax,'xtick',1:5:21)
set(hax,'xlim',[1 20])
set(hax,'ylim',[0 max([cpdf,apdf])+2])
xlabel('Effective Radius (km)')

title({'Physical Characteristics of Mesoscale Eddies',[num2str(length(cui)),' Cyclones in Blue and ',num2str(length(aui)), ...
       ' Anticyclones in Red'],['Minimum Duration ', ...
       num2str(min(cat(2,cdur,adur)))]})

t_bins=[0:4:300];

[bar_dur,num_dur]=phist(cdur,t_bins);
h = num_dur./sum(num_dur);
%pdf = h/.5;
cpdf = h*100;

[bar_dur,num_dur]=phist(adur,t_bins);
h = num_dur./sum(num_dur);
%pdf = h/.5;
apdf = h*100;

hax=subplot(233)
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{int2str(t_bins(1:10:76)')})
set(hax,'xtick',1:10:76)
set(hax,'xlim',[1 50])
set(hax,'ylim',[0 max([cpdf,apdf])+2])
%title({'Distribution of Duration','VOCALS'})
%ylabel('Percent of Total')
xlabel('Lifetime (weeks)')


t_bins=[0:100:10000];
[bar_nlp,num_nlp]=phist(cxdist,t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
cpdf = h*100;

[bar_nlp,num_nlp]=phist(axdist,t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
apdf = h*100;


hax=subplot(234)
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{num2str((t_bins(1:10:101)./100)')})
set(hax,'xtick',1:10:101)
set(hax,'xlim',[1 40])
set(hax,'ylim',[0 max([cpdf,apdf])+2])
xlabel({'Zonal Propagation',' Distance (100 x km)'})
ylabel('Percent of Total')
%xlabel('Liftime (weeks)')



t_bins=[0:.25:10];

[bar_nlp,num_nlp]=phist(axial_speed(ci)./prop_speed(ci),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
cpdf = h*100;

[bar_nlp,num_nlp]=phist(axial_speed(ai)./prop_speed(ai),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
apdf = h*100;

hax=subplot(235)
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{num2str(t_bins(1:4:41)')})
set(hax,'xtick',1:4:41)
set(hax,'xlim',[1 40])
set(hax,'ylim',[0 max([cpdf,apdf])+2])
xlabel({'Nonlinearity ratio (U/c)'})
%}


t_bins=[0:40];

[bar_nlp,num_nlp]=phist(axial_speed(ci),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
cpdf = h*100;

[bar_nlp,num_nlp]=phist(axial_speed(ai),t_bins);
h = num_nlp./sum(num_nlp);
%pdf = h/.5;
apdf = h*100;

hax=subplot(236)
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)

set(hax,'xticklabel',{num2str(t_bins(1:8:41)')})
set(hax,'xtick',1:8:41)
set(hax,'xlim',[1 30])
set(hax,'ylim',[0 max([cpdf,apdf])+2])
xlabel({'Tangental Velocity (cm/s)'})
