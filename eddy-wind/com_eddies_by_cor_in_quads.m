clear all

low_curs = {'ek','natl','haw','lw','eac','agu','bmc','gs','opac','glb'};
curs = {'EK','NATL','HAW','LW','EAC','AGU','BMC','GS','OPAC','GLB'};

lags=[-5:5];


for pz=1
curs{pz}
%
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
s_ac_jday=ac_jday(i_s_ac_id);
s_ac_Sig_r_chl_ssh=ac_Sig_r_chl_ssh(i_s_ac_id);
s_ac_Sig_r_chl_wek=ac_Sig_r_chl_wek(i_s_ac_id);
s_ac_N_r_chl_ssh=ac_N_r_chl_ssh(i_s_ac_id);
s_ac_N_r_chl_wek=ac_N_r_chl_wek(i_s_ac_id);



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
s_cc_jday=cc_jday(i_s_cc_id);
s_cc_Sig_r_chl_ssh=cc_Sig_r_chl_ssh(i_s_cc_id);
s_cc_Sig_r_chl_wek=cc_Sig_r_chl_wek(i_s_cc_id);
s_cc_N_r_chl_ssh=cc_N_r_chl_ssh(i_s_cc_id);
s_cc_N_r_chl_wek=cc_N_r_chl_wek(i_s_cc_id);


%make indices by quad
ia1=find(s_ac_r_chl_wek>s_ac_Sig_r_chl_wek & s_ac_chl>.03);
ia2=find(s_ac_r_chl_wek<-s_ac_Sig_r_chl_wek & s_ac_chl>.03);
ia3=find(s_ac_r_chl_wek<-s_ac_Sig_r_chl_wek & s_ac_chl<-.03);
ia4=find(s_ac_r_chl_wek>s_ac_Sig_r_chl_wek & s_ac_chl<-.03);

ic1=find(s_cc_r_chl_wek>s_cc_Sig_r_chl_wek & s_cc_chl>.03);
ic2=find(s_cc_r_chl_wek<-s_cc_Sig_r_chl_wek & s_cc_chl>.03);
ic3=find(s_cc_r_chl_wek<-s_cc_Sig_r_chl_wek & s_cc_chl<-.03);
ic4=find(s_cc_r_chl_wek>s_cc_Sig_r_chl_wek & s_cc_chl<-.03);


q1_time_ac_r_chl=nan(length(ia1),5);
q2_time_ac_r_chl=nan(length(ia2),5);
q3_time_ac_r_chl=nan(length(ia3),5);
q4_time_ac_r_chl=nan(length(ia4),5);

q1_time_ac_r_wek=nan(length(ia1),5);
q2_time_ac_r_wek=nan(length(ia2),5);
q3_time_ac_r_wek=nan(length(ia3),5);
q4_time_ac_r_wek=nan(length(ia4),5);


%{
%
%put  obs in lag matrix
%
%
for m=1:length(ia1)
	q1_time_ac_r_chl_wek(m,3)=s_ac_chl(ia1(m));
	if m>1
		ii=s_ac_chl(ia1(m-1));
		if any(ii) & s_ac_k(m)< s_ac_k(m-1)
			q1_time_ac_r_chl_wek(m,2)=s_ac_chl(i1a(m-1));
		end
	end	
	if m>2
		ii=s_ac_chl(ia1(m-2));
		if any(ii) & s_ac_k(m-1)< s_ac_k(m-2)
			q1_time_ac_r_chl_wek(m,1)=s_ac_chl(i1a(m-2));
		end
	end
	if m<length(ia1)
	ii=s_ac_chl(ia1(m+1));
		if any(ii) & s_ac_k(m+1)> s_ac_k(m)
			q1_time_ac_r_chl_wek(m,4)=s_ac_chl(i1a(m+1));
		end
	end	
	if m<length(ia1)-1
	ii=s_ac_chl(ia1(m+2));
		if any(ii) & s_ac_k(m+2)> s_ac_k(m+1)
			q1_time_ac_r_chl_wek(m,5)=s_ac_chl(i1a(m+2));
		end
	end	
end	
	
%}		
	



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


