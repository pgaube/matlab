!rm /Volumes/matlab/matlab/CC
/crl_cwgt.avi
clf
mov = avifile('crl_cwgt.avi','fps',3,'quality',100)
hf=figure('visible','off');
h=axes;
x=[283;270;270;290];
y=[-10;-10;-30;-30];




%m=axesm('mapprojection','mercator','frame','on','grid','off','MapLatLimit',...
%    [min(lat) max(lat)],'MapLonlimit',[min(lon) %max(lon)],'ParallelLabel','on','meridianlabel','on',...
%    'fontsize',[10],'MLabelParallel','south','FontWeight','bold')
%geoshow('landareas.shp', 'FaceColor', [0 0 0]);

for i = 1:length(SST(1,1,:))
%for i = 1:3
    m=pcolor(lon,lat,CRL(:,:,i));
    colormap(bwr)
    caxis([-8e-5 9e-5])
    %caxis([-.000013 .000013]) %Use for VOCALS region
	shading flat
    i_CWGT=CWGT(:,:,i);
    max_CWGT=max(i_CWGT(:));
    min_CWGT=min(i_CWGT(:));
    colorbar;
	hold on
    [c,h] = contour(lon,lat,CWGT(:,:,i),[0:5e-6:max_CWGT],'k');
    [c,h] = contour(lon,lat,CWGT(:,:,i),[0:-5e-6:min_CWGT],'k--');
    hold off
    %t=[int2str(time(i)),' \nabla x T and Crosswind \nabla T'];
    %title(t,'FontSize',12,'FontWeight','bold')
    %line(x,y,'LineWidth',2,'color','black')
    set(gca,'color',[0 0 0])
    %axes(b)
    %ylabel('\circ C/m','FontSize',12,'FontWeight','bold')
    %axes(m)
    land
    mov = addframe(mov,gca); %adds frames to the AVI file
    clf 


end

mov = close(mov);

    
!open /Volumes/matlab/matlab/CC/crl_cwgt.avi