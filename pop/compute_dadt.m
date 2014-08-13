clear all
fnames={'obs_stream_sla2','pop_stream_sla2','pop_stream_run33_sla2','obs_meanders_sla2','pop_meanders_sla2','pop_meanders_run33_sla2'};
loads={'GS_core_eddies_observed_sla','GS_core_eddies_run14_sla','GS_core_eddies_run33_sla','GS_core_meanders_observed_sla','GS_core_meanders_run14_sla','GS_core_meanders_run33_sla'};

kk=1:30;
for drap=1:length(fnames)
    clearallbut fnames drap vars loads kk
    load(loads{drap})
    
    for m=1:length(kk)
        ii=find(stream_eddies.k==kk(m) & stream_eddies.cyc==1);
        amp_a(m)=pmean(stream_eddies.amp(ii));
        amp_std_a(m)=pstd(stream_eddies.amp(ii));
        amp_n_a(m)=length(ii);
        
        ii=find(stream_eddies.k==kk(m) & stream_eddies.cyc==-1);
        amp_c(m)=pmean(stream_eddies.amp(ii));
        amp_std_c(m)=pstd(stream_eddies.amp(ii));
        amp_n_c(m)=length(ii);
    end
    
    uid=unique(stream_eddies.id(stream_eddies.cyc==1));
    [tmp_k,tmp]=deal(nan(length(uid),length(kk)));
    
    for n=1:length(uid)
        io=find(stream_eddies.id==uid(n) & stream_eddies.k==1);
        if any(io)
            for m=1:length(kk)
                ii=find(stream_eddies.id==uid(n) & stream_eddies.k==kk(m));
                if any(ii)
                    tmp(n,m)=stream_eddies.amp(ii)-stream_eddies.amp(io);
                    tmp_k(n,m)=kk(m);
                end
            end
        end
    end
    
    tmp_k(find(~isnan(tmp)))=1;
    amp_oks_a=nanmean(tmp,1);
    amp_oks_std_a=nanstd(tmp,0,1);
    amp_oks_n_a=nansum(tmp_k,1);
    
    clear uid tmp tmp_l
    uid=unique(stream_eddies.id(stream_eddies.cyc==-1));
    [tmp_k,tmp]=deal(nan(length(uid),length(kk)));
    
    for n=1:length(uid)
        io=find(stream_eddies.id==uid(n) & stream_eddies.k==1);
        if any(io)
            for m=1:length(kk)
                ii=find(stream_eddies.id==uid(n) & stream_eddies.k==kk(m));
                if any(ii)
                    tmp(n,m)=stream_eddies.amp(ii)-stream_eddies.amp(io);
                    tmp_k(n,m)=kk(m);
                end
            end
        end
    end
    
    tmp_k(find(~isnan(tmp)))=1;
    amp_oks_c=nanmean(tmp,1);
    amp_oks_std_c=nanstd(tmp,0,1);
    amp_oks_n_c=nansum(tmp_k,1);
    
    save(fnames{drap},'*_a','*_c','-append')

end
