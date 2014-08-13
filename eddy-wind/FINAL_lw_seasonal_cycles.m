clear all
load FINAL_monthly_comps lw_chl_a lw_chl_c
load ~/matlab/regions/tracks/tight/lw_tracks x y cyc id track_jday scale k
ii=find(track_jday>=2450828 & track_jday<=2455137);
% ii=find(track_jday>=2451913 & track_jday<=2455137);
% % ii=find(track_jday>=2451913 & track_jday<=2452046);
% 
x=x(ii);
y=y(ii);
cyc=cyc(ii);
id=id(ii);
track_jday=track_jday(ii);
scale=scale(ii);
k=k(ii);

load lw_domain_chl_ss
djdays=jdays;
jdays=unique(track_jday);
f=2*pi/365.25;
x=1:365;
xx=linspace(1,12,365);
% 
% load EK_time_chl_wek ac_amld cc_amld ac_jday cc_jday
% [ts_ac_amld,ts_cc_amld]=deal(deal(nan*jdays));
% 
% for m=1:length(ts_ac_amld);
% 	ii=find(ac_jday==jdays(m));
% 	ts_ac_mld(m)=pmean(ac_amld(ii));
%     ii=find(cc_jday==jdays(m));
% 	ts_cc_mld(m)=pmean(cc_amld(ii));
% end
% [ss_ac_mld,beta_ac_mld]=harm_reg(jdays,ts_ac_mld,2,2*pi/365.25);
% [ss_cc_mld,beta_cc_mld]=harm_reg(jdays,ts_cc_mld,2,2*pi/365.25);
% ac_mld_y=beta_ac_mld(1)+beta_ac_mld(2)*cos(f*x)+beta_ac_mld(3)*cos(2*f*x)+beta_ac_mld(4)*sin(f*x)+beta_ac_mld(5)*sin(2*f*x);
% cc_mld_y=beta_cc_mld(1)+beta_cc_mld(2)*cos(f*x)+beta_cc_mld(3)*cos(2*f*x)+beta_cc_mld(4)*sin(f*x)+beta_cc_mld(5)*sin(2*f*x);
% 
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% plot(xx,ac_mld_y,'r','linewidth',4)
% hold on
% plot(xx,cc_mld_y,'b','linewidth',4)
% axis tight
% D=axis;
% axis([D(1) D(2) 20 90])
% axis ij
% xlabel('month','fontsize',20,'fontweight','bold')
% ylabel('m','fontsize',20,'fontweight','bold')
% %line([0 0],[D(3) D(4)+5],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[1:12],'XTickLabel',{'J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'})
% text(1,16.7,'c) seasonal cycle of MLD from Argo','fontsize',30,'fontweight','bold','Interpreter', 'Latex')
% legend('anticyclones','cyclones','location',[.76 .27 .06 .12])
% legend boxoff
% print -dpng -r300 figs/ss_mld
% !open figs/ss_mld.png
% 
%     
%     

% [ss_dd_full,beta_dd_full]=harm_reg(djdays,10.^data,2,2*pi/365.25);
% dd_full_y=beta_dd_full(1)+beta_dd_full(2)*cos(f*x)+beta_dd_full(3)*cos(2*f*x)+beta_dd_full(4)*sin(f*x)+beta_dd_full(5)*sin(2*f*x);
% 
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% plot(xx,dd_full_y,'k','linewidth',4)
% axis tight
% D=axis;
% axis([D(1) D(2) D(3)-.005 D(4)+.01])
% xlabel('month','fontsize',20,'fontweight','bold')
% ylabel('mg m^{-3}','fontsize',20,'fontweight','bold')
% line([0 0],[D(3) D(4)+5],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[1:12],'XTickLabel',{'J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'})
% text(1,.1095,'d) seasonal cycle of SeaWiFS CHL','fontsize',30,'fontweight','bold','Interpreter', 'Latex')
% print -dpng -r300 figs/ss_full_chl
% !open figs/ss_full_chl.png
% 

