


figure
subplot(2,3,[2:3])
pcolor(tlon,tlat,mat);shading flat
title('Test Matrix')
subplot(2,3,[5:6])
plot(mat(1,:),'k')
hold on
plot(mat(90,:),'b')
title('Zonal Section')
legend('sin=(1,:)','cos=(90,:)','Location','best')
subplot(2,3,[1 4])
plot(mat(:,1),'k')
hold on
plot(mat(:,100),'b')
legend('sin=(:,1:50)','cos=(:,51:100)','Location','best')

title('Meridional Section')