clear all

curs = {'GLB','AGU','LW','EAC','BMC','GS','OPAC','HAW'};
lags=[-5:5];


for pz=3%:length(curs)
eval(['load ' curs{pz} '_time_chl_wek'])

%sort and make nan arrays for mean eddy values
[s_ac_id,i_s_ac_id]=sort(ac_id);
s_ac_wek=ac_wek(i_s_ac_id);
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
ac_age=ac_range;
ac_mux=ac_range;
ac_muy=ac_range;


[s_cc_id,i_s_cc_id]=sort(cc_id);
s_cc_wek=cc_wek(i_s_cc_id);
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
cc_age=cc_range;
cc_mux=cc_range;
cc_muy=cc_range;


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

%max indices by quad
ia1=find(ac_mux>.02 & ac_muy>0.02 & ac_age>=16);
ia2=find(ac_mux<-.02 & ac_muy>0.02 & ac_age>=16);
ia3=find(ac_mux<-.02 & ac_muy<-0.02 & ac_age>=16);
ia4=find(ac_mux>.02 & ac_muy<-0.02 & ac_age>=16);

ic1=find(cc_mux>.02 & cc_muy>0.02 & cc_age>=16);
ic2=find(cc_mux<-.02 & cc_muy>0.02 & cc_age>=16);
ic3=find(cc_mux<-.02 & cc_muy<-0.02 & cc_age>=16);
ic4=find(cc_mux>.02 & cc_muy<-0.02 & cc_age>=16);


load /matlab/data/eddy/V4/global_tracks_V4_12_weeks id x y track_jday nneg
%{
startjd=2451556;
endjd=2454461;
f1=find(track_jday>=startjd & track_jday<=endjd);
id=id(f1);
x=x(f1);
y=y(f1);
%}

iu1=sames(cat(1,unique(ac_uid(ia1)),unique(cc_uid(ic1))),id);
iu2=sames(cat(1,unique(ac_uid(ia2)),unique(cc_uid(ic2))),id);
iu3=sames(cat(1,unique(ac_uid(ia3)),unique(cc_uid(ic3))),id);
iu4=sames(cat(1,unique(ac_uid(ia4)),unique(cc_uid(ic4))),id);

max_lon=max(cat(1,x(iu1),x(iu2),x(iu3),x(iu4)));
max_lat=max(cat(1,y(iu1),y(iu2),y(iu3),y(iu4)));
min_lon=min(cat(1,x(iu1),x(iu2),x(iu3),x(iu4)));
min_lat=min(cat(1,y(iu1),y(iu2),y(iu3),y(iu4)));


figure(1)
clf
subplot(333)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[x(iu1) y(iu1) id(iu1)],'tracks_dots')


subplot(331)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[x(iu2) y(iu2) id(iu2)],'tracks_dots')

subplot(337)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[x(iu3) y(iu3) id(iu3)],'tracks_dots')

subplot(339)
pmap(min_lon-10:max_lon+10,min_lat-3:max_lat+3,[x(iu4) y(iu4) id(iu4)],'tracks_dots')


subplot(335)
scatter(ac_mux,ac_muy,'r.')
hold on
scatter(cc_mux,cc_muy,'b.')
line([0 0],[-1 1],'color','k')
line([-.02 -.02],[-1 1],'color',[.5 .5 .5])
line([.02 .02],[-1 1],'color',[.5 .5 .5])
line([-1 1],[-.02 -.02],'color',[.5 .5 .5])
line([-1 1],[.02 .02],'color',[.5 .5 .5])
line([-5 5],[0 0],'color','k')
set(gca,'xtick',[-5:5])
axis([-.2 .2 -.2 .2])
xlabel('mean wek over whole life  ')
ylabel('mean chl over whole life  ')
title({'Scatter of mean chl within eddy core'})
text(1,.15,curs{pz})
eval(['print -dpng figs/tracks_dots_quad_means_' curs{pz} '_wek_chl'])


id1=unique(id(iu1));
want_id=id1(find(id1>=nneg));
eval(['fdir=' char(39) 'frames/quads_means/wek/q1_ac_' curs{pz} '/' char(39)])
panimate_ac(want_id,fdir)

want_id=id1(find(id1<nneg));
eval(['fdir=' char(39) 'frames/quads_means/wek/q1_cc_' curs{pz} '/' char(39)])
panimate_cc(want_id,fdir)

id2=unique(id(iu2));
want_id=id2(find(id2>=nneg));
eval(['fdir=' char(39) 'frames/quads_means/wek/q2_ac_' curs{pz} '/' char(39)])
panimate_ac(want_id,fdir)

want_id=id2(find(id2<nneg));
eval(['fdir=' char(39) 'frames/quads_means/wek/q2_cc_' curs{pz} '/' char(39)])
panimate_cc(want_id,fdir)

id3=unique(id(iu3));
want_id=id3(find(id3>=nneg));
eval(['fdir=' char(39) 'frames/quads_means/wek/q3_ac_' curs{pz} '/' char(39)])
panimate_ac(want_id,fdir)

want_id=id3(find(id3<nneg));
eval(['fdir=' char(39) 'frames/quads_means/wek/q3_cc_' curs{pz} '/' char(39)])
panimate_cc(want_id,fdir)

id4=unique(id(iu4));
want_id=id4(find(id4>=nneg));
eval(['fdir=' char(39) 'frames/quads_means/wek/q4_ac_' curs{pz} '/' char(39)])
panimate_ac(want_id,fdir)

want_id=id4(find(id4<nneg));
eval(['fdir=' char(39) 'frames/quads_means/wek/q4_cc_' curs{pz} '/' char(39)])
panimate_cc(want_id,fdir)
%}

end
