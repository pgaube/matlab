load dCC_eddy_argo_prof.mat   
load /matlab/data/eddy/V4/full_tracks/dCC_lat_lon_tracks.mat lon lat nneg prop_speed amp scale track_jday id amp axial_speed

tt=nansum(eddy_ist,1);
ii=find(tt>0); 
length(ii)

eddy_id=eddy_id(ii);
eddy_pjday_round=eddy_pjday_round(ii);

for m=1:length(eddy_id)
	same_prof(m)=find(id==eddy_id(m) & track_jday==eddy_pjday_round(m));
end	

id=id(same_prof);
amp=amp(same_prof);
scale=scale(same_prof);
axial_speed=axial_speed(same_prof);

ia=find(id>=nneg);
ic=find(id<nneg);

tbins=20:10:200;
[ba,na]=phist(scale(ia),tbins);
[bc,nc]=phist(scale(ic),tbins);

figure(1)
clf
stairs(tbins(1:end-1),(nc./sum([nc])).*100,'b','linewidth',1)
hold on
stairs(tbins(1:end-1),(na./sum([na])).*100,'r','linewidth',1)
title('Histo of eddy scale from which Argo composites are calculated')
ylabel('% of total for each polarity')
xlabel('L_s (km)')
print -dpng -r300 figs/2d/dCC_histo_scale

tbins=4:20;
[ba,na]=phist(amp(ia),tbins);
[bc,nc]=phist(amp(ic),tbins);

figure(2)
clf
stairs(tbins(1:end-1),(nc./sum([nc])).*100,'b','linewidth',1)
hold on
stairs(tbins(1:end-1),(na./sum([na])).*100,'r','linewidth',1)
title('Histo of eddy amp from which Argo composites are calculated')
ylabel('% of total for each polarity')
xlabel('amp (cm)')
print -dpng -r300 figs/2d/dCC_histo_amp

tbins=0:2:40;
[ba,na]=phist(axial_speed(ia),tbins);
[bc,nc]=phist(axial_speed(ic),tbins);

figure(3)
clf
stairs(tbins(1:end-1),(nc./sum([nc])).*100,'b','linewidth',1)
hold on
stairs(tbins(1:end-1),(na./sum([na])).*100,'r','linewidth',1)
title('Histo of eddy axial speed from which Argo composites are calculated')
ylabel('% of total for each polarity')
xlabel('axial speed (cm/s)')
print -dpng -r300 figs/2d/dCC_histo_axial_speed