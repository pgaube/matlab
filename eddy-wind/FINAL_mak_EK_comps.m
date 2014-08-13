clear all

mon=['jan';'feb';'mar';'apr';'may';'jun';'jul';'aug';'sep';'oct';'nov';'dec'];
%
%
%

load ~/data/eddy/V5/new_lw_p_lat_lon_orgin_tracks x y cyc id track_jday scale k
%load ~/matlab/regions/tracks/tight/lw_tracks x y cyc id track_jday scale k
ii=find(track_jday>=2451911 & track_jday<=2455137);
x=x(ii);
y=y(ii);
cyc=cyc(ii);
id=id(ii);
track_jday=track_jday(ii);
scale=scale(ii);
k=k(ii);
[yeaa,mona,daya]=jd2jdate(track_jday);

for n=1:12
    ii=find(mona==n);
    eval(['[lw_',num2str(n),'_noac_a,lw',...
        '_',num2str(n),'_noac_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
        char(39),'hp66_noac_chl',char(39),',',char(39),...
        '~/data/gsm/mat/GSM_9_21_',char(39),',',...
        char(39),'n',char(39),');'])
    
    eval(['[lw_',num2str(n),'_nocc_a,lw',...
        '_',num2str(n),'_nocc_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
        char(39),'hp66_nocc_chl',char(39),',',char(39),...
        '~/data/gsm/mat/GSM_9_21_',char(39),',',...
        char(39),'n',char(39),');'])
    
    eval(['[lw_',num2str(n),'_chl_a,lw',...
        '_',num2str(n),'_chl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
        char(39),'sp66_chl',char(39),',',char(39),...
        '~/data/gsm/mat/GSM_9_21_',char(39),',',...
        char(39),'n',char(39),');'])
    
    eval(['[lw_',num2str(n),'_car_a,lw',...
        '_',num2str(n),'_car_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
        char(39),'sp66_car',char(39),',',char(39),...
        '~/data/gsm/mat/GSM_9_21_',char(39),',',...
        char(39),'n',char(39),');'])
    
    eval(['[lw_',num2str(n),'_cc_a,lw',...
        '_',num2str(n),'_cc_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
        char(39),'sp66_cc',char(39),',',char(39),...
        '~/data/gsm/mat/GSM_9_21_',char(39),',',...
        char(39),'n',char(39),');'])
    
    eval(['[lw_',num2str(n),'_wek_a,lw',...
        '_',num2str(n),'_wek_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
        char(39),'w_ek',char(39),',',char(39),...
        '~/data/QuickScat/mat/QSCAT_30_25km_',char(39),',',...
        char(39),'n',char(39),');'])
end
save -append FINAL_EK_lw_p_comps


