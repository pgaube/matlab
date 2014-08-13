clear all

%{
load EK_time_chl_wek
[yeaa,mona,daya]=jd2jdate(ac_jday);
[yeac,monc,dayc]=jd2jdate(cc_jday);
%
iwintera=find(ac_par<1.5);
iwinterc=find(cc_par<1.5);

isummera=find(ac_par>2);
isummerc=find(cc_par>2);

iwindya=find(ac_u3>600);
iwindyc=find(cc_u3>600);

icalma=find(ac_u3<600);
icalmc=find(cc_u3<600);
%
ibigc_w=find(cc_wek<=-.05 & monc>4 & monc<11);
ismallc_w=find(cc_wek>-.05 & monc>4 & monc<11);

ibigc_s=find(cc_wek<=-.05 & monc<5 | monc>10);
ismallc_s=find(cc_wek>-.05 & monc<5 | monc>10);

ibiga_w=find(ac_wek>=.076 & mona>4 & mona<11);
ismalla_w=find(ac_wek<.076 & mona>4 & mona<11);

ibiga_s=find(ac_wek>=.076 & mona<5 | mona>10);
ismalla_s=find(ac_wek<.076 & mona<5 | mona>10);

ihighc_w=find(cc_wek<=-.08 & monc>4 & monc<11);
imedc_w=find(cc_wek>-.08 & cc_wek<=-.03 & monc>4 & monc<11);
ilowc_w=find(cc_wek>-.03 & monc>4 & monc<11);

ihighc_s=find(cc_wek<=-.08 & monc<5 | monc>10);
imedc_s=find(cc_wek>-.08 & cc_wek<=-.03 & monc<5 | monc>10);
ilowc_s=find(cc_wek>-.03 & monc<5 | monc>10);

ihigha_w=find(ac_wek>=.11 & mona>4 & mona<11);
imeda_w=find(ac_wek>=.05 & ac_wek<.11 & mona>4 & mona<11);
ilowa_w=find(ac_wek<.05 & mona>4 & mona<11);

ihigha_s=find(ac_wek>=.11 & mona<5 | mona>10);
imeda_s=find(ac_wek>=.05 & ac_wek<.11  & mona<5 | mona>10);
ilowa_s=find(ac_wek<.05 & mona<5 | mona>10);

%{
iic=find(monc==1);
iia=find(mona==1);
[jan_a,jan_c]=mcomps_time_step(cat(1,ac_id(iia),cc_id(iic)),cat(1,ac_jday(iia),cc_jday(iic)));
iic=find(monc==2);
iia=find(mona==2);
[feb_a,feb_c]=mcomps_time_step(cat(1,ac_id(iia),cc_id(iic)),cat(1,ac_jday(iia),cc_jday(iic)));
iic=find(monc==3);
iia=find(mona==3);
[mar_a,mar_c]=mcomps_time_step(cat(1,ac_id(iia),cc_id(iic)),cat(1,ac_jday(iia),cc_jday(iic)));
iic=find(monc==4);
iia=find(mona==4);
[apr_a,apr_c]=mcomps_time_step(cat(1,ac_id(iia),cc_id(iic)),cat(1,ac_jday(iia),cc_jday(iic)));
iic=find(monc==5);
iia=find(mona==5);
[may_a,may_c]=mcomps_time_step(cat(1,ac_id(iia),cc_id(iic)),cat(1,ac_jday(iia),cc_jday(iic)));
iic=find(monc==6);
iia=find(mona==6);
[jun_a,jun_c]=mcomps_time_step(cat(1,ac_id(iia),cc_id(iic)),cat(1,ac_jday(iia),cc_jday(iic)));
iic=find(monc==7);
iia=find(mona==7)
[jul_a,jul_c]=mcomps_time_step(cat(1,ac_id(iia),cc_id(iic)),cat(1,ac_jday(iia),cc_jday(iic)));
iic=find(monc==8);
iia=find(mona==8);
[aug_a,aug_c]=mcomps_time_step(cat(1,ac_id(iia),cc_id(iic)),cat(1,ac_jday(iia),cc_jday(iic)));
iic=find(monc==9);
iia=find(mona==9);
[sep_a,sep_c]=mcomps_time_step(cat(1,ac_id(iia),cc_id(iic)),cat(1,ac_jday(iia),cc_jday(iic)));
iic=find(monc==10);
iia=find(mona==10);
[oct_a,oct_c]=mcomps_time_step(cat(1,ac_id(iia),cc_id(iic)),cat(1,ac_jday(iia),cc_jday(iic)));
iic=find(monc==11);
iia=find(mona==11);
[nov_a,nov_c]=mcomps_time_step(cat(1,ac_id(iia),cc_id(iic)),cat(1,ac_jday(iia),cc_jday(iic)));
iic=find(monc==12);
iia=find(mona==12);
[dec_a,dec_c]=mcomps_time_step(cat(1,ac_id(iia),cc_id(iic)),cat(1,ac_jday(iia),cc_jday(iic)));
%}
%{
[high_winter_a,high_winter_c]=mcomps_time_step(cat(1,ac_id(ihigha_w),cc_id(ihighc_w)),cat(1,ac_jday(ihigha_w),cc_jday(ihighc_w)));
[med_winter_a,med_winter_c]=mcomps_time_step(cat(1,ac_id(imeda_w),cc_id(imedc_w)),cat(1,ac_jday(imeda_w),cc_jday(imedc_w)));
[low_winter_a,low_winter_c]=mcomps_time_step(cat(1,ac_id(ilowa_w),cc_id(ilowc_w)),cat(1,ac_jday(ilowa_w),cc_jday(ilowc_w)));

[high_summer_a,high_summer_c]=mcomps_time_step(cat(1,ac_id(ihigha_s),cc_id(ihighc_s)),cat(1,ac_jday(ihigha_s),cc_jday(ihighc_s)));
[med_summer_a,med_summer_c]=mcomps_time_step(cat(1,ac_id(imeda_s),cc_id(imedc_s)),cat(1,ac_jday(imeda_s),cc_jday(imedc_s)));
[low_summer_a,low_summer_c]=mcomps_time_step(cat(1,ac_id(ilowa_s),cc_id(ilowc_s)),cat(1,ac_jday(ilowa_s),cc_jday(ilowc_s)));

[big_winter_a,big_winter_c]=mcomps_time_step(cat(1,ac_id(ibiga_w),cc_id(ibigc_w)),cat(1,ac_jday(ibiga_w),cc_jday(ibigc_w)));
[small_winter_a,small_winter_c]=mcomps_time_step(cat(1,ac_id(ismalla_w),cc_id(ismallc_w)),cat(1,ac_jday(ismalla_w),cc_jday(ismallc_w)));

[big_summer_a,big_summer_c]=mcomps_time_step(cat(1,ac_id(ibiga_s),cc_id(ibigc_s)),cat(1,ac_jday(ibiga_s),cc_jday(ibigc_s)));
[small_summer_a,small_summer_c]=mcomps_time_step(cat(1,ac_id(ismalla_s),cc_id(ismallc_s)),cat(1,ac_jday(ismalla_s),cc_jday(ismallc_s)));

%[all_rot_a,all_rot_c]=mcomps('/matlab/matlab/hovmuller/tracks/ek_cor_masked_orgin_tracks','nrw_ek_sample','w');


%[winter_a,winter_c]=mcomps_time_step(cat(1,ac_id(iwintera),cc_id(iwinterc)),cat(1,ac_jday(iwintera),cc_jday(iwinterc)));
%[summer_a,summer_c]=mcomps_time_step(cat(1,ac_id(isummera),cc_id(isummerc)),cat(1,ac_jday(isummera),cc_jday(isummerc)));

%[wind_a,wind_c]=mcomps_time_step(cat(1,ac_id(iwindya),cc_id(iwindyc)),cat(1,ac_jday(iwindya),cc_jday(iwindyc)));
%[calm_a,calm_c]=mcomps_time_step(cat(1,ac_id(icalma),cc_id(icalmc)),cat(1,ac_jday(icalma),cc_jday(icalmc)));

%[all_a,all_c]=mcomps_time_step(cat(1,ac_id,cc_id),cat(1,ac_jday,cc_jday));

[eof_winter_a,eof_winter_c]=eofcomps_time_step(cat(1,ac_id(iwintera),cc_id(iwinterc)),cat(1,ac_jday(iwintera),cc_jday(iwinterc)));
[eof_summer_a,eof_summer_c]=eofcomps_time_step(cat(1,ac_id(isummera),cc_id(isummerc)),cat(1,ac_jday(isummera),cc_jday(isummerc)));
%}
iisumc=find(monc==12 | monc>=1 & monc<=2);
iisuma=find(mona==12 | mona>=1 & mona<=2);
iifalc=find(monc>=3 & monc<=4);
iifala=find(mona>=3 & mona<=4);
iiwinc=find(monc>=5 & monc<=9);
iiwina=find(mona>=5 & mona<=9);
iisprc=find(monc>=10 & monc<=11);
iispra=find(mona>=10 & mona<=11);
%{
[eof_sum_a,eof_sum_c]=eofcomps_time_step(cat(1,ac_id(iisuma),cc_id(iisumc)),cat(1,ac_jday(iisuma),cc_jday(iisumc)));
[eof_fal_a,eof_fal_c]=eofcomps_time_step(cat(1,ac_id(iifala),cc_id(iifalc)),cat(1,ac_jday(iifala),cc_jday(iifalc)));
[eof_win_a,eof_win_c]=eofcomps_time_step(cat(1,ac_id(iiwina),cc_id(iiwinc)),cat(1,ac_jday(iiwina),cc_jday(iiwinc)));
[eof_spr_a,eof_spr_c]=eofcomps_time_step(cat(1,ac_id(iispra),cc_id(iisprc)),cat(1,ac_jday(iispra),cc_jday(iisprc)));

%[sum_a,sum_c]=mcomps_time_step(cat(1,ac_id(iisuma),cc_id(iisumc)),cat(1,ac_jday(iisuma),cc_jday(iisumc)));
%[fal_a,fal_c]=mcomps_time_step(cat(1,ac_id(iifala),cc_id(iifalc)),cat(1,ac_jday(iifala),cc_jday(iifalc)));
%}
[win_a,win_c]=mcomps_time_step(cat(1,ac_id(iiwina),cc_id(iiwinc)),cat(1,ac_jday(iiwina),cc_jday(iiwinc)));
%[spr_a,spr_c]=mcomps_time_step(cat(1,ac_id(iispra),cc_id(iisprc)),cat(1,ac_jday(iispra),cc_jday(iisprc)));

%{
[eof_all_a,eof_all_c]=eofcomps_time_step(cat(1,ac_id,cc_id),cat(1,ac_jday,cc_jday));

load /matlab/matlab/regions/tracks/tight/lw_tracks
[bp26_crlg_c,bp26_crlg_cc]=clock_comps(id,track_jday,y,'nrbp26_crlg_sample','n');
[bp26_crl_c,bp26_crl_cc]=clock_comps(id,track_jday,y,'nrbp26_crl_sample','n');
%}
save -append EK_new_comps 

return
%}
load EK_new_comps
r=9:41;
c=9:41;

