clear all
zgrid_grid
r=17:65;
c=17:65;
dist=dist(r,c);
dist=interp2(dist,2);
mask=nan*dist;
ii=find(dist<=1.7);
mask(ii)=1;
%
lags=[-2:2];
load EK_time_chl_wek
%sort and make nan arrays for mean eddy values
[s_ac_id,i_s_ac_id]=sort(ac_id);
s_ac_wek=ac_wek(i_s_ac_id);
s_ac_mld=ac_mld(i_s_ac_id);
s_ac_x=ac_x(i_s_ac_id);
s_ac_y=ac_y(i_s_ac_id);
s_ac_r_chl_wek=ac_r_chl_wek(i_s_ac_id);
s_ac_r_chl_ssh=ac_r_chl_ssh(i_s_ac_id);
s_ac_mu=ac_mu(i_s_ac_id);
s_ac_chl=ac_chl(i_s_ac_id);
s_ac_raw=ac_raw(i_s_ac_id);
s_ac_amp=.01*ac_amp(i_s_ac_id);
s_ac_var=ac_var(i_s_ac_id);
s_ac_scale=ac_scale(i_s_ac_id);
s_ac_prct=ac_prct(i_s_ac_id,:);
s_ac_k=ac_k(i_s_ac_id);
s_ac_jday=ac_jday(i_s_ac_id);
s_ac_Sig_r_chl_ssh=ac_Sig_r_chl_ssh(i_s_ac_id);
s_ac_Sig_r_chl_wek=ac_Sig_r_chl_wek(i_s_ac_id);
s_ac_N_r_chl_ssh=ac_N_r_chl_ssh(i_s_ac_id);
s_ac_N_r_chl_wek=ac_N_r_chl_wek(i_s_ac_id);



[s_cc_id,i_s_cc_id]=sort(cc_id);
s_cc_wek=cc_wek(i_s_cc_id);
s_cc_mld=cc_mld(i_s_cc_id);
s_cc_x=cc_x(i_s_cc_id);
s_cc_y=cc_y(i_s_cc_id);
s_cc_r_chl_wek=cc_r_chl_wek(i_s_cc_id);
s_cc_r_chl_ssh=cc_r_chl_ssh(i_s_cc_id);
s_cc_mu=cc_mu(i_s_cc_id);
s_cc_chl=cc_chl(i_s_cc_id);
s_cc_raw=cc_raw(i_s_cc_id);
s_cc_amp=-.01*cc_amp(i_s_cc_id);
s_cc_var=cc_var(i_s_cc_id);
s_cc_scale=cc_scale(i_s_cc_id);
s_cc_prct=cc_prct(i_s_cc_id,:);
s_cc_k=cc_k(i_s_cc_id);
s_cc_jday=cc_jday(i_s_cc_id);
s_cc_Sig_r_chl_ssh=cc_Sig_r_chl_ssh(i_s_cc_id);
s_cc_Sig_r_chl_wek=cc_Sig_r_chl_wek(i_s_cc_id);
s_cc_N_r_chl_ssh=cc_N_r_chl_ssh(i_s_cc_id);
s_cc_N_r_chl_wek=cc_N_r_chl_wek(i_s_cc_id);

[ac_year,ac_month,ac_day]=jd2jdate(ac_jday);
[cc_year,cc_month,cc_day]=jd2jdate(cc_jday);


%make indices by quad
%{
ia1=find(s_ac_r_chl_wek>s_ac_Sig_r_chl_wek & s_ac_chl>0);
ia2=find(s_ac_r_chl_wek<-s_ac_Sig_r_chl_wek & s_ac_chl>0);
ia3=find(s_ac_r_chl_wek<-s_ac_Sig_r_chl_wek & s_ac_chl<-0);
ia4=find(s_ac_r_chl_wek>s_ac_Sig_r_chl_wek & s_ac_chl<-0);

ic1=find(s_cc_r_chl_wek>s_cc_Sig_r_chl_wek & s_cc_chl>0);
ic2=find(s_cc_r_chl_wek<-s_cc_Sig_r_chl_wek & s_cc_chl>0);
ic3=find(s_cc_r_chl_wek<-s_cc_Sig_r_chl_wek & s_cc_chl<-0);
ic4=find(s_cc_r_chl_wek>s_cc_Sig_r_chl_wek & s_cc_chl<-0);


ia1=find(s_ac_mld>50 & s_ac_chl>0);
ia2=find(s_ac_mld<50 & s_ac_chl>0);
ia3=find(s_ac_mld<50 & s_ac_chl<0);
ia4=find(s_ac_mld>50 & s_ac_chl<0);

ic1=find(s_cc_mld>50 & s_cc_chl>0);
ic2=find(s_cc_mld<50 & s_cc_chl>0);
ic3=find(s_cc_mld<50 & s_cc_chl<0);
ic4=find(s_cc_mld>50 & s_cc_chl<0);

%}
igooda=find(s_ac_wek>10 & s_ac_chl>0);
igoodc=find(s_cc_wek>10 & s_cc_chl<0);

ibada=1:length(s_ac_id);
ibada(igooda)=[];
ibadc=1:length(s_cc_id);
ibadc(igoodc)=[];
%{
hp_s_ac_wek=s_ac_wek-smooth1d_loess(s_ac_wek,s_ac_k,20,s_ac_k);
hp_s_ac_chl=s_ac_chl-smooth1d_loess(s_ac_chl,s_ac_k,20,s_ac_k);
hp_s_ac_raw=s_ac_chl-smooth1d_loess(s_ac_raw,s_ac_k,20,s_ac_k);

[r_hp_good,b,b,sig]=pcor(hp_s_ac_wek(igooda),hp_s_ac_raw(igooda))
[r_hp_bad,b,b,sig]=pcor(hp_s_ac_wek(ibada),hp_s_ac_raw(ibada))
%}


