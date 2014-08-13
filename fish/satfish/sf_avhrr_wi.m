
function sf_avhrr(region,rname)

set(0,'DefaultFigureVisible','off')
close all
global DATA_DIR
global CLOUD_IMAGE_DIR
global HOME_DIR
global IMAGE_DIR
global HDF_DIR
global MAT_DIR
global MASK_IMAGE_DIR
global COMP_MAT_DIR
global COMP_IMG_DIR
global d
global s
global jd
global ran
global fran
global AVHRR_DATA_DIR
global AVHRR_ARC_DIR
global AVHRR_CUR_DIR
global AVHRR_HDF_DIR
global ran
global fran
global cran
global pd
global minlon
global maxlon
global minlat
global maxlat
global AVHRR_SFCUR_DIR


set_satfish
load(region)
%load([HOME_DIR '/' rname '_fishran'])

maxlat=max(mlat(:));
minlat=min(mlat(:));
maxlon=max(mlon(:));
minlon=min(mlon(:));

cd(AVHRR_SFCUR_DIR)

%now loop through each hdf file and plot
tmp=dir('*wi*hdf');
if length(tmp)>0

for m=1:length(tmp)
fname=num2str(getfield(tmp,{m},'name'));
eval(['!cp ' fname ' tmp_out.hdf'])
lon=double(hdfread('tmp_out.hdf','/longitude'));
lat=double(hdfread('tmp_out.hdf','/latitude'));
sst=0.01*double(hdfread('tmp_out.hdf','/sst'));
sst=(sst*(9/5))+32;
cloud=double(hdfread('tmp_out.hdf','/cloud'));
%zenith=double(hdfread('tmp_out.hdf','/sat_zenith'));

cmask=nan*cloud;
cmask(cloud==0)=1;
[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);

sst=sst(r,c);
cmask=cmask(r,c);
cloud=cloud(r,c);
lon=lon(r,c);
lat=lat(r,c);
zt=find(sst<-10);
sst(sst<0)=nan;
sst(sst<34)=nan;
sst(sst>90)=nan;

%sst=fillnans(sst.*cmask);
sci_sst=sst.*cmask;
cmask2=cmask;
cmask(cloud==123)=1;
cmask(cloud==4)=1;
cmask(cloud==16)=1;
cmask(cloud==18)=1;
cmask(cloud==22)=1;
cmask(cloud==2)=1;
cmask(cloud==6)=1;
cmask(cloud==38)=1;
cmask(cloud==70)=1;
cmask(cloud==98)=1;
cmask(cloud==114)=1;
cmask(cloud==66)=1;
cmask(cloud==34)=1;
cmask(cloud==102)=1;
cmask(cloud==32)=1;
cmask(cloud==50)=1;
cmask(cloud==31)=1;
cmask(cloud==23)=1;
cmask(cloud==66)=1;




cmask2(cloud==123)=1;
%cmask2(cloud==4)=1;
cmask2(cloud==16)=1;
cmask2(cloud==18)=1;
cmask2(cloud==22)=1;
cmask2(cloud==2)=1;
cmask2(cloud==6)=1;
cmask2(cloud==38)=1;

full_sst=sst;
sst=sst.*cmask;
sst2=sst.*cmask2;


%remove cloud adjacent point
%pmask
pmask=nan*full_sst;
pmask((full_sst)>min(ran)+2)=1;
psst=sst.*pmask;
buff_sst=sst.*pmask;
buff_sst=sst.*pmask;
tic;psst=buffnan_rad_fast(psst,avhrr_mask(r,c),5);
toto=toc;
display(['decimation took ',num2str(toto)])



tic;
sm_sst=smoothn(psst,3).*cmask;
gr_mask=nan*sm_sst;
gr_mask(~isnan(psst))=1;
gradt=sqrt(dfdx(lat,sm_sst,.01).^2+dfdy(sm_sst,.01).^2).*gr_mask;
toto=toc;
display(['smoothong took ',num2str(toto)])

tic;
tmp_sst=griddata(lon,lat,sst,mlon,mlat,'linear');
psst=griddata(lon,lat,psst,mlon,mlat,'linear');
tmp_full=griddata(lon,lat,full_sst,mlon,mlat,'linear');
gradt=griddata(lon,lat,gradt,mlon,mlat,'linear');
tmp_sst=tmp_sst.*mask;
tmp_full=tmp_full.*mask;
psst=psst.*mask;

gradt=gradt.*mask;
toto=toc;
display(['interp took ',num2str(toto)])


tt=str2num(fname(10:13))+UTC;
if tt>24
    tt=tt-24;
end


[s(2),s(3),s(1)]=jul2date(str2num(fname(6:8)),str2num(fname(1:4)));
d=julian(s(2),s(3),s(1),s(1));
if s(2)<10 & s(3)<10
	pd=[num2str(s(1)-2000) '0' num2str(s(2)) '0' num2str(s(3))];
elseif s(2)>=10 & s(3)<10
	pd=[num2str(s(1)-2000) num2str(s(2)) '0' num2str(s(3))];	
elseif s(2)<10 & s(3)>=10
	pd=[num2str(s(1)-2000) '0' num2str(s(2)) num2str(s(3))];
else
	pd=[num2str(s(1)-2000) num2str(s(2)) num2str(s(3))];
end
pd
%test to see if any covarage
st=find(~isnan(psst));
per=length(st)./length(find(~isnan(mask(:))));

%test to see if NAV is off
nav_off=find(psst>=max(ran)+10);

ti=prctile(tmp_sst(:),[1 99]);
tmran=round(10*ti)./10;
tmran=ran+1.5;

tmp_time=[num2str(tt)]
if length(tmp_time)<4
    tmp_time=['0',tmp_time];
end
%save([COMP_MAT_DIR,rname,'_avhrr_',num2str(s(1)) num2str(d) '_' num2str(tt)])

% if per>=.18 & length(zt)<=100 & length(nav_off)<100
% 		sfplot(psst,mask,ran(1)+1,ran(2)+1.5,'fdcolor',[CLOUD_IMAGE_DIR rname '_bdsc_'],pd,tmp_time,'sst')
% end
sfplot(tmp_full,mask,ran(1)+1,ran(2)+1.5,'fdcolor',[CLOUD_IMAGE_DIR rname '_bdsc_'],pd,tmp_time,'sst')
sfplot(gradt,mask,fran(1),fran(2),'fdcolor',[CLOUD_IMAGE_DIR rname '_bz_'],pd,tmp_time,'bz')

end
end

cd(AVHRR_SFCUR_DIR)
!rm *wi*
cd(HOME_DIR)	