for m=1:length(ac_uid)
	ii=find(s_ac_id==ac_uid(m));
	[ac_r(m,:),ac_c(m,:),ac_n(m,:),ac_Sig(m,:),d,d,ac_sdx(m,:),ac_sdy(m,:)]=...
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
	[cc_r(m,:),cc_c(m,:),cc_n(m,:),cc_Sig(m,:),d,d,cc_sdx(m,:),cc_sdy(m,:)]=...
	pcor(s_cc_wek(ii),s_cc_chl(ii),lags);
	cc_mux(m,:)=nanmean(s_cc_wek(ii));
	cc_muy(m,:)=nanmean(s_cc_chl(ii));
	cc_range(m)=abs(pmean(s_cc_prct(ii,1)-s_cc_prct(ii,2)));
	cc_var(m)=pmean(s_cc_var(ii));
	cc_age(m)=max(s_cc_k(ii));
end

ac_r_bar=(1./nansum(ac_n,1)).*nansum(ac_n.*ac_r,1);
cc_r_bar=(1./nansum(cc_n,1)).*nansum(cc_n.*cc_r,1);
figure(20)
plot(lags,ac_r_bar,'r')
hold on
plot(lags,cc_r_bar,'b')
plot(lags,ac_r_bar,'r*')
plot(lags,cc_r_bar,'b*')



eval(['[lo_',curs{pz},'_a,lo_',curs{pz},'_c]=mcomps_time_step(cat(1,ac_lo_id,cc_lo_id),cat(1,ac_lo_jday,cc_lo_jday));'])
eval(['[q1_',curs{pz},'_a,q1_',curs{pz},'_c]=mcomps_time_step(cat(1,s_ac_id(ia1),s_cc_id(ic1)),cat(1,s_ac_jday(ia1),s_cc_jday(ic1)));'])
eval(['[q2_',curs{pz},'_a,q2_',curs{pz},'_c]=mcomps_time_step(cat(1,s_ac_id(ia2),s_cc_id(ic2)),cat(1,s_ac_jday(ia2),s_cc_jday(ic2)));'])
eval(['[q3_',curs{pz},'_a,q3_',curs{pz},'_c]=mcomps_time_step(cat(1,s_ac_id(ia3),s_cc_id(ic3)),cat(1,s_ac_jday(ia3),s_cc_jday(ic3)));'])
eval(['[q4_',curs{pz},'_a,q4_',curs{pz},'_c]=mcomps_time_step(cat(1,s_ac_id(ia4),s_cc_id(ic4)),cat(1,s_ac_jday(ia4),s_cc_jday(ic4)));'])


minlat=min(cat(1,s_ac_y(ia1),s_ac_y(ia2),s_ac_y(ia3),s_ac_y(ia4),s_cc_y(ic1),s_cc_y(ic2),s_cc_y(ic3),s_cc_y(ic4)));
maxlat=max(cat(1,s_ac_y(ia1),s_ac_y(ia2),s_ac_y(ia3),s_ac_y(ia4),s_cc_y(ic1),s_cc_y(ic2),s_cc_y(ic3),s_cc_y(ic4)));
minlon=min(cat(1,s_ac_x(ia1),s_ac_x(ia2),s_ac_x(ia3),s_ac_x(ia4),s_cc_x(ic1),s_cc_x(ic2),s_cc_x(ic3),s_cc_x(ic4)));
maxlon=max(cat(1,s_ac_x(ia1),s_ac_x(ia2),s_ac_x(ia3),s_ac_x(ia4),s_cc_x(ic1),s_cc_x(ic2),s_cc_x(ic3),s_cc_x(ic4)));


figure(1)
clf
subplot(222)
pmap(minlon-3:maxlon+3,minlat-3:maxlat+3,[cat(1,s_ac_x(ia1),s_cc_x(ic1)) cat(1,s_ac_y(ia1),s_cc_y(ic1)) cat(1,s_ac_id(ia1),s_cc_id(ic1))],'tracks_big_dots')

subplot(221)
pmap(minlon-3:maxlon+3,minlat-3:maxlat+3,[cat(1,s_ac_x(ia2),s_cc_x(ic2)) cat(1,s_ac_y(ia2),s_cc_y(ic2)) cat(1,s_ac_id(ia2),s_cc_id(ic2))],'tracks_big_dots')

subplot(224)
pmap(minlon-3:maxlon+3,minlat-3:maxlat+3,[cat(1,s_ac_x(ia3),s_cc_x(ic3)) cat(1,s_ac_y(ia3),s_cc_y(ic3)) cat(1,s_ac_id(ia3),s_cc_id(ic3))],'tracks_big_dots')
	 
subplot(223)
pmap(minlon-3:maxlon+3,minlat-3:maxlat+3,[cat(1,s_ac_x(ia4),s_cc_x(ic4)) cat(1,s_ac_y(ia4),s_cc_y(ic4)) cat(1,s_ac_id(ia4),s_cc_id(ic4))],'tracks_big_dots')
	 
