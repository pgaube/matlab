clear all
fnames={'GS_rings_tracks_run14_sla2','GS_rings_tracks_run14_sla2','GS_rings_tracks_run33_sla2'};


for drap=1:length(fnames)
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
        npop_eddies.dchl_dt=pop_eddies.dchl_dt;
        npop_eddies.da_dt=pop_eddies.da_dt;
        npop_eddies.prop_dir=pop_eddies.prop_dir;
        pop_eddies=npop_eddies;
    end
    pop_eddies.prop_speed=nan*pop_eddies.x;

        %%%comute derivates and such
        uid=unique(pop_eddies.id);
        for mm=1:length(uid)
            ii=find(pop_eddies.id==uid(mm));
            for nn=2:length(ii)
                dx=pop_eddies.x(ii(nn))-pop_eddies.x(ii(nn-1));
                pop_eddies.prop_speed(ii(nn))=111.11e5*dx*cosd(pop_eddies.y(ii(nn)))/5/24/60/60;
                pop_eddies.prop_dir(ii(nn))=sign(pop_eddies.x(ii(nn))-pop_eddies.x(ii(nn-1)));
            end
        end
        
        if drap==1
            aviso_eddies=pop_eddies;
            save([fnames{drap}],'aviso_eddies','-append')
        else
            save([fnames{drap}],'pop_eddies','-append')
        end
        
    end
    
    
