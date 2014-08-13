%create a test matrix
clear all
close all

global SPAN2 SPAN2HALF C CR
global NPTS_SPAN_THRESHOLD NPTS_HALFSPAN_THRESHOLD
global NPTS_NORTH NPTS_SOUTH NPTS_EAST NPTS_WEST
global RADIAL_SPAN
global DX_OVERLAP
global GRIDX GRIDY

tmat_st_params



mat=ones(360,100);
mat(:,1:50)=sind(0:359)'*ones(1,50);
mat(:,51:100)=cosd(0:359)'*ones(1,50);



tlat = [0:.1:35.9]'*ones(1,100);
tlon = ones(360,1)*[0:.1:9.9];

figure(1)
clf
subplot(2,3,[2:3])
pcolor(tlon,tlat,mat);shading flat
colorbar
line([5 5],[0 35],'color','k')
title('Test Matrix')
subplot(2,3,[5:6])
plot(mat(1,:),'k')
hold on
plot(mat(91,:),'b')
axis([0 100 -.1 1.1])
title('Zonal Section')
legend('sin=(1,:)','cos=(90,:)','Location','best')
subplot(2,3,[1 4])
plot(mat(:,1),'k')
hold on
plot(mat(:,100),'b')
axis([0 400 -1.1 1.1])
legend('sin=(:,1:50)','cos=(:,51:100)','Location','best')
title('Meridional Section')


tgrid=nan(360,100);
tgrid=grid_tmat(tlon(:),tlat(:),mat(:));

figure(2)
clf
subplot(2,3,[2:3])
pcolor(GRIDX,GRIDY,tgrid);shading flat
colorbar
line([5 5],[0 35],'color','k')
title('Gridded Test Matrix')
subplot(2,3,[5:6])
plot(tgrid(1,:),'k')
hold on
plot(tgrid(91,:),'b')
axis([0 100 -.1 1.1])
title('Zonal Section')
legend('(1,:)','(90,:)','Location','best')
subplot(2,3,[1 4])
plot(tgrid(:,1),'k')
hold on
plot(tgrid(:,100),'b')
axis([0 400 -1.1 1.1])
legend('(:,1)','(:,100)','Location','best')
title('Meridional Section')




mat=ones(360,100);
mat(1:50,1:50)=-1;
mat(101:150,1:50)=-1;
mat(201:250,1:50)=-1;
mat(301:350,1:50)=-1;

mat(51:100,51:100)=-1;
mat(151:200,51:100)=-1;
mat(251:300,51:100)=-1;


tlat = [0:.1:35.9]'*ones(1,100);
tlon = ones(360,1)*[0:.1:9.9];

figure(3)
clf
subplot(2,3,[2:3])
pcolor(tlon,tlat,mat);shading flat
colorbar
line([5 5],[0 35],'color','k')
title('Test Matrix')
subplot(2,3,[5:6])
plot(mat(5,:),'k')
hold on
plot(mat(110,:),'b')
axis([0 100 -1.1 1.1])
title('Zonal Section')
legend('(5,:)','(110,:)','Location','best')
subplot(2,3,[1 4])
plot(mat(40:60,1),'k')
hold on
plot(mat(40:60,100),'b')
axis([1 21 -1.1 1.1])
legend('(40:60,1)','(40:60,100)','Location','best')
title('Meridional Section')


tgrid=nan(360,100);
tgrid=grid_tmat(tlon(:),tlat(:),mat(:));

figure(4)
clf
subplot(2,3,[2:3])
pcolor(GRIDX,GRIDY,tgrid);shading flat
colorbar
line([5 5],[0 35],'color','k')
title('Test Matrix')
subplot(2,3,[5:6])
plot(tgrid(5,:),'k')
hold on
plot(tgrid(110,:),'b')
axis([0 100 -1.1 1.1])
title('Zonal Section')
legend('(5,:)','(110,:)','Location','best')
subplot(2,3,[1 4])
plot(tgrid(40:60,1),'k')
hold on
plot(tgrid(40:60,100),'b')
axis([1 21 -1.1 1.1])
legend('(40:60,1)','(40:60,100)','Location','best')
title('Meridional Section')


%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%