eval(['print -dpng -r300 figs/quad_tracks_cor_', curs{pz}]);	 



figure(1)
clf
scatter(s_ac_r_chl_wek,s_ac_chl,'g.')
hold on
scatter(s_cc_r_chl_wek,s_cc_chl,'g.')
scatter(s_ac_r_chl_wek(ia1),s_ac_chl(ia1),'r.')
scatter(s_ac_r_chl_wek(ia2),s_ac_chl(ia2),'r.')
scatter(s_ac_r_chl_wek(ia3),s_ac_chl(ia3),'r.')
scatter(s_ac_r_chl_wek(ia4),s_ac_chl(ia4),'r.')
scatter(s_cc_r_chl_wek(ic1),s_cc_chl(ic1),'b.')
scatter(s_cc_r_chl_wek(ic2),s_cc_chl(ic2),'b.')
scatter(s_cc_r_chl_wek(ic3),s_cc_chl(ic3),'b.')
scatter(s_cc_r_chl_wek(ic4),s_cc_chl(ic4),'b.')
line([0 0],[-1 1],'color','k')
line([-.5 -.5],[-1 1],'color',[.5 .5 .5])
line([.5 .5],[-1 1],'color',[.5 .5 .5])
line([-1 1],[-.03 -.03],'color',[.5 .5 .5])
line([-1 1],[.03 .03],'color',[.5 .5 .5])
line([-5 5],[0 0],'color','k')
%set(gca,'xtick',[-5:5])
axis([-1 1 -.2 .2])
xlabel('r(ssh,chl) in eddy core  ')
ylabel('mean chl in eddy core  ')
title({'Scatter of r and wek within eddy core'})
text(1,.15,curs{pz})
eval(['print -dpng figs/tracks_dots_cor_' curs{pz} '_wek_chl'])
%{
%eval(['[',curs{pz},'_a,',curs{pz},'_c]=mcomps_time_step(cat(1,ac_id,cc_id),cat(1,ac_jday,cc_jday));'])


load current_comps_cor_by_quad
zgrid_grid
r=17:65;
c=17:65;
dist=dist(r,c);
dist=interp2(dist,2);
mask=nan*dist;
ii=find(dist<=1.7);
mask(ii)=1;

eval(['fnc=[',char(39),'lo_',curs{pz},'_c.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_c.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_c.chl_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_c_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_chl_comps/',flc]) 
eval(['fnc=[',char(39),'lo_',curs{pz},'_a.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_a.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_a.chl_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_a_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_chl_comps/',flc]) 	

eval(['fnc=[',char(39),'lo_',curs{pz},'_c.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_c.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_c.wek_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_c_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_wek_comps/',flc]) 
eval(['fnc=[',char(39),'lo_',curs{pz},'_a.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_a.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_a.wek_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_a_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_wek_comps/',flc]) 	
	
eval(['fnc=[',char(39),'lo_',curs{pz},'_c.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_c.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_c.mu_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_c_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_mu_comps/',flc]) 
eval(['fnc=[',char(39),'lo_',curs{pz},'_a.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_a.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_a.mu_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_a_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_mu_comps/',flc]) 	

eval(['fnc=[',char(39),'lo_',curs{pz},'_c.car_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_c.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_c.car_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_c_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_car_comps/',flc]) 
eval(['fnc=[',char(39),'lo_',curs{pz},'_a.car_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_a.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_a.car_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_a_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_car_comps/',flc]) 

eval(['fnc=[',char(39),'lo_',curs{pz},'_c.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_c.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_c.sst_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_c_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_sst_comps/',flc]) 
eval(['fnc=[',char(39),'lo_',curs{pz},'_a.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_a.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_a.sst_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_a_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_sst_comps/',flc]) 
	
	
for d=1:4
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.chl_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_c_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_chl_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.chl_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_a_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_chl_comps/',flc]) 	

eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.wek_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_c_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_wek_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.wek_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_a_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_wek_comps/',flc]) 	
	
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.mu_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_c_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_mu_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.mu_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_a_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_mu_comps/',flc]) 	

eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.car_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.car_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_c_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_car_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.car_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.car_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_a_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_car_comps/',flc]) 

eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.sst_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_c_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_sst_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.sst_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_a_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_cor_sst_comps/',flc]) 
end
%}
end

save -append current_comps_cor_wek_by_quad *_a *_c