clear all

load test_data

eddies=track_eddies_PG(lon,lat,jdays,SSH,.25,5);

ia=find(eddies.cyc==1);
ic=find(eddies.cyc==-1);
uia=unique(eddies.id(ia));
uic=unique(eddies.id(ic));

land=mean(SSH,3);
mask=nan*land;
mask(isnan(land))=1;


% % %plot edddy tracks
figure(1)
clf
pcolor(lon,lat,mask);shading interp;axis image
hold on
for m=1:length(uia)
    ii=find(eddies.id==uia(m));
    plot(eddies.x(ii),eddies.y(ii),'r');
end
for m=1:length(uic)
    ii=find(eddies.id==uic(m));
    plot(eddies.x(ii),eddies.y(ii),'b');
end
grid
title([num2str(uia),' anticyclones and ',num2str(uic),' cyclones with lifetimes of 4 weeks or longer'])
xlabel('lon')
ylabel('lat')

% % %animate eddies
figure(2)
clf

for p=1:length(jdays)
    clf
    tmask=ones(size(eddies.mask(:,:,p)));
    tmask(isnan(eddies.mask(:,:,p)))=nan;
    
    subplot(211)
    pcolor(lon,lat,SSH(:,:,p).*tmask);shading interp;axis image;caxis([-40 40]);cc=colorbar;
    hold on
    contour(lon,lat,SSH(:,:,p),[-100:5:-5],'k--')
    contour(lon,lat,SSH(:,:,p),[5:5:100],'k')
    ii=find(eddies.track_jday==jdays(p));
    for m=1:length(ii)
        plot(eddies.x(ii(m)),eddies.y(ii(m)),'k.','markersize',40)
        irr=find(eddies.id==eddies.id(ii(m)) & eddies.track_jday<=jdays(p));
        if eddies.cyc(ii(m))==1
            plot(eddies.x(irr),eddies.y(irr),'r','linewidth',3);
        else
            plot(eddies.x(irr),eddies.y(irr),'b','linewidth',3);
        end
    end
    grid
    title([num2str(year(p)),'-',num2str(month(p)),'-',num2str(day(p))])
    xlabel('lon')
    ylabel('lat')
    axes(cc)
    xlabel('cm')
    
    subplot(212)
    pcolor(lon,lat,SSH(:,:,p));shading interp;axis image;caxis([-40 40]);cc=colorbar;
    hold on
    contour(lon,lat,SSH(:,:,p),[-100:5:-5],'k--')
    contour(lon,lat,SSH(:,:,p),[5:5:100],'k')
    ii=find(eddies.track_jday==jdays(p));
    for m=1:length(ii)
        plot(eddies.x(ii(m)),eddies.y(ii(m)),'k.','markersize',40)
        irr=find(eddies.id==eddies.id(ii(m)) & eddies.track_jday<=jdays(p));
        if eddies.cyc(ii(m))==1
            plot(eddies.x(irr),eddies.y(irr),'r','linewidth',3);
        else
            plot(eddies.x(irr),eddies.y(irr),'b','linewidth',3);
        end
    end
    grid
    title([num2str(year(p)),'-',num2str(month(p)),'-',num2str(day(p))])
    xlabel('lon')
    ylabel('lat')
    axes(cc)
    xlabel('cm')
%     pause(.3)
    eval(['print -dpng -r150 figs/test/frame',num2str(p)])
    
end
