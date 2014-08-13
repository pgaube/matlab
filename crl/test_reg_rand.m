clear all
x=-5:.001:5;
time=x;
h=10*exp(-(x.^2/3));

ds=0.01:.01:.8;
b_lin=nan(length(ds)*50,2);
ff=1;

for orr=1:30
w=randn(round(length(time)/200),1);
t=linspace(time(1),time(end),length(w));
w=interp1(t,w,time);
nw=((w-pmean(w))./pstd(w)).*(pstd(h));
[s,f]=ppsd(nw,.25,60,'tri');
figure(1)
clf
loglog(f,s,'k')
hold on
loglog(f,10^-3*f.^-4)
axis([10^-3 10 10^-12 10^5])
text(1,.01,'f^{-3}')
title('PSD of red noise')
eval(['print -dpng -r100 frames/test_gauss/frame_',num2str(ff)])
ff=ff+1;



for m=1:length(ds)
	%eval(['r=smooth1d_loess(nw,time,',num2str(ds(m)),',time);'])
	%eval(['w=randn(round(length(time)/',num2str(ds(m)),'),1);'])
	%t=linspace(time(1),time(end),length(w));
	%nw=((w)./pstd(w)).*.2;
	%r=interp1(t,nw,time);
	r=ds(m)*nw;
	y=h+r;
	%eval(['y=f3+r',num2str(m),';'])
	%eval(['ppsd(r',num2str(m),',1,2,',char(39),'tri',char(39),');'])
	%{
	[s,f]=ppsd(r,1,20,'tri');
	hold on
	loglog(f,10^-4*f.^-3)
	drawnow
	%}
	C=cov(h,y);
	b_lin(ff)=C(1,2)/C(1,1);
	%b_lin(m,:)=polyfit(f3,y,1);
	%b_lin(m)=ols_line(f3,y);
	figure(1)
	clf
	plot(time,h)
	hold on
	plot(time,y,'r')
	title(['\alpha = ',num2str(ds(m)),'  \beta_1 = ',num2str(b_lin(m)),'   '])
	axis([-5 5 -8 12])
	drawnow
	eval(['print -dpng -r100 frames/test_gauss/frame_',num2str(ff)])
	ff=ff+1;

end	
end

hist(b_lin(:,1),40)
title('histogram of \beta_1  ')
xlabel('\beta_1')
eval(['print -dpng -r100 frames/test_gauss/frame_',num2str(ff)])

return

d=1-(1-(abs(b_lin(:,1))));
figure(2)
clf
plot(ds,b_lin(:,1))

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