% 
data_a=lw_chl_a.ts_1;
data_c=lw_chl_c.ts_1;
[ss_ac_dcdy,beta_ac_dcdy]=harm_reg(jdays,data_a,2,2*pi/365.25);
[ss_cc_dcdy,beta_cc_dcdy]=harm_reg(jdays,data_c,2,2*pi/365.25);
ac_dcdy_y=beta_ac_dcdy(1)+beta_ac_dcdy(2)*cos(f*x)+beta_ac_dcdy(3)*cos(2*f*x)+beta_ac_dcdy(4)*sin(f*x)+beta_ac_dcdy(5)*sin(2*f*x);
cc_dcdy_y=beta_cc_dcdy(1)+beta_cc_dcdy(2)*cos(f*x)+beta_cc_dcdy(3)*cos(2*f*x)+beta_cc_dcdy(4)*sin(f*x)+beta_cc_dcdy(5)*sin(2*f*x);
figure(1)
figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
plot(xx,ac_dcdy_y,'r','linewidth',4)
hold on
plot(xx,cc_dcdy_y,'b','linewidth',4)
axis tight
D=axis;
axis([D(1) D(2) -.01 .01])
xlabel('month','fontsize',20,'fontweight','bold')
ylabel('mg m^{-3}','fontsize',20,'fontweight','bold')
line([0 0],[D(3) D(4)+5],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[1:12],'XTickLabel',{'J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'})
text(1,.011,['b) seasonal cycle of CHL',char(39)],'fontsize',30,'fontweight','bold','Interpreter', 'Latex')
legend('anticyclones','cyclones','location',[.76 .27 .06 .08])
legend boxoff
print -dpng -r300 figs/ss_chl
!open figs/ss_chl.png
return
% 
% load ~/matlab/regions/new_regions_tight_comps lw_dcdy* track_jday
% jdays=unique(track_jday);
% data_a=lw_dcdy_a.ts_1;
% data_c=lw_dcdy_c.ts_1;
% [ss_ac_dcdy,beta_ac_dcdy]=harm_reg(jdays,data_a,2,2*pi/365.25);
% [ss_cc_dcdy,beta_cc_dcdy]=harm_reg(jdays,data_c,2,2*pi/365.25);
% ac_dcdy_y=beta_ac_dcdy(1)+beta_ac_dcdy(2)*cos(f*x)+beta_ac_dcdy(3)*cos(2*f*x)+beta_ac_dcdy(4)*sin(f*x)+beta_ac_dcdy(5)*sin(2*f*x);
% cc_dcdy_y=beta_cc_dcdy(1)+beta_cc_dcdy(2)*cos(f*x)+beta_cc_dcdy(3)*cos(2*f*x)+beta_cc_dcdy(4)*sin(f*x)+beta_cc_dcdy(5)*sin(2*f*x);
% figure(1)
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% plot(xx,1e6*ac_dcdy_y,'r','linewidth',4)
% hold on
% plot(xx,1e6*cc_dcdy_y,'b','linewidth',4)
% axis tight
% D=axis;
% axis([D(1) D(2) .0015 .03])
% xlabel('month','fontsize',20,'fontweight','bold')
% ylabel('mg m^{-3} per 1,000 km','fontsize',20,'fontweight','bold')
% %line([0 0],[D(3) D(4)+5],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[1:12],'XTickLabel',{'J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'})
% text(1,.0314,'a) seasonal cycle of $\partial CHL/\partial y$','fontsize',30,'fontweight','bold','Interpreter', 'Latex')
% legend('anticyclones','cyclones','location',[.76 .27 .06 .12])
% legend boxoff
% print -dpng -r300 figs/ss_dchldy
% !open figs/ss_dchldy.png

load ~/data/eddy/V5/global_tracks_V5 track_jday k cyc x y
ii=find(x>=70 & x<=100 & y>=-30 & y<=-10);
track_jday=track_jday(ii);
cyc=cyc(ii);
k=k(ii);
clear x y
x=1:365;

jdays=unique(track_jday);
[yea,mon,day]=jd2jdate(jdays);
for m=1:length(jdays);
    ii=find(track_jday==jdays(m));
    num_start_a(m)=length(find(k(ii)==1 & cyc(ii)==1));
    num_start_c(m)=length(find(k(ii)==1 & cyc(ii)==-1));
