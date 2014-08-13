clear
% 
% 
load GS_core_meanders_observed_sla
%%%%now we have to inerpolate the eddy locations from 5-day POP weeks to
%%%%7-day AVISO/CHL weeks,  FUCK!!

njdays=min(stream_eddies.track_jday):7:max(stream_eddies.track_jday);


%%%%%Fix to make sure first week falls on GSM jday
njdays=2451563:7:max(njdays);

st=0;
uid=unique(stream_eddies.id);
for m=1:length(uid)
    ii=find(stream_eddies.id==uid(m));
    jj=find(njdays>=min(stream_eddies.track_jday(ii)) & njdays<=max(stream_eddies.track_jday(ii)));

    nstream_eddies.x(st+1:st+length(jj))=interp1(stream_eddies.track_jday(ii),stream_eddies.x(ii),njdays(jj));
    nstream_eddies.y(st+1:st+length(jj))=interp1(stream_eddies.track_jday(ii),stream_eddies.y(ii),njdays(jj));
    nstream_eddies.id(st+1:st+length(jj))=interp1(stream_eddies.track_jday(ii),stream_eddies.id(ii),njdays(jj));
    nstream_eddies.cyc(st+1:st+length(jj))=interp1(stream_eddies.track_jday(ii),stream_eddies.cyc(ii),njdays(jj));
    nstream_eddies.radius(st+1:st+length(jj))=interp1(stream_eddies.track_jday(ii),stream_eddies.radius(ii),njdays(jj));
    
    nstream_eddies.track_jday(st+1:st+length(jj))=njdays(jj);
    nstream_eddies.k(st+1:st+length(jj))=1:length(jj);
    st=st+length(jj);
end




% %%Basic stuff
% [ssh_a,ssh_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'ssh','~/data/eddy/V5/mat/AVISO_25_W_','n');
% [norm_ssh_a,norm_ssh_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'ssh','~/data/eddy/V5/mat/AVISO_25_W_','nn');
[norm_hp66_chl_a,norm_hp66_chl_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'sp66_chl','~/data/gsm/mat/GSM_9_21_','dd');
[hp66_chl_a,hp66_chl_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'sp66_chl','~/data/gsm/mat/GSM_9_21_','n');
[chl_a,chl_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'gchl_week','~/data/gsm/mat/GSM_9_21_','n10');
% [mean_chl_a,mean_chl_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'gchl_week','~/data/gsm/mat/GSM_9_21_','mm');
% [norm_hp66_c_a,norm_hp66_c_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'sp66_car','~/data/gsm/mat/GSM_9_21_','cd');
save -append obs_meanders_sla
return
load obs_stream

pcomps_raw(norm_ssh_a.mean,norm_ssh_a.mean,[-1 1],-1,.1,1,'Normalized SSH AC',1,20)
print -dpng -r300 figs/obs_stream/norm_ssh_a
pcomps_raw(norm_ssh_c.mean,norm_ssh_c.mean,[-1 1],-1,.1,1,'Normalized SSH CC',1,20)
print -dpng -r300 figs/obs_stream/norm_ssh_c


pcomps_raw(norm_hp66_chl_a.mean,norm_ssh_a.mean,[-.5 .5],-1,.1,1,['CHL',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/obs_stream/norm_chl_a
pcomps_raw(norm_hp66_chl_c.mean,norm_ssh_c.mean,[-.5 .5],-1,.1,1,['CHL',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/obs_stream/norm_chl_c

