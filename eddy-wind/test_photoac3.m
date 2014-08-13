%MJB
a=-0.3467;
b=3.3220;

%MORELL
a=-0.3554;
b=3.5805;
%{

load /matlab/matlab/regions/tracks/tight/lw_tracks
load /matlab/matlab/argo/eddy_UCSD_mld_index

ii=sames(unique(id),eddy_id);

[argo_dist,argo_zeu,argo_cc,argo_par,argo_ig,...
argo_id,argo_kd,argo_chl,argo_c,argo_cyc,argo_mld,...
argo_month,argo_scale,argo_kpar,argo_igpar]=deal(nan(length(ii),1));

progressbar('Checking Float')
lap=length(ii);
[year,month,day]=jd2jdate(eddy_pjday_round);
for m=1:length(ii)
	progressbar(m/lap)
	if(~isnan((eddy_pjday_round(ii(m))))) & exist(['/matlab/data/gsm/mat/GSM_9_21_',num2str(eddy_pjday_round(ii(m))),'.mat'])
	load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(eddy_pjday_round(ii(m)))],'gkd_week','gpar_week','gchl_week','gcar_week','glat','glon')
	tx=eddy_plon(ii(m));
	ty=eddy_plat(ii(m));
	tmpxs=floor(tx)-2.125:.25:ceil(tx)+2.125;
    tmpys=floor(ty)-2.125:.25:ceil(ty)+2.125;
    disx = abs(tmpxs-tx);
    disy = abs(tmpys-ty);
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cx=tmpxs(iminx(1));
    cy=tmpys(iminy(1));
    [r,c]=imap(cy-.1,cy+.1,cx-.1,cx+.1,glat,glon);	
    dist_x=111.11*abs(eddy_x(ii(m))-tx)*cosd(ty);
    dist_y=111.11*abs(eddy_y(ii(m))-ty);
    dist_r=sqrt(dist_x.^2+dist_y.^2);
    if r>2 & r<=length(glon(:,1))-2 & c>2 & c<=length(glon(1,:))-2
		tmp_chl			=	10.^gchl_week(r-2:r+2,c-2:c+2);
		tmp_car			=	10.^gcar_week(r-2:r+2,c-2:c+2);
		tmp_par			=	gpar_week(r-2:r+2,c-2:c+2);
		tmp_kd			=	gkd_week(r-2:r+2,c-2:c+2);
		argo_cc(m)		=	nanmean(tmp_chl(:))/nanmean(tmp_car(:));
		argo_par(m)		=	nanmean(tmp_par(:));
		argo_chl(m)		=	nanmean(tmp_chl(:));
		argo_c(m)		=	nanmean(tmp_car(:));
		argo_mld(m)		=	eddy_mld(ii(m));
		argo_zeu(m)		=	exp(a*log(argo_chl(m))+b);
		argo_kpar(m)	=	log(.01)./argo_zeu(m);
		argo_kd(m)		=	nanmean(tmp_kd(:));
		argo_id(m) 		= 	eddy_id(ii(m));
		argo_cyc(m) 	= 	eddy_cyc(ii(m));
		argo_month(m)	=	month(ii(m));
		argo_dist(m)	=	dist_r;
		argo_scale(m)	=	eddy_scale(ii(m));
    else
    	waring='not enough poins within eddy sample'
    end
    end
end
argo_ig = argo_par.* exp(-argo_kd.*(argo_mld./2));
argo_igpar = argo_par.* exp(argo_kpar.*(argo_mld./2));
argo_mu=2*(argo_cc./(0.022+(0.045-0.022)*exp(-3*argo_ig))).*(1-exp(-3*argo_ig));
argo_mu(argo_mu>2)=nan;
save indian_test_photac2 argo_*

%.022+(.045-.022)*exp(-3*ig);


%}
%}
load indian_test_photac2 argo_*

%{
b=linspace(0,3.5,25);
cc = .022+(.045-.022)*exp(-3*b);
[n]=hist(argo_ig,b);
save -ascii ~/Documents/Publications/gaube_chelton_eddy_wind/figures/calcom_data/hist_ig_bins.txt b
save -ascii ~/Documents/Publications/gaube_chelton_eddy_wind/figures/calcom_data/ig.txt b
save -ascii ~/Documents/Publications/gaube_chelton_eddy_wind/figures/calcom_data/cc.txt cc
cpdf=cumsum(n);
cpdf=100*cpdf./max(cpdf);
save -ascii ~/Documents/Publications/gaube_chelton_eddy_wind/figures/calcom_data/hist_ig.txt cpdf
%}

