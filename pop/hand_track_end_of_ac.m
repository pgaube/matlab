clear all

load chelle.pal

figure(1);
ff=1;
set_pop
spath='~/matlab/pop/mat/run14_';
load([spath '1801'],'lat','lon')
load case_study_tracks 
jdays=min(track_jday):max(track_jday);
[r,c]=imap(25,50,200,330,lat,lon);
lat_step=4;
lon_step=5;
dlat=lat(r,c);
dlon=lon(r,c);
max_lat=max(dlat(:));
min_lat=min(dlat(:));
max_lon=max(dlon(:));
min_lon=min(dlon(:));



for m=1:length(jdays)
    fname=[spath num2str(jdays(m))]
    
    if exist([fname,'.mat'])
        
        %load data
        load(fname,'total_chl','bp21_ssh')
        
        figure(1)
        clf        
        pmap(lon(r,c),lat(r,c),double(real(log10(total_chl(r,c)))))
        caxis([-1.7 1])
        title(['BEC CHL, week ',num2str(jdays(m))])
        colormap(chelle)
        shading interp
        hold on

        m_contour(lon(r,c),lat(r,c),bp21_ssh(r,c),[7:7:100],'k')
        m_contour(lon(r,c),lat(r,c),bp21_ssh(r,c),[-100:7:-7],'k--')
        
        ii=find(track_jday==jdays(m));
        uid=unique(id(ii));
        for d=1:length(uid)
            ii=find(id==uid(d) & track_jday<=jdays(m));
            jj=find(id==uid(d) & track_jday==jdays(m));
            m_plot(x(jj),y(jj),'k.','markersize',5)
            m_plot(x(ii),y(ii),'k','linewidth',1)
            m_text(x(jj),y(jj)+.2,num2str(uid(d)))
        end
        shading flat
        grid
%         colorbar
        m_coast('patch','k');
        reply = input('Do you want to enter eddy location? y/n/q [n]:','s');
        if reply=='y'
            [xx,yy]=ginput(1);
            [lons(ff),lats(ff)]=m_xy2ll(xx,yy)
            ff=ff+1;
        elseif reply=='q'
            break
            break
            break
        else
            continue
        end
    end
end

save tmp_lat_lons lats lons x y id k cyc track_jday radius adens warm_id

ii=find(id==warm_id);
x=cat(2,x,lons);
y=cat(2,y,lats);
id=cat(2,id,warm_id*ones(size(lats)));
k=cat(2,k,k(ii(end)):k(ii(end))+length(lats)-1);
track_jday=cat(2,track_jday,track_jday(ii(end)):track_jday(ii(end))+length(lats)-1);
cyc=cat(2,cyc,cyc(ii(1))*ones(size(lats)));
adens=cat(2,adens,adens(ii(1))*ones(size(lats)));
radius=cat(2,radius,radius(ii(1))*ones(size(lats)));

clearallbut x y id cyc k track_jday radius adens warm_id cold_id

save case_study_tracks



