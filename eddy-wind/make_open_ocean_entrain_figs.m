load chelle.pal
spath='~/data/gsm/mat/GSM_9_21_';
mpath='~/data/mu/mat/MU_25_30_';
asave='~/data/eddy/V5/mat/AVISO_25_W_';
load([spath '2450884'],'glon','glat','jdays')
load([asave '2454769'],'lon','lat','ssh')
slon=(lon);
slat=(lat);
nlat=-25:-15;
nlon=75:90;
[r,c]=imap(min(nlat),max(nlat),min(nlon),max(nlon),glat,glon);
glon=interp2(glon(r,c));
glat=interp2(glat(r,c));



startjd=date2jd(2001,3,28)+.5;
endjd=date2jd(2001,8,15)+.5;
jdays=[startjd:7:endjd];

load ~/matlab/regions/tracks/tight/opac_tracks
load ~/matlab/domains/test_sopac


load ~/data/eddy/V5/global_tracks_v5_12_weeks.mat x y id track_jday

[rssh,cssh]=imap(min(nlat),max(nlat),min(nlon),max(nlon),slat,slon);

ff=1;
for m=[1 7 13]%:length(jdays)
    load([spath num2str(jdays(m))],'bp26_chl','gchl_week')
    %load([mpath num2str(jdays(m))],'bp21_mu')
    load([asave num2str(jdays(m))],'ssh')
    %ssh=interp2(ssh);
    chl=smoothn(interp2(fillnans(double(gchl_week(r,c)))),.1);
    %{
    figure(1)
    clf
    m_proj('Equidistant cylindrical','lon',[min(lon) max(lon)],'lat',[min(lat) max(lat)]);   
    m_grid('xtick',[min(lon):10:max(lon)],'ytick',[min(lat):5:max(lat)],'tickdir','in','color','k','lineweight',1.5);  
    hold on
    m_pcolor(glon(r,c),glat(r,c),double(bp26_chl(r,c)));
    shading interp
   	colormap(chelle)
    hold on
    m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:2:-2],'k--')
    m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:2:100],'k')		
    caxis([-.01 .01])
    eval(['print -dpng figs/sp66_' num2str(ff) '.png'])
    m_coast('patch',[0 0 0]);
    grid
    %}
    figure(2)
    clf
    m_proj('Equidistant cylindrical','lon',[min(nlon) max(nlon)],'lat',[min(nlat) max(nlat)]);   
    m_grid('xtick',[min(nlon):5:max(nlon)],'ytick',[min(nlat):2:max(nlat)],'tickdir','in','color','k','lineweight',1.5,'fontsize',23);  
    hold on
    m_pcolor(glon,glat,chl);
    shading interp
   	colormap(chelle)
    m_coast('patch',[0 0 0]);
    grid
    hold on
    m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:2:-2],'k--')
    m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:2:100],'k')		
    caxis([-1.3 -.9])
    colormap(chelle)
    m_coast('patch',[0 0 0]);
    grid
    [yy,mon,da]=jd2jdate(jdays(m));
    title([num2str(yy),'-',num2str(mon),'-',num2str(da)])
    set(gca,'fontsize',18);
    ii=find(id==150774 & track_jday<=jdays(m));
    iij=find(id==150774 & track_jday==jdays(m));
    if any(ii)
        m_plot(x(ii),y(ii),'k','linewidth',2)
        m_plot(x(iij),y(iij),'k.','markersize',20)
    end
    eval(['print -dpng -r300 figs/open_ocean/chl_' num2str(m) '.png'])
    ff=ff+1;
    clear bp26_mu sm_gchl_week gchl_week nbp26_chl
end
