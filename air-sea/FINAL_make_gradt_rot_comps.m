
% clear all
% 
% 
load tracks/midlat_tracks
ii=find(track_jday>=2452427 & track_jday<=2455159);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);
%
% [sst_cc,sst_c]=comps_dir_grad(x,y,cyc,id,track_jday,scale,'hp66_sst','~/data/ReynoldsSST/mat/OI_25_30_','t')
[wspd_cc,wspd_c]=comps_dir_grad(x,y,cyc,id,track_jday,scale,'hp66_wspd','~/data/QuickScat/FINAL_mat/QSCAT_30_25km_','t')
% 
% 
save -append FIANL_sst_midlat_rot_comps
load FIANL_sst_midlat_rot_comps
%
zgrid_grid
cw=find(xi(1,:)<=0);
ce=find(xi(1,:)>0);

wsst=sst_cc.N_mean(:,cw);
esst=sst_cc.N_mean(:,ce);
if max(sst_cc.N_mean(:))>abs(min(sst_cc.N_mean(:)))
    g=abs(max(wsst(:))/min(esst(:)));
else
    g=abs(min(wsst(:))/max(esst(:)));
end
r=num2str(round(g*100)/100);
pcomps_raw2(sst_cc.N_mean,sst_cc.N_mean,[-0.3 0.3],-1,.05,1,['SST northward \nabla SST CC r=',num2str(r)],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/hp66_sst_cc_N'])

wsst=sst_cc.S_mean(:,cw);
esst=sst_cc.S_mean(:,ce);
if max(sst_cc.S_mean(:))>abs(min(sst_cc.S_mean(:)))
    g=abs(max(wsst(:))/min(esst(:)));
else
    g=abs(min(wsst(:))/max(esst(:)));
end
r=num2str(round(g*100)/100);
pcomps_raw2(sst_cc.S_mean,sst_cc.S_mean,[-0.3 0.3],-1,.05,1,['SST southward \nabla SST CC r=',num2str(r)],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/hp66_sst_cc_S'])

wsst=sst_c.N_mean(:,cw);
esst=sst_c.N_mean(:,ce);
if max(sst_c.N_mean(:))>abs(min(sst_c.N_mean(:)))
    g=abs(max(wsst(:))/min(esst(:)));
else
    g=abs(min(wsst(:))/max(esst(:)));
end
r=num2str(round(g*100)/100);
pcomps_raw2(sst_c.N_mean,sst_c.N_mean,[-0.3 0.3],-1,.05,1,['SST northward \nabla SST CW r=',num2str(r)],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/hp66_sst_c_N'])

wsst=sst_c.S_mean(:,cw);
esst=sst_c.S_mean(:,ce);
if max(sst_c.S_mean(:))>abs(min(sst_c.S_mean(:)))
    g=abs(max(wsst(:))/min(esst(:)));
else
    g=abs(min(wsst(:))/max(esst(:)));
end
r=num2str(round(g*100)/100);
pcomps_raw2(sst_c.S_mean,sst_c.S_mean,[-0.3 0.3],-1,.05,1,['SST southward \nabla SST CW r=',num2str(r)],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/hp66_sst_c_S'])


%%%%
%%WSPD
%%%%%
wwspd=wspd_cc.N_mean(:,cw);
ewspd=wspd_cc.N_mean(:,ce);
if max(wspd_cc.N_mean(:))>abs(min(wspd_cc.N_mean(:)))
    g=abs(max(wwspd(:))/min(ewspd(:)));
else
    g=abs(min(wwspd(:))/max(ewspd(:)));
end
r=num2str(round(g*100)/100);
pcomps_raw2(wspd_cc.N_mean,wspd_cc.N_mean,[-0.1 .1],-1,.025,1,['SPD northward \nabla SST CC r=',num2str(r)],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/hp66_wspd_cc_N'])

wwspd=wspd_cc.S_mean(:,cw);
ewspd=wspd_cc.S_mean(:,ce);
if max(wspd_cc.S_mean(:))>abs(min(wspd_cc.S_mean(:)))
    g=abs(max(wwspd(:))/min(ewspd(:)));
else
    g=abs(min(wwspd(:))/max(ewspd(:)));
end
r=num2str(round(g*100)/100);
pcomps_raw2(wspd_cc.S_mean,wspd_cc.S_mean,[-0.1 .1],-1,.025,1,['SPD southward \nabla SST CC r=',num2str(r)],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/hp66_wspd_cc_S'])

wwspd=wspd_c.N_mean(:,cw);
ewspd=wspd_c.N_mean(:,ce);
if max(wspd_c.N_mean(:))>abs(min(wspd_c.N_mean(:)))
    g=abs(max(wwspd(:))/min(ewspd(:)));
else
    g=abs(min(wwspd(:))/max(ewspd(:)));
end
r=num2str(round(g*100)/100);
pcomps_raw2(wspd_c.N_mean,wspd_c.N_mean,[-0.1 .1],-1,.025,1,['SPD northward \nabla SST CW r=',num2str(r)],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/hp66_wspd_c_N'])

wwspd=wspd_c.S_mean(:,cw);
ewspd=wspd_c.S_mean(:,ce);
if max(wspd_c.S_mean(:))>abs(min(wspd_c.S_mean(:)))
    g=abs(max(wwspd(:))/min(ewspd(:)));
else
    g=abs(min(wwspd(:))/max(ewspd(:)));
end
r=num2str(round(g*100)/100);
pcomps_raw2(wspd_c.S_mean,wspd_c.S_mean,[-0.1 .1],-1,.025,1,['SPD southward \nabla SST CW r=',num2str(r)],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/hp66_wspd_c_S'])

