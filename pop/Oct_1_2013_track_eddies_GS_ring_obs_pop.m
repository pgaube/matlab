clear all

minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);

%%first track eddies in AVISO

spath='~/data/eddy/V5/mat/AVISO_25_W_';
startjd=2451549; %5 Jan 2000
endjd=2453523; %1 Jun 2005
jdays=[startjd:7:endjd];
    

% % now load SSH data
load([spath,num2str(startjd)],'lat','lon')
[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
slat=lat(r,c);
slon=lon(r,c);


SSH=nan(length(r),length(c),length(jdays));
for m=1:length(jdays)
    load([spath,num2str(jdays(m))],'ssh')
    SSH(:,:,m)=ssh(r,c);
    clear ssh
end


aviso_eddies=track_eddies_PG(slon,slat,jdays,SSH,.25,7);
save GS_rings_tracks_aviso
return

%Now track eddies in model run 14

spath='~/matlab/pop/mat/run14_';
pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];


% now load pop SSH data
load ~/matlab/pop/mat/pop_model_domain.mat lat lon
load(['~/data/eddy/V5/mat/AVISO_25_W_2451549'],'ssh')
mask=nan*ssh;
mask(~isnan(ssh))=1;
mask=mask(r,c);
[rp,cp]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
plat=lat(rp,cp);
plon=lon(rp,cp);

pSSH=nan(length(r),length(c),length(pdays));
for m=1:length(pdays)
    if exist([spath,num2str(pdays(m)),'.mat'])
        load([spath,num2str(pdays(m))],'bp21_ssh')
    else
        load([spath,num2str(pdays(m-1))],'bp21_ssh')
    end
    m
    pSSH(:,:,m)=griddata(plon,plat,bp21_ssh(rp,cp),slon,slat,'linear').*mask;
    clear bp21_ssh
end
jdays_tmp=1:length(pdays);
pop_eddies=track_eddies3(slon,slat,jdays_tmp,pSSH,.25,5);
pop_eddies.track_jday=jday2pday(pop_eddies.track_jday)
save GS_rings_tracks_run14

% 
% 
% 
% %%Now track eddies in model Run 33
% 
% spath='~/matlab/pop/mat/run33_';
% pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
%     
% 
% % now load pop SSH data
% load ~/matlab/pop/mat/pop_model_domain.mat lat lon
% load(['~/data/eddy/V5/mat/AVISO_25_W_2451549'],'ssh')
% mask=nan*ssh;
% mask(~isnan(ssh))=1;
% mask=mask(r,c);
% [rp,cp]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
% plat=lat(rp,cp);
% plon=lon(rp,cp);
% 
% pSSH=nan(length(r),length(c),length(pdays));
% for m=1:length(pdays)
%     if exist([spath,num2str(pdays(m)),'.mat'])
%         load([spath,num2str(pdays(m))],'bp21_ssh')
%     else
%         load([spath,num2str(pdays(m-1))],'bp21_ssh')
%     end
%     pSSH(:,:,m)=griddata(plon,plat,bp21_ssh(rp,cp),slon,slat,'linear').*mask;
%     clear bp21_ssh
% end
% 
% ijd=1:5:5*length(pdays);
% pjd=1:7:5*length(pdays);
% ipSSH=nan(length(r),length(c),length(pjd));
% 
% for m=1:length(r)
%     for n=1:length(c)
%         ipSSH(m,n,:)=interp1(ijd,squeeze(pSSH(m,n,:)),pjd,'linear');
%     end
% end
% 
% 
% 
% pop_eddies=track_eddies2(slon,slat,pjd,ipSSH,.25);
% save GS_rings_tracks_run33
% 
% 
% 
% return
load GS_rings_tracks_aviso aviso_eddies slon slat 
load GS_rings_tracks_run14 pop_eddies pSSH
figure(1)
clf
subplot(211)
ii=find(aviso_eddies.age>=4);
pmap(slon,slat,[aviso_eddies.x(ii)' aviso_eddies.y(ii)' aviso_eddies.id(ii)' aviso_eddies.cyc(ii)' aviso_eddies.track_jday(ii)' aviso_eddies.k(ii)'],'new_tracks_starts')
title('AVISO lt>=28 days')
subplot(212)
ii=find(pop_eddies.age>=6);
pmap(slon,slat,[pop_eddies.x(ii)' pop_eddies.y(ii)' pop_eddies.id(ii)' pop_eddies.cyc(ii)' pop_eddies.track_jday(ii)' pop_eddies.k(ii)'],'new_tracks_starts')
title('POP lt>=30 days')
print -dpng -r300 figs/compare_eddies_30_days


ai=find(aviso_eddies.cyc==1);
ci=find(aviso_eddies.cyc==-1);
pai=find(pop_eddies.cyc==1);
pci=find(pop_eddies.cyc==-1);

npj=length(unique(pop_eddies.track_jday))
naj=length(unique(aviso_eddies.track_jday))

uid=unique(aviso_eddies.id);
puid=unique(pop_eddies.id);
dat(1,1)=length(uid)./naj;
dat(1,2)=length(puid)./npj;
dat(2,1)=length(aviso_eddies.x)./naj;
dat(2,2)=length(pop_eddies.x)./npj;

dat(3,1)=pmean(aviso_eddies.amp(ai));
dat(4,1)=pmean(aviso_eddies.amp(ci));
dat(3,2)=pmean(pop_eddies.amp(pai));
dat(4,2)=pmean(pop_eddies.amp(pci));

dat(5,1)=pmean(aviso_eddies.radius(ai));
dat(6,1)=pmean(aviso_eddies.radius(ci));
dat(5,2)=pmean(pop_eddies.radius(pai));
dat(6,2)=pmean(pop_eddies.radius(pci));
%%make table
f = figure(5);
set(f,'Position',[200 200 400 250]);
cnames = {'AVISO','POP'};
rnames = {'N4','N','Amp AC','Amp CC','Rad AC','Rad CC'};
t = uitable('Parent',f,'Data',dat,'ColumnName',cnames,... 
            'RowName',rnames,'Position',[20 20 360 200]);
print -dpng -r300 figs/compare_tracks_table



%%%make hists


[na,ba]=hist(aviso_eddies.amp(ai),20);
[nc,bc]=hist(aviso_eddies.amp(ci),ba);
npa=hist(pop_eddies.amp(pai),ba);
npc=hist(pop_eddies.amp(pci),bc);

figure(3)
clf
subplot(211)
stairs(ba,100*(na./nansum(na)),'r')
hold on
stairs(bc,100*(nc./nansum(nc)),'b')
title('Amp AVISO')

subplot(212)
stairs(ba,100*(npa./nansum(npa)),'r')
hold on
stairs(bc,100*(npc./nansum(npc)),'b')
title('Amp POP')

[na,ba]=hist(aviso_eddies.radius(ai),20);
[nc,bc]=hist(aviso_eddies.radius(ci),ba);
npa=hist(pop_eddies.radius(pai),ba);
npc=hist(pop_eddies.radius(pci),bc);
print -dpng -r300 figs/histos_amps


figure(4)
clf
subplot(211)
stairs(ba,100*(na./nansum(na)),'r')
hold on
stairs(bc,100*(nc./nansum(nc)),'b')
title('Radius AVISO')

subplot(212)
stairs(ba,100*(npa./nansum(npa)),'r')
hold on
stairs(bc,100*(npc./nansum(npc)),'b')
title('Radius POP')

print -dpng -r300 figs/histos_radius
