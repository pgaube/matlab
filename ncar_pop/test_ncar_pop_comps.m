load 7_week_pop_eddies

eddies.adens=nan*eddies.x
eddies.adens(eddies.cyc==1)=-1;
eddies.adens(eddies.cyc==-1)=1;
unique(eddies.track_jday)

[ssh_a,ssh_m,ssh_c,ssh_t]=ncar_pop_comps(eddies.x,eddies.y,eddies.cyc,eddies.k,eddies.id,eddies.radius,eddies.track_jday,eddies.adens,'ssh',1);


pcomps_raw2(ssh_a.mean,ssh_a.mean,[-15 15],-300,2,300,['NCAR GS Anticyclones'],1,20)
print -dpng -r300 figs/ncar_gs_ssh_a
pcomps_raw2(ssh_c.mean,ssh_c.mean,[-15 15],-300,2,300,['NCAR GS Cyclones'],1,20)
print -dpng -r300 figs/ncar_gs_ssh_c