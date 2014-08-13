clear all

curs = {'GLB','HAW','LW','EAC','AGU','BMC','GS','OPAC'};
lags=[-5:5];


for pz=3%:length(curs)
eval(['load ' curs{pz} '_time_chl_wek'])

%sort and make nan arrays for mean eddy values
[s_ac_id,i_s_ac_id]=sort(ac_id);
s_ac_wek=ac_wek(i_s_ac_id);
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
	ac_mux(m)=nanmedian(s_ac_amp(ii));
	ac_muy(m)=nanmedian(s_ac_chl(ii));
	ac_range(m)=abs(pmean(s_ac_prct(ii,1)-s_ac_prct(ii,2)));
	ac_var(m)=pmean(s_ac_var(ii));
	ac_age(m)=max(s_ac_k(ii));
end

for m=1:length(cc_uid)
	ii=find(s_cc_id==cc_uid(m));
	%[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]
	[cc_r(m,:),cc_c(m,:),cc_n(m,:),cc_sig(m,:),d,d,cc_sdx(m,:),cc_sdy(m,:)]=...
	pcor(s_cc_wek(ii),s_cc_chl(ii),lags);
	cc_mux(m)=nanmedian(s_cc_amp(ii));
	cc_muy(m)=nanmedian(s_cc_chl(ii));
	cc_range(m)=abs(pmean(s_cc_prct(ii,1)-s_cc_prct(ii,2)));
	cc_var(m)=pmean(s_cc_var(ii));
	cc_age(m)=max(s_cc_k(ii));
end

%max indices by quad
%Use for time averages

ia1=find(ac_r(:,6)>ac_sig(:,6) & ac_muy>0.02 & ac_age>=16);
ia2=find(ac_r(:,6)<-ac_sig(:,6) & ac_muy>0.02 & ac_age>=16);
ia3=find(ac_r(:,6)<-ac_sig(:,6) & ac_muy<-0.02 & ac_age>=16);
ia4=find(ac_r(:,6)>ac_sig(:,6) & ac_muy<-0.02 & ac_age>=16);

ic1=find(cc_r(:,6)>cc_sig(:,6) & cc_muy>0.02 & cc_age>=16);
ic2=find(cc_r(:,6)<-cc_sig(:,6) & cc_muy>0.02 & cc_age>=16);
ic3=find(cc_r(:,6)<-cc_sig(:,6) & cc_muy<-0.02 & cc_age>=16);
ic4=find(cc_r(:,6)>cc_sig(:,6) & cc_muy<-0.02 & cc_age>=16);

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

%{

ia1=find(s_ac_r_chl_wek>.5 & s_ac_chl>0.05);
ia2=find(s_ac_r_chl_wek<-.5 & s_ac_chl>0.05);
ia3=find(s_ac_r_chl_wek<-.5 & s_ac_chl<-0.05);
ia4=find(s_ac_r_chl_wek>.5 & s_ac_chl<-0.05);

ic1=find(s_cc_r_chl_wek>.5 & s_cc_chl>0.05);
ic2=find(s_cc_r_chl_wek<-.5 & s_cc_chl>0.05);
ic3=find(s_cc_r_chl_wek<-.5 & s_cc_chl<-0.05);
ic4=find(s_cc_r_chl_wek>.5 & s_cc_chl<-0.05);
%}
ac_r_bar=(1./nansum(ac_n(ia1,:),1)).*nansum(ac_n(ia1,:).*ac_r(ia1,:),1);
cc_r_bar=(1./nansum(cc_n(ic3,:),1)).*nansum(cc_n(ic3,:).*cc_r(ic3,:),1);

figure(23)
clf
plot(lags,ac_r_bar,'r')
hold on
plot(lags,ac_r_bar,'r*')
plot(lags,cc_r_bar,'b')
plot(lags,cc_r_bar,'b*')


%{
load /matlab/data/eddy/V4/global_tracks_dots_V4_12_weeks id x y track_jday nneg
startjd=2451556;
endjd=2454461;
f1=find(track_jday>=startjd & track_jday<=endjd);
id=id(f1);
x=x(f1);
y=y(f1);
%}