end
    

data_a=num_start_a;
data_c=num_start_c;
[ss_ac_dcdy,beta_ac_dcdy]=harm_reg(jdays,data_a,2,2*pi/365.25);
[ss_cc_dcdy,beta_cc_dcdy]=harm_reg(jdays,data_c,2,2*pi/365.25);
ac_dcdy_y=beta_ac_dcdy(1)+beta_ac_dcdy(2)*cos(f*x)+beta_ac_dcdy(3)*cos(2*f*x)+beta_ac_dcdy(4)*sin(f*x)+beta_ac_dcdy(5)*sin(2*f*x);
cc_dcdy_y=beta_cc_dcdy(1)+beta_cc_dcdy(2)*cos(f*x)+beta_cc_dcdy(3)*cos(2*f*x)+beta_cc_dcdy(4)*sin(f*x)+beta_cc_dcdy(5)*sin(2*f*x);
figure(1)
figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
plot(xx,ac_dcdy_y,'r','linewidth',4)
hold on
plot(xx,cc_dcdy_y,'b','linewidth',4)
axis tight
D=axis;
xlabel('month','fontsize',20,'fontweight','bold')
ylabel('number of eddies formed','fontsize',20,'fontweight','bold')
%line([0 0],[D(3) D(4)+5],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[1:12],'XTickLabel',{'J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'})
title('a) seasonal cycle of offshore eddy formation','fontsize',30,'fontweight','bold','Interpreter', 'Latex')
legend('anticyclones','cyclones','location',[.76 .27 .06 .12])
legend boxoff
print -dpng -r300 figs/ss_offshore_formation
!open figs/ss_offshore_formation.png

load ~/data/eddy/V5/global_tracks_V5 track_jday k cyc x y
ii=find(x>=108 & x<=120 & y>=-30 & y<=-10);
track_jday=track_jday(ii);
cyc=cyc(ii);
k=k(ii);
clear x y
x=1:365;

jdays=unique(track_jday);
[yea,mon,day]=jd2jdate(jdays);
for m=1:length(jdays);
    ii=find(track_jday==jdays(m));
    num_start_a(m)=length(find(k(ii)==1 & cyc(ii)==1));
    num_start_c(m)=length(find(k(ii)==1 & cyc(ii)==-1));
end
    

data_a=num_start_a;
data_c=num_start_c;
[ss_ac_dcdy,beta_ac_dcdy]=harm_reg(jdays,data_a,2,2*pi/365.25);
[ss_cc_dcdy,beta_cc_dcdy]=harm_reg(jdays,data_c,2,2*pi/365.25);
ac_dcdy_y=beta_ac_dcdy(1)+beta_ac_dcdy(2)*cos(f*x)+beta_ac_dcdy(3)*cos(2*f*x)+beta_ac_dcdy(4)*sin(f*x)+beta_ac_dcdy(5)*sin(2*f*x);
cc_dcdy_y=beta_cc_dcdy(1)+beta_cc_dcdy(2)*cos(f*x)+beta_cc_dcdy(3)*cos(2*f*x)+beta_cc_dcdy(4)*sin(f*x)+beta_cc_dcdy(5)*sin(2*f*x);
figure(1)
figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
plot(xx,ac_dcdy_y,'r','linewidth',4)
hold on
plot(xx,cc_dcdy_y,'b','linewidth',4)
axis tight
D=axis;
xlabel('month','fontsize',20,'fontweight','bold')
ylabel('number of eddies formed','fontsize',20,'fontweight','bold')
%line([0 0],[D(3) D(4)+5],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[1:12],'XTickLabel',{'J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'})
title('a) seasonal cycle of Leeuwin Current eddy formation','fontsize',30,'fontweight','bold','Interpreter', 'Latex')
legend('anticyclones','cyclones','location',[.76 .27 .06 .12])
legend boxoff
print -dpng -r300 figs/ss_LC_formation
!open figs/ss_LC_formation.png
