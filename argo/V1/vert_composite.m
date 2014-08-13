clear all
load /Volumes/matlab/matlab/argo/south_anom_prof
%%%%
% OLD NNEG
%%%%%
nneg=90001;

ai=find(tid>=nneg);
ci=find(tid<nneg);

% find profile amp
tprof_amp=nan*tid;
adist=tprof_amp;



jday=2452459:7:max(tjday_round);
for m=1:length(jday)
	load(['/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jday(m))],'lat','lon','ssh','idmask')
	p=find(tjday_round==jday(m));
	for n=1:length(p)
		tmpxs=floor(tx(p(n)))-1.125:.25:ceil(tx(p(n)))+1.125;
		tmpys=floor(ty(p(n)))-1.125:.25:ceil(ty(p(n)))+1.125;
    	disx = abs(tmpxs-tx(p(n)));
    	disy = abs(tmpys-ty(p(n)));
    	iminx=find(disx==min(disx));
    	iminy=find(disy==min(disy));
    	cx=tmpxs(iminx(1));
    	cy=tmpys(iminy(1));
    	r=find(cy(:,1)>=lat(:,1)-.09 & cy(:,1)<=lat(:,1)+.09);
    	c=find(cx(1,:)>=lon(1,:)-.09 & cx(1,:)<=lon(1,:)+.09);		
		tprof_amp(p(n))=abs(abs(tedge_ssh(p(n)))-abs(ssh(r,c)));
		adist(p(n)) = sqrt((111.11*(tx(p(n))-tlon(p(n)))*cosd(ty(p(n))))^2+(111.11*(ty(p(n))-tlat(p(n))))^2);
	end
end	

% calc vert integrated T' to 400 db
% z at max t
% t at z of max t
integ_T=nan*tprof_amp;
z_max_t=nan*tprof_amp;
t_max_t=z_max_t;
for m=1:length(tjday)
	integ_T(m)=nansum(stT(m,1:41))*10;
	if ~isnan(max(abs(stT(m,:))))
	z_max_t(m)=z_prime(find(abs(stT(m,1:41))==max(abs(stT(m,1:41)))));
	t_max_t(m)=tT(m,find(abs(stT(m,1:41))==max(abs(stT(m,1:41)))));
	end
end

figure(1)
scatter(tamp(ai),integ_T(ai),'r')
hold on
scatter(tamp(ci),integ_T(ci),'b')
xlabel('amp')
ylabel('T integrated to 400 db')
axis([0 40 -2e3 2e3])

figure(2)
scatter(tprof_amp(ai),integ_T(ai),'r')
hold on
scatter(tprof_amp(ci),integ_T(ci),'b')
xlabel('amp at prof location')
ylabel('T integrated to 400 db')
axis([0 40 -2e3 2e3])

%{
figure(3)
scatter(adist(ai),integ_T(ai),'r')
hold on
scatter(adist(ci),integ_T(ci),'b')
xlabel('amp')
ylabel('T integrated to 400 db')
axis([0 200 -100 100])

figure(4)
scatter(tamp,z_max_t)
xlabel('amp')
ylabel('depth of max T')

figure(5)
scatter(tprof_amp,z_max_t)
xlabel('amp at prof location')
ylabel('depth of max T')

figure(6)
scatter(adist,z_max_t)
xlabel('dist')
ylabel('depth of max T')
%}

figure(7)
scatter(tamp(ai),t_max_t(ai),'r')
hold on
scatter(tamp(ci),t_max_t(ci),'b')
xlabel('amp')
ylabel('T at depth of max T')
axis([0 30 -5 5])

figure(8)
scatter(tprof_amp(ai),t_max_t(ai),'r')
hold on
scatter(tprof_amp(ci),t_max_t(ci),'b')
xlabel('amp at prof location')
ylabel('T at depth of max T')
axis([0 30 -5 5])

figure(9)
scatter(adist(ai),t_max_t(ai),'r')
hold on
scatter(adist(ci),t_max_t(ci),'b')
xlabel('dist')
ylabel('T at depth of max T')
axis([0 200 -5 5])
