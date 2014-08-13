%test De_Leon_and_Paldo_hovs
load chelle.pal
% load ~/data/eddy/V5/global_tracks_v5.mat
% 
% ii=find(x>=125 & x<=135 & y>=-46 & y<=-44);
% hx=x(ii);
% hy=y(ii);
% hid=id(ii);
% htrack_jday=track_jday(ii);
% hcyc=cyc(ii);
% 
% jdays=[2448910:7:2455581];
% data_dir='~/data/eddy/V5/mat/AVISO_25_W_';
% load([data_dir num2str(jdays(1))],'lat','lon');
% 
% [r,c]=imap(-46,-44,125,135,lat,lon);
% shov=nan(length(jdays),length(c));
% lj=length(jdays);
% for m=1:lj
% 	fprintf('\r    loading %03u of %03u\r',m,lj)
% 	if exist([data_dir num2str(jdays(m)) '.mat'])
% 		load([data_dir num2str(jdays(m))],'ssh');
% 		shov(m,:)=nanmean(ssh(r,c),1);
% 	else
% 	fprintf('\n    missing data file %03u',m)
% 	end
% end
% 
% %make year_day vector
% [year,mon,day]=jd2jdate(jdays);
% for m=1:length(jdays)
% 	year_day(m)=(year(m)*1000)+julian(mon(m),day(m),year(m),year(m));
% end

figure(30)
clf
pcolor(lon(1,c),jdays,shov);shading flat
hold on


ai=find(hcyc==1);
uai=unique(hid(ai));
numit=length(uai);
for p=1:numit
    pi=sames(uai(p),hid);
    plot(hx(pi),htrack_jday(pi),'k','linewidth',1)
end
ci=find(hid<nneg);
uci=unique(hid(ci));
numit=length(uci);
for p=1:numit
    pi=sames(uci(p),hid);
    plot(hx(pi),htrack_jday(pi),'k--','linewidth',1)
end
% set(gca,'ytick',[jdays(13):2*365:max(jdays)]','yticklabel',...
%     {int2str(year(1:2*52:length(year))')},'tickdir',...
%     'out','layer','top','clipping','off')
set(gca,'ytick',[jdays(100):700:max(jdays)]','yticklabel',...
    {int2str([100:100:900]')},'tickdir',...
    'out','layer','top','clipping','off','ylim',[jdays(1) jdays(650)])
daspect([1 300 1])
shading interp
xlabel('Longitude   ')
ylabel('week')
colormap(chelle)
caxis([-10 10])
hold on
title('Time-Longitude Diagram at 45^\circ S')
text(135,jdays(300),'  anticyclones -')
text(135,jdays(250),'        cyclones --')
yy=colorbar;
set(yy,'position',[0.15 0.1080 0.0108 0.8169])
print -dpng -r300 ~/Documents/reviews/GRL/De-Leon_and_Pador_2013_GRL_Fig_3_PG_V1
return
figure(30)
clf
pcolor(lon(1,c),jdays,shov);shading flat
hold on


ai=find(hcyc==1);
uai=unique(hid(ai));
numit=length(uai);
for p=1:numit
    pi=sames(uai(p),hid);
    plot(hx(pi),htrack_jday(pi),'k','linewidth',1)
end
ci=find(hid<nneg);
uci=unique(hid(ci));
numit=length(uci);
for p=1:numit
    pi=sames(uci(p),hid);
    plot(hx(pi),htrack_jday(pi),'k--','linewidth',1)
end
set(gca,'ytick',[jdays(13):2*365:max(jdays)]','yticklabel',...
    {int2str(year(1:2*52:length(year))')},'tickdir',...
    'out','layer','top','clipping','off')
daspect([1 500 1])
shading interp
xlabel('Longitude   ')
colormap(chelle)
caxis([-10 10])
hold on
title('Time-Longitude Diagram at 45^\circ S')
text(135,jdays(800),'  anticyclones -')
text(135,jdays(750),'        cyclones --')

print -dpng -r300 ~/Documents/reviews/GRL/De-Leon_and_Pador_2013_GRL_Fig_3_PG_V2
