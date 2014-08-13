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
argo_month,argo_scale]=deal(nan(length(ii),1));

progressbar('Checking Float')
lap=length(ii);
[year,month,day]=jd2jdate(eddy_pjday_round);
for m=1:length(ii)
	progressbar(m/lap)
	if(~isnan((eddy_pjday_round(ii(m))))) & exist(['/matlab/data/gsm/mat/GSM_9_21_',num2str(eddy_pjday_round(ii(m))),'.mat'])
	load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(eddy_pjday_round(ii(m)))],'gpar_week','gchl_week','gcar_week','glat','glon')
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
		argo_cc(m)		=	nanmean(tmp_chl(:))/nanmean(tmp_car(:));
		argo_par(m)		=	nanmean(tmp_par(:));
		argo_chl(m)		=	nanmean(tmp_chl(:));
		argo_c(m)		=	nanmean(tmp_car(:));
		argo_mld(m)		=	eddy_mld(ii(m));
		argo_zeu(m)		=	exp(a*log(argo_chl(m))+b);
		argo_kd(m)		=	log(.01)./argo_zeu(m);
		argo_ig(m) 		= 	argo_par(m).* exp(argo_kd(m).*(argo_mld(m)./2));
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

argo_mu=2*(argo_cc./(0.022+(0.045-0.022)*exp(-3*argo_ig))).*(1-exp(-3*argo_ig));
argo_mu(argo_mu>2)=nan;
save indian_test_photac2 argo_*

%.022+(.045-.022)*exp(-3*ig);


%{
b=linspace(0,2.5,25);
[n]=hist(argo_ig,b);
save -ascii ~/Documents/Publications/gaube_chelton_eddy_wind/figures/calcom_data/hist_ig_bins.txt b
cpdf=cumsum(n);
cpdf=100*cpdf./max(cpdf);
save -ascii ~/Documents/Publications/gaube_chelton_eddy_wind/figures/calcom_data/hist_ig.txt cpdf
%}
%}
load indian_test_photac2 argo_*
argo_mu(argo_dist./argo_scale>=.5)=nan;
ia=find(argo_cyc>0);
ic=find(argo_cyc<0);
iaw=find(argo_month>4 & argo_month<11 & argo_cyc>0);
icw=find(argo_month>4 & argo_month<11 & argo_cyc<0);
ias=find(argo_month>10 | argo_month<5 & argo_cyc>0);
ics=find(argo_month>10 | argo_month<5 & argo_cyc<0);

[naw,baw]=hist(argo_mu(iaw),30);
[nas,bas]=hist(argo_mu(ias),30);
[ncw,bcw]=hist(argo_mu(icw),30);
[ncs,bcs]=hist(argo_mu(ics),30);
%}

ia=find(argo_cyc>0);
ic=find(argo_cyc<0);
[nc,b]=hist(argo_mu(ic),25);
[na]=hist(argo_mu(ia),b);

na=na./sum(na);
nc=nc./sum(nc);

figure(99)
set(gcf,'PaperPosition',[1 1 10 30])
clf
subplot(311)
stairs(b,na,'r','LineWidth',12)
hold on
stairs(b,nc,'b','LineWidth',12)
set(gca,'fontsize',60,'fontweight','bold','LineWidth',15,'TickLength',[.01 .05],'layer','top')

subplot(312)
stairs(b,cumsum(na),'r','LineWidth',12)
hold on
stairs(b,cumsum(nc),'b','LineWidth',12)
set(gca,'fontsize',60,'fontweight','bold','LineWidth',15,'TickLength',[.01 .05],'layer','top')

subplot(313)
plot(b,nc./na,'k','LineWidth',12)
line([0 2],[1 1],'color','k','LineWidth',12)
set(gca,'fontsize',60,'fontweight','bold','LineWidth',15,'TickLength',[.01 .05],'layer','top')
print -depsc hists_mu

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
