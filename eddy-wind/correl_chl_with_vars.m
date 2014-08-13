%
apath='/matlab/data/eddy/V4/mat/AVISO_25_W_';
spath='/matlab/data/mld/mat/MLD_25_30_';
qpath='/matlab/data/QuickScat/mat/QSCAT_30_25km_';
ppath='/matlab/data/gsm/mat/GSM_9_21_';

startjd=2451556
endjd=2454832
jdays=[startjd:7:endjd];

load([ppath num2str(jdays(1))],'glon','glat')
load([spath num2str(jdays(1))],'lon','lat')
mlat=lat;
mlon=lon;
load([qpath num2str(jdays(200))],'lon','lat')
qlon=lon;
qlat=lat;
load([apath num2str(jdays(200))],'lon','lat')
alon=lon;
alat=lat;

load /matlab/matlab/domains/global_lat_lon.mat
lat=[-60:60];
[r,c]=imap(min(lat),max(lat),min(lon),max(lon),mlat,mlon);
[rq,cq]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
[rg,cg]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);
[ra,ca]=imap(min(lat),max(lat),min(lon),max(lon),alat,alon);


[ts_mld,ts_u3,ts_par,ts_chl,ts_car]=deal(single(nan(length(r),length(c),length(jdays))));

%
for m=1:464%length(jdays)
	m
	load([apath num2str(jdays(m))],'mask')
	mask=mask(ra,ca);
	load([spath num2str(jdays(m))],'mld_week')
	ts_mld(:,:,m)=single(mld_week(r,c));
	
	load([ppath num2str(jdays(m))],'gpar_week')
	ts_par(:,:,m)=single(flipud(gpar_week(rg,cg)));
	
	load([ppath num2str(jdays(m))],'bp26_chl')
	ts_chl(:,:,m)=single(flipud(bp26_chl(rg,cg))).*mask;
	
	load([ppath num2str(jdays(m))],'bp26_car')
	ts_car(:,:,m)=single(flipud(bp26_chl(rg,cg))).*mask;
	
	load([qpath num2str(jdays(m))],'u3_week')
	ts_u3(:,:,m)=single(u3_week(rq,cq));
end

%save GLB_vars ts_* jdays r c *lat *lon
%}
%clear
%load EK_vars
for m=1:length(r)
	for n=1:length(c)
		r_chl_mld(m,n)=pcor(ts_mld(m,n,:),ts_chl(m,n,:));
		r_chl_u3(m,n)=pcor(ts_u3(m,n,:),ts_chl(m,n,:));
		r_chl_par(m,n)=pcor(ts_par(m,n,:),ts_chl(m,n,:));
		r_chl_par(m,n)=pcor(ts_chl(m,n,:),ts_car(m,n,:));
	end
end	
save GLB_cors jdays r c *lat *lon r_*