%{
mon=['jan';'feb';'mar';'apr';'may';'jun';'jul';'aug';'sep';'oct';'nov';'dec'];

ran=[-.005 .005]
flc='sum_c_sp_with_wek';
tmp = double(interp2(sum_c.anom_median(r,c),2));
tmp2 = double(interp2(sum_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'cyclones in summer',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='sum_a_sp_with_wek';
tmp = double(interp2(sum_a.anom_median(r,c),2));
tmp2 = double(interp2(sum_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'anticyclones in summer',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
flc='sum_c_sp_with_ssh';
tmp = double(interp2(sum_c.anom_median(r,c),2));
tmp2 = double(interp2(sum_c.ssh_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),2,-200,200,'cyclones in summer',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='sum_a_sp_with_ssh';
tmp = double(interp2(sum_a.anom_median(r,c),2));
tmp2 = double(interp2(sum_a.ssh_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),2,-200,200,'anticyclones in summer',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 

ran=[-.07 .07]	
flc='sum_c_wek_with_wek';
tmp = double(interp2(sum_c.wek_median(r,c),2));
tmp2 = double(interp2(sum_c.wek_median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,ran(1),ran(2),.01,-1,1,'cyclones in summer',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='sum_a_wek_with_wek';
tmp = double(interp2(sum_a.wek_median(r,c),2));
tmp2 = double(interp2(sum_a.wek_median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,ran(1),ran(2),.01,-1,1,'anticyclones in summer',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
ran=[-.2 .2]	
flc='sum_c_sst_with_wek';
tmp = double(interp2(sum_c.sst_median(r,c),2));
tmp2 = double(interp2(sum_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'cyclones in summer',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='sum_a_sst_with_wek';
tmp = double(interp2(sum_a.sst_median(r,c),2));
tmp2 = double(interp2(sum_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'anticyclones in summer',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 	
return
	
	return
%
ran=[-.4 .4]
flc='win_c_sst_with_wek';
tmp = double(interp2(win_c.sst_median(r,c),2));
tmp2 = double(interp2(win_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'SST cyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='win_a_sst_with_ssh';
tmp = double(interp2(win_a.sst_median(r,c),2));
tmp2 = double(interp2(win_a.ssh_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),2,-200,200,'SST anticyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla])
	
flc='win_c_sst_with_ssh';
tmp = double(interp2(win_c.sst_median(r,c),2));
tmp2 = double(interp2(win_c.ssh_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),2,-200,200,'SST cyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc])


fla='win_a_sst_with_wek';
tmp = double(interp2(win_a.sst_median(r,c),2));
tmp2 = double(interp2(win_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'SST anticyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 	
%}
ran=[-.0007 .0007]
flc='win_c_cc_with_wek';
tmp = double(interp2(win_c.cc_median(r,c),2));
tmp2 = double(interp2(win_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'CHL:C cyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='win_a_cc_with_ssh';
tmp = double(interp2(win_a.cc_median(r,c),2));
tmp2 = double(interp2(win_a.ssh_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),2,-200,200,'CHL:C anticyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla])
	
flc='win_c_cc_with_ssh';
tmp = double(interp2(win_c.cc_median(r,c),2));
tmp2 = double(interp2(win_c.ssh_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),2,-200,200,'CHL:C cyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc])


fla='win_a_cc_with_wek';
tmp = double(interp2(win_a.cc_median(r,c),2));
tmp2 = double(interp2(win_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'CHL:C anticyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 	

ran=[-.4 .4]
flc='win_c_c_with_wek';
tmp = double(interp2(win_c.car_median(r,c),2));
tmp2 = double(interp2(win_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'C cyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='win_a_c_with_wek';
tmp = double(interp2(win_a.car_median(r,c),2));
tmp2 = double(interp2(win_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'C anticyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
ran=[-.005 .005]
flc='win_c_sp_with_wek';
tmp = double(interp2(win_c.anom_median(r,c),2));
tmp2 = double(interp2(win_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'CHL cyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='win_a_sp_with_wek';
tmp = double(interp2(win_a.anom_median(r,c),2));
tmp2 = double(interp2(win_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'CHL anticyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
flc='win_c_sp_with_ssh';
tmp = double(interp2(win_c.anom_median(r,c),2));
tmp2 = double(interp2(win_c.ssh_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),2,-200,200,'CHL cyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='win_a_sp_with_ssh';
tmp = double(interp2(win_a.anom_median(r,c),2));
tmp2 = double(interp2(win_a.ssh_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),2,-200,200,'CHL anticyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 

ran=[-.07 .07]	
flc='win_c_wek_with_wek';
tmp = double(interp2(win_c.wek_median(r,c),2));
tmp2 = double(interp2(win_c.wek_median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,ran(1),ran(2),.01,-1,1,'W_E^ cyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='win_a_wek_with_wek';
tmp = double(interp2(win_a.wek_median(r,c),2));
tmp2 = double(interp2(win_a.wek_median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,ran(1),ran(2),.01,-1,1,'W_E^ anticyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
ran=[-.07 .07]	
flc='win_c_wek_with_wek';
tmp = double(interp2(win_c.wek_median(r,c),2));
tmp2 = double(interp2(win_c.wek_median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,ran(1),ran(2),.01,-1,1,'W_E^ cyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='win_a_wek_with_wek';
tmp = double(interp2(win_a.wek_median(r,c),2));
tmp2 = double(interp2(win_a.wek_median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,ran(1),ran(2),.01,-1,1,'W_E^ anticyclones',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 	
	
return
%{
flc='fal_c_sp_with_wek';
tmp = double(interp2(spr_c.anom_median(r,c),2));
tmp2 = double(interp2(spr_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'cyclones in spring',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='fal_a_sp_with_wek';
tmp = double(interp2(spr_a.anom_median(r,c),2));
tmp2 = double(interp2(spr_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'anticyclones in spring',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
flc='sum_c_sp_with_wek';
tmp = double(interp2(sum_c.anom_median(r,c),2));
tmp2 = double(interp2(sum_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'cyclones in summer',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='sum_a_sp_with_wek';
tmp = double(interp2(sum_a.anom_median(r,c),2));
tmp2 = double(interp2(sum_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'anticyclones in summer',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
flc='fal_c_sp_with_wek';
tmp = double(interp2(fal_c.anom_median(r,c),2));
tmp2 = double(interp2(fal_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'cyclones in fall',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 


fla='fal_a_sp_with_wek';
tmp = double(interp2(fal_a.anom_median(r,c),2));
tmp2 = double(interp2(fal_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.01,-1,1,'anticyclones in fall',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 	
return
%}
for m=1:length(mon)
	ran=[-.3 .3];
	%{
	fbc=[mon(m,:),'_a.sst_median(r,c)'];
	fbc2=[mon(m,:),'_a.wek_median(r,c)'];
	eval(['fbc=double(interp2(',fbc,'));'])
	eval(['fbc2=double(interp2(',fbc2,'));'])
	cplot_comps_cont_2_2(fbc,fbc2,ran(1),ran(2),.01,-1,1,[mon(m,:),'  anticyclones'],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/sst/',mon(m,:),'_a']) 

	fbc=[mon(m,:),'_c.sst_median(r,c)'];
	fbc2=[mon(m,:),'_c.wek_median(r,c)'];
	eval(['fbc=double(interp2(',fbc,'));'])
	eval(['fbc2=double(interp2(',fbc2,'));'])
	cplot_comps_cont_2_2(fbc,fbc2,ran(1),ran(2),.01,-1,1,[mon(m,:),'  cyclones'],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/sst/',mon(m,:),'_c']) 
	
	%}
	ran=[-.02 .02]
	fbc=[mon(m,:),'_a.cc_median(r,c)'];
	fbc2=[mon(m,:),'_a.wek_median(r,c)'];
	eval(['fbc=double(interp2(',fbc,'));'])
	eval(['fbc2=double(interp2(',fbc2,'));'])
	cplot_comps_cont_2_2(fbc,fbc2,ran(1),ran(2),.01,-1,1,[mon(m,:),'  anticyclones'],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/full_cc/',mon(m,:),'_a']) 

	fbc=[mon(m,:),'_c.cc_median(r,c)'];
	fbc2=[mon(m,:),'_c.wek_median(r,c)'];
	eval(['fbc=double(interp2(',fbc,'));'])
	eval(['fbc2=double(interp2(',fbc2,'));'])
	cplot_comps_cont_2_2(fbc,fbc2,ran(1),ran(2),.01,-1,1,[mon(m,:),'  cyclones'],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/full_cc/',mon(m,:),'_c']) 
	%{
	ran=[-.4 .4]
		fbc=[mon(m,:),'_a.car_median(r,c)'];
	fbc2=[mon(m,:),'_a.wek_median(r,c)'];
	eval(['fbc=double(interp2(',fbc,'));'])
	eval(['fbc2=double(interp2(',fbc2,'));'])
	cplot_comps_cont_2_2(fbc,fbc2,ran(1),ran(2),.01,-1,1,[mon(m,:),'  anticyclones'],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/car/',mon(m,:),'_a']) 

	fbc=[mon(m,:),'_c.car_median(r,c)'];
	fbc2=[mon(m,:),'_c.wek_median(r,c)'];
	eval(['fbc=double(interp2(',fbc,'));'])
	eval(['fbc2=double(interp2(',fbc2,'));'])
	cplot_comps_cont_2_2(fbc,fbc2,ran(1),ran(2),.01,-1,1,[mon(m,:),'  cyclones'],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/car/',mon(m,:),'_c']) 
		ran=[-.005 .005]
	fbc=[mon(m,:),'_a.anom_median(r,c)'];
	fbc2=[mon(m,:),'_a.wek_median(r,c)'];
	eval(['fbc=double(interp2(',fbc,'));'])
	eval(['fbc2=double(interp2(',fbc2,'));'])
	cplot_comps_cont_2_2(fbc,fbc2,ran(1),ran(2),.01,-1,1,[mon(m,:),'  anticyclones'],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/sp/',mon(m,:),'_a']) 
	%
	figure(1)
	clf
	pcolor(double(fbc))
	shading flat;axis image
	drawnow
	eval(['print -dpng -r300 ',['~/Documents/OSU/figures/eddy-wind/EK_comps/sp/',mon(m,:),'_a']])
	%

	fbc=[mon(m,:),'_c.anom_median(r,c)'];
	fbc2=[mon(m,:),'_c.wek_median(r,c)'];
	eval(['fbc=double(interp2(',fbc,'));'])
	eval(['fbc2=double(interp2(',fbc2,'));'])
	cplot_comps_cont_2_2(fbc,fbc2,ran(1),ran(2),.01,-1,1,[mon(m,:),'  cyclones'],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/sp/',mon(m,:),'_c']) 
	%{
	figure(1)
	clf
	pcolor(double(fbc))
	shading flat;axis image
	drawnow
	eval(['print -dpng -r300 ',['~/Documents/OSU/figures/eddy-wind/EK_comps/sp/',mon(m,:),'_c']])
	%}
	%}
	%}
end
return
%}

fnc='all_c.wek_N';
fmc='all_c.wek_n_max_sample';
fbc='all_c.wek_median';
fbc2='all_c.wek_median';
flc='all_c_wek_wek_with_wek';
tmp = double(interp2(all_c.wek_median(r,c),2));
tmp2 = double(interp2(all_c.wek_median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-1,-.01,'QuikSCAT Ekman downwelling',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='all_a.wek_N';
fma='all_a.wek_n_max_sample';
fba='all_a.wek_median';
fba2='all_a.wek_median';
fla='all_a_wek_wek_with_wek';
tmp = double(interp2(all_a.wek_median(r,c),2));
tmp2 = double(interp2(all_a.wek_median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,.01,1,'QuikSCAT Ekman upwelling',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
fnc='big_winter_a.raw_N';
fmc='big_winter_a.raw_n_max_sample';
fbc='big_winter_a.raw_median';
fbc2='big_winter_a.wek_median';
flc='big_winter_a_raw_raw_with_wek';
tmp = double(interp2(big_winter_a.raw_median(r,c),2));
tmp2 = double(interp2(big_winter_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.01,.01,1,'Ekman pumping >= 7.6 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fnc='small_winter_a.raw_N';
fmc='small_winter_a.raw_n_max_sample';
fbc='small_winter_a.raw_median';
fbc2='small_winter_a.wek_median';
flc='small_winter_a_raw_raw_with_wek';
tmp = double(interp2(small_winter_a.raw_median(r,c),2));
tmp2 = double(interp2(small_winter_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.005,.01,1,'Ekman pumping < 7.6 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
fnc='big_winter_c.raw_N';
fmc='big_winter_c.raw_n_max_sample';
fbc='big_winter_c.raw_median';
fbc2='big_winter_c.wek_median';
flc='big_winter_c_raw_raw_with_wek';
tmp = double(interp2(big_winter_c.raw_median(r,c),2));
tmp2 = double(interp2(big_winter_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.01,-1,-.01,'Ekman pumping <= -5 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fnc='small_winter_c.raw_N';
fmc='small_winter_c.raw_n_max_sample';
fbc='small_winter_c.raw_median';
fbc2='small_winter_c.wek_median';
flc='small_winter_c_raw_raw_with_wek';
tmp = double(interp2(small_winter_c.raw_median(r,c),2));
tmp2 = double(interp2(small_winter_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.005,-1,-.01,'Ekman pumping > -5 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
fnc='big_summer_a.raw_N';
fmc='big_summer_a.raw_n_max_sample';
fbc='big_summer_a.raw_median';
fbc2='big_summer_a.wek_median';
flc='big_summer_a_raw_raw_with_wek';
tmp = double(interp2(big_summer_a.raw_median(r,c),2));
tmp2 = double(interp2(big_summer_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.01,.01,1,'Ekman pumping >= 7.6 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fnc='small_summer_a.raw_N';
fmc='small_summer_a.raw_n_max_sample';
fbc='small_summer_a.raw_median';
fbc2='small_summer_a.wek_median';
flc='small_summer_a_raw_raw_with_wek';
tmp = double(interp2(small_summer_a.raw_median(r,c),2));
tmp2 = double(interp2(small_summer_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.005,.01,1,'Ekman pumping < 7.6 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
fnc='big_summer_c.raw_N';
fmc='big_summer_c.raw_n_max_sample';
fbc='big_summer_c.raw_median';
fbc2='big_summer_c.wek_median';
flc='big_summer_c_raw_raw_with_wek';
tmp = double(interp2(big_summer_c.raw_median(r,c),2));
tmp2 = double(interp2(big_summer_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.01,-1,-.01,'Ekman pumping <= -5 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fnc='small_summer_c.raw_N';
fmc='small_summer_c.raw_n_max_sample';
fbc='small_summer_c.raw_median';
fbc2='small_summer_c.wek_median';
flc='small_summer_c_raw_raw_with_wek';
tmp = double(interp2(small_summer_c.raw_median(r,c),2));
tmp2 = double(interp2(small_summer_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.005,-1,-.01,'Ekman pumping > -5 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 	
	
fnc='med_winter_a.raw_N';
fmc='med_winter_a.raw_n_max_sample';
fbc='med_winter_a.raw_median';
fbc2='med_winter_a.wek_median';
flc='med_winter_a_raw_raw_with_wek';
tmp = double(interp2(med_winter_a.raw_median(r,c),2));
tmp2 = double(interp2(med_winter_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.01,.01,1,'Ekman pumping >= 5 and < 11 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
fnc='high_winter_a.raw_N';
fmc='high_winter_a.raw_n_max_sample';
fbc='high_winter_a.raw_median';
fbc2='high_winter_a.wek_median';
flc='high_winter_a_raw_raw_with_wek';
tmp = double(interp2(high_winter_a.raw_median(r,c),2));
tmp2 = double(interp2(high_winter_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.006,.006,.02,.01,1,'Ekman pumping >= 11 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
	
fnc='low_winter_a.raw_N';
fmc='low_winter_a.raw_n_max_sample';
fbc='low_winter_a.raw_median';
fbc2='low_winter_a.wek_median';
flc='low_winter_a_raw_raw_with_wek';
tmp = double(interp2(low_winter_a.raw_median(r,c),2));
tmp2 = double(interp2(low_winter_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.004,.004,.005,.005,1,'Ekman pumping < 5 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
fnc='low_winter_c.raw_N';
fmc='low_winter_c.raw_n_max_sample';
fbc='low_winter_c.raw_median';
fbc2='low_winter_c.wek_median';
flc='low_winter_c_raw_raw_with_wek';
tmp = double(interp2(low_winter_c.raw_median(r,c),2));
tmp2 = double(interp2(low_winter_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.004,.004,.005,-1,-.005,'Ekman pumping > -3 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fnc='high_winter_c.raw_N';
fmc='high_winter_c.raw_n_max_sample';
fbc='high_winter_c.raw_median';
fbc2='high_winter_c.wek_median';
flc='high_winter_c_raw_raw_with_wek';
tmp = double(interp2(high_winter_c.raw_median(r,c),2));
tmp2 = double(interp2(high_winter_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.006,.006,.02,-1,-.01,'Ekman pumping <= -8 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fnc='med_winter_c.raw_N';
fmc='med_winter_c.raw_n_max_sample';
fbc='med_winter_c.raw_median';
fbc2='med_winter_c.wek_median';
flc='med_winter_c_raw_raw_with_wek';
tmp = double(interp2(med_winter_c.raw_median(r,c),2));
tmp2 = double(interp2(med_winter_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.01,-1,-.01,'Ekman pumping <= -3 and > -8 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
fnc='med_summer_c.raw_N';
fmc='med_summer_c.raw_n_max_sample';
fbc='med_summer_c.raw_median';
fbc2='med_summer_c.wek_median';
flc='med_summer_c_raw_raw_with_wek';
tmp = double(interp2(med_summer_c.raw_median(r,c),2));
tmp2 = double(interp2(med_summer_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.01,-1,-.01,'Ekman pumping <= -3 and > -8 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
fnc='high_summer_c.raw_N';
fmc='high_summer_c.raw_n_max_sample';
fbc='high_summer_c.raw_median';
fbc2='high_summer_c.wek_median';
flc='high_summer_c_raw_raw_with_wek';
tmp = double(interp2(high_summer_c.raw_median(r,c),2));
tmp2 = double(interp2(high_summer_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.006,.006,.02,-1,-.01,'Ekman pumping <= -8 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fnc='med_summer_a.raw_N';
fmc='med_summer_a.raw_n_max_sample';
fbc='med_summer_a.raw_median';
fbc2='med_summer_a.wek_median';
flc='med_summer_a_raw_raw_with_wek';
tmp = double(interp2(med_summer_a.raw_median(r,c),2));
tmp2 = double(interp2(med_summer_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.01,.01,1,'Ekman pumping >= 5 and < 11 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
fnc='high_summer_a.raw_N';
fmc='high_summer_a.raw_n_max_sample';
fbc='high_summer_a.raw_median';
fbc2='high_summer_a.wek_median';
flc='high_summer_a_raw_raw_with_wek';
tmp = double(interp2(high_summer_a.raw_median(r,c),2));
tmp2 = double(interp2(high_summer_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.006,.006,.01,.02,1,'Ekman pumping >= 11 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
	
fnc='low_summer_c.raw_N';
fmc='low_summer_c.raw_n_max_sample';
fbc='low_summer_c.raw_median';
fbc2='low_summer_c.wek_median';
flc='low_summer_c_raw_raw_with_wek';
tmp = double(interp2(low_summer_c.raw_median(r,c),2));
tmp2 = double(interp2(low_summer_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.004,.004,.005,-1,-.005,'Ekman pumping > -3 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fnc='low_summer_a.raw_N';
fmc='low_summer_a.raw_n_max_sample';
fbc='low_summer_a.raw_median';
fbc2='low_summer_a.wek_median';
flc='low_summer_a_raw_raw_with_wek';
tmp = double(interp2(low_summer_a.raw_median(r,c),2));
tmp2 = double(interp2(low_summer_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.004,.004,.005,.005,1,'Ekman pumping < 5 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc])
	
	
fnc='med_summer_c.raw_N';
fmc='med_summer_c.raw_n_max_sample';
fbc='med_summer_c.raw_median';
fbc2='med_summer_c.wek_median';
flc='med_summer_c_raw_raw_with_wek';
tmp = double(interp2(med_summer_c.raw_median(r,c),2));
tmp2 = double(interp2(med_summer_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.005,.005,.01,-1,0,'Ekman pumping <= -3 and > -8 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
	
fnc='high_summer_c.raw_N';
fmc='high_summer_c.raw_n_max_sample';
fbc='high_summer_c.raw_median';
fbc2='high_summer_c.wek_median';
flc='high_summer_c_raw_raw_with_wek';
tmp = double(interp2(high_summer_c.raw_median(r,c),2));
tmp2 = double(interp2(high_summer_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.006,.006,.02,-1,0,'Ekman pumping <= -11 cm d^-1 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 
%{

fnc='winter_c.sst_N';
fmc='winter_c.sst_n_max_sample';
fbc='winter_c.sst_median';
fbc2='winter_c.sst_median';
flc='winter_c_sst_sst_with_sst';
tmp = double(interp2(winter_c.sst_median(r,c),2));
tmp2 = double(interp2(winter_c.sst_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.3,.3,.1,-1,1,'CHL cyclones PAR < 1.5 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='winter_a.sst_N';
fma='winter_a.sst_n_max_sample';
fba='winter_a.sst_median';
fba2='winter_a.sst_median';
fla='winter_a_sst_sst_with_sst';
tmp = double(interp2(winter_a.sst_median(r,c),2));
tmp2 = double(interp2(winter_a.sst_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.3,.3,.1,-1,1,'CHL anticyclones PAR < 1.5 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
fnc='summer_c.sst_N';
fmc='summer_c.sst_n_max_sample';
fbc='summer_c.sst_median';
fbc2='summer_c.sst_median';
flc='summer_c_sst_sst_with_sst';
tmp = double(interp2(summer_c.sst_median(r,c),2));
tmp2 = double(interp2(summer_c.sst_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.3,.3,.1,-1,1,'CHL cyclones PAR > 2 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='summer_a.sst_N';
fma='summer_a.sst_n_max_sample';
fba='summer_a.sst_median';
fba2='summer_a.sst_median';
fla='summer_a_sst_sst_with_sst';
tmp = double(interp2(summer_a.sst_median(r,c),2));
tmp2 = double(interp2(summer_a.sst_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.3,.3,.1,-1,1,'CHL anticyclones PAR > 2 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
fnc='winter_c.ssh_N';
fmc='winter_c.ssh_n_max_sample';
fbc='winter_c.ssh_median';
fbc2='winter_c.ssh_median';
flc='winter_c_ssh_ssh_with_ssh';
tmp = double(interp2(winter_c.ssh_median(r,c),2));
tmp2 = double(interp2(winter_c.ssh_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-15,15,3,-30,0,'CHL cyclones PAR < 1.5 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='winter_a.ssh_N';
fma='winter_a.ssh_n_max_sample';
fba='winter_a.ssh_median';
fba2='winter_a.ssh_median';
fla='winter_a_ssh_ssh_with_ssh';
tmp = double(interp2(winter_a.ssh_median(r,c),2));
tmp2 = double(interp2(winter_a.ssh_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-15,15,3,0,30,'CHL anticyclones PAR < 1.5 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
fnc='summer_c.ssh_N';
fmc='summer_c.ssh_n_max_sample';
fbc='summer_c.ssh_median';
fbc2='summer_c.ssh_median';
flc='summer_c_ssh_ssh_with_ssh';
tmp = double(interp2(summer_c.ssh_median(r,c),2));
tmp2 = double(interp2(summer_c.ssh_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-15,15,3,-30,0,'CHL cyclones PAR > 2 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='summer_a.ssh_N';
fma='summer_a.ssh_n_max_sample';
fba='summer_a.ssh_median';
fba2='summer_a.ssh_median';
fla='summer_a_ssh_ssh_with_ssh';
tmp = double(interp2(summer_a.ssh_median(r,c),2));
tmp2 = double(interp2(summer_a.ssh_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-15,15,3,0,30,'CHL anticyclones PAR > 2 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
fnc='winter_c.raw_N';
fmc='winter_c.raw_n_max_sample';
fbc='winter_c.raw_median';
fbc2='winter_c.wek_median';
flc='winter_c_raw_raw_with_wek';
tmp = double(interp2(winter_c.raw_median(r,c),2));
tmp2 = double(interp2(winter_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.004,.004,.01,-1,0,'CHL cyclones PAR < 1.5 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='winter_a.raw_N';
fma='winter_a.raw_n_max_sample';
fba='winter_a.raw_median';
fba2='winter_a.wek_median';
fla='winter_a_raw_raw_with_wek';
tmp = double(interp2(winter_a.raw_median(r,c),2));
tmp2 = double(interp2(winter_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.004,.004,.01,0,1,'CHL anticyclones PAR < 1.5 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
fnc='summer_c.raw_N';
fmc='summer_c.raw_n_max_sample';
fbc='summer_c.raw_median';
fbc2='summer_c.wek_median';
flc='summer_c_raw_raw_with_wek';
tmp = double(interp2(summer_c.raw_median(r,c),2));
tmp2 = double(interp2(summer_c.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.004,.004,.01,-1,0,'CHL cyclones PAR > 2 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='summer_a.raw_N';
fma='summer_a.raw_n_max_sample';
fba='summer_a.raw_median';
fba2='summer_a.wek_median';
fla='summer_a_raw_raw_with_wek';
tmp = double(interp2(summer_a.raw_median(r,c),2));
tmp2 = double(interp2(summer_a.wek_median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.004,.004,.01,.006,1,'CHL anticyclones PAR > 2 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 	
	
fnc='winter_c.wek_N';
fmc='winter_c.wek_n_max_sample';
fbc='winter_c.wek_median';
fbc2='winter_c.wek_median';
flc='winter_c_wek_wek_with_wek';
tmp = double(interp2(winter_c.wek_median(r,c),2));
tmp2 = double(interp2(winter_c.wek_median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-1,0,'CHL cyclones PAR < 1.5 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='winter_a.wek_N';
fma='winter_a.wek_n_max_sample';
fba='winter_a.wek_median';
fba2='winter_a.wek_median';
fla='winter_a_wek_wek_with_wek';
tmp = double(interp2(winter_a.wek_median(r,c),2));
tmp2 = double(interp2(winter_a.wek_median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,0,1,'CHL anticyclones PAR < 1.5 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 
	
fnc='summer_c.wek_N';
fmc='summer_c.wek_n_max_sample';
fbc='summer_c.wek_median';
fbc2='summer_c.wek_median';
flc='summer_c_wek_wek_with_wek';
tmp = double(interp2(summer_c.wek_median(r,c),2));
tmp2 = double(interp2(summer_c.wek_median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-1,0,'CHL cyclones PAR > 2 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',flc]) 

fna='summer_a.wek_N';
fma='summer_a.wek_n_max_sample';
fba='summer_a.wek_median';
fba2='summer_a.wek_median';
fla='summer_a_wek_wek_with_wek';
tmp = double(interp2(summer_a.wek_median(r,c),2));
tmp2 = double(interp2(summer_a.wek_median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,.006,1,'CHL anticyclones PAR > 2 ',...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/',fla]) 		
%}

