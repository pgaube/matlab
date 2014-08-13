set(0,'DefaultFigureVisible','off')
clear all
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

set_nb

cd ~/fish/tmp/


%now loop through each hdf file and plot
tmp=dir('*fd*hdf');
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
sst2=sst.*cmask;
%sst2=sst.*cmask2;

%remove cloud adjacent point
sst=buffnan(sst,4);
sm_sst=smoothn(sst,3).*cmask;
gr_mask=nan*sm_sst;
gr_mask(~isnan(sst))=1;
gradt=sqrt(dfdx(lat,sm_sst,.01).^2+dfdy(sm_sst,.01).^2).*gr_mask;

tmp_sst=griddata(lon,lat,sst,mlon,mlat,'linear');
tmp_sst2=griddata(lon,lat,sst2,mlon,mlat,'linear');
tmp_sci=griddata(lon,lat,sci_sst,mlon,mlat,'linear');
fake_cloud=griddata(lon,lat,cloud,mlon,mlat,'linear');
%tmp_full=griddata(lon,lat,full_sst,mlon,mlat,'linear');
gradt=griddata(lon,lat,gradt,mlon,mlat,'linear');
tmp_sst=tmp_sst.*mask;
tmp_sst2=tmp_sst2.*mask;
tmp_sci=tmp_sci.*mask;
imask=nan*mask;
imask(isnan(mask))=1;
imask(isnan(tmp_sci))=1;
fake_cloud=fake_cloud.*imask;
%tmp_full=tmp_full.*mask;
gradt=gradt.*mask;

%ty=tmp_sst-bulk_temp;
ty=0;
offset=nanmedian(ty(:));

%pmask
%pmask=nan*tmp_full;
%pmask((tmp_full+offset)>min(ran)+1.7)=1;
%psst=tmp_full.*pmask;
tt=str2num(fname(10:13))-100;
big_sst=tmp_sst;

%test to see if any covarage
st=find(~isnan(big_sst));
per=length(st)./length(find(~isnan(mask(:))));
	
ti=prctile(big_sst(:)+offset,[1 99]);
tmran=round(10*ti)./10;
tmran=ran+1.5;

if tt./100<12
	if tt<1000
		tmp_time=['0' num2str(tt) 'a'];
	else
		tmp_time=[num2str(tt) 'a'];
	end	
else
	tt=tt-1200;
	if tt<1000
		tmp_time=['0' num2str(tt) 'p'];
	else
		tmp_time=[num2str(tt) 'p'];
	end	
end	





fplot(tmp_sst2,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR 'nb_bdsc_'],pd,tmp_time,'sst')
%fplot(tmp_sst2,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR3 'bdsc_'],pd,tmp_time,'sst')
%fplot(big_sst,mask,tmran(1),tmran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tmp_time,'sst')
fplot(tmp_sci,mask,ran(1),ran(2),'fdcolor',[MASK_IMAGE_DIR 'nb_bdsc_'],pd,tmp_time,'sst')
fplot(tmp_sci,mask,tmran(1),tmran(2),'fdcolor',[MASK_IMAGE_DIR 'nb_bdsc_'],pd,tmp_time,'sst')
%fplot(big_sst,mask,tmran(1),tmran(2),'fdcolor',[IMAGE_DIR fname(15:17) '_bdsc_'],pd,tmp_time)
fplot(gradt,mask,fran(1),fran(2),'pjet',[IMAGE_DIR 'nb_bz_'],pd,tmp_time,'sst')


end
end


cd(AVHRR_CUR_DIR)
!rm *
cd(HOME_DIR)	
