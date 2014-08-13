%MJB
a=-0.3467;
b=3.3220;

%MORELL
a=-0.3554;
b=3.5805;
%{

load /matlab/matlab/air-sea/tracks/midlat_tracks id
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
save Srgo_mu_midlat argo_*
return
%.022+(.045-.022)*exp(-3*ig);


%}
%}
load Srgo_mu_midlat argo_*

argo_mu(argo_dist./argo_scale>=1)=nan;
ia=find(argo_cyc>0);
ic=find(argo_cyc<0);

[nc,b]=hist(argo_mu(ic),25);
[na]=hist(argo_mu(ia),b);

na=100*(na./sum(na));
nc=100*(nc./sum(nc));


figure(99)
set(gcf,'PaperPosition',[1 1 10 30])
clf
subplot(311)
stairs(b,na,'r','LineWidth',5)
hold on
stairs(b,nc,'b','LineWidth',5)
text(1,10,['\mu = ',num2str(round(100*pmean(argo_mu))./100),' day^{-1}'],'fontsize',40,'fontweight','bold')
set(gca,'fontsize',60,'fontweight','bold','LineWidth',6,'TickLength',[.01 .05],'layer','top')
axis([0 2 0 15])

subplot(312)
stairs(b,cumsum(na),'r','LineWidth',5)
hold on
stairs(b,cumsum(nc),'b','LineWidth',5)
%text(-.4,3,'percentage of observations','Rotation',90,'fontsize',60,'fontweight','bold')
axis([0 2 0 110])
set(gca,'fontsize',60,'fontweight','bold','LineWidth',6,'TickLength',[.01 .05],'layer','top')

subplot(313)
plot(b,nc./na,'k','LineWidth',5)
line([0 2],[1 1],'color','k','LineWidth',5)
text(.65,.5,'cyclonic/anticyclonic','fontsize',30,'fontweight','bold')
xlabel({'phytoplankton','growth rate (day^{-1})'},'fontsize',60,'fontweight','bold')
set(gca,'ylim',[0 2])
set(gca,'fontsize',60,'fontweight','bold','LineWidth',6,'TickLength',[.01 .05],'layer','top')
print -dpng -r300 figs/mu_midlat_hist
