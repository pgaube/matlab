
clear all
zgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);
xi=xi(r,c);
yi=yi(r,c);
dist=sqrt(xi.^2+yi.^2);
ii=find(dist<=1.6);
mask=nan*dist;
mask_maj(ii)=1;

[LW_anom_a,LW_anom_c]  =  ...
		comps_k_9km('tracks/cLW_lat_lon_tracks.mat','nrchl_anom_sample','n',1,48);
[CCNS_anom_a,CCNS_anom_c]  =  ...
		comps_k_9km('tracks/cCCNS_lat_lon_tracks.mat','nrchl_anom_sample','n',1,36);
[CC_anom_a,CC_anom_c]  =  ...
		comps_k_9km('tracks/cCC_lat_lon_tracks.mat','nrchl_anom_sample','n',1,52);
[PC_anom_a,PC_anom_c]  =  ...
		comps_k_9km('tracks/cPC_lat_lon_tracks.mat','nrchl_anom_sample','n',1,40);
[AK_anom_a,AK_anom_c]  =  ...
		comps_k_9km('tracks/cAK_lat_lon_tracks.mat','nrchl_anom_sample','n',1,30);		
[BG_anom_a,BG_anom_c]  =  ...
		comps_k_9km('tracks/cBG_lat_lon_tracks.mat','nrchl_anom_sample','n',1,35);		
		
save ebc_anom_comps_k_9km
