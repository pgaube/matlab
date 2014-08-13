clear all
ipath='~/data/QuickScat/mat/QSCAT_30_25km_'
spath='~/data/QuickScat/new_mat/QSCAT_30_25km_'
fpath='~/data/QuickScat/ULTI_mat/QSCAT_30_25km_'
rpath='~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_'

%Set range of dates

jdays=[2451388:7:2454713];
[year,month,day]=jd2jdate(jdays);
%loess filter

load([spath num2str(jdays(30))],'lat','lon')
ff=f_cor(lat);
ff=(8640000./(1020.*ff));
rm=f_cor(lat)./f_cor(20);
load bwr.pal
load chelle.pal
% progressbar
ddo=1;


wek_th=100
sst_th=100
spd_th=3

for m=1:length(jdays)
    yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
    calday(m) =  year(m)*10000+month(m)*100+day(m);
    fprintf('\r   filtering %08u \r',calday(m))
    load([spath num2str(jdays(m))],'hp_wek_crlg_week')
    load([fpath num2str(jdays(m))],'hp_wek_sst_week_dtdn','hp_wek_sst_week_fixed','hp66_crlstr','hp66_wspd')
    
%     
%     tp=ones(size(hp66_wspd));
%     tp(isnan(hp66_wspd))=nan;
%     tt=find(abs(hp66_wspd)>spd_th);
%     hp66_wspd(tt)=nan;tp(tt)=2;
%     sm_u_week(tt)=nan;
%     sm_v_week(tt)=nan;
%     wind_dir=rad2deg(cart2pol(sm_u_week,sm_v_week));
%     wind_dir(wind_dir<0)=180-wind_dir(wind_dir<0);
%     
    wek=ff.*hp66_crlstr;
    
    tw=ones(size(wek));
    tc=ones(size(wek));
    
    tw(isnan(wek))=nan;
    tc(isnan(wek))=nan;
    tt=find(abs(rm.*wek)>wek_th);
    tw(tt)=nan;tc(tt)=2;
    
    tw(isnan(hp_wek_crlg_week))=nan;
    tc(isnan(hp_wek_crlg_week))=nan;
    tt=find(abs(rm.*hp_wek_crlg_week)>wek_th);
    tw(tt)=nan;tc(tt)=2;
    
    
    if ~exist('hp_wek_sst_week_dtdn')
        hp_wek_sst_week_dtdn=nan*wek;
    end
%     tw(isnan(hp_wek_sst_week_dtdn))=nan;
%     tc(isnan(hp_wek_sst_week_dtdn))=nan;
    tt=find(abs(rm.*hp_wek_sst_week_dtdn)>sst_th);
    tw(tt)=nan;tc(tt)=2;
    
    hp_wek_sst_week_dtdn=tw.*hp_wek_sst_week_dtdn;
    wek=tw.*wek;
    hp_wek_crlg_week=tw.*hp_wek_crlg_week;
    
%     figure(1)
%     clf
%     subplot(211)
%     pmap(lon,lat,wek);caxis([-50 50]);colormap(bwr)
%     title(['QuikSCAT ',num2str(100*(length(find(tc==2))./length(find(tc==1)))),' removed'])
%     subplot(212)
%     pmap(lon,lat,tw);caxis([1 2]);colormap(bwr)
%     xlabel(num2str(jdays(m)))
%     eval(['print -dpng -r300 frames/confirm_QSCAT_wek/frame_',num2str(ddo)])
% 
%     
%     figure(2)
%     clf
%     subplot(211)
%     pmap(lon,lat,hp_wek_crlg_week);caxis([-50 50]);colormap(bwr)
%     title(['Current ',num2str(100*(length(find(tc==2))./length(find(tc==1)))),' removed'])
%     subplot(212)
%     pmap(lon,lat,tw);caxis([1 2]);colormap(bwr)
%     xlabel(num2str(jdays(m)))
%     eval(['print -dpng -r300 frames/confirm_cur_wek/frame_',num2str(ddo)])
% 
%     
%     figure(3)
%     clf
%     subplot(211)
%     pmap(lon,lat,hp_wek_sst_week_dtdn);caxis([-20 20]);colormap(bwr)
%     title(['SST ',num2str(100*(length(find(tc==2))./length(find(tc==1)))),' removed'])
%     subplot(212)
%     pmap(lon,lat,tw);caxis([1 2]);colormap(bwr)
%     xlabel(num2str(jdays(m)))
%     eval(['print -dpng -r300 frames/confirm_sst_wek/frame_',num2str(ddo)])
% 
%     
%     figure(4)
%     clf
%     subplot(211)
%     pmap(lon,lat,hp66_wspd);caxis([-1 1]);colormap(bwr)
%     title(['QuikSCAT ',num2str(100*(length(find(tp==2))./length(find(tp==1)))),' removed'])
%     subplot(212)
%     pmap(lon,lat,tp);caxis([1 2]);colormap(bwr)
%     xlabel(num2str(jdays(m)))
%     eval(['print -dpng -r300 frames/confirm_QSCAT_spd/frame_',num2str(ddo)])
%     
%     
%     figure(5)
%     clf
%     subplot(211)
%     pcolor(lon,lat,wind_dir);caxis([0 360]);colormap(chelle);shading flat;axis image
%     hold on
%     quiver(lon(1:30:end,1:30:end),lat(1:30:end,1:30:end),sm_u_week(1:30:end,1:30:end),sm_v_week(1:30:end,1:30:end))
%     title(['QuikSCAT ',num2str(100*(length(find(tp==2))./length(find(tp==1)))),' removed'])
%     freezeColors
%     subplot(212)
%     pmap(lon,lat,tp);caxis([1 2]);colormap(bwr)
%     xlabel(num2str(jdays(m)))
%     eval(['print -dpng -r300 frames/confirm_QSCAT_wind_dir/frame_',num2str(ddo)])


    ddo=ddo+1;
    
%     eval(['save -append ' [fpath num2str(jdays(m))] ' hp* wek'])
    eval(['save ' [rpath num2str(jdays(m))] ' lat lon *_week hp* wek'])
end


