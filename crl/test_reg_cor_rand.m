clear all
r=randn(2,10000);

ds=[1:.5:5];
ff=1;
[b_lin,b_ols]=deal(nan(size(ds)));

for m=1:length(ds)
Sigma = [ds(m) .5; 
         .5 ds(m)]; 
L=chol(Sigma); 
u=L'*r; 

C=cov(u');
x=u(1,:);
y=u(2,:);
%b=polyfit(x,y,1)
cor=C(1,2)/(sqrt(C(1,1)*C(2,2)));
b_lin(m)=cor*sqrt(C(2,2))/sqrt(C(1,1));
b_ols(m)=ols_line(x,y,b_lin(m));
figure(2)
clf
subplot(122)
scatter(x,y,'k.')
title(num2str(ds(m)))
hold on
plot([-5:5],b_lin(m)*([-5:5]),'k')
plot([-5:5],b_ols(m)*([-5:5]),'g')
legend('data','lin','ols')
axis image
axis([-5 5 -5 5])

subplot(121)
plot(ds,b_lin,'k')
hold on
plot(ds,b_ols,'g')
legend('lin','ols')
title('fixed (cov_{xy}), variable \sigma_y and \sigma_x ')
ylabel('\beta_1')
xlabel('\sigma_y, \sigma_x')
axis image
axis([min(ds) max(ds) 0 5])
%daspect([3 1 1])
eval(['print -dpng -r150 frames/test_rand/frame_',num2str(ff)])
ff=ff+1;

end

figure(1)
clf
plot(ds,b_lin,'k')
hold on
plot(ds,b_ols)
legend('lin','ols')
title('fixed (\sigma_x,\sigma_y), variable cov_{xy}  ')
ylabel('\beta_1')
xlabel('cov_{xy}')


