clear all
fnames={'GS_rings_tracks_run14_sla','GS_rings_tracks_run14_sla','GS_rings_tracks_run33_sla'};


for drap=1%:length(fnames)
    clearallbut fnames drap
    load(fnames{drap})
    if drap==1
        pop_eddies=aviso_eddies;
        %%%%now we have to inerpolate the eddy locations from 5-day POP weeks to
        %%%%7-day AVISO/CHL weeks,  FUCK!!
        
        njdays=min(pop_eddies.track_jday):7:max(pop_eddies.track_jday);
        
        st=0;
        uid=unique(pop_eddies.id);
        for gg=1:length(uid)
            ii=find(pop_eddies.id==uid(gg));
            if length(ii)>1
                jj=find(njdays>=min(pop_eddies.track_jday(ii)) & njdays<=max(pop_eddies.track_jday(ii)));
                
                npop_eddies.x(st+1:st+length(jj))=interp1(pop_eddies.track_jday(ii),pop_eddies.x(ii),njdays(jj));
                npop_eddies.y(st+1:st+length(jj))=interp1(pop_eddies.track_jday(ii),pop_eddies.y(ii),njdays(jj));
                npop_eddies.id(st+1:st+length(jj))=interp1(pop_eddies.track_jday(ii),pop_eddies.id(ii),njdays(jj));
                npop_eddies.cyc(st+1:st+length(jj))=interp1(pop_eddies.track_jday(ii),pop_eddies.cyc(ii),njdays(jj));
                npop_eddies.radius(st+1:st+length(jj))=interp1(pop_eddies.track_jday(ii),pop_eddies.radius(ii),njdays(jj));
                npop_eddies.amp(st+1:st+length(jj))=interp1(pop_eddies.track_jday(ii),pop_eddies.amp(ii),njdays(jj));
                
                npop_eddies.track_jday(st+1:st+length(jj))=njdays(jj);
                npop_eddies.k(st+1:st+length(jj))=1:length(jj);
                st=st+length(jj);
                %
            end
            
        end
        pop_eddies=npop_eddies;
    end
    pop_eddies.prop_dir=nan*pop_eddies.x;
    pop_eddies.dchl_dt=nan*pop_eddies.x;
    pop_eddies.da_dt=nan*pop_eddies.x;
    pop_eddies.chl=nan*pop_eddies.x;
    pop_eddies.adens=ones(size(pop_eddies.x));
    pop_eddies.adens(pop_eddies.cyc==1)=-1;
    uid=unique(pop_eddies.id);
    
    %%%add dchl/dt
    if drap==1
        [chl_a,chl_c]=comps(pop_eddies.x,pop_eddies.y,pop_eddies.cyc,pop_eddies.k,pop_eddies.id,pop_eddies.track_jday,pop_eddies.radius,'gchl_week','~/data/gsm/mat/GSM_9_21_','n10');
    elseif drap==2
        [chl_a,dd,chl_c,rr]=pop_comps_mat(pop_eddies.x,pop_eddies.y,pop_eddies.cyc,pop_eddies.k,pop_eddies.id,pop_eddies.track_jday,pop_eddies.radius,pop_eddies.adens,'total_chl',1,'n');
    else
        [chl_a,dd,chl_c,rr]=pop_comps_mat_run33(pop_eddies.x,pop_eddies.y,pop_eddies.cyc,pop_eddies.k,pop_eddies.id,pop_eddies.track_jday,pop_eddies.radius,pop_eddies.adens,'total_chl',1,'n');
    end
    
    ff=1;
    for m=1:length(pop_eddies.x)
        ii=find(chl_a.jdays == pop_eddies.track_jday(m) &...
                chl_a.id    == pop_eddies.id(m));
        if any(ii)
            pop_eddies.chl(m)=chl_a.mean_05(ii);
        else
            ii=find(chl_c.jdays == pop_eddies.track_jday(m) &...
                    chl_c.id    == pop_eddies.id(m));
            if any(ii)
                pop_eddies.chl(m)=chl_c.mean_05(ii);
            else
                missing=pop_eddies.id(ii)
                ff=ff+1;
            end
        end
    end
        
        
        proportion_missing=ff/length(pop_eddies.x)
        
        %%%comute derivates and such
        uid=unique(pop_eddies.id);
        for mm=1:length(uid)
            ii=find(pop_eddies.id==uid(mm));
            for nn=2:length(ii)
                pop_eddies.prop_dir(ii(nn))=sign(pop_eddies.x(ii(nn))-pop_eddies.x(ii(nn-1)));
                pop_eddies.da_dt(ii(nn))=(pop_eddies.amp(ii(nn))-pop_eddies.amp(ii(nn-1)))/5;
                pop_eddies.dchl_dt(ii(nn))=(pop_eddies.chl(ii(nn))-pop_eddies.chl(ii(nn-1)))/5;
            end
        end
        
        if drap==1
            aviso_eddies=pop_eddies;
            save([fnames{drap},'2'],'aviso_eddies','chl_a','chl_c','-append')
        else
            save([fnames{drap},'2'],'pop_eddies','chl_a','chl_c','-append')
        end
        
    end
    
    
