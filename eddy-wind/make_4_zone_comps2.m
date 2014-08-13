clear all

mon=['jan';'feb';'mar';'apr';'may';'jun';'jul';'aug';'sep';'oct';'nov';'dec'];



for rr=1:4
    load ~/matlab/regions/tracks/tight/lw_tracks x y cyc id track_jday scale k
    
    if rr==1
        ii=find(track_jday>=2451911 & track_jday<=2455137 & x<80);
    elseif rr==2
        ii=find(track_jday>=2451911 & track_jday<=2455137 & x>80 & x<94);
    elseif rr==3
        ii=find(track_jday>=2451911 & track_jday<=2455137 & x>94 & x<108);
    elseif rr==4
        ii=find(track_jday>=2451911 & track_jday<=2455137 & x>108);
    end
    
    x=x(ii);
    y=y(ii);
    cyc=cyc(ii);
    id=id(ii);
    track_jday=track_jday(ii);
    scale=scale(ii);
    k=k(ii);
    [yeaa,mona,daya]=jd2jdate(track_jday);
    
    for n=1:2
        if n==1
            ii=find(mona>=7 & mona<=8);
            [lw_win_chl_a,lw_win_chl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),'sp66_chl','~/data/gsm/mat/GSM_9_21_','n');
            [lw_win_ddchl_a,lw_win_ddchl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),'sp66_chl','~/data/gsm/mat/GSM_9_21_','dd');
        elseif n==2
            ii=find(mona>=1 & mona<=2);
            [lw_sum_chl_a,lw_sum_chl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),'sp66_chl','~/data/gsm/mat/GSM_9_21_','n');
            [lw_sum_ddchl_a,lw_sum_ddchl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),'sp66_chl','~/data/gsm/mat/GSM_9_21_','dd');
        end
    end
    eval(['save new_4_zone_comp_season_',num2str(rr)])
end
return


for rr=1:4
    eval(['load 4_zone_comp_season_',num2str(rr)])
        
        nn=['lw_win_chl_a.n_max_sample'];
        eval(['lab=num2str(', nn,');'])
        pcomps_raw(lw_win_chl_a.median,lw_win_wek_a.median,[-.008 .008],-1,.01,1,['N=',num2str(lab)],1,40)
        eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/3_zone2/',num2str(rr),'/lw_win_a'])
         
        nn=['lw_sum_chl_a.n_max_sample'];
        eval(['lab=num2str(', nn,');'])
        pcomps_raw(lw_sum_chl_a.median,lw_sum_wek_a.median,[-.008 .008],-1,.01,1,['N=',num2str(lab)],1,40)
        eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/3_zone2/',num2str(rr),'/lw_sum_a'])

        nn=['lw_win_chl_c.n_max_sample'];
        eval(['lab=num2str(', nn,');'])
        pcomps_raw(lw_win_chl_c.median,lw_win_wek_c.median,[-.008 .008],-1,.01,1,['N=',num2str(lab)],1,40)
        eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/3_zone2/',num2str(rr),'/lw_win_c'])
         
        nn=['lw_sum_chl_c.n_max_sample'];
        eval(['lab=num2str(', nn,');'])
        pcomps_raw(lw_sum_chl_c.median,lw_sum_wek_c.median,[-.008 .008],-1,.01,1,['N=',num2str(lab)],1,40)
        eval(['print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/FINAL_comps/3_zone2/',num2str(rr),'/lw_sum_c'])
end