argo_mu=2*(argo_cc./(0.022+(0.045-0.022)*exp(-3*argo_ig))).*(1-exp(-3*argo_ig));
argo_mu(argo_mu>2)=nan;
%argo_mu(argo_dist./argo_scale>=2)=nan;
ia=find(argo_cyc>0);
ic=find(argo_cyc<0);
iaw=find(argo_month>4 & argo_month<11 & argo_cyc>0);
icw=find(argo_month>4 & argo_month<11 & argo_cyc<0);
ias=find(argo_month>10 | argo_month<5 & argo_cyc>0);
ics=find(argo_month>10 | argo_month<5 & argo_cyc<0);

bbb=[.01:.2:2];
[naw,baw]=hist(argo_mu(iaw),bbb);
[nas,bas]=hist(argo_mu(ias),bbb);
[ncw,bcw]=hist(argo_mu(icw),bbb);
[ncs,bcs]=hist(argo_mu(ics),bbb);
%}

%do stats
mu_bar_ac=pmean(argo_mu(iaw))
mu_bar_cc=pmean(argo_mu(icw))

std_a=pstd(argo_mu(iaw));
std_c=pstd(argo_mu(icw));
na=length(find(~isnan(argo_mu(iaw))));
nc=length(find(~isnan(argo_mu(icw))));

ci_a=abs(std_a.*tinv((.05)/2,na-1)./sqrt(na))
ci_c=abs(std_c.*tinv((.05)/2,nc-1)./sqrt(nc))



ia=find(argo_cyc>0);
ic=find(argo_cyc<0);
[nc,b]=hist(argo_mu(ic),bbb);
[na]=hist(argo_mu(ia),b);

cnaw=100*(naw./sum(naw));
cncw=100*(ncw./sum(ncw));
cnas=100*(nas./sum(nas));
cncs=100*(ncs./sum(ncs));

na=100*(na./sum(na));
nc=100*(nc./sum(nc));

figure(98)
set(gcf,'PaperPosition',[1 1 20 30])
clf
subplot(322)
stairs(baw,cnaw,'r','LineWidth',5)
hold on
stairs(bcw,cncw,'b','LineWidth',5)
axis([0 2 0 55])
title('winter','fontsize',60,'fontweight','bold')
text(.75,37,['\mu = ',num2str(round(100*pmean(cat(1,argo_mu(iaw),argo_mu(icw))))./100),' day^{-1}'],'fontsize',40,'fontweight','bold')
set(gca,'fontsize',60,'fontweight','bold','LineWidth',6,'TickLength',[.01 .05],'layer','top')

subplot(324)
stairs(baw,cumsum(cnaw),'r','LineWidth',5)
hold on
stairs(bcw,cumsum(cncw),'b','LineWidth',5)
axis([0 2 0 110])
set(gca,'fontsize',60,'fontweight','bold','LineWidth',6,'TickLength',[.01 .05],'layer','top')

subplot(326)
plot(baw,ncw./naw,'k','LineWidth',5)
line([0 2],[1 1],'color','k','LineWidth',5)
axis([0 2 0 2])
xlabel({'phytoplankton','growth rate (day^{-1})'},'fontsize',60,'fontweight','bold')
text(.65,1.8,'cyclonic/anticyclonic','fontsize',30,'fontweight','bold')
set(gca,'fontsize',60,'fontweight','bold','LineWidth',6,'TickLength',[.01 .05],'layer','top')

subplot(321)
stairs(bas,cnas,'r','LineWidth',5)
hold on
stairs(bcs,cncs,'b','LineWidth',5)
axis([0 2 0 55])
text(.75,37,['\mu = ',num2str(round(100*pmean(cat(1,argo_mu(ias),argo_mu(ics))))./100),' day^{-1}'],'fontsize',40,'fontweight','bold')
title('summer','fontsize',60,'fontweight','bold')
set(gca,'fontsize',60,'fontweight','bold','LineWidth',6,'TickLength',[.01 .05],'layer','top')

subplot(323)
stairs(bas,cumsum(cnas),'r','LineWidth',5)
hold on
stairs(bcs,cumsum(cncs),'b','LineWidth',5)
axis([0 2 0 110])
text(-.6,3,'percentage of observations','Rotation',90,'fontsize',60,'fontweight','bold')
set(gca,'fontsize',60,'fontweight','bold','LineWidth',6,'TickLength',[.01 .05],'layer','top')

