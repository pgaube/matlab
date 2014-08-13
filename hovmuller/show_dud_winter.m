clear all
load gline_24_hov full_chov raw_chov clon raw_clon cjdays
jdays=[2450821:2454489];
[y,m,d]=jd2jdate(jdays);
t1=find(cjdays>=jdays(2400) & cjdays<=jdays(2600));

figure(1)
clf
plot(1:201,raw_chov(2400:2600,200),'k');
hold on
scatter(1:201,raw_chov(2400:2600,200),'k.');
plot(1:7:201,full_chov(t1,119),'r')
set(gca,'xticklabel',[08 09 11 12 01])

title([num2str(y(2400)),'- Longitude ',num2str(clon(119))])

print -dpng show_dud_winter_1



figure(1)
clf
plot(1:201,raw_chov(2400:2600,100),'k');
hold on
scatter(1:201,raw_chov(2400:2600,100),'k.');
plot(1:7:201,full_chov(t1,19),'r')
set(gca,'xticklabel',[08 09 11 12 01])

title([num2str(y(2400)),'- Longitude ',num2str(clon(19))])

print -dpng show_dud_winter_2

figure(1)
clf
plot(1:201,raw_chov(2400:2600,250),'k');
hold on
scatter(1:201,raw_chov(2400:2600,250),'k.');
plot(1:7:201,full_chov(t1,169),'r')
set(gca,'xticklabel',[08 09 11 12 01])

title([num2str(y(2400)),'- Longitude ',num2str(clon(169))])

print -dpng show_dud_winter_3

t1=find(cjdays>=jdays(1000) & cjdays<=jdays(1200));

figure(1)
clf
plot(1:201,raw_chov(1000:1200,200),'k');
hold on
scatter(1:201,raw_chov(1000:1200,200),'k.');
plot(1:7:201,full_chov(t1,119),'r')
set(gca,'xticklabel',[10 11 12 01 02])

title([num2str(y(1000)),'- Longitude ',num2str(clon(119))])

print -dpng show_dud_winter_4



figure(1)
clf
plot(1:201,raw_chov(1000:1200,100),'k');
hold on
scatter(1:201,raw_chov(1000:1200,100),'k.');
plot(1:7:201,full_chov(t1,19),'r')
set(gca,'xticklabel',[10 11 12 01 02])

title([num2str(y(1000)),'- Longitude ',num2str(clon(19))])

print -dpng show_dud_winter_5

figure(1)
clf
plot(1:201,raw_chov(1000:1200,250),'k');
hold on
scatter(1:201,raw_chov(1000:1200,250),'k.');
plot(1:7:201,full_chov(t1,169),'r')
set(gca,'xticklabel',[10 11 12 01 02])

title([num2str(y(1000)),'- Longitude ',num2str(clon(169))])

print -dpng show_dud_winter_6

t1=find(cjdays>=jdays(2800) & cjdays<=jdays(3000));

figure(1)
clf
plot(1:201,raw_chov(2800:3000,200),'k');
hold on
scatter(1:201,raw_chov(2800:3000,200),'k.');
plot(1:7:201,full_chov(t1,119),'r')
set(gca,'xticklabel',[09 10 12 02 03])

title([num2str(y(2800)),'- Longitude ',num2str(clon(119))])

print -dpng show_dud_winter_7



figure(1)
clf
plot(1:201,raw_chov(2800:3000,100),'k');
hold on
scatter(1:201,raw_chov(2800:3000,100),'k.');
plot(1:7:201,full_chov(t1,19),'r')
set(gca,'xticklabel',[09 10 12 02 03])

title([num2str(y(2800)),'- Longitude ',num2str(clon(19))])

print -dpng show_dud_winter_8

figure(1)
clf
plot(1:201,raw_chov(2800:3000,250),'k');
hold on
scatter(1:201,raw_chov(2800:3000,250),'k.');
plot(1:7:201,full_chov(t1,169),'r')
set(gca,'xticklabel',[09 10 12 02 03])

title([num2str(y(2800)),'- Longitude ',num2str(clon(169))])

print -dpng show_dud_winter_9

