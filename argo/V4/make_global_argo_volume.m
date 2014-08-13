load global_4deg_grid
olap = 8; %half span of overlap in deg
[map_num_ac_yr,map_num_cc_yr,map_ac_trap,map_cc_trap,map_ac_aha,map_cc_aha,map_ac_asa,map_cc_asa,map_ac_vol,map_cc_vol]=deal(nan*mlat);
load ~/data/eddy/V5/global_tracks_v5_12_weeks.mat id cyc track_jday x y

for m=1:length(mlat(:))
    
    %figure out lat/lon bounds
    clat=mlat(m);
    clon=mlon(m);
    [r,c]=imap(mlat(m)-olap,mlat(m)+olap,mlon(m)-olap,mlon(m)+olap,mlat,mlon);
    tt=mlat(r,c);minlat=min(tt(:));
    tt=mlat(r,c);maxlat=max(tt(:));
    tt=mlon(r,c);minlon=min(tt(:));
    tt=mlon(r,c);maxlon=max(tt(:));
    
    
    outname=['/Users/new_gaube/matlab/argo/V4/global_comps/output/global_4deg_',num2str(m),'_argo_comp'];
    
    if ~isnan(mask(m)) & exist([outname,'.mat'])
        
        load(outname,'cc_t','ac_t','cc_s','ac_s','km_x','prop_speed','ac_v_dh','cc_v_dh','eddy_scale','ppres','eddy_y')
        
        
        
        
        
        ac_v=100*ac_v_dh;
        cc_v=100*cc_v_dh;
        c_spd=pmean(prop_speed);
        
        
        iin=find(km_x<=pmean(eddy_scale));
        for rr=1:length(ppres)
            if pmean(eddy_y)>0
                ac_max_speed(rr)=abs(min(ac_v(rr,iin)));
                cc_max_speed(rr)=max(cc_v(rr,iin));
                tt=km_x(find(abs(ac_v(rr,iin))==ac_max_speed(rr)));
                if any(tt)
                    ac_imax(rr)=tt(1);
                else
                    ac_imax(rr)=1;
                end
                tt=km_x(find(cc_v(rr,iin)==cc_max_speed(rr)));
                if any(tt)
                    cc_imax(rr)=tt(1);
                else
                    cc_imax(rr)=1;
                end
            else
                ac_max_speed(rr)=max(ac_v(rr,iin));
                cc_max_speed(rr)=abs(min(cc_v(rr,iin)));
                tt=km_x(find(ac_v(rr,iin)==ac_max_speed(rr)));
                if any(tt)
                    ac_imax(rr)=tt(1);
                else
                    ac_imax(rr)=1;
                end
                tt=km_x(find(abs(cc_v(rr,iin))==cc_max_speed(rr)));
                if any(tt)
                    cc_imax(rr)=tt(1);
                else
                    cc_imax(rr)=1;
                end
            end
        end
        
        ac_non=ac_max_speed./c_spd;
        cc_non=cc_max_speed./c_spd;
        
        i_non_ac=find(ac_non<1);
        if any(i_non_ac)
            i_non_ac=i_non_ac(1);
        else
            i_non_ac=1;
        end
        i_non_cc=find(cc_non<1);
        if any(i_non_cc)
            i_non_cc=i_non_cc(1);
        else
            i_non_cc=1;
        end
        %now calculate volume
        if i_non_ac>1
            ac_vol=10*sum(pi*(1000*(ac_imax(1:i_non_ac))).^2); %m^3
        else
            ac_vol=nan;
        end
        if i_non_cc>1
            cc_vol=10*sum(pi*(1000*(cc_imax(1:i_non_cc))).^2); %m^3
        else
            cc_vol=nan;
        end
        
        %now available heat and salt anomalies
        mean_ac_t=nanmean(ac_t,2); %K
        ac_aha=1020*4000*pmean(mean_ac_t(1:i_non_ac)).*ac_vol; %J
        mean_ac_s=nanmean(ac_s,2); %psu
        ac_asa=1020*0.001*pmean(mean_ac_s(1:i_non_ac)).*ac_vol; %kg
        
        mean_cc_t=nanmean(cc_t,2);
        cc_aha=1020*4000*pmean(mean_cc_t(1:i_non_ac)).*cc_vol;
        mean_cc_s=nanmean(cc_s,2);
        cc_asa=1020*0.001*pmean(mean_cc_s(1:i_non_ac)).*cc_vol;
        
        save(outname,'mean_*_t','mean_*_s','*_vol','*_aha','*_asa','-append')
        
        
        map_ac_aha(m)=ac_aha;
        map_cc_aha(m)=cc_aha;
        map_ac_asa(m)=ac_asa;
        map_cc_asa(m)=cc_asa;
        map_ac_vol(m)=ac_vol;
        map_cc_vol(m)=cc_vol;
        map_ac_trap(m)=ppres(i_non_ac);
        map_cc_trap(m)=ppres(i_non_cc);
        
        figure(100)
        clf
        pmap(mlon,mlat,mask)
        hold on
        m_plot(clon,clat,'k.','markersize',50)
        draw_domain(mlon(r,c),mlat(r,c))
        drawnow
        
        %         figure(101)
        %         clf
        %         rat=double(map_ac_trap./map_cc_trap);
        %         pmap(mlon,mlat,rat)
        %         hold on
        %         m_plot(clon,clat,'k.','markersize',50)
        %         draw_domain(mlon(r,c),mlat(r,c))
        %         caxis([0 2])
        %         title('ac_trap/cc_trap')
        %         drawnow
        
        %now figure out how many eddies per year to calc transport
        %find eddies within box
        [r,c]=imap(mlat(m)-olap,mlat(m)+olap,mlon(m)-olap,mlon(m)+olap,mlat,mlon);
        tt=mlat(r,c);minlat=min(tt(:));
        tt=mlat(r,c);maxlat=max(tt(:));
        tt=mlon(r,c);minlon=min(tt(:));
        tt=mlon(r,c);maxlon=max(tt(:));
        
        ii=find(x>=minlon & x<=maxlon & y>=minlat & y<=maxlat);
        
        tcyc=cyc(ii);
        ttrack_jday=track_jday(ii);
        tid=id(ii);
        
        ia=find(tcyc==1);
        ic=find(tcyc==-1);
        map_num_ac_yr(m)=length(unique(tid(ia)))/((max(ttrack_jday(ia))-min(ttrack_jday(ia)))/365.25);
        map_num_cc_yr(m)=length(unique(tid(ic)))/((max(ttrack_jday(ic))-min(ttrack_jday(ic)))/365.25);
        clear ac_* cc_* mean_* ia ic num_ac_* num_cc_*
        
    end
    
    
end

save /Users/new_gaube/matlab/argo/V4/global_comps/mean_maps mlat mlon mask map_num_ac_yr map_num_cc_yr map_*