subplot(325)
plot(bas,ncs./nas,'k','LineWidth',5)
line([0 2],[1 1],'color','k','LineWidth',5)
axis([0 2 0 2])
xlabel({'phytoplankton','growth rate (day^{-1})'},'fontsize',60,'fontweight','bold')
text(.65,1.8,'cyclonic/anticyclonic','fontsize',30,'fontweight','bold')
set(gca,'fontsize',60,'fontweight','bold','LineWidth',6,'TickLength',[.01 .05],'layer','top')
print -dpng -r300 hists_mu
return

figure(99)
set(gcf,'PaperPosition',[1 1 10 30])
clf
subplot(311)
stairs(b,na,'r','LineWidth',5)
hold on
stairs(b,nc,'b','LineWidth',5)
set(gca,'fontsize',60,'fontweight','bold','LineWidth',6,'TickLength',[.01 .05],'layer','top')

subplot(312)
stairs(b,cumsum(na),'r','LineWidth',5)
hold on
stairs(b,cumsum(nc),'b','LineWidth',5)
set(gca,'fontsize',60,'fontweight','bold','LineWidth',6,'TickLength',[.01 .05],'layer','top')

subplot(313)
plot(b,nc./na,'k','LineWidth',5)
line([0 2],[1 1],'color','k','LineWidth',5)
set(gca,'fontsize',60,'fontweight','bold','LineWidth',6,'TickLength',[.01 .05],'layer','top')
print -depsc mu_1_column

figure(1)
clf
stairs(baw,(naw)./sum((naw)),'r')
hold on
stairs(bas,(nas)./sum((nas)),'r--')
stairs(bcw,(ncw)./sum((ncw)),'b')
stairs(bcs,(ncs)./sum((ncs)),'b--')
legend('winter AC','summer AC','winter CC','summer CC')

figure(2)
clf
stairs(baw,cumsum(naw)./sum(cumsum(naw)),'r')
hold on
stairs(bas,cumsum(nas)./sum(cumsum(nas)),'r--')
stairs(bcw,cumsum(ncw)./sum(cumsum(ncw)),'b')
stairs(bcs,cumsum(ncs)./sum(cumsum(ncs)),'b--')
legend('winter AC','summer AC','winter CC','summer CC')
return
%Calculate Ig and CC_light
ig = 0:.05:2.5;

cc = .022+(.045-.022)*exp(-3*ig);

figure(3)
clf
[ax,h1,h2]=plotyy(ig,cc,b,cpdf)
ylabel('CHL:C')
xlabel('I_g')
hold on
stairs(b,cpdf)
title('CHL:C as a function of I_g')


return
%}
%the global curve
sum_par=2.5;
win_par=1.5;
mld=50;
chl=0:.05:10;

	
z=exp(a*log(chl)+b);
kd=log(.01)./z;
	

axis([0 2 .01 .05])
return


mld1=25;
chl1=.048;
z1=exp(a*log(chl1)+b);
kd1=log(.01)./z1;
ig1 = sum_par.* exp(kd1.*(mld1./2));
cc1 = .022+(.045-.022)*exp(-3*ig1)

mld2=70;
chl2=.08;
z2=exp(a*log(chl2)+b);;
kd2=log(.01)./z2;;
ig2 = win_par.* exp(kd2.*(mld2./2));
cc2 = .022+(.045-.022)*exp(-3*ig2)

mld2=150;
chl2=.1;
z2=exp(a*log(chl2)+b);;
kd2=log(.01)./z2;;
ig3 = win_par.* exp(kd2.*(mld2./2));
cc3 = .022+(.045-.022)*exp(-3*ig3)

figure(6)
clf
plot(ig,cc,'k')
ylabel('CHL:C')
xlabel('I_g')
hold on
plot(ig1,cc1,'r*')
plot(ig2,cc2,'b*')
plot(ig3,cc3,'g*')
title('CHL:C as a function of I_g')
legend('CHL:C resultant from light alone','summer (40m and .01 mg m^{-3})',...
'winter (70m and .1 mg m^{-3})','ARGO 90th percentile (150m and .1 mg m^{-3})')
axis([0 2 .01 .05])
return
print -dpng -r300 figs/chl_c_winter_summer

cd /Users/gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/

save -ascii calcom_data/ig.txt ig
save -ascii calcom_data/cc.txt cc
nyp=length(ig)
cd /matlab/matlab/eddy-wind/