max_lon=max(cat(1,s_ac_x(ia1),s_ac_x(ia2),s_ac_x(ia3),s_ac_x(ia4),s_cc_x(ic1),s_cc_x(ic2),s_cc_x(ic3),s_cc_x(ic4)));
max_lat=max(cat(1,s_ac_y(ia1),s_ac_y(ia2),s_ac_y(ia3),s_ac_y(ia4),s_cc_y(ic1),s_cc_y(ic2),s_cc_y(ic3),s_cc_y(ic4)));
min_lon=min(cat(1,s_ac_x(ia1),s_ac_x(ia2),s_ac_x(ia3),s_ac_x(ia4),s_cc_x(ic1),s_cc_x(ic2),s_cc_x(ic3),s_cc_x(ic4)));
min_lat=min(cat(1,s_ac_y(ia1),s_ac_y(ia2),s_ac_y(ia3),s_ac_y(ia4),s_cc_y(ic1),s_cc_y(ic2),s_cc_y(ic3),s_cc_y(ic4)));


%{
figure(1)
clf

subplot(333)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[cat(1,s_ac_x(ia1),s_cc_x(ic1)) cat(1,s_ac_y(ia1),s_cc_y(ic1)) cat(1,s_ac_id(ia1),s_cc_id(ic1))],'tracks_dots')

subplot(331)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[cat(1,s_ac_x(ia2),s_cc_x(ic2)) cat(1,s_ac_y(ia2),s_cc_y(ic2)) cat(1,s_ac_id(ia2),s_cc_id(ic2))],'tracks_dots')

subplot(337)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[cat(1,s_ac_x(ia3),s_cc_x(ic3)) cat(1,s_ac_y(ia3),s_cc_y(ic3)) cat(1,s_ac_id(ia3),s_cc_id(ic3))],'tracks_dots')

subplot(339)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[cat(1,s_ac_x(ia4),s_cc_x(ic4)) cat(1,s_ac_y(ia4),s_cc_y(ic4)) cat(1,s_ac_id(ia4),s_cc_id(ic4))],'tracks_dots')


subplot(335)
%}
figure(22)
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
xlabel('r(w_{ek},CHL)')
ylabel('mean chl over eddy core  ')
title({'Scatter of mean chl within eddy core'})
text(1,.15,curs{pz})
eval(['print -dpng figs/tracks_dots_dots_quad_time_step_' curs{pz} '_amp_chl'])
%{
id1=unique(id(iu1));
want_id=id1(find(id1>=nneg));
eval(['fdir=' char(39) 'frames/quads/amp/q1_ac_' curs{pz} char(39)])
panimate_ac(want_id,fdir)

want_id=id1(find(id1<nneg));
eval(['fdir=' char(39) 'frames/quads/amp/q1_cc_' curs{pz} char(39)])
panimate_cc(want_id,fdir)

id2=unique(id(iu2));
want_id=id2(find(id2>=nneg));
eval(['fdir=' char(39) 'frames/quads/amp/q2_ac_' curs{pz} char(39)])
panimate_ac(want_id,fdir)

want_id=id2(find(id2<nneg));
eval(['fdir=' char(39) 'frames/quads/amp/q2_cc_' curs{pz} char(39)])
panimate_cc(want_id,fdir)

id3=unique(id(iu3));
want_id=id3(find(id3>=nneg));
eval(['fdir=' char(39) 'frames/quads/amp/q3_ac_' curs{pz} char(39)])
panimate_ac(want_id,fdir)

want_id=id3(find(id3<nneg));
eval(['fdir=' char(39) 'frames/quads/amp/q3_cc_' curs{pz} char(39)])
panimate_cc(want_id,fdir)

id4=unique(id(iu4));
want_id=id4(find(id4>=nneg));
eval(['fdir=' char(39) 'frames/quads/amp/q4_ac_' curs{pz} char(39)])
panimate_ac(want_id,fdir)

want_id=id4(find(id4<nneg));
eval(['fdir=' char(39) 'frames/quads/amp/q4_cc_' curs{pz} char(39)])
panimate_cc(want_id,fdir)
%}

end
