clear all
zgrid_grid
r=17:65;
c=17:65;
dist=dist(r,c);
dist=interp2(dist,2);
mask=nan*dist;
ii=find(dist<=1.7);
mask(ii)=1;
%{
lags=[-2:2];
load EK_time_chl_wek
%sort and make nan arrays for mean eddy values
[s_ac_id,i_s_ac_id]=sort(ac_id);
s_ac_wek=ac_wek(i_s_ac_id);
s_ac_par=ac_par(i_s_ac_id);
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
s_cc_par=cc_par(i_s_cc_id);
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



igooda=find(s_ac_par<1.5);
igoodc=find(s_cc_par<1.5);

length(igooda)./length(s_ac_wek)
length(igoodc)./length(s_cc_wek)

ibada=find(s_ac_par>2);
ibadc=find(s_cc_par>2);


%ibada=1:length(s_ac_id);
%ibada(igooda)=[];
%ibadc=1:length(s_cc_id);
%ibadc(igoodc)=[];


hp_s_ac_wek=s_ac_wek-smooth1d_loess(s_ac_wek,s_ac_k,20,s_ac_k);
hp_s_ac_chl=s_ac_chl-smooth1d_loess(s_ac_chl,s_ac_k,20,s_ac_k);
hp_s_ac_raw=s_ac_chl-smooth1d_loess(s_ac_raw,s_ac_k,20,s_ac_k);

[r_hp_good,b,b,sig]=pcor(hp_s_ac_wek(igooda),hp_s_ac_raw(igooda))
[r_hp_bad,b,b,sig]=pcor(hp_s_ac_wek(ibada),hp_s_ac_raw(ibada))






[good_a,good_c]=mcomps_time_step(cat(1,s_ac_id(igooda),s_cc_id(igoodc)),cat(1,s_ac_jday(igooda),s_cc_jday(igoodc)));
[bad_a,bad_c]=mcomps_time_step(cat(1,s_ac_id(ibada),s_cc_id(ibadc)),cat(1,s_ac_jday(ibada),s_cc_jday(ibadc)));

save EK_final_comps 
return

%}
load EK_final_comps
zgrid_grid
r=17:65;
c=17:65;
dist=dist(r,c);
dist=interp2(dist,2);
mask=nan*dist;
ii=find(dist<=2);
mask(ii)=1;


	
fnc='good_c.chl_N';
fmc='good_c.chl_n_max_sample';
fbc='good_c.raw_median';
fbc2='good_c.wek_median';
flc='good_c_chl_with_wek';
tmp = double(interp2(good_c.raw_median,2));
tmp2 = double(interp2(good_c.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.005,.005,.006,-1,0,'CHL cyclones PAR < 1.8 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='good_a.chl_N';
fma='good_a.chl_n_max_sample';
fba='good_a.raw_median';
fba2='good_a.wek_median';
fla='good_a_chl_with_wek';
tmp = double(interp2(good_a.raw_median,2));
tmp2 = double(interp2(good_a.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.005,.005,.006,0,1,'CHL anticyclones PAR < 1.8 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
fnc='bad_c.chl_N';
fmc='bad_c.chl_n_max_sample';
fbc='bad_c.raw_median';
fbc2='bad_c.wek_median';
flc='bad_c_chl_with_wek';
tmp = double(interp2(bad_c.raw_median,2));
tmp2 = double(interp2(bad_c.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.002,.002,.006,-1,0,'CHL cyclones PAR > 1.8 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='bad_a.chl_N';
fma='bad_a.chl_n_max_sample';
fba='bad_a.raw_median';
fba2='bad_a.wek_median';
fla='bad_a_chl_with_wek';
tmp = double(interp2(bad_a.raw_median,2));
tmp2 = double(interp2(bad_a.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.002,.002,.006,.006,1,'CHL anticyclones PAR > 1.8 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 	

fnc='good_c.car_N';
fmc='good_c.car_n_max_sample';
fbc='good_c.car_median';
fbc2='good_c.wek_median';
flc='good_c_car_with_wek';
tmp = double(interp2(good_c.car_median,2));
tmp2 = double(interp2(good_c.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.02,.02,.006,-1,-.006,'C cyclones PAR < 1.8 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='good_a.car_N';
fma='good_a.car_n_max_sample';
fba='good_a.car_median';
fba2='good_a.wek_median';
fla='good_a_car_with_wek';
tmp = double(interp2(good_a.car_median,2));
tmp2 = double(interp2(good_a.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.02,.02,.006,.006,1,'C anticyclones PAR < 1.8 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
fnc='bad_c.car_N';
fmc='bad_c.car_n_max_sample';
fbc='bad_c.car_median';
fbc2='bad_c.wek_median';
flc='bad_c_car_with_wek';
tmp = double(interp2(bad_c.car_median,2));
tmp2 = double(interp2(bad_c.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.01,.01,.006,-1,-.006,'C cyclones PAR > 1.8 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='bad_a.car_N';
fma='bad_a.car_n_max_sample';
fba='bad_a.car_median';
fba2='bad_a.wek_median';
fla='bad_a_car_with_wek';
tmp = double(interp2(bad_a.car_median,2));
tmp2 = double(interp2(bad_a.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.01,.01,.006,.006,1,'C anticyclones PAR > 1.8 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 	
	
return

fna='q1_a.sst_N';
fma='q1_a.sst_n_max_sample';
fba='q1_a.sst_median';
fba2='q1_a.wek_median';
fla='q1_a_sst_with_wek';
tmp = double(interp2(q1_a.sst_median,2));
tmp2 = double(interp2(q1_a.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.3,.3,.006,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 	
	
fnc='q4_c.sst_N';
fmc='q4_c.sst_n_max_sample';
fbc='q4_c.sst_median';
fbc2='q4_c.wek_median';
flc='q4_c_sst_with_wek';
tmp = double(interp2(q4_c.sst_median,2));
tmp2 = double(interp2(q4_c.wek_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.3,.3,.006,-1,1,...
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
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.006,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'lo_a.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_a.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_a.wek_median',char(39),'];'])
eval(['flc=[',char(39),'lo_a_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.006,-1,1,...
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
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.006,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_a.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_a.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_a.wek_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_a_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.006,-1,1,...
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
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.006,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'lo_a.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'lo_a.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'lo_a.wek_median',char(39),'];'])
eval(['flc=[',char(39),'lo_a_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.006,-1,1,...
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
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.006,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
eval(['fnc=[',char(39),'q',num2str(d),'_a.wek_N',char(39),'];']);
eval(['fmc=[',char(39),'q',num2str(d),'_a.wek_n_max_sample',char(39),'];'])
eval(['fbc=[',char(39),'q',num2str(d),'_a.wek_median',char(39),'];'])
eval(['flc=[',char(39),'q',num2str(d),'_a_wek',char(39),'];'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.15,.15,.006,-1,1,...
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
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.07,.07,.006,-1,1,...
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

