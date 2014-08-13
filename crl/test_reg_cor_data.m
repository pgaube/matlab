clear all
load eio_crls

x=1e5*tmp_var(20,:,10);
time=1:length(x);
tt=linspace(time(1),time(end),5000);
x=interp1(x,tt);
z=tmp_var_qs(20,:,10);
z=-1e5*interp1(z,tt);

ii=find(isnan(z));
x(ii)=[];
z(ii)=[];
time=1:length(x);
tt=linspace(time(1),time(end),length(x));

w=randn(2,length(x)/50);
t=linspace(time(1),time(end),length(w));
for m=1:2
	nw(m,:)=((w(m,:)-pmean(w(m,:)))./pstd(w(m,:)));
	r(m,:)=interp1(t,nw(m,:),tt).*pstd(x);
end	

n(1,:)=x;
n(2,:)=r(1,:);
Sigma=cov([x;z]');
L=chol(Sigma);
u=L'*n; 
y=u(2,:);
nx=u(1,:);

figure(1)
clf
plot(nx)
hold on
plot(y,'r')
return


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


