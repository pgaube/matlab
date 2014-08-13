set(0,'DefaultFigureVisible','off')
clear all
close all
global DATA_DIR
global HOME_DIR
global IMAGE_DIR
global HDF_DIR
global MAT_DIR
global COMP_MAT_DIR
global d
global s
global jd
global ran
global fran
global AVHRR_DATA_DIR
global ran
global fran
global cran
global pd

set_fish

%%%%%
%mlat=mlat+.0125;
%mlon=mlon+.01;

%%%%%

cd(AVHRR_DATA_DIR)


minlon = -121;
maxlon = -116;
minlat = 30;
maxlat = 35;

xvec = [minlon maxlon];
yvec = [minlat maxlat];


%now loop through each hdf file, register and plot
tmp=dir('*mo*hdf');
for m=1:length(tmp)
fname=num2str(getfield(tmp,{m},'name'));
eval(['!cwregister ' HOME_DIR '/pgSoCal_master.hdf ' fname ' tmp_out.hdf'])
%!cwnavigate -t -10/0 tmp_out.hdf
%!cwautonav ../../../sw/fd_domain_autonav.txt avhrr_ch2 tmp_out.hdf
!cwautonav ../../../sw/fd_domain_autonav.txt sst tmp_out.hdf
!cwangles -l -f tmp_out.hdf

lon=double(hdfread('tmp_out.hdf','/longitude','Index',{[1 1],[1 1],[900 900]}));
lat=double(hdfread('tmp_out.hdf','/latitude','Index',{[1 1],[1 1],[900 900]}));
sst=0.01*double(hdfread('tmp_out.hdf','/sst','Index',{[1 1],[1 1],[900 900]}));
cloud=double(hdfread('tmp_out.hdf','/cloud','Index',{[1 1],[1 1],[900 900]}));
cmask=nan*cloud;
cmask(cloud==0)=1;

[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
sst=sst(r,c);
cmask=cmask(r,c);
cloud=cloud(r,c);
lon=lon(r,c);
lat=lat(r,c);

%sst=fillnans(sst.*cmask);
sci_sst=sst.*cmask;

cmask(cloud==2)=1;
cmask(cloud==16)=1;
cmask(cloud==18)=1;
cmask(cloud==22)=1;
%cmask(cloud==23)=1;
%cmask(cloud==31)=1;


sst=sst.*cmask;
sst(sst<0)=nan;
sm_sst=smoothn(sci_sst,3).*cmask;
gr_mask=nan*sm_sst;
gr_mask(~isnan(sst))=1;
gradt=sqrt(dfdx(lat,sm_sst,.01).^2+dfdy(sm_sst,.01).^2).*gr_mask;

tmp_sst=griddata(lon,lat,sst,mlon,mlat,'cubic');
gradt=griddata(lon,lat,gradt,mlon,mlat,'cubic');
tmp_sst=tmp_sst.*mask;
gradt=gradt.*mask;

tmp_time=fname(10:13);
big_sst=tmp_sst;

%test to see if any covarage
st=find(~isnan(big_sst));
if length(st(:))>=20
%continue

save([COMP_MAT_DIR,'pgSoCal_avhrr_',num2str(s(1)) num2str(d) '_' tmp_time],'lon','lat','sst')


idata=big_sst*(9/5)+32;
new_mask=nan*idata;
new_mask(~isnan(idata))=1;
nrgb=length(fdcolor(:,1));
cstep = (nrgb-1)/(ran(2)-ran(1));
irgb = max(min(round((idata-ran(1))*cstep+1),nrgb),1).*mask;
irgb(irgb==256)=255;
q=ones(256,1);
q(256)=0;     
irgb(isnan(new_mask))=256;
eval(['imwrite(flipud(fliplr(irgb)),fdcolor,' char(39) IMAGE_DIR fname(15:17) '_bdsc_' ...
	pd '_' tmp_time '_' num2str(ran(1)) '_'	num2str(ran(2)) '.png' char(39) ',' ...
	char(39) 'Transparency' char(39) ',q)' ]) 
eval(['imwrite(flipud(fliplr(irgb)),fdcolor,' char(39) FDIMAGE_DIR 'bdsc_' ...
	pd '_' tmp_time '_' num2str(ran(1)) '_'	num2str(ran(2)) '.png' char(39) ',' ...
	char(39) 'Transparency' char(39) ',q)' ]) 	
eval(['ls ' [IMAGE_DIR fname(15:17) '_bdsc_' pd '_' tmp_time '_' num2str(ran(1)) '_' num2str(ran(2)) '.png']]) 



idata=gradt;
new_mask=nan*idata;
new_mask(~isnan(idata))=1;
nrgb=length(pjet(:,1));
cstep = (nrgb-1)/(fran(2)-fran(1));
irgb = max(min(round((idata-fran(1))*cstep+1),nrgb),1).*mask;
irgb(irgb==256)=255;
q=ones(256,1);
q(256)=0;     
irgb(isnan(new_mask))=256;
eval(['imwrite(flipud(fliplr(irgb)),pjet,' char(39) IMAGE_DIR fname(15:17) '_bz_' ...
	pd '_' tmp_time '_0_10.png' char(39) ',' char(39) 'Transparency' char(39) ',q)']) 
eval(['imwrite(flipud(fliplr(irgb)),pjet,' char(39) FDIMAGE_DIR 'bz_' ...
	pd '_' tmp_time '_0_10.png' char(39) ',' char(39) 'Transparency' char(39) ',q)'])
eval(['ls ' IMAGE_DIR fname(15:17) '_bz_'  ...
	pd '_' tmp_time '_0_10.png'])


else
end
end

cd(HOME_DIR)	
