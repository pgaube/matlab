%{
SSH_HEAD   = 'AVISO_25_W_';
SSH_PATH   = '/matlab/data/eddy/V4/mat/';
GSM_HEAD   = 'GSM_9_21_';
GSM_PATH   = '/matlab/data/gsm/mat/';
wdays=2451395:7:2454832;
jdays=2450821:2454832;

load([GSM_PATH GSM_HEAD num2str(wdays(10))],'glon','glat')
load([SSH_PATH SSH_HEAD num2str(wdays(10))],'lon','lat')
slat=lat;
slon=lon;
load([GSM_PATH 'GSM_9_D_2454765'],'lon','lat')
[rg1,cg1]=imap(-30,-28,80,82,glat,glon);
[r1,c1]=imap(-30,-28,80,82,lat,lon);
[rs1,cs1]=imap(-30,-28,80,82,slat,slon);
[rg2,cg2]=imap(-30,-28,113,115,glat,glon);
[r2,c2]=imap(-30,-28,113,115,lat,lon);
[rs2,cs2]=imap(-30,-28,113,115,slat,slon);


daily1=nan(length(r1),length(c1),length(jdays));
weekly1=nan(length(rg1),length(cg1),length(wdays));
weekly1m=weekly1;
log_anom1=weekly1;
raw_anom1=weekly1;
daily2=nan(length(r2),length(c2),length(jdays));
weekly2=nan(length(rg2),length(cg2),length(wdays));
log_anom2=weekly1;
raw_anom2=weekly1;
%{
for m=1:length(jdays)
	if exist([GSM_PATH 'GSM_9_D_' num2str(jdays(m)) '.mat'])
		m
		load([GSM_PATH 'GSM_9_D_' num2str(jdays(m))],'chl_day')
		daily1(:,:,m)=chl_day(r1,c1);
		daily2(:,:,m)=chl_day(r2,c2);
	end	
end	
%}
for m=1:length(wdays)
	load([GSM_PATH GSM_HEAD num2str(wdays(m))],'gchl_week','bp26_chl','sp66_chl')
	load([SSH_PATH SSH_HEAD num2str(wdays(m))],'mask')
	weekly1m(:,:,m)=10.^gchl_week(rg1,cg1).* mask(rs1,cs1);
	weekly1(:,:,m)=10.^gchl_week(rg1,cg1);
	log_anom1(:,:,m)=bp26_chl(rg1,cg1);
	raw_anom1(:,:,m)=sp66_chl(rg1,cg1);
	weekly2(:,:,m)=10.^gchl_week(rg2,cg2);
	log_anom2(:,:,m)=bp26_chl(rg2,cg2);
	raw_anom2(:,:,m)=sp66_chl(rg2,cg2);
end	

save -append log_or_not weekly* daily* *_anom*
%}
load log_or_not
tbins=0:.01:.5;

[bw,nw1]=phist(weekly1(:),tbins);
[bw,nw2]=phist(weekly2(:),tbins);
cc=tbins(1:end-1);

figure(1)
clf
stairs(tbins(1:end-1),nw1./sum(nw1),'b','linewidth',8)
hold on
stairs(tbins(1:end-1),nw2./sum(nw2),'g','linewidth',8)
xlabel('CHL (mg m^{-3})','fontsize',40,'fontweight','bold')
ylabel('%','fontsize',40,'fontweight','bold')
axis([0 
set(gca,'fontsize',40,'fontweight','bold','LineWidth',8,'TickLength',[.01 .05],'layer','top')

return

tbins=log10(tbins);

[bd,nd1]=phist(log10(daily1(:)),tbins);
[bw,nw1]=phist(log10(weekly1(:)),tbins);
[bd,nd2]=phist(log10(daily2(:)),tbins);
[bw,nw2]=phist(log10(weekly2(:)),tbins);

figure(2)
clf
stairs(tbins(1:end-1),nd1./sum(nd1),'g')
hold on
stairs(tbins(1:end-1),nw1./sum(nw1),'b')
stairs(tbins(1:end-1),nd2./sum(nd2),'g--')
stairs(tbins(1:end-1),nw2./sum(nw2),'b--')
legend('daily pelagic','weekly pelagic','daily coastal','weekly coastal')

return

tbins=-.2:.001:.2;

[bl,nl1]=phist(log_anom1(:),tbins);
[br,nr1]=phist(raw_anom1(:),tbins);
[bl,nl2]=phist(log_anom2(:),tbins);
[br,nr2]=phist(raw_anom2(:),tbins);

figure(3)
clf
stairs(tbins(1:end-1),nl1./sum(nl1),'r')
hold on
stairs(tbins(1:end-1),nr1./sum(nr1),'b')
stairs(tbins(1:end-1),nl2./sum(nl2),'r--')
stairs(tbins(1:end-1),nr2./sum(nr2),'b--')
legend('log pelagic','raw pelgic','log coastal','raw coastal')
