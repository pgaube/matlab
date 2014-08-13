clear all
load /Volumes/matlab/matlab/argo/GLOBAL_anom_prof

ai=find(tid>=nneg);
ci=find(tid<nneg);

% calc vert integrated T' to 400 db
% z at max t
% t at z of max t
integ_T=nan*tid;
z_max_t=integ_T;
t_max_t=z_max_t;
for m=1:length(tjday)
	integ_T(m)=nansum(stT(m,1:41))*10;
	if ~isnan(max(abs(stT(m,:))))
	%z_max_t(m)=z_prime(find(abs(stT(m,1:41))==max(abs(stT(m,1:41)))));
	%t_max_t(m)=tT(m,find(abs(stT(m,1:41))==max(abs(stT(m,1:41)))));
	end
end

%{
figure(1)
tbins=[-1000:50:1000];
[b,n]=phist(integ_T(ai),tbins);
stairs(tbins(1:length(tbins)-1),n,'r')
hold on
[b,n]=phist(integ_T(ci),tbins);
stairs(tbins(1:length(tbins)-1),n,'b')
%}


%first try to identify ite anticyclones

%1)
%Integral test
itmp=find(integ_T(ai)<-100);

%2)
ite=nan*itmp;
for m=1:length(itmp)
	if min(stT(ai(itmp(m)),1:61))>=-10% & length(find(~isnan(stT(ai(itmp(m)),1:61))))>20;
	ite(m)=itmp(m);
	end
end
ite(find(isnan(ite)))=[];


%3)
d2tdz2=nan(size(stT(ite,1:61)));
pp=1;
for m=1:length(ite)
	d2tdz2(m,:)=dfdz(dfdz(stT(ite(m),1:61),10),10);
	tmp=find(d2tdz2(m,:)==min(d2tdz2(m,:)));
	if any(tmp)
		loc_con(pp)=tmp;
		if tmp>=10 | tmp<=61
			new_ite(pp)=ite(m);
		end
		pp=pp+1;
	end
end	



ite=new_ite;
unique(tid(ai(ite)))

figure(2)
clf
stT=stT(ai(ite),:);
stS=stS(ai(ite),:);
tamp=tamp(ai(ite));
tedge_ssh=tedge_ssh(ai(ite));
tjday_round=tjday_round(ai(ite));
tk=tk(ai(ite));
tlat=tlat(ai(ite));
tlon=tlon(ai(ite));
tx=tx(ai(ite));
ty=ty(ai(ite));
tid=tid(ai(ite));
teid=teid(ai(ite));
tefold=tefold(ai(ite));
integ_T=integ_T(ai(ite));

save global_ite_prof stS stT tamp tedge_ssh tefold teid tjday_round tk tlat tlon tid tx ty integ_T z_prime nneg

for m=1:length(tid)
	clf
	pprof(stT(m,1:61),z_prime(1:61),50,stT(m,1:61))
	hold on
	pprof(stT(m,1:61),z_prime(1:61))
	caxis([-4 4])
	drawnow
end	