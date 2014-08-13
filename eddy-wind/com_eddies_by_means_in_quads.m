clear all

low_curs = {'natl','haw','lw','eac','agu','bmc','gs','opac','glb'};
curs = {'NATL','HAW','LW','EAC','AGU','BMC','GS','OPAC','GLB'};

lags=[-5:5];


for pz=1:8
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


%make indices by quad
ia1=find(s_ac_wek>.034 & s_ac_chl>0.034);
ia2=find(s_ac_wek<-.034 & s_ac_chl>0.034);
ia3=find(s_ac_wek<-.034 & s_ac_chl<-0.034);
ia4=find(s_ac_wek>.034 & s_ac_chl<-0.034);

ic1=find(s_cc_wek>.034 & s_cc_chl>0.034);
ic2=find(s_cc_wek<-.034 & s_cc_chl>0.034);
ic3=find(s_cc_wek<-.034 & s_cc_chl<-0.034);
ic4=find(s_cc_wek>.034 & s_cc_chl<-0.034);

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
%{
eval(['[lo_',curs{pz},'_a,lo_',curs{pz},'_c]=mcomps_time_step(cat(1,ac_lo_id,cc_lo_id),cat(1,ac_lo_jday,cc_lo_jday));'])
eval(['[q1_',curs{pz},'_a,q1_',curs{pz},'_c]=mcomps_time_step(cat(1,s_ac_id(ia1),s_cc_id(ic1)),cat(1,s_ac_jday(ia1),s_cc_jday(ic1)));'])
eval(['[q2_',curs{pz},'_a,q2_',curs{pz},'_c]=mcomps_time_step(cat(1,s_ac_id(ia2),s_cc_id(ic2)),cat(1,s_ac_jday(ia2),s_cc_jday(ic2)));'])
eval(['[q3_',curs{pz},'_a,q3_',curs{pz},'_c]=mcomps_time_step(cat(1,s_ac_id(ia3),s_cc_id(ic3)),cat(1,s_ac_jday(ia3),s_cc_jday(ic3)));'])
eval(['[q4_',curs{pz},'_a,q4_',curs{pz},'_c]=mcomps_time_step(cat(1,s_ac_id(ia4),s_cc_id(ic4)),cat(1,s_ac_jday(ia4),s_cc_jday(ic4)));'])
%}

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

subplot(223)
pmap(minlon-3:maxlon+3,minlat-3:maxlat+3,[cat(1,s_ac_x(ia3),s_cc_x(ic3)) cat(1,s_ac_y(ia3),s_cc_y(ic3)) cat(1,s_ac_id(ia3),s_cc_id(ic3))],'tracks_big_dots')
	 
subplot(224)
pmap(minlon-3:maxlon+3,minlat-3:maxlat+3,[cat(1,s_ac_x(ia4),s_cc_x(ic4)) cat(1,s_ac_y(ia4),s_cc_y(ic4)) cat(1,s_ac_id(ia4),s_cc_id(ic4))],'tracks_big_dots')
	 
eval(['print -dpng -r300 figs/quad_tracks', curs{pz}]);	 
%{

figure(1)
clf
scatter(s_ac_wek,s_ac_chl,'g.')
hold on
scatter(s_cc_wek,s_cc_chl,'g.')
scatter(s_ac_wek(ia1),s_ac_chl(ia1),'r.')
scatter(s_ac_wek(ia2),s_ac_chl(ia2),'r.')
scatter(s_ac_wek(ia3),s_ac_chl(ia3),'r.')
scatter(s_ac_wek(ia4),s_ac_chl(ia4),'r.')
scatter(s_cc_wek(ic1),s_cc_chl(ic1),'b.')
scatter(s_cc_wek(ic2),s_cc_chl(ic2),'b.')
scatter(s_cc_wek(ic3),s_cc_chl(ic3),'b.')
scatter(s_cc_wek(ic4),s_cc_chl(ic4),'b.')
line([0 0],[-1 1],'color','k')
line([-.034 -.034],[-1 1],'color',[.5 .5 .5])
line([.034 .034],[-1 1],'color',[.5 .5 .5])
line([-1 1],[-.034 -.034],'color',[.5 .5 .5])
line([-1 1],[.034 .034],'color',[.5 .5 .5])
line([-5 5],[0 0],'color','k')
%set(gca,'xtick',[-5:5])
axis([-.2 .2 -.2 .2])
xlabel('mean wek in eddy core  ')
ylabel('mean chl in eddy core  ')
title({'Scatter of mean chl and wek within eddy core'})
text(1,.15,curs{pz})
eval(['print -dpng figs/tracks_big_dots_cores_' curs{pz} '_wek_chl'])

%eval(['[',curs{pz},'_a,',curs{pz},'_c]=mcomps_time_step(cat(1,ac_id,cc_id),cat(1,ac_jday,cc_jday));'])


load current_comps_by_quad
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
	['~/Documents/OSU/figures/eddy-wind/current_chl_comps/',flc]) 
eval(['fnc=[',char(39),'lo_',curs{pz},'_a.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_a.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_a.chl_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_a_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_chl_comps/',flc]) 	

eval(['fnc=[',char(39),'lo_',curs{pz},'_c.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_c.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_c.wek_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_c_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_wek_comps/',flc]) 
eval(['fnc=[',char(39),'lo_',curs{pz},'_a.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_a.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_a.wek_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_a_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_wek_comps/',flc]) 	
	
eval(['fnc=[',char(39),'lo_',curs{pz},'_c.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_c.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_c.mu_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_c_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_mu_comps/',flc]) 
eval(['fnc=[',char(39),'lo_',curs{pz},'_a.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_a.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_a.mu_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_a_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_mu_comps/',flc]) 	

eval(['fnc=[',char(39),'lo_',curs{pz},'_c.car_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_c.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_c.car_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_c_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_car_comps/',flc]) 
eval(['fnc=[',char(39),'lo_',curs{pz},'_a.car_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_a.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_a.car_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_a_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_car_comps/',flc]) 

eval(['fnc=[',char(39),'lo_',curs{pz},'_c.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_c.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_c.sst_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_c_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_sst_comps/',flc]) 
eval(['fnc=[',char(39),'lo_',curs{pz},'_a.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_',curs{pz},'_a.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_',curs{pz},'_a.sst_median',char(39),'];'])
eval(['flc=[',char(39),'lo_',curs{pz},'_a_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_sst_comps/',flc]) 
	
	
for d=1:4
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.chl_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_c_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_chl_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.chl_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.chl_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.chl_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_a_chl',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_chl_comps/',flc]) 	

eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.wek_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_c_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_wek_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.wek_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_a_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_wek_comps/',flc]) 	
	
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.mu_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_c_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_mu_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.mu_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.mu_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.mu_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_a_mu',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_mu_comps/',flc]) 	

eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.car_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.car_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_c_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_car_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.car_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.car_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.car_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_a_car',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_car_comps/',flc]) 

eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_c.sst_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_c_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_sst_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.sst_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.sst_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_',curs{pz},'_a.sst_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_',curs{pz},'_a_sst',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.3,.3,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/current_sst_comps/',flc]) 
end
%}
end

%save -append current_comps_by_quad *_a *_c