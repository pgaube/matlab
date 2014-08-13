!rm /Volumes/matlab/matlab/CC/div_dwgt.avi
clf
mov = avifile('div_dwgt.avi','fps',3,'quality',100)
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
    m=pcolor(lon,lat,DIV(:,:,i));
    colormap(bwr)
    b=colorbar;
    caxis([-8e-5 8e-5])	
    shading flat
    b=colorbar;
    i_DWGT=DWGT(:,:,i);
    max_DWGT=max(i_DWGT(:));
    min_DWGT=min(i_DWGT(:));
	hold on
    [c,h] = contour(lon,lat,DWGT(:,:,i),[0:5e-6:max_DWGT],'k');
    [c,h] = contour(lon,lat,DWGT(:,:,i),[0:-5e-6:min_DWGT],'k--');
    hold off
	t=[int2str(time(i)),'  \nabla \cdot T and Downwind \nabla T'];
	title(t,'FontSize',12,'FontWeight','bold')
    %line(x,y,'LineWidth',2,'color','black')
    set(gca,'color',[0 0 0])
    %axes(b)
    %ylabel('\circ C/m','FontSize',12,'FontWeight','bold')
    %land
    mov = addframe(mov,gca); %adds frames to the AVI file
    clf 


end

mov = close(mov);
!open /Volumes/matlab/matlab/CC/div_dwgt.avi
    
