clear all

curs = {'new_SP',...
    'AGR',...
    'HAW',...
    'EIO',...
    'CAR',...
    'AGU',...
    'new_EIO',...
    'new_SEA'};

%			sst		crl	    W_E		W_Ec	W_T		W_Tc
cranges= [	.3		.4		5		1		0.5		.1		%SP		1
    .7		.7		15		2		15		2		%AGR	2
    .15		.5		10		2		1		.1		%HAW	3
    .4		.7		12		2		2		.25		%EIO	4
    .06		.5		12		2		.5		.1   	%CAR	5
    1		1		15		2		7		1       %SEA	6
    .4		.7		12		2		2		.25     %newEIO 7
    1		1		15		2		7		1 ];    %SEA2	8


% % % % %
for mm=1:6
    cd ~/data/eddy/V6/
%     eval(['subset_tracks_tight_ext_v6(',char(39),curs{mm},'_lat_lon',char(39),')'])
    % %
    load(['~/data/eddy/V6/',curs{mm},'_lat_lon_tracks_V6'])
    ii=find(track_jday>=2452571 & track_jday<=2455159 & age>=12);
    ext_x=ext_x(ii);
    ext_y=ext_y(ii);
    k=k(ii);
    id=id(ii);
    track_jday=track_jday(ii);
    cyc=cyc(ii);
    scale=scale(ii);
    cd ~/matlab/air-sea
    
    eval(['[',curs{mm},'_wek_crlg_a,',curs{mm},'_wek_crlg_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
        char(39),'hp21_wek_crlg_week',char(39),',',char(39),...
        '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
        char(39),'n',char(39),');'])
    
    save(['~/matlab/air-sea/V6_',curs{mm},'_comps'],'*_a','*_c','-append')
end

for mm=1:6
    load(['V6_',curs{mm},'_comps'])
    
    %%crl wek and crl wek
    flc='new_wek_crl_c_with_wek_crl';
    eval(['tmp = ',curs{mm},'_wek_crlg_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_crlg_c;'])
    eval(['n = ',curs{mm},'_wek_crlg_c.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='new_wek_crl_a_with_wek_crl';
    eval(['tmp = ',curs{mm},'_wek_crlg_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_crlg_a;'])
    eval(['n = ',curs{mm},'_wek_crlg_a.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    
end


