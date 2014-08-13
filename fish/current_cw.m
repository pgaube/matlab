set(0,'DefaultFigureVisible','off')
clear all
close all
global DATA_DIR
global HOME_DIR
global IMAGE_DIR
global HDF_DIR
global MAT_DIR
global CW_DIR
global COMP_MAT_DIR
global d
global s
global jd
global ran
global fran
global AVHRR_DATA_DIR
global AVHRR_ARC_DIR
global AVHRR_CUR_DIR
global ran
global fran
global cran
global pd
global minlon
global maxlon
global minlat
global maxlat

set_fish

%%%%%
%mlat=mlat+.0125;
%mlon=mlon+.01;

%%%%%

cd(CW_DIR)





xvec = [minlon maxlon];
yvec = [minlat maxlat];

vo = [datenum(s(1),s(2),s(3)) datenum(s(1),s(2),s(3))];
v1 = [datenum(s(1),s(2),s(3)) datenum(s(1),s(2),s(3)+1)];


[sstn nlon nlat ntime] = xtracto_3D_bdap(xvec,yvec,v1,'TATsstnhday');
[sstd dlon dlat dtime] = xtracto_3D_bdap(xvec,yvec,v1,'TATsstdhday');


%first do night
if ndims(sstn)>2
for m=1:length(sstn(:,1,1,1))
[lon,lat]=meshgrid(nlon,nlat);
smask=nan*squeeze(sstn(m,:,:,:));
smask(~isnan(squeeze(sstn(m,:,:,:))))=1;
sm_sstn=smoothn(squeeze(sstn(m,:,:,:)),3).*smask;
gradtn=sqrt(dfdx(lat,sm_sstn,.01).^2+dfdy(sm_sstn,.01).^2);

tmp_sstn=griddata(lon,lat,squeeze(sstn(m,:,:,:)),mlon,mlat,'linear');
gradtn=griddata(lon,lat,gradtn,mlon,mlat,'linear');
tmp_sstn=tmp_sstn.*mask;
gradtn=gradtn.*mask;

lon=mlon;
lat=mlat;
tmp_time=datestr(ntime(m));
tt=[tmp_time(13:14) tmp_time(16:17)];
sst=tmp_sstn.*(9/5)+32;

ty=sst-bulk_temp;
offset=nanmedian(ty(:));
sran=ran;


%save([COMP_MAT_DIR,'pgSoCal_cw_',num2str(s(1)) num2str(d) '_' tmp_time(13:14) tmp_time(16:17)],'lon','lat','sst')


if tt./100<12
	tt=[num2str(tt) 'a'];
else
	tt=[num2str(tt-1200) 'p'];
end	


fplot(sst,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
fplot(sst,mask,ran(1)+1,ran(2)-1.5,'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
%fplot(gradtn,mask,fran(1),fran(2),'pjet',[IMAGE_DIR 'cwa_bz_'],pd,tt,'sst')
end
end


%now do day
if ndims(sstd)>2
for m=1:length(sstd(:,1,1,1))
[lon,lat]=meshgrid(dlon,dlat);
smask=nan*squeeze(sstd(m,:,:,:));
smask(~isnan(squeeze(sstd(m,:,:,:))))=1;
sm_sstd=smoothn(squeeze(sstd(m,:,:,:)),3).*smask;
gradtd=sqrt(dfdx(lat,sm_sstd,.01).^2+dfdy(sm_sstd,.01).^2);

tmp_sstd=griddata(lon,lat,squeeze(sstd(m,:,:,:)),mlon,mlat,'linear');
gradtd=griddata(lon,lat,gradtd,mlon,mlat,'linear');
tmp_sstd=tmp_sstd.*mask;
gradtd=gradtd.*mask;

lon=mlon;
lat=mlat;
tmp_time=datestr(dtime(m));
tt=[tmp_time(13:14) tmp_time(16:17)];
sst=tmp_sstd.*(9/5)+32;

ty=sst-bulk_temp;
offset=nanmedian(ty(:));
sran=ran;
return

%save([COMP_MAT_DIR,'pgSoCal_cw_',num2str(s(1)) num2str(d) '_' tmp_time(13:14) tmp_time(16:17)],'lon','lat','sst')

if tt./100<12
	tt=[num2str(tt) 'a'];
else
	tt=[num2str(tt-1200) 'p'];
end	


fplot(sst,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
fplot(sst,mask,ran(1)+1,ran(2)-1.5,'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
%fplot(gradtd,mask,fran(1),fran(2),'pjet',[IMAGE_DIR 'cwa_bz_'],pd,tt,'sst')

end
end

cd(HOME_DIR)

