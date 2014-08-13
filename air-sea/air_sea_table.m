clear all

curs = {'EIO','CAR','HAW','new_SP','AGU','AGR','midlat'};

startjd=date2jd(2002,6,1);
endjd=date2jd(2009,11,1);
%
for m=1:length(curs)
    if m==7
        load ~/matlab/air-sea/tracks/midlat_tracks
    else
        load(['~/data/eddy/V6/',curs{m},'_lat_lon_tracks_V6'])
    end
    y=ext_y;
    x=ext_x;

    ai=find(track_jday>=startjd & track_jday<=endjd & cyc==1 & age>=12);
    ci=find(track_jday>=startjd & track_jday<=endjd & cyc==-1 & age>=12);
    tab2(1,m)=min(y);
    tab2(2,m)=max(y);
    tab2(3,m)=min(x);
    tab2(4,m)=max(x);
    tab2(5,m)=length(unique(id(ci)));
    tab2(6,m)=length(unique(id(ai)));
    tab2(7,m)=length((id(ci)));
    tab2(8,m)=length((id(ai)));
    tab2(9,m)=pmean(amp(ci));
    tab2(10,m)=pmean(amp(ai));
    tab2(11,m)=pmean(scale(ci));
    tab2(12,m)=pmean(scale(ai));
    tab2(13,m)=pmean(axial_speed(ci));
    tab2(14,m)=pmean(axial_speed(ai));
    
    tab(1,m)=min(y);
    tab(2,m)=max(y);
    tab(3,m)=min(x);
    tab(4,m)=max(x);
    tab(5,m)=length(unique(id(ci)));
    tab(6,m)=length(unique(id(ai)));
    tab(7,m)=length((id(ci)));
    tab(8,m)=length((id(ai)));
    tab(9,m)=nanmedian(amp(ci));
    tab(10,m)=nanmedian(amp(ai));
    tab(11,m)=nanmedian(scale(ci));
    tab(12,m)=nanmedian(scale(ai));
    tab(13,m)=nanmedian(axial_speed(ci));
    tab(14,m)=nanmedian(axial_speed(ai));

    mean_scale(m)=pmean(scale);
    median_scale(m)=median(scale);
    mode_scale(m)=mode(scale);
    
end

	