
clear all


load tracks/midlat_tracks	
ii=find(track_jday>=2452427 & track_jday<=2455159);
ii=find(track_jday>=2452427 & track_jday<=2452427+365);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);

%make offset

a=1/3
wx= (sum(-a + (a+a).*rand(3,length(x))));
wy= (sum(-a + (a+a).*rand(3,length(x))));

rms=sqrt(pmean(wx.^2))
rms=sqrt(pmean(wy.^2))
return

off_x=x+wx';
off_y=y+wy';

[rot_w_ek_off_a,rot_w_ek_off_c]=comps(off_x,off_y,cyc,k,id,track_jday,scale,'hp_wek_crlg_week','~/data/QuickScat/ULTI_mat/QSCAT_30_25km_','w');
save -append FIANL_wind_midlat_rot_comps rot_*



load FIANL_wind_midlat_rot_comps

pcomps_raw2(rot_w_ek_off_c.mean,smoothn(rot_w_ek_off_c.mean,2),[-10 10],-100,1,100,['simulated Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_off_c_mean'])

pcomps_raw2(rot_w_ek_off_a.mean,smoothn(rot_w_ek_off_a.mean,2),[-10 10],-100,1,100,['simulated Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_off_a_mean'])

