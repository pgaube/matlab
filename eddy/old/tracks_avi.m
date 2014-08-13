
startjd = 2450716;
endjd = 2454279;
%endjd = startjd+70;
weekjd = [startjd:7:endjd];
load VOCALS

!rm tracks_sCHL.avi

scrsz = get(0,'ScreenSize');
mov = avifile('tracks_sCHL.avi','fps',3)
hf= figure('visible','off','Position',[1 scrsz(4)/1.5 scrsz(3)/1.5 scrsz(4)/1.5]); %turns visibility of figure off and makes figure 1/4 sie of screen
hax=axes;
caxis([.01 0.5])


worldmap(latlim,lonlim)
geoshow('landareas.shp', 'FaceColor', [0 0 0]);

for i = weekjd
    p = find(tracks(:,2)==i);
    q = find(weekjd == i);
    image(pcolorm(sCHL(:,:,q)))
    image(scatterm(tracks(p,4),tracks(p,3),15,[0 0 0],'filled')); %puts image in invisible axes H
    geoshow('landareas.shp', 'FaceColor', [0 0 0]);
    mov = addframe(mov,hf); %adds frames to the AVI file
    clmo('surface')
    %clmo('patch')
end

mov = close(mov);
!open tracks_sCHL.avi
    
