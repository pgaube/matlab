clear all
fnames={'obs_stream_sla2','pop_stream_sla2','pop_stream_run33_sla2','obs_meanders_sla2','pop_meanders_sla2','pop_meanders_run33_sla2'};
loads={'GS_core_eddies_observed_sla','GS_core_eddies_run14_sla','GS_core_eddies_run33_sla','GS_core_meanders_observed_sla','GS_core_meanders_run14_sla','GS_core_meanders_run33_sla'};


for drap=[3 6]%:length(fnames)
    clearallbut fnames drap vars loads
    load(loads{drap})
    if drap==1
        %%%%now we have to inerpolate the eddy locations from 5-day POP weeks to
        %%%%7-day AVISO/CHL weeks,  FUCK!!
        
        njdays=min(stream_eddies.track_jday):7:max(stream_eddies.track_jday);
        
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
        
        %%remove bad outlier
        ii=find(nstream_eddies.id==1907)
        nstream_eddies.x(ii)=[];
        nstream_eddies.y(ii)=[];
        nstream_eddies.id(ii)=[];
        nstream_eddies.cyc(ii)=[];
        nstream_eddies.k(ii)=[];
        nstream_eddies.track_jday(ii)=[];
        nstream_eddies.radius(ii)=[];
        [ssh_a,ssh_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'ssh','~/data/eddy/V5/mat/AVISO_25_W_','n');
%         [hp66_chl_a,hp66_chl_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'sp66_chl','~/data/gsm/mat/GSM_9_21_','n');
        % [chl_a,chl_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'gchl_week','~/data/gsm/mat/GSM_9_21_','n10');
        % [mean_chl_a,mean_chl_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'gchl_week','~/data/gsm/mat/GSM_9_21_','mm');% [norm_ssh_a,norm_ssh_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'ssh','~/data/eddy/V5/mat/AVISO_25_W_','nn');
%         [norm_hp66_chl_a,norm_hp66_chl_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'sp66_chl','~/data/gsm/mat/GSM_9_21_','dd');
        
    elseif drap==4
        %%%%now we have to inerpolate the eddy locations from 5-day POP weeks to
        %%%%7-day AVISO/CHL weeks,  FUCK!!
        njdays=min(stream_eddies.track_jday):7:max(stream_eddies.track_jday);
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
        [ssh_a,ssh_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'ssh','~/data/eddy/V5/mat/AVISO_25_W_','n');
%         [hp66_chl_a,hp66_chl_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'sp66_chl','~/data/gsm/mat/GSM_9_21_','n');
        % [chl_a,chl_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'gchl_week','~/data/gsm/mat/GSM_9_21_','n10');
        % [mean_chl_a,mean_chl_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'gchl_week','~/data/gsm/mat/GSM_9_21_','mm');% [norm_ssh_a,norm_ssh_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'ssh','~/data/eddy/V5/mat/AVISO_25_W_','nn');
%         [norm_hp66_chl_a,norm_hp66_chl_c]=comps(nstream_eddies.x,nstream_eddies.y,nstream_eddies.cyc,nstream_eddies.k,nstream_eddies.id,nstream_eddies.track_jday,nstream_eddies.radius,'sp66_chl','~/data/gsm/mat/GSM_9_21_','dd');
            
    elseif drap==2 | drap==5
        [pda_268_a,dd,pda_268_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'pdens_anom',16,'n');
        [pda_317_a,dd,pda_317_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'pdens_anom',17,'n');
        [pda_381_a,dd,pda_381_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'pdens_anom',18,'n');
%         [ssh_a,dd,ssh_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp21_ssh',1,'n');
%         [norm_hp66_chl_a,dd,norm_hp66_chl_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_chl',1,'dd');
%         [hp66_chl_a,dd,hp66_chl_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_chl',1,'n');
        % [chl_a,dd,chl_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'total_chl',1,'nn');
        
    else
        [ssh_a,dd,ssh_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp21_ssh',1,'n');
%         [hp66_chl_a,dd,hp66_chl_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_chl',1,'n');
%         [norm_hp66_chl_a,dd,norm_hp66_chl_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_chl',1,'dd');
        % [chl_a,dd,chl_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'total_chl',1,'nn');
    end
%     if exist(fnames{drap})
        save(fnames{drap},'*_a','*_c','-append')
%     else
%         save(fnames{drap},'*_a','*_c')
%     end
end

