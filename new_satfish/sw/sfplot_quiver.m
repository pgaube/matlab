function sfplot_quiver(u,v,lon,lat,out_head,pd,time)
%out_head has the full dir in it


close all
hh=figure(57)
lon=interp2(lon,3);lat=interp2(lat,3);u=interp2(u,3);v=interp2(v,3);
clf
h=quiver2(lon(1:4:end,1:4:end),lat(1:4:end,1:4:end),...
            u(1:4:end,1:4:end),  v(1:4:end,1:4:end),...
            .12,'a@','fancy','filled','w=',1.3);
axis image
set(gca, 'position', [0 0 1 1],'xcolor','w','ycolor','w');

print -dpng -r300 tmp.png
c=imread('tmp.png');
data=c(:,:,1);
data(data~=255)=1;
data(data==255)=0;

dpi=num2str(fix((300/2.54) * 100));

eval(['imwrite(data,' char(39) out_head ...
    pd '_' time '_000_100.png' char(39) ',' ...
    char(39) 'Transparency' char(39) ',0,' ...
    char(39) 'ResolutionUnit' char(39) ',' char(39) 'meter' char(39) ',' ...
    char(39) 'XResolution' char(39) ',' dpi ',' ...
    char(39) 'YResolution' char(39) ',' dpi ')' ]);


set(0,'DefaultFigureVisible','off')
