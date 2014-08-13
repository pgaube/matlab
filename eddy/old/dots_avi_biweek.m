
startjd = 2450716;
endjd = 2452494;
%endjd = startjd+14*5;
biweekjd = [startjd:14:endjd-14];
weekjd = [startjd:7:endjd];
%load VOCALS

!rm dots_VOCALS_biweek.avi

set(0,'Units','points')
%scrsz = get(0,'ScreenSize');
mov = avifile('dots_VOCALS_biweek.avi','fps',6);
hf= figure('visible','off','Position',[1 800 800 1000]); %turns visibility of figure off and makes figure have pixels of 1/40 deg
hax=axes;
%caxis([-.15 .5]) %use this for lon trend removed data
caxis([.0 .6]); %set color axis to best visualize data


worldmap(latlim,lonlim)
geoshow('landareas.shp', 'FaceColor', [0 0 0]); %set up map projection
for i = weekjd
        p = find(tracks(:,2)==i);
        q = find(biweekjd == i);
        pix = scatterm(tracks(p,4),tracks(p,3),tracks(p,5)*10,'k'); %puts image in invisible axes H and also plots circles the size of eddy pixels
        points = scatterm(tracks(p,4),tracks(p,3),[1],'m','.');
        title(int2str(i));
        if length(q)>0
            clmo('surface')
            image(pcolorm(sCHL(:,:,q)))
        end
        geoshow('landareas.shp', 'FaceColor', [0 0 0]);
        mov = addframe(mov,hf); %adds frames to the AVI file
        clmo(pix)
        clear pix
end

mov = close(mov);
!open dots_VOCALS_biweek.avi
    
