clear all


set_regions



for mm=18%[8 7 5 19 18]
    eval(['load ',curs{mm},'_aviso_eddies aviso_eddies'])
    [ssh_a,ssh_c]=comps(aviso_eddies.x,aviso_eddies.y,aviso_eddies.cyc,aviso_eddies.k,aviso_eddies.id,aviso_eddies.track_jday,aviso_eddies.radius,'ssh','~/data/eddy/V5/mat/AVISO_25_W_','n');
    [chl_a,chl_c]=comps(aviso_eddies.x,aviso_eddies.y,aviso_eddies.cyc,aviso_eddies.k,aviso_eddies.id,aviso_eddies.track_jday,aviso_eddies.radius,'sp66_chl','~/data/gsm/mat/GSM_9_21_','n');
    
    jdays=min(aviso_eddies.track_jday):7:max(aviso_eddies.track_jday);
    [years,months,days]=jd2jdate(jdays);
    for m=1:12
        ii=find(months==m);
        jj=sames(jdays(ii),aviso_eddies.track_jday);
        [tmp_ssh_a,tmp_ssh_c]=comps(aviso_eddies.x(jj),aviso_eddies.y(jj),aviso_eddies.cyc(jj),aviso_eddies.k(jj),aviso_eddies.id(jj),aviso_eddies.track_jday(jj),aviso_eddies.radius(jj),'ssh','~/data/eddy/V5/mat/AVISO_25_W_','n');
        [tmp_chl_a,tmp_chl_c]=comps(aviso_eddies.x(jj),aviso_eddies.y(jj),aviso_eddies.cyc(jj),aviso_eddies.k(jj),aviso_eddies.id(jj),aviso_eddies.track_jday(jj),aviso_eddies.radius(jj),'sp66_chl','~/data/gsm/mat/GSM_9_21_','n');
        eval(['chl_',num2str(m),'_a=tmp_chl_a;'])
        eval(['chl_',num2str(m),'_c=tmp_chl_c;'])
        eval(['ssh_',num2str(m),'_a=tmp_ssh_a;'])
        eval(['ssh_',num2str(m),'_c=tmp_ssh_c;'])
    end
    eval(['save -append ',curs{mm},'_obs_comps ssh_* chl_*'])
end


