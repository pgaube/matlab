%MORELL
a=-0.3554;
b=3.5805;

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
load FINAL_monthly_comps lw_kd490_a lw_kd490_c
djdays=jdays;
jdays=unique(track_jday);
f=2*pi/365.25;
x=1:365;
xx=linspace(1,12,365);

data_a=1./lw_kd490_a.ts_1;
data_c=1./lw_kd490_c.ts_1;
[ss_ac_dcdy,beta_ac_dcdy]=harm_reg(jdays,data_a,2,2*pi/365.25);
[ss_cc_dcdy,beta_cc_dcdy]=harm_reg(jdays,data_c,2,2*pi/365.25);
ac_dcdy_y=beta_ac_dcdy(1)+beta_ac_dcdy(2)*cos(f*x)+beta_ac_dcdy(3)*cos(2*f*x)+beta_ac_dcdy(4)*sin(f*x)+beta_ac_dcdy(5)*sin(2*f*x);
cc_dcdy_y=beta_cc_dcdy(1)+beta_cc_dcdy(2)*cos(f*x)+beta_cc_dcdy(3)*cos(2*f*x)+beta_cc_dcdy(4)*sin(f*x)+beta_cc_dcdy(5)*sin(2*f*x);


load EK_time_chl_wek ac_amld cc_amld ac_jday cc_jday
[ts_ac_amld,ts_cc_amld]=deal(deal(nan*jdays));

for m=1:length(ts_ac_amld);
	ii=find(ac_jday==jdays(m));
	ts_ac_mld(m)=pmean(ac_amld(ii));
    ii=find(cc_jday==jdays(m));
	ts_cc_mld(m)=pmean(cc_amld(ii));
end
[ss_ac_mld,beta_ac_mld]=harm_reg(jdays,ts_ac_mld,2,2*pi/365.25);
[ss_cc_mld,beta_cc_mld]=harm_reg(jdays,ts_cc_mld,2,2*pi/365.25);
ac_mld_y=beta_ac_mld(1)+beta_ac_mld(2)*cos(f*x)+beta_ac_mld(3)*cos(2*f*x)+beta_ac_mld(4)*sin(f*x)+beta_ac_mld(5)*sin(2*f*x);
cc_mld_y=beta_cc_mld(1)+beta_cc_mld(2)*cos(f*x)+beta_cc_mld(3)*cos(2*f*x)+beta_cc_mld(4)*sin(f*x)+beta_cc_mld(5)*sin(2*f*x);

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
plot(xx,ac_dcdy_y,'r--','linewidth',4)
hold on
plot(xx,cc_dcdy_y,'b--','linewidth',4)

plot(xx,ac_mld_y,'r','linewidth',4)
hold on
plot(xx,cc_mld_y,'b','linewidth',4)

axis tight
D=axis;
axis ij
axis([D(1) D(2) D(3)-5 D(4)+5])
xlabel('month','fontsize',20,'fontweight','bold')
ylabel('m','fontsize',20,'fontweight','bold')
line([0 0],[D(3) D(4)+5],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[1:12],'XTickLabel',{'J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'})
text(1,.1095,'d) seasonal cycle of Z_{eu}','fontsize',30,'fontweight','bold','Interpreter', 'Latex')
legend('anticyclones','cyclones','location',[.76 .3 .06 .12])
legend boxoff
print -dpng -r300 figs/ss_zeu