%now just winter
%{
load ~/matlab/regions/tracks/tight/lw_tracks
[yeaa,mona,daya]=jd2jdate(track_jday);
ii=find(mona>=5 & mona<=10 & track_jday>=2451911 & track_jday<=2455137);
x=x(ii);
y=y(ii);
cyc=cyc(ii);
id=id(ii);
track_jday=track_jday(ii);
scale=scale(ii);
k=k(ii);

[lw_chl_a,lw_chl_c]=comps(x,y,cyc,k,id,track_jday,scale,'sp66_chl','~/data/gsm/mat/GSM_9_21_','n');
[lw_car_a,lw_car_c]=comps(x,y,cyc,k,id,track_jday,scale,'sp66_car','~/data/gsm/mat/GSM_9_21_','n');
[lw_ccc_a,lw_ccc_c]=comps(x,y,cyc,k,id,track_jday,scale,'sp66_cc','~/data/gsm/mat/GSM_9_21_','n');
[lw_wek_a,lw_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'w_ek','~/data/QuickScat/mat/QSCAT_30_25km_','n');


save -append FINAL_EK_lw_p_comps
%}
%now plot
%
clear
load FINAL_EK_lw_p_comps
%{
fbc=lw_chl_a.median;
fbc2=lw_wek_a.median;
fbc=interp2(fbc,2);
fbc2=interp2(fbc2,2);
pcomps(fbc,fbc2,[-.004 .004],-1,.01,1,['CHL',char(39)])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/winter/sp66_chl_a

pcomps(fbc,fbc2,[-.006 .006],-1,.01,1,['median CHL',char(39),' and Ekman pumping'])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/winter/meadian_sp66_chl_a

fbc=lw_car_a.median;
fbc=interp2(fbc,2);
pcomps(fbc,fbc2,[-.4 .4],-1,.01,1,['C_{phyto}',char(39)])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/winter/sp66_car_a

fbc=lw_ccc_a.median;
fbc=interp2(fbc,2);
pcomps(fbc,fbc2,[-.0004 .0004],-1,.01,1,['CHL',char(39)])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/winter/sp66_cc_a

fbc=lw_chl_c.median;
fbc2=lw_wek_c.median;
fbc=interp2(fbc,2);
fbc2=interp2(fbc2,2);
pcomps(fbc,fbc2,[-.004 .004],-1,.01,1,['CHL',char(39)])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/winter/sp66_chl_c

pcomps(fbc,fbc2,[-.006 .006],-1,.01,1,['median CHL',char(39),' and Ekman pumping'])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/winter/meadian_sp66_chl_C

fbc=lw_car_c.median;
fbc=interp2(fbc,2);
pcomps(fbc,fbc2,[-.4 .4],-1,.01,1,['C_{phyto}',char(39)])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/winter/sp66_car_c

fbc=lw_ccc_c.median;
fbc=interp2(fbc,2);
pcomps(fbc,fbc2,[-.0004 .0004],-1,.01,1,['r_C',char(39)])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/winter/sp66_cc_c


fbc=lw_chl_a.mean;
fbc2=smoothn(lw_wek_a.median,40)+.02;
fbc=interp2(fbc,2);
fbc2=interp2(fbc2,2);
pcomps(fbc,fbc2,[-.006 .006],-1,.01,1,['mean CHL',char(39),' and Ekman pumping'])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/winter/mean_sp66_chl_a

fbc=lw_chl_c.mean;
fbc2=smoothn(lw_wek_c.median,40)-.02;
fbc=interp2(fbc,2);
fbc2=interp2(fbc2,2);
pcomps(fbc,fbc2,[-.006 .006],-1,.01,1,['mean CHL',char(39),' and Ekman pumping'])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/winter/mean_sp66_chl_c
%

fbc=lw_6_chl_a.median;
fbc2=lw_6_wek_a.median;
fbc=interp2(fbc,2);
fbc2=interp2(fbc2,2);
pcomps(fbc,fbc2,[-.01 .01],-1,.01,1,['June median anticyclones'])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/compare/meadian_sp66_chl_a

fbc=lw_6_chl_a.mean;
fbc2=lw_6_wek_a.mean;
fbc=interp2(fbc,2);
fbc2=interp2(fbc2,2);
pcomps(fbc,fbc2,[-.01 .01],-1,.01,1,['June mean anticyclones'])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/compare/mean_sp66_chl_a

fbc=lw_6_chl_c.median;
fbc2=lw_6_wek_c.median;
fbc=interp2(fbc,2);
fbc2=interp2(fbc2,2);
pcomps(fbc,fbc2,[-.01 .01],-1,.01,1,['June median cyclones'])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/compare/meadian_sp66_chl_c

fbc=lw_6_chl_c.mean;
fbc2=lw_6_wek_c.mean;
fbc=interp2(fbc,2);
fbc2=interp2(fbc2,2);
pcomps(fbc,fbc2,[-.01 .01],-1,.01,1,['June mean cyclones'])
print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/compare/mean_sp66_chl_c

%}

clear
load FINAL_EK_lw_p_comps
for n=1:12
    %
    fbc=['lw','_',num2str(n),'_chl_a.median'];
    fbc2=['lw','_',num2str(n),'_wek_a.median'];
    nn=['lw','_',num2str(n),'_chl_a.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double(interp2(',fbc,'));'])
    eval(['fbc2=double(interp2(',fbc2,'));'])
    pcomps(fbc,fbc2,[-.006 .006],-1,.01,1,[mon(n,:),' N=',num2str(lab)])
    eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/sp66_chl/lw_',num2str(n),'_a']) 

    fbc=['lw','_',num2str(n),'_chl_c.median'];
    fbc2=['lw','_',num2str(n),'_wek_c.median'];
    nn=['lw','_',num2str(n),'_chl_c.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double(interp2(',fbc,'));'])
    eval(['fbc2=double(interp2(',fbc2,'));'])
    pcomps(fbc,fbc2,[-.006 .006],-1,.01,1,[mon(n,:),' N=',num2str(lab)])
    eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/sp66_chl/lw_',num2str(n),'_c'])
    %{
    fbc=['lw','_',num2str(n),'_car_a.median'];
    fbc2=['lw','_',num2str(n),'_wek_a.median'];
    nn=['lw','_',num2str(n),'_car_a.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double(interp2(',fbc,'));'])
    eval(['fbc2=double(interp2(',fbc2,'));'])
    pcomps(fbc,fbc2,[-.4 .4],-1,.01,1,[mon(n,:),' N=',num2str(lab)])
    eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/sp66_car/lw_',num2str(n),'_a']) 

    fbc=['lw','_',num2str(n),'_car_c.median'];
    fbc2=['lw','_',num2str(n),'_wek_c.median'];
    nn=['lw','_',num2str(n),'_car_c.n_max_sample'];
    eval(['lab=num2str(', nn,');'])
    eval(['fbc=double(interp2(',fbc,'));'])
    eval(['fbc2=double(interp2(',fbc2,'));'])
    pcomps(fbc,fbc2,[-.4 .4],-1,.01,1,[mon(n,:),' N=',num2str(lab)])
    eval(['print -depsc ~/Documents/OSU/figures/eddy-wind/FINAL_lw_p_comps/sp66_car/lw_',num2str(n),'_c'])
    %}
end
