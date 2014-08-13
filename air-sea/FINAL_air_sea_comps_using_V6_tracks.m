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
%
%
% % % % % %
for mm=[2 6]
%     cd ~/data/eddy/V6/
%     eval(['subset_tracks_tight_ext_v6(',char(39),curs{mm},'_lat_lon',char(39),')'])
%     % %
    load(['~/data/eddy/V6/',curs{mm},'_lat_lon_tracks_V6'])
    ii=find(track_jday>=2452466 & track_jday<=2455159 & age>=12);
    ext_x=ext_x(ii);
    ext_y=ext_y(ii);
    k=k(ii);
    id=id(ii);
    track_jday=track_jday(ii);
    cyc=cyc(ii);
    scale=scale(ii);
%     cd ~/matlab/air-sea
    
    %     figure(1)
    %     clf
    %     pmap(min(ext_x)-5:max(ext_x)+5,min(ext_y)-5:max(ext_y)+5,[ext_x ext_y id cyc track_jday k],'new_tracks_starts')
    %     title(['Na=',num2str(length(find(cyc==1))),'  Nc=',num2str(length(find(cyc==-1)))])
    %     xlabel(['min jdays =',num2str(min(track_jday)),'   max jdays =',num2str(max(track_jday))])
    %     eval(['print -dpng -r300 figs/',curs{mm},'_tracks_V6'])
    %
    %     %
    eval(['[',curs{mm},'_crlg_a,',curs{mm},'_crlg_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
        char(39),'hp66_crlg',char(39),',',char(39),...
        '~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
        char(39),'n',char(39),');'])
    
    %     %
%     save(['~/matlab/air-sea/V6_',curs{mm},'_comps'],'*_a','*_c')
    save(['~/matlab/air-sea/V6_',curs{mm},'_comps'],'*_a','*_c','-append')
end
%
