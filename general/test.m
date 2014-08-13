%make a series of test matricies.

qquad=ones(100,100);
qquad(51:100,1:50)=2;
qquad(1:50,51:100)=3;
qquad(51:100,51:100)=4;

tmpx=20.1:.1:30;
tmpy=tmpx;
[lon,lat]=meshgrid(tmpx,tmpy);
clear tmpx tmpy

dist=sqrt((lon-25.1).^2+(lat-25.1).^2);
mask=nan(100,100);
mask(dist<=4)=1;

figure(101)
clf
subplot(221)
pcolor(lon,lat,qquad);shading flat
title('quad')

subplot(222)
pcolor(lon,lat,dist);shading flat
title('dist')

subplot(223)
pcolor(lon,lat,qquad.*mask);shading flat
title('quad.*mask')

subplot(224)
pcolor(lon,lat,dist.*mask);shading flat
title('dist.*mask')

whos