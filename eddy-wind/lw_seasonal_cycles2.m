cd ../regions
set_regions
load ../regions/new_regions_tight_comps
cd ../eddy-wind
load lw_domain_chl_ss
djdays=jdays;
jdays=unique(track_jday);
f=2*pi/365.25;
x=1:365;
xx=linspace(1,12,365);
m=4
 
eval(['data_a=(',curs{m},'_full_a.ts_1);'])
eval(['data_c=(',curs{m},'_full_c.ts_1);'])
[ss_ac_dcdy,beta_ac_dcdy]=harm_reg(jdays,10.^data_a,2,2*pi/365.25);
[ss_cc_dcdy,beta_cc_dcdy]=harm_reg(jdays,10.^data_c,2,2*pi/365.25);
[ss_dd_dcdy,beta_dd_dcdy]=harm_reg(djdays,10.^data,2,2*pi/365.25);
ac_dcdy_y=beta_ac_dcdy(1)+beta_ac_dcdy(2)*cos(f*x)+beta_ac_dcdy(3)*cos(2*f*x)+beta_ac_dcdy(4)*sin(f*x)+beta_ac_dcdy(5)*sin(2*f*x);
cc_dcdy_y=beta_cc_dcdy(1)+beta_cc_dcdy(2)*cos(f*x)+beta_cc_dcdy(3)*cos(2*f*x)+beta_cc_dcdy(4)*sin(f*x)+beta_cc_dcdy(5)*sin(2*f*x);
dd_dcdy_y=beta_dd_dcdy(1)+beta_dd_dcdy(2)*cos(f*x)+beta_dd_dcdy(3)*cos(2*f*x)+beta_dd_dcdy(4)*sin(f*x)+beta_dd_dcdy(5)*sin(2*f*x);
figure(1)
clf
plot(xx,ac_dcdy_y,'r','linewidth',4)
hold on
plot(xx,cc_dcdy_y,'b','linewidth',4)
plot(xx,dd_dcdy_y,'k','linewidth',4)
axis tight
D=axis;
axis([D(1) D(2) D(3)-.005 D(4)+.01])
%xlabel('year day','fontsize',40,'fontweight','bold')
ylabel('mg m^{-3}','fontsize',30,'fontweight','bold')
%line([0 0],[D(3) D(4)+5],'color','k','LineWidth',2)
set(gca,'fontsize',20,'fontweight','bold','LineWidth',4,'TickLength',[.01 .05],'layer','top')
set(gca,'xtick',[1:12],'XTickLabel',{'j';'f';'m';'a';'m';'j';'j';'a';'s';'o';'n';'d'})
title('Seasonal cycle of full CHL','fontsize',30,'fontweight','bold')
%daspect([100 1 45])
print -dpng -r300 figs/ss_full_chl


cplot_seasonal_cycle3(x,dd_dcdy_y,ac_dcdy_y,cc_dcdy_y,D(3)-.005,D(4)+.005,1,'m',[curs{m},' CHL'],...
				 ['~/Documents/OSU/figures/regions/ss/',curs{m},'_full_chl'])
				 

return

eval(['data_a=(',curs{m},'_chl_a.ts_1);'])
eval(['data_c=(',curs{m},'_chl_c.ts_1);'])
[ss_ac_dcdy,beta_ac_dcdy]=harm_reg(jdays,data_a,2,2*pi/365.25);
[ss_cc_dcdy,beta_cc_dcdy]=harm_reg(jdays,data_c,2,2*pi/365.25);
ac_dcdy_y=beta_ac_dcdy(1)+beta_ac_dcdy(2)*cos(f*x)+beta_ac_dcdy(3)*cos(2*f*x)+beta_ac_dcdy(4)*sin(f*x)+beta_ac_dcdy(5)*sin(2*f*x);
cc_dcdy_y=beta_cc_dcdy(1)+beta_cc_dcdy(2)*cos(f*x)+beta_cc_dcdy(3)*cos(2*f*x)+beta_cc_dcdy(4)*sin(f*x)+beta_cc_dcdy(5)*sin(2*f*x);
figure(1)
clf
plot(xx,ac_dcdy_y,'r','linewidth',4)
hold on
plot(xx,cc_dcdy_y,'b','linewidth',4)
axis tight
D=axis;
axis([D(1) D(2) D(3)-.005 D(4)+.01])
%xlabel('year day','fontsize',40,'fontweight','bold')
ylabel('mg m^{-3} per 1,000 km','fontsize',30,'fontweight','bold')
%line([0 0],[D(3) D(4)+5],'color','k','LineWidth',2)
set(gca,'fontsize',20,'fontweight','bold','LineWidth',4,'TickLength',[.01 .05],'layer','top')
set(gca,'xtick',[1:12],'XTickLabel',{'j';'f';'m';'a';'m';'j';'j';'a';'s';'o';'n';'d'})
title('Seasonal cycle of \partial(CHL)/\partialy','fontsize',30,'fontweight','bold')
daspect([100 1 45])
print -dpng -r300 figs/ss_dchldy
cplot_seasonal_cycle(x,ac_dcdy_y,cc_dcdy_y,D(3)-.005,D(4)+.005,1,'m',[curs{m},' CHL'],...
				 ['~/Documents/OSU/figures/regions/ss/',curs{m},'_chl'])

eval(['data_a=(1e6*',curs{m},'_dcdy_a.ts_1);'])
eval(['data_c=(1e6*',curs{m},'_dcdy_c.ts_1);'])
[ss_ac_dcdy,beta_ac_dcdy]=harm_reg(jdays,data_a,2,2*pi/365.25);
[ss_cc_dcdy,beta_cc_dcdy]=harm_reg(jdays,data_c,2,2*pi/365.25);
ac_dcdy_y=beta_ac_dcdy(1)+beta_ac_dcdy(2)*cos(f*x)+beta_ac_dcdy(3)*cos(2*f*x)+beta_ac_dcdy(4)*sin(f*x)+beta_ac_dcdy(5)*sin(2*f*x);
cc_dcdy_y=beta_cc_dcdy(1)+beta_cc_dcdy(2)*cos(f*x)+beta_cc_dcdy(3)*cos(2*f*x)+beta_cc_dcdy(4)*sin(f*x)+beta_cc_dcdy(5)*sin(2*f*x);
figure(1)
clf
plot(xx,ac_dcdy_y,'r','linewidth',4)
hold on
plot(xx,cc_dcdy_y,'b','linewidth',4)
axis tight
D=axis;
axis([D(1) D(2) D(3)-.005 D(4)+.01])
%xlabel('year day','fontsize',40,'fontweight','bold')
ylabel('mg m^{-3} per 1,000 km','fontsize',30,'fontweight','bold')
%line([0 0],[D(3) D(4)+5],'color','k','LineWidth',2)
set(gca,'fontsize',20,'fontweight','bold','LineWidth',4,'TickLength',[.01 .05],'layer','top')
set(gca,'xtick',[1:12],'XTickLabel',{'j';'f';'m';'a';'m';'j';'j';'a';'s';'o';'n';'d'})
title('Seasonal cycle of \partial(CHL)/\partialy','fontsize',30,'fontweight','bold')
daspect([100 1 45])
print -dpng -r300 figs/ss_dchldy
cplot_seasonal_cycle(x,ac_dcdy_y,cc_dcdy_y,0,.03,1,'m',[curs{m},' dCHLdy'],...
				['~/Documents/OSU/figures/regions/ss/',curs{m},'_dcdy'])


