clear all

startjd=2451556;
endjd=2454461;
%cd //matlab/matlab/hovmuller

load /matlab/matlab/woa/woa05 lat lon MLD NC
load /matlab/matlab/argo/eddy_UCSD_mld_index
wlat=lat;
wlon=lon;


load /matlab/matlab/regions/tracks/tight/lw_tracks

f1=find(track_jday>=startjd & track_jday<=endjd);
id=id(f1);
track_jday=track_jday(f1);
b=1;
jdays=[min(track_jday):7:max(track_jday)];
lj=length(jdays);
lid=length(id);

% Create indicies
uid=unique(id);
ic = length(find(id<nneg));
ia = length(find(id>=nneg));

ac_chl=double(nan(ia,1));
cc_chl=double(nan(ic,1));
ac_x=ac_chl;
ac_jday=ac_chl;
cc_jday=cc_chl;
ac_ncd=ac_chl;
cc_ncd=cc_chl;
ac_u3=ac_chl;
cc_u3=cc_chl;
ac_y=ac_chl;
cc_x=cc_chl;
cc_y=cc_chl;
ac_r_chl_wek=ac_chl;
cc_r_chl_wek=cc_chl;
ac_r_chl_ssh=ac_chl;
cc_r_chl_ssh=cc_chl;
ac_N_r_chl_wek=ac_chl;
ac_Sig_r_chl_wek=ac_chl;
cc_N_r_chl_wek=cc_chl;
cc_Sig_r_chl_wek=cc_chl;
ac_N_r_chl_ssh=ac_chl;
ac_Sig_r_chl_ssh=ac_chl;
cc_N_r_chl_ssh=cc_chl;
cc_Sig_r_chl_ssh=cc_chl;
ac_raw=ac_chl;
cc_raw=cc_chl;
ac_mld=ac_chl;
cc_mld=cc_chl;
ac_amld=ac_chl;
cc_amld=cc_chl;
ac_k=ac_chl;
cc_k=cc_chl;
ac_wek=ac_chl;
cc_wek=cc_chl;
ac_par=ac_chl;
cc_par=cc_chl;
ac_id=ac_chl;
cc_id=cc_chl;
ac_amp=ac_chl;
cc_amp=cc_chl;
ac_scale=ac_chl;
cc_scale=cc_chl;
ac_car=ac_chl;
cc_car=cc_chl;
ac_log=ac_chl;
cc_log=cc_chl;

zza=1;
zzc=1;

%mask only cores
zgrid_grid
ii=find(dist<=.5);
mask_up=nan(81,81);
mask_up(ii)=1;
mask_dn=mask_up;

for m=1:length(jdays)
	fprintf('\r  Sampling -- file %3u of %3u \r',m,length(jdays))
	load(['/matlab/matlab/global/trans_samp/TRANS_W_NOR_',num2str(jdays(m))],...
	'id_index','k_index','nrw_ek_sample','nrbp26_chl_sample','nrsp66_chl_sample',...
	'nru3_week_sample','nrgchl_week_sample','nrsp66_car_sample','nrssh_sample',...
	'amp_index','x_index','y_index','scale_index')
	
	day_id=unique(id(track_jday==jdays(m)));
    
    ii=sames(day_id,id_index);
    if any(ii)
        for pp=1:length(ii)
        	[y,im,d]=jd2jdate(jdays(m));
            obs=nrw_ek_sample(:,:,ii(pp));
            
            if id_index(ii(pp))>=nneg;
            	ttu=nrsp66_chl_sample(:,:,ii(pp));
            	tt=nrbp26_chl_sample(:,:,ii(pp));
            	ac_chl(zza)=nanmean(tt(:));
            	%tt=nrgpar_week_sample(:,:,ii(pp));
            	%ac_par(zza)=nanmean(tt(:));
            	ac_raw(zza)=nanmean(ttu(:));
            	tt=nru3_week_sample(:,:,ii(pp));
            	ac_u3(zza)=nanmean(tt(:));
            	ttq=nrw_ek_sample(:,:,ii(pp));
            	tts=nrssh_sample(:,:,ii(pp));
            	ac_wek(zza)=nanmean(ttq(:));
            	tt=nrgchl_week_sample(:,:,ii(pp));
            	ac_log(zza)=10^nanmean(tt(:));
            	tt=nrsp66_car_sample(:,:,ii(pp));
            	ac_car(zza)=nanmean(tt(:));
            	%[ac_r_car_wek(zza)]=pcor(ttg(itt),ttq(itt));
            	[ac_r_chl_wek(zza),Covar,ac_N_r_chl_wek(zza),ac_Sig_r_chl_wek(zza)]=pcor(ttu,ttq);
            	[ac_r_chl_ssh(zza),Covar,ac_N_r_chl_ssh(zza),ac_Sig_r_chl_ssh(zza)]=pcor(ttu,tts);
            	ac_jday(zza)=jdays(m);
            	
            	ac_k(zza)=k_index(ii(pp));
            	ac_id(zza)=id_index(ii(pp));
            	ac_amp(zza)=amp_index(ii(pp));
            	ac_scale(zza)=scale_index(ii(pp));
            	ac_x(zza)=x_index(ii(pp));
            	ac_y(zza)=y_index(ii(pp));
            	itt=find(eddy_id==id_index(ii(pp)) & eddy_pjday_round==jdays(m));
            	if any(itt)
            		ac_amld(zza)=nanmean(eddy_mld(itt));
            	end
            	zza=zza+1;
            else
            	ttu=nrsp66_chl_sample(:,:,ii(pp));
            	tt=nrbp26_chl_sample(:,:,ii(pp));
            	cc_chl(zzc)=nanmean(tt(:));
            	%tt=nrgpar_week_sample(:,:,ii(pp));
            	%cc_par(zzc)=nanmean(tt(:));
            	cc_raw(zzc)=nanmean(ttu(:));
            	tt=nru3_week_sample(:,:,ii(pp));
            	cc_u3(zzc)=nanmean(tt(:));
            	ttq=nrw_ek_sample(:,:,ii(pp));
            	tts=nrssh_sample(:,:,ii(pp));
            	cc_wek(zzc)=nanmean(ttq(:));
            	tt=nrgchl_week_sample(:,:,ii(pp));
            	cc_log(zzc)=10^nanmean(tt(:));
            	tt=nrsp66_car_sample(:,:,ii(pp));
            	cc_car(zza)=nanmean(tt(:));
            	%[ac_r_car_wek(zza)]=pcor(ttg(itt),ttq(itt));
            	[cc_r_chl_wek(zzc),Covar,cc_N_r_chl_wek(zzc),ac_Sig_r_chl_wek(zzc)]=pcor(ttu,ttq);
            	[cc_r_chl_ssh(zzc),Covar,cc_N_r_chl_ssh(zzc),ac_Sig_r_chl_ssh(zzc)]=pcor(ttu,tts);
            	cc_jday(zzc)=jdays(m);
            	
            	cc_k(zzc)=k_index(ii(pp));
            	cc_id(zzc)=id_index(ii(pp));
            	cc_amp(zzc)=amp_index(ii(pp));
            	cc_scale(zzc)=scale_index(ii(pp));
            	cc_x(zzc)=x_index(ii(pp));
            	cc_y(zzc)=y_index(ii(pp));
            	itt=find(eddy_id==id_index(ii(pp)) & eddy_pjday_round==jdays(m));
            	if any(itt)
            		cc_amld(zzc)=nanmean(eddy_mld(itt));
            	end
            	zzc=zzc+1;
   		   end
      	end
   	end
end      
fprintf('\n')

save EK_time_chl_wek cc_* ac_*
