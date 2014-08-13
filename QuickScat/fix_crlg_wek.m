spath='~/data/QuickScat/mat/QSCAT_30_25km_';
jdays=[1808 1857 2165 2529 2536 2543 2557 2876 2900 2907 2921 2928 2935 2949 2956 2984 3236 3243 3264 3271 3320 3635 3649 3684 3978 4006 4370 4384 4370];

for m=1:length(jdays)
    tj=2450000+jdays(m);
    for n=1:length(tj)
        if exist([spath num2str(tj(n)) '.mat'])
            tj(n)
            load([spath num2str(tj(n))],'hp_wek_crlg_week')
            hp_wek_crlg_week=nan*hp_wek_crlg_week;
            save([spath num2str(tj(n))],'hp_wek_crlg_week','-append')
        end
    end
end

    