%{
ia1=find(s_ac_r_chl_wek>s_ac_Sig_r_chl_wek);
ia2=find(s_ac_r_chl_wek<-s_ac_Sig_r_chl_wek);
ia3=find(s_ac_r_chl_wek<-s_ac_Sig_r_chl_wek);
ia4=find(s_ac_r_chl_wek>s_ac_Sig_r_chl_wek);

ic1=find(s_cc_r_chl_wek>s_cc_Sig_r_chl_wek);
ic2=find(s_cc_r_chl_wek<-s_cc_Sig_r_chl_wek);
ic3=find(s_cc_r_chl_wek<-s_cc_Sig_r_chl_wek);
ic4=find(s_cc_r_chl_wek>s_cc_Sig_r_chl_wek);
%}

%{
ia1=find(ac_month>=1 & ac_month<4);
ia2=find(ac_month>=4 & ac_month<7);
ia3=find(ac_month>=7 & ac_month<10);
ia4=find(ac_month>=10);

ic1=find(cc_month>=1 & cc_month<4);
ic2=find(cc_month>=4 & cc_month<7);
ic3=find(cc_month>=7 & cc_month<10);
ic4=find(cc_month>=10);
%}

%{
ac_uid=unique(s_ac_id(ia1));
cc_uid=unique(s_cc_id(ic4));



for m=1:length(ac_uid)
	ii=find(s_ac_id==ac_uid(m));
	[ac_r(m,:),ac_c(m,:),ac_n(m,:),ac_sig(m,:),d,d,ac_sdx(m,:),ac_sdy(m,:)]=...
	pcor(s_ac_wek(ii),s_ac_chl(ii),lags);
	ac_mux(m,:)=nanmean(s_ac_wek(ii));
	ac_muy(m,:)=nanmean(s_ac_chl(ii));
	ac_range(m)=abs(pmean(s_ac_prct(ii,1)-s_ac_prct(ii,2)));
	ac_var(m)=pmean(s_ac_var(ii));
	ac_age(m)=max(s_ac_k(ii));
end

for m=1:length(cc_uid)
	ii=find(s_cc_id==cc_uid(m));
	%[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]
	[cc_r(m,:),cc_c(m,:),cc_n(m,:),cc_sig(m,:),d,d,cc_sdx(m,:),cc_sdy(m,:)]=...
	pcor(s_cc_wek(ii),s_cc_chl(ii),lags);
	cc_mux(m,:)=nanmean(s_cc_wek(ii));
	cc_muy(m,:)=nanmean(s_cc_chl(ii));
	cc_range(m)=abs(pmean(s_cc_prct(ii,1)-s_cc_prct(ii,2)));
	cc_var(m)=pmean(s_cc_var(ii));
	cc_age(m)=max(s_cc_k(ii));
end

ac_r_bar=(1./nansum(ac_n,1)).*nansum(ac_n.*ac_r,1);
cc_r_bar=(1./nansum(cc_n,1)).*nansum(cc_n.*cc_r,1);

figure(1)
clf
plot(lags,ac_r_bar,'r')
hold on
plot(lags,ac_r_bar,'r*')
plot(lags,cc_r_bar,'b')
plot(lags,cc_r_bar,'b*')





q1_time_ac_chl=nan(length(ia1),5);
q2_time_ac_chl=nan(length(ia2),5);
q3_time_ac_chl=nan(length(ia3),5);
q4_time_ac_chl=nan(length(ia4),5);

q1_time_ac_wek=nan(length(ia1),5);
q2_time_ac_wek=nan(length(ia2),5);
q3_time_ac_wek=nan(length(ia3),5);
q4_time_ac_wek=nan(length(ia4),5);

q1_time_cc_chl=nan(length(ic1),5);
q2_time_cc_chl=nan(length(ic2),5);
q3_time_cc_chl=nan(length(ic3),5);
q4_time_cc_chl=nan(length(ic4),5);

q1_time_cc_wek=nan(length(ic1),5);
q2_time_cc_wek=nan(length(ic2),5);
q3_time_cc_wek=nan(length(ic3),5);
q4_time_cc_wek=nan(length(ic4),5);

q1_ac_chl_wek=nan(length(ia1),5);
q2_ac_chl_wek=nan(length(ia2),5);
q3_ac_chl_wek=nan(length(ia3),5);
q4_ac_chl_wek=nan(length(ia4),5);

q1_ac_sig_chl_wek=nan(length(ia1),5);
q2_ac_sig_chl_wek=nan(length(ia2),5);
q3_ac_sig_chl_wek=nan(length(ia3),5);
q4_ac_sig_chl_wek=nan(length(ia4),5);



%
%put  obs in lag matrix
%

%q1_ac
for m=1:length(ia1)
	q1_time_ac_chl(m,3)=s_ac_chl(ia1(m));
	q1_time_ac_wek(m,3)=s_ac_wek(ia1(m));
	if m>2
		if s_ac_k(ia1(m-1))==s_ac_k(ia1(m))-1
			q1_time_ac_chl(m,2)=s_ac_chl(ia1(m-1));
			q1_time_ac_wek(m,2)=s_ac_wek(ia1(m-1));
		end
	end	
	if m>3
		if s_ac_k(ia1(m-2))==s_ac_k(ia1(m))-2
			q1_time_ac_chl(m,1)=s_ac_chl(ia1(m-2));
			q1_time_ac_wek(m,1)=s_ac_wek(ia1(m-2));
		end
	end
	if m<length(ia1)-1
		if s_ac_k(ia1(m+1))==s_ac_k(ia1(m))+1
			q1_time_ac_chl(m,4)=s_ac_chl(ia1(m+1));
			q1_time_ac_wek(m,4)=s_ac_wek(ia1(m+1));
		end
	end	
	if m<length(ia1)-2
		if s_ac_k(ia1(m+2))==s_ac_k(ia1(m))+2
			q1_time_ac_chl(m,5)=s_ac_chl(ia1(m+2));
			q1_time_ac_wek(m,5)=s_ac_wek(ia1(m+2));
		end
	end	
end	
	
		
		
for m=1:5
	[q1_r_ac_chl_wek(:,m),d,d,q1_sig_ac_chl_wek(:,m)]=...
	pcor(q1_time_ac_wek(:,m),q1_time_ac_chl(:,m));
end
	

%q4_cc
for m=1:length(ia3)
	q4_time_cc_chl(m,3)=s_cc_chl(ia3(m));
	q4_time_cc_wek(m,3)=s_cc_wek(ia3(m));
	if m>2
		if s_cc_k(ia3(m-1))==s_cc_k(ia3(m))-1
			q4_time_cc_chl(m,2)=s_cc_chl(ia3(m-1));
			q4_time_cc_wek(m,2)=s_cc_wek(ia3(m-1));
		end
	end	
	if m>3
		if s_cc_k(ia3(m-2))==s_cc_k(ia3(m))-2
			q4_time_cc_chl(m,1)=s_cc_chl(ia3(m-2));
			q4_time_cc_wek(m,1)=s_cc_wek(ia3(m-2));
		end
	end
	if m<length(ia3)-1
		if s_cc_k(ia3(m+1))==s_cc_k(ia3(m))+1
			q4_time_cc_chl(m,4)=s_cc_chl(ia3(m+1));
			q4_time_cc_wek(m,4)=s_cc_wek(ia3(m+1));
		end
	end	
	if m<length(ia3)-2
		if s_cc_k(ia3(m+2))==s_cc_k(ia3(m))+2
			q4_time_cc_chl(m,5)=s_cc_chl(ia3(m+2));
			q4_time_cc_wek(m,5)=s_cc_wek(ia3(m+2));
		end
	end	
end	
	
		
for m=1:5
	[q4_r_cc_chl_wek(:,m),d,d,q4_sig_cc_chl_wek(:,m)]=...
	pcor(q4_time_cc_wek(:,m),q4_time_cc_chl(:,m));
end



ac_uid=unique(s_ac_id);
r=nan(length(ac_uid),50);
n=r;
for m=1:length(ac_uid)
	ii=find(ac_id==ac_uid(m));
	for d=10:60
		if length(ii)>=d+5
			%[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]
			[r(m,d-9),y,n(m,d-9)]=pcor(s_ac_wek(ii(d-5:d+5)),s_ac_chl(ii(d-5:d+5)));
		end
	end
end
r_bar=(1./nansum(n,1)).*nansum(n.*r),1;

figure(20)
plot(r_bar)

figure(1)
clf
plot(lags,q1_r_ac_chl_wek,'r')
hold on
plot(lags,q1_r_ac_chl_wek,'r*')
plot(lags,q4_r_cc_chl_wek,'b')
plot(lags,q4_r_cc_chl_wek,'b*')

%

ac_lo_id=s_ac_id;
cc_lo_id=s_cc_id;
ac_lo_jday=s_ac_jday;
cc_lo_jday=s_cc_jday;

ac_lo_id(ia1)=nan;
ac_lo_jday(ia1)=nan;
cc_lo_id(ic1)=nan;
cc_lo_jday(ic1)=nan;
ac_lo_id(ia2)=nan;
ac_lo_jday(ia2)=nan;
cc_lo_id(ic2)=nan;
cc_lo_jday(ic2)=nan;
ac_lo_id(ia3)=nan;
ac_lo_jday(ia3)=nan;
cc_lo_id(ic3)=nan;
cc_lo_jday(ic3)=nan;
ac_lo_id(ia4)=nan;
ac_lo_jday(ia4)=nan;
cc_lo_id(ic4)=nan;
cc_lo_jday(ic4)=nan;

ac_lo_id(find(isnan(ac_lo_id)))=[];
ac_lo_jday(find(isnan(ac_lo_jday)))=[];
cc_lo_id(find(isnan(cc_lo_id)))=[];
cc_lo_jday(find(isnan(cc_lo_jday)))=[];

ac_uid=unique(s_ac_id(ia1));
cc_uid=unique(s_cc_id(ic3));


figure(3)
clf
scatter(s_ac_r_chl_wek,s_ac_chl,'g.')
hold on
scatter(s_cc_r_chl_wek,s_cc_chl,'g.')
scatter(s_ac_r_chl_wek(ia2),s_ac_chl(ia2),'r.')
scatter(s_ac_r_chl_wek(ia3),s_ac_chl(ia3),'r.')

%scatter(s_ac_r_chl_wek(ia2),s_ac_chl(ia2),'r.')
%scatter(s_ac_r_chl_wek(ia3),s_ac_chl(ia3),'r.')
%scatter(s_ac_r_chl_wek(ia4),s_ac_chl(ia4),'r.')
%scatter(s_cc_r_chl_wek(ic1),s_cc_chl(ic1),'b.')
%scatter(s_cc_r_chl_wek(ic2),s_cc_chl(ic2),'b.')
%scatter(s_cc_r_chl_wek(ic3),s_cc_chl(ic3),'b.')
scatter(s_cc_r_chl_wek(ic2),s_cc_chl(ic2),'b.')
scatter(s_cc_r_chl_wek(ic3),s_cc_chl(ic3),'b.')

line([0 0],[-1 1],'color','k')
%line([-.5 -.5],[-1 1],'color',[.5 .5 .5])
%line([.5 .5],[-1 1],'color',[.5 .5 .5])
line([-1 1],[-.03 -.03],'color',[.5 .5 .5])
line([-1 1],[.03 .03],'color',[.5 .5 .5])
line([-5 5],[0 0],'color','k')
%set(gca,'xtick',[-5:5])
axis([-1 1 -.2 .2])
xlabel('r(ssh,chl) in eddy core  ')
ylabel('mean chl in eddy core  ')
title({'Scatter of r and wek within eddy core'})

iia=find(ac_mld>=50);
iic=find(cc_mld>=50);
%

%[lo_a,lo_c]=mcomps_time_step(cat(1,ac_lo_id,cc_lo_id),cat(1,ac_lo_jday,cc_lo_jday));
[q1_a,q1_c]=mcomps_time_step(cat(1,s_ac_id(ia1),s_cc_id(ic1)),cat(1,s_ac_jday(ia1),s_cc_jday(ic1)));
%[q2_a,q2_c]=mcomps_time_step(cat(1,s_ac_id(ia2),s_cc_id(ic2)),cat(1,s_ac_jday(ia2),s_cc_jday(ic2)));
%[q3_a,q3_c]=mcomps_time_step(cat(1,s_ac_id(ia3),s_cc_id(ic3)),cat(1,s_ac_jday(ia3),s_cc_jday(ic3)));
[q4_a,q4_c]=mcomps_time_step(cat(1,s_ac_id(ia4),s_cc_id(ic4)),cat(1,s_ac_jday(ia4),s_cc_jday(ic4)));
%[mld_a,mld_c]=mcomps_time_step(cat(1,s_ac_id(iia),s_cc_id(iic)),cat(1,s_ac_jday(iia),s_cc_jday(iic)));
%[q24_a,q24_c]=mcomps_time_step(cat(1,s_ac_id(ia2),s_ac_id(ia3),s_ac_id(ia4),s_cc_id(ic1),s_cc_id(ic2),s_cc_id(ic3)),...
%							   cat(1,s_ac_jday(ia2),s_ac_jday(ia3),s_ac_jday(ia4),s_cc_jday(ic1),s_cc_jday(ic2),s_cc_jday(ic3)));


[good_a,good_c]=mcomps_time_step(cat(1,s_ac_id(igooda),s_cc_id(igoodc)),cat(1,s_ac_jday(igooda),s_cc_jday(igoodc)));
[bad_a,bad_c]=mcomps_time_step(cat(1,s_ac_id(ibada),s_cc_id(ibadc)),cat(1,s_ac_jday(ibada),s_cc_jday(ibadc)));

save EK_final_comps 
%{


minlat=min(cat(1,s_ac_y(ia1),s_ac_y(ia2),s_ac_y(ia3),s_ac_y(ia4),s_cc_y(ic1),s_cc_y(ic2),s_cc_y(ic3),s_cc_y(ic4)));
maxlat=max(cat(1,s_ac_y(ia1),s_ac_y(ia2),s_ac_y(ia3),s_ac_y(ia4),s_cc_y(ic1),s_cc_y(ic2),s_cc_y(ic3),s_cc_y(ic4)));
minlon=min(cat(1,s_ac_x(ia1),s_ac_x(ia2),s_ac_x(ia3),s_ac_x(ia4),s_cc_x(ic1),s_cc_x(ic2),s_cc_x(ic3),s_cc_x(ic4)));
maxlon=max(cat(1,s_ac_x(ia1),s_ac_x(ia2),s_ac_x(ia3),s_ac_x(ia4),s_cc_x(ic1),s_cc_x(ic2),s_cc_x(ic3),s_cc_x(ic4)));


figure(2)
clf
subplot(222)
pmap(minlon-3:maxlon+3,minlat-3:maxlat+3,[cat(1,s_ac_x(ia1),s_cc_x(ic1)) cat(1,s_ac_y(ia1),s_cc_y(ic1)) cat(1,s_ac_id(ia1),s_cc_id(ic1))],'tracks_big_dots')

subplot(221)
pmap(minlon-3:maxlon+3,minlat-3:maxlat+3,[cat(1,s_ac_x(ia2),s_cc_x(ic2)) cat(1,s_ac_y(ia2),s_cc_y(ic2)) cat(1,s_ac_id(ia2),s_cc_id(ic2))],'tracks_big_dots')

subplot(223)
pmap(minlon-3:maxlon+3,minlat-3:maxlat+3,[cat(1,s_ac_x(ia3),s_cc_x(ic3)) cat(1,s_ac_y(ia3),s_cc_y(ic3)) cat(1,s_ac_id(ia3),s_cc_id(ic3))],'tracks_big_dots')
	 
subplot(224)
pmap(minlon-3:maxlon+3,minlat-3:maxlat+3,[cat(1,s_ac_x(ia4),s_cc_x(ic4)) cat(1,s_ac_y(ia4),s_cc_y(ic4)) cat(1,s_ac_id(ia4),s_cc_id(ic4))],'tracks_big_dots')
	 	 



figure(3)
clf
scatter(s_ac_r_chl_wek,s_ac_chl,'g.')
hold on
scatter(s_cc_r_chl_wek,s_cc_chl,'g.')
scatter(s_ac_r_chl_wek(ia2),s_ac_chl(ia2),'r.')
scatter(s_ac_r_chl_wek(ia3),s_ac_chl(ia3),'r.')

%scatter(s_ac_r_chl_wek(ia2),s_ac_chl(ia2),'r.')
%scatter(s_ac_r_chl_wek(ia3),s_ac_chl(ia3),'r.')
%scatter(s_ac_r_chl_wek(ia4),s_ac_chl(ia4),'r.')
%scatter(s_cc_r_chl_wek(ic1),s_cc_chl(ic1),'b.')
%scatter(s_cc_r_chl_wek(ic2),s_cc_chl(ic2),'b.')
%scatter(s_cc_r_chl_wek(ic3),s_cc_chl(ic3),'b.')
scatter(s_cc_r_chl_wek(ic2),s_cc_chl(ic2),'b.')
scatter(s_cc_r_chl_wek(ic3),s_cc_chl(ic3),'b.')

line([0 0],[-1 1],'color','k')
%line([-.5 -.5],[-1 1],'color',[.5 .5 .5])
%line([.5 .5],[-1 1],'color',[.5 .5 .5])
line([-1 1],[-.03 -.03],'color',[.5 .5 .5])
line([-1 1],[.03 .03],'color',[.5 .5 .5])
line([-5 5],[0 0],'color','k')
%set(gca,'xtick',[-5:5])
axis([-1 1 -.2 .2])
xlabel('r(ssh,chl) in eddy core  ')
ylabel('mean chl in eddy core  ')
title({'Scatter of r and wek within eddy core'})

%eval(['[',curs{pz},'_a,',curs{pz},'_c]=mcomps_time_step(cat(1,ac_id,cc_id),cat(1,ac_jday,cc_jday));'])

%}
%}
load EK_final_comps
zgrid_grid
r=17:65;
c=17:65;
dist=dist(r,c);
dist=interp2(dist,2);
mask=nan*dist;
ii=find(dist<=1.7);
mask(ii)=1;


	
fnc='good_c.chl_N';
fmc='good_c.chl_n_max_sample';
fbc='good_c.raw_median';
fbc2='good_c.wek_median';
flc='good_c_chl_with_wek';
tmp = double(interp2(good_c.raw_median,2));
tmp2 = double(interp2(good_c.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.007,.007,.01,-1,1,'CHL cyclones MLD > 50 m',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='good_a.chl_N';
fma='good_a.chl_n_max_sample';
fba='good_a.raw_median';
fba2='good_a.wek_median';
fla='good_a_chl_with_wek';
tmp = double(interp2(good_a.raw_median,2));
tmp2 = double(interp2(good_a.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.007,.007,.01,-1,1,'CHL anticyclones MLD > 50 m',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
fnc='bad_c.chl_N';
fmc='bad_c.chl_n_max_sample';
fbc='bad_c.raw_median';
fbc2='bad_c.wek_median';
flc='bad_c_chl_with_wek';
tmp = double(interp2(bad_c.raw_median,2));
tmp2 = double(interp2(bad_c.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.003,.003,.01,-1,1,'CHL cyclones MLD < 50 m',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='bad_a.chl_N';
fma='bad_a.chl_n_max_sample';
fba='bad_a.raw_median';
fba2='bad_a.wek_median';
fla='bad_a_chl_with_wek';
tmp = double(interp2(bad_a.raw_median,2));
tmp2 = double(interp2(bad_a.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.003,.003,.01,-1,1,'CHL anticyclones MLD < 50 m',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 	

return
fnc='good_c.car_N';
fmc='good_c.car_n_max_sample';
fbc='good_c.car_median';
fbc2='good_c.wek_median';
flc='good_c_car_with_wek';
tmp = double(interp2(good_c.car_median,2));
tmp2 = double(interp2(good_c.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.05,.05,.01,-1,1,'C cyclones MLD > 50 m',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='good_a.car_N';
fma='good_a.car_n_max_sample';
fba='good_a.car_median';
fba2='good_a.wek_median';
fla='good_a_car_with_wek';
tmp = double(interp2(good_a.car_median,2));
tmp2 = double(interp2(good_a.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.05,.05,.01,-1,1,'C anticyclones MLD > 50 m',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
fnc='bad_c.car_N';
fmc='bad_c.car_n_max_sample';
fbc='bad_c.car_median';
fbc2='bad_c.wek_median';
flc='bad_c_car_with_wek';
tmp = double(interp2(bad_c.car_median,2));
tmp2 = double(interp2(bad_c.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.05,.05,.01,-1,1,'C cyclones MLD < 50 m',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='bad_a.car_N';
fma='bad_a.car_n_max_sample';
fba='bad_a.car_median';
fba2='bad_a.wek_median';
fla='bad_a_car_with_wek';
tmp = double(interp2(bad_a.car_median,2));
tmp2 = double(interp2(bad_a.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.05,.05,.01,-1,1,'C anticyclones MLD < 50 m',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 	
	


fna='q1_a.sst_N';
fma='q1_a.sst_n_max_sample';
fba='q1_a.sst_median';
fba2='q1_a.wek_median';
fla='q1_a_sst_with_wek';
tmp = double(interp2(q1_a.sst_median,2));
tmp2 = double(interp2(q1_a.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.3,.3,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 	
	
fnc='q4_c.sst_N';
fmc='q4_c.sst_n_max_sample';
fbc='q4_c.sst_median';
fbc2='q4_c.wek_median';
flc='q4_c_sst_with_wek';
tmp = double(interp2(q4_c.sst_median,2));
tmp2 = double(interp2(q4_c.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.3,.3,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	

eval(['fnc=[',char(39),'lo_c.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_c.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_c.chl_median',char(39),'];'])
eval(['flc=[',char(39),'lo_c_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'lo_a.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_a.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_a.chl_median',char(39),'];'])
eval(['flc=[',char(39),'lo_a_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	

eval(['fnc=[',char(39),'lo_c.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_c.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_c.wek_median',char(39),'];'])
eval(['flc=[',char(39),'lo_c_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'lo_a.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_a.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_a.wek_median',char(39),'];'])
eval(['flc=[',char(39),'lo_a_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	
	
eval(['fnc=[',char(39),'lo_c.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_c.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_c.mu_median',char(39),'];'])
eval(['flc=[',char(39),'lo_c_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'lo_a.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_a.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_a.mu_median',char(39),'];'])
eval(['flc=[',char(39),'lo_a_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	

eval(['fnc=[',char(39),'lo_c.car_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_c.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_c.car_median',char(39),'];'])
eval(['flc=[',char(39),'lo_c_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'lo_a.car_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_a.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_a.car_median',char(39),'];'])
eval(['flc=[',char(39),'lo_a_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

eval(['fnc=[',char(39),'lo_c.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_c.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_c.sst_median',char(39),'];'])
eval(['flc=[',char(39),'lo_c_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'lo_a.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_a.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_a.sst_median',char(39),'];'])
eval(['flc=[',char(39),'lo_a_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
	
for d=[1 4]
eval(['fnc=[',char(39),'q',num2str(d),'_c.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_c.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_c.chl_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_c_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_a.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_a.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_a.chl_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_a_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	

eval(['fnc=[',char(39),'q',num2str(d),'_c.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_c.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_c.wek_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_c_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_a.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_a.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_a.wek_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_a_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	
	
eval(['fnc=[',char(39),'q',num2str(d),'_c.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_c.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_c.mu_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_c_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_a.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_a.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_a.mu_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_a_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	

eval(['fnc=[',char(39),'q',num2str(d),'_c.car_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_c.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_c.car_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_c_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_a.car_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_a.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_a.car_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_a_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

eval(['fnc=[',char(39),'q',num2str(d),'_c.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_c.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_c.sst_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_c_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_a.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_a.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_a.sst_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_a_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
end

%}
%}
%}




lags=[-5:5];
want=[	125980	 4
			129581   4   
			130375   4   
			131961   4   
			132472   4   
			132906   3.5   
			143726   3.5   
			143729   4.5   
			149011   4.5   
			157168   4   
			158098   4.5   
			158190   4  ];
			
want_id=want(:,1);
score=want(:,2);
load EK_time_chl_wek


%sort and make nan arrays for mean eddy values
[s_ac_id,i_s_ac_id]=sort(ac_id);
s_ac_wek=ac_wek(i_s_ac_id);
s_ac_mld=ac_mld(i_s_ac_id);
s_ac_x=ac_x(i_s_ac_id);
s_ac_y=ac_y(i_s_ac_id);
s_ac_r_chl_wek=ac_r_chl_wek(i_s_ac_id);
s_ac_r_chl_ssh=ac_r_chl_ssh(i_s_ac_id);
s_ac_mu=ac_mu(i_s_ac_id);
s_ac_chl=ac_chl(i_s_ac_id);
s_ac_raw=ac_raw(i_s_ac_id);
s_ac_amp=.01*ac_amp(i_s_ac_id);
s_ac_var=ac_var(i_s_ac_id);
s_ac_prct=ac_prct(i_s_ac_id,:);
s_ac_k=ac_k(i_s_ac_id);

ac_uid=unique(s_ac_id);
ac_uid(isnan(ac_uid))=[];
ac_r=nan(length(ac_uid),length(lags));
ac_n=ac_r;
ac_sdx=ac_r;
ac_sdy=ac_r;
ac_c=ac_r;
ac_sig=ac_r;
ac_range=nan(length(ac_uid),1);
ac_var=nan(length(ac_uid),1);
ac_mux=ac_range;
ac_muy=ac_range;
ac_age=ac_range;


[s_cc_id,i_s_cc_id]=sort(cc_id);
s_cc_wek=cc_wek(i_s_cc_id);
s_cc_x=cc_x(i_s_cc_id);
s_cc_y=cc_y(i_s_cc_id);
s_cc_r_chl_wek=cc_r_chl_wek(i_s_cc_id);
s_cc_r_chl_ssh=cc_r_chl_ssh(i_s_cc_id);
s_cc_mu=cc_mu(i_s_cc_id);
s_cc_chl=cc_chl(i_s_cc_id);
s_cc_raw=cc_raw(i_s_cc_id);
s_cc_amp=-.01*cc_amp(i_s_cc_id);
s_cc_var=cc_var(i_s_cc_id);
s_cc_prct=cc_prct(i_s_cc_id,:);
s_cc_k=cc_k(i_s_cc_id);

cc_uid=unique(s_cc_id);
cc_uid(isnan(cc_uid))=[];
cc_r=nan(length(cc_uid),length(lags));
cc_n=cc_r;
cc_sdx=cc_r;
cc_sdy=cc_r;
cc_c=cc_r;
cc_sig=cc_r;
cc_range=nan(length(cc_uid),1);
cc_var=nan(length(cc_uid),1);
cc_mux=cc_range;
cc_muy=cc_range;
cc_age=cc_range;


for m=1:length(ac_uid)
	ii=find(s_ac_id==ac_uid(m));
	[ac_r(m,:),ac_c(m,:),ac_n(m,:),ac_sig(m,:),d,d,ac_sdx(m,:),ac_sdy(m,:)]=...
	pcor(s_ac_wek(ii),s_ac_chl(ii),lags);
	ac_mux(m,:)=nanmean(s_ac_wek(ii));
	ac_muy(m,:)=nanmean(s_ac_chl(ii));
	ac_range(m)=abs(pmean(s_ac_prct(ii,1)-s_ac_prct(ii,2)));
	ac_var(m)=pmean(s_ac_var(ii));
	ac_age(m)=max(s_ac_k(ii));
end

for m=1:length(cc_uid)
	ii=find(s_cc_id==cc_uid(m));
	%[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]
	[cc_r(m,:),cc_c(m,:),cc_n(m,:),cc_sig(m,:),d,d,cc_sdx(m,:),cc_sdy(m,:)]=...
	pcor(s_cc_wek(ii),s_cc_chl(ii),lags);
	cc_mux(m,:)=nanmean(s_cc_wek(ii));
	cc_muy(m,:)=nanmean(s_cc_chl(ii));
	cc_range(m)=abs(pmean(s_cc_prct(ii,1)-s_cc_prct(ii,2)));
	cc_var(m)=pmean(s_cc_var(ii));
	cc_age(m)=max(s_cc_k(ii));
end


%{
ia1=find(ac_r(:,6)>ac_sig(:,6) & ac_muy>0.02 & ac_age>=16);
ia2=find(ac_r(:,6)<-ac_sig(:,6) & ac_muy>0.02 & ac_age>=16);
ia3=find(ac_r(:,6)<-ac_sig(:,6) & ac_muy<-0.02 & ac_age>=16);
ia4=find(ac_r(:,6)>ac_sig(:,6) & ac_muy<-0.02 & ac_age>=16);

ic1=find(cc_r(:,6)>cc_sig(:,6) & cc_muy>0.02 & cc_age>=16);
ic2=find(cc_r(:,6)<-cc_sig(:,6) & cc_muy>0.02 & cc_age>=16);
ic3=find(cc_r(:,6)<-cc_sig(:,6) & cc_muy<-0.02 & cc_age>=16);
ic4=find(cc_r(:,6)>cc_sig(:,6) & cc_muy<-0.02 & cc_age>=16);

ia1=find(ac_r(:,6)>0 & ac_muy>0 & ac_age>=16);
ia2=find(ac_r(:,6)<-0 & ac_muy>0 & ac_age>=16);
ia3=find(ac_r(:,6)<-0 & ac_muy<-0 & ac_age>=16);
ia4=find(ac_r(:,6)>0 & ac_muy<-0 & ac_age>=16);

ic1=find(cc_r(:,6)>0 & cc_muy>0 & cc_age>=16);
ic2=find(cc_r(:,6)<-0 & cc_muy>0 & cc_age>=16);
ic3=find(cc_r(:,6)<-0 & cc_muy<-0 & cc_age>=16);
ic4=find(cc_r(:,6)>0 & cc_muy<-0 & cc_age>=16);

ac_lo_id=ac_uid;
cc_lo_id=cc_uid;


ac_lo_id(ia1)=nan;
cc_lo_id(ic1)=nan;
ac_lo_id(ia2)=nan;
cc_lo_id(ic2)=nan;
ac_lo_id(ia3)=nan;
cc_lo_id(ic3)=nan;
ac_lo_id(ia4)=nan;
cc_lo_id(ic4)=nan;

ac_lo_id(find(isnan(ac_lo_id)))=[];
cc_lo_id(find(isnan(cc_lo_id)))=[];

ialo=same(ac_lo_id,ac_uid);
iclo=same(cc_lo_id,cc_uid);

ac_r_bar=(1./nansum(ac_n(ia1,:),1)).*nansum(ac_n(ia1,:).*ac_r(ia1,:),1);
cc_r_bar=(1./nansum(cc_n(ic3,:),1)).*nansum(cc_n(ic3,:).*cc_r(ic3,:),1);
%{
figure(1)
clf
plot(lags,ac_r_bar,'r')
hold on
plot(lags,ac_r_bar,'r*')
plot(lags,cc_r_bar,'b')
plot(lags,cc_r_bar,'b*')

max_lon=max(cat(1,s_ac_x(ia1),s_ac_x(ia2),s_ac_x(ia3),s_ac_x(ia4),s_cc_x(ic1),s_cc_x(ic2),s_cc_x(ic3),s_cc_x(ic4)));
max_lat=max(cat(1,s_ac_y(ia1),s_ac_y(ia2),s_ac_y(ia3),s_ac_y(ia4),s_cc_y(ic1),s_cc_y(ic2),s_cc_y(ic3),s_cc_y(ic4)));
min_lon=min(cat(1,s_ac_x(ia1),s_ac_x(ia2),s_ac_x(ia3),s_ac_x(ia4),s_cc_x(ic1),s_cc_x(ic2),s_cc_x(ic3),s_cc_x(ic4)));
min_lat=min(cat(1,s_ac_y(ia1),s_ac_y(ia2),s_ac_y(ia3),s_ac_y(ia4),s_cc_y(ic1),s_cc_y(ic2),s_cc_y(ic3),s_cc_y(ic4)));

load /matlab/data/eddy/V4/global_tracks_V4_12_weeks nneg id track_jday x y

f1=sames(cat(1,ac_uid(ia1),cc_uid(ic1)),id);
f2=sames(cat(1,ac_uid(ia2),cc_uid(ic2)),id);
f3=sames(cat(1,ac_uid(ia3),cc_uid(ic3)),id);
f4=sames(cat(1,ac_uid(ia4),cc_uid(ic4)),id);
fo=sames(cat(1,ac_uid(ialo),cc_uid(iclo)),id);

id1=id(f1);
x1=x(f1);
y1=y(f1);
id2=id(f2);
x2=x(f2);
y2=y(f2);
id3=id(f3);
x3=x(f3);
y3=y(f3);
id4=id(f4);
x4=x(f4);
y4=y(f4);
ido=id(fo);
xo=x(fo);
yo=y(fo);


figure(2)
clf

subplot(331)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[x2 y2 id2],'tracks')
subplot(333)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[x1 y1 id1],'tracks')
subplot(337)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[x3 y3 id3],'tracks')
subplot(339)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[x4 y4 id4],'tracks')
subplot(335)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[xo yo ido],'tracks')


figure(3)
clf
scatter(ac_r(ia1,6),ac_muy(ia1),'r.')
hold on
scatter(ac_r(ia2,6),ac_muy(ia2),'r.')
scatter(ac_r(ia3,6),ac_muy(ia3),'r.')
scatter(ac_r(ia4,6),ac_muy(ia4),'r.')
scatter(ac_r(ialo,6),ac_muy(ialo),'ro')
scatter(cc_r(iclo,6),cc_muy(iclo),'bo')
scatter(cc_r(ic1,6),cc_muy(ic1),'b.')
scatter(cc_r(ic2,6),cc_muy(ic2),'b.')
scatter(cc_r(ic3,6),cc_muy(ic3),'b.')
scatter(cc_r(ic4,6),cc_muy(ic4),'b.')
line([0 0],[-1 1],'color','k')
%line([-.2 -.2],[-1 1],'color',[.5 .5 .5])
%line([.2 .2],[-1 1],'color',[.5 .5 .5])
%line([-1 1],[-.02 -.02],'color',[.5 .5 .5])
%line([-1 1],[.02 .02],'color',[.5 .5 .5])
line([-5 5],[0 0],'color','k')
set(gca,'xtick',[-5:5])
axis([-1 1 -.2 .2])
xlabel('r(W_{ek},CHL)')
ylabel('mean chl over eddy core  ')


%{
[lo_a,lo_c]=mcomps_id(cat(1,ac_uid(ialo),cc_uid(iclo)));
[q1_a,q1_c]=mcomps_id(cat(1,ac_uid(ia1),cc_uid(ic1)));
[q2_a,q2_c]=mcomps_id(cat(1,ac_uid(ia2),cc_uid(ic2)));
[q3_a,q3_c]=mcomps_id(cat(1,ac_uid(ia3),cc_uid(ic3)));
[q4_a,q4_c]=mcomps_id(cat(1,ac_uid(ia4),cc_uid(ic4)));

save EK_cor_and_comps 


load EK_cor_and_comps
zgrid_grid
r=17:65;
c=17:65;
dist=dist(r,c);
dist=interp2(dist,2);
mask=nan*dist;
ii=find(dist<=1.7);
mask(ii)=1;

eval(['fnc=[',char(39),'lo_c.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_c.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_c.chl_median',char(39),'];'])
eval(['flc=[',char(39),'lo_c_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'lo_a.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_a.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_a.chl_median',char(39),'];'])
eval(['flc=[',char(39),'lo_a_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	

eval(['fnc=[',char(39),'lo_c.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_c.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_c.wek_median',char(39),'];'])
eval(['flc=[',char(39),'lo_c_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'lo_a.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_a.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_a.wek_median',char(39),'];'])
eval(['flc=[',char(39),'lo_a_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	
	
eval(['fnc=[',char(39),'lo_c.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_c.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_c.mu_median',char(39),'];'])
eval(['flc=[',char(39),'lo_c_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'lo_a.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_a.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_a.mu_median',char(39),'];'])
eval(['flc=[',char(39),'lo_a_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	

eval(['fnc=[',char(39),'lo_c.car_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_c.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_c.car_median',char(39),'];'])
eval(['flc=[',char(39),'lo_c_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'lo_a.car_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_a.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_a.car_median',char(39),'];'])
eval(['flc=[',char(39),'lo_a_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

eval(['fnc=[',char(39),'lo_c.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_c.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_c.sst_median',char(39),'];'])
eval(['flc=[',char(39),'lo_c_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'lo_a.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_a.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_a.sst_median',char(39),'];'])
eval(['flc=[',char(39),'lo_a_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
	
for d=1:4
eval(['fnc=[',char(39),'q',num2str(d),'_c.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_c.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_c.chl_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_c_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_a.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_a.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_a.chl_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_a_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	

eval(['fnc=[',char(39),'q',num2str(d),'_c.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_c.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_c.wek_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_c_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_a.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_a.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_a.wek_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_a_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	
	
eval(['fnc=[',char(39),'q',num2str(d),'_c.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_c.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_c.mu_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_c_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_a.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_a.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_a.mu_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_a_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	

eval(['fnc=[',char(39),'q',num2str(d),'_c.car_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_c.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_c.car_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_c_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_a.car_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_a.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_a.car_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_a_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

eval(['fnc=[',char(39),'q',num2str(d),'_c.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_c.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_c.sst_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_c_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_a.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_a.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_a.sst_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_a_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
end

%}


%}

%[want_a,want_c]=mcomps_id(want_id);
%save want_ac_comp want_a want_c


%{
load want_ac_comp
tmp = double(interp2(want_a.chl_median,2));
tmp2 = double(interp2(want_a.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.07,.07,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/want_ac_chl_wek']) 	
%}	
%}

lags=[-5:5];
sel_r=nan(length(want_id),length(lags));
sel_n=sel_r;

r=nan(length(want_id),50);
n=r;

for m=[2 12 9]%1:length(want_id)

ii=find(ac_id==want_id(m));
jj=find(ac_uid==want_id(m));


time_subs=10:80;
for d=time_subs
	if length(ii)>=d+5
		%[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]
		[r(m,d-9),y,n(m,d-9)]=pcor(ac_wek(ii(d-5:d+5)),ac_chl(ii(d-5:d+5)));
	end
end
sel_r(m,:)=ac_r(jj,:);
sel_n(m,:)=ac_n(jj,:);
%}
figure(m)
clf
subplot(311)
plot(ac_k(ii),ac_wek(ii),'k')
hold on
plot(ac_k(ii),ac_wek(ii),'ko')
plot(ac_k(ii),ac_chl(ii),'g')
plot(ac_k(ii),ac_r_chl_wek(ii)./10,'b')

cor_hp=pcor(ac_wek(ii)-smooth1d_loess(ac_wek(ii),ac_k(ii),10,ac_k(ii)),ac_chl(ii)-smooth1d_loess(ac_chl(ii),ac_k(ii),10,ac_k(ii)));

title([num2str(want_id(m)),' - ',num2str(score(m)),'- hp-cor = ',num2str(cor_hp),'   '])
line([min(ac_k(ii)) max(ac_k(ii))],[0 0],'color','k')
axis([ac_k(ii(1)) ac_k(ii(end)) -.2 .5])

%subplot(212)
%plot(lags,ac_r(jj,:))


subplot(312)
plotyy(ac_k(ii),ac_mld(ii),ac_k(ii),ac_r_chl_wek(ii))

%plot(time_subs,r(m,:))
%line([ac_k(ii(1)) ac_k(ii(end))],[0 0],'color','k')
%axis([ac_k(ii(1)) ac_k(ii(end)) -1 1])

subplot(313)
hp_r=pcor(ac_wek(ii)-smooth1d_loess(ac_wek(ii),ac_k(ii),20,ac_k(ii)),ac_chl(ii)-smooth1d_loess(ac_chl(ii),ac_k(ii),20,ac_k(ii)),lags);
plot(lags,hp_r)
hold on
plot(lags,hp_r,'*')
axis([-5 5 -1 1])

end
r_bar=(1./nansum(n,1)).*nansum(n.*r),1;


ac_r_bar=(1./nansum(sel_n,1)).*nansum(sel_n.*sel_r,1);
%{
figure(m+1)
plot(r_bar)
figure(m+2)
plot(lags,ac_r_bar)

%}

