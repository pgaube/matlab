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

set_new_fish


%get data from bettong
cd ~/fish/avhrr_work

%now loop through each hdf file and plot
tmp=dir('*fd*hdf');
if length(tmp)>0

for m=1:length(tmp)
fname=num2str(getfield(tmp,{m},'name'));
jd=fname(7:8);
fname
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
%pmask((full_sst-offset)>min(ran)+3)=1;
pmask((full_sst)>min(ran)+2)=1;
psst=sst.*pmask;

buffing_nans='started'
buff_sst=buffnan_rad(sst,3);
psst=buffnan_rad(psst,3);

smoothing='started'
sm_sst=smoothn(buff_sst,3).*cmask;
gr_mask=nan*sm_sst;
gr_mask(~isnan(sst))=1;

bite_zone = 'started'
gradt=sqrt(dfdx(lat,sm_sst,.01).^2+dfdy(sm_sst,.01).^2).*gr_mask;

interpilated='started'

tmp_sst=griddata(lon,lat,sst,mlon,mlat,'linear');
buff_sst=griddata(lon,lat,buff_sst,mlon,mlat,'linear');
tmp_sst2=griddata(lon,lat,sst2,mlon,mlat,'linear');
psst=griddata(lon,lat,psst,mlon,mlat,'linear');
%fake_cloud=griddata(lon,lat,cloud,mlon,mlat,'linear');
gradt=griddata(lon,lat,gradt,mlon,mlat,'linear');
tmp_sst=tmp_sst.*mask;
tmp_sst2=tmp_sst2.*mask;
buff_sst=buff_sst.*mask;
psst=psst.*mask;
imask=nan*mask;
imask(isnan(mask))=1;
%fake_cloud=fake_cloud.*imask;
%tmp_full=tmp_full.*mask;
gradt=gradt.*mask;

cloudmask='done'

tt=str2num(fname(10:13));
if tt>300
	tt=tt-300;
else
	tt=tt+2100;
end	



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

load([COMP_MAT_DIR,'pgSoCal_avhrr_',num2str(s(1)) num2str(jd) '_' num2str(tt)],'ran')


%fplot(fake_cloud,mask,0,50,'pgray',[CLOUD_IMAGE_DIR 'sccd_'],pd,tmp_time,'cloud')

		fplot(buff_sst,mask,ran(1),ran(2),'fdcolor',[AUTO_IMAGE_DIR 'jsd_bdsc_'],pd,tmp_time,'sst')
		%fplot(tmp_sci,mask,ran(1),ran(2),'fdcolor',[L0_IMAGE_DIR 'jsd_bdsc_'],pd,tmp_time,'sst')
		fplot(psst,mask,ran(1),ran(2)+1,'fdcolor',[AUTO_IMAGE_DIR 'jsd_bdsc_'],pd,tmp_time,'sst')
		%fplot(tmp_sst+offset,mask,ran(1),ran(2),'fdcolor',[L0_IMAGE_DIR fname(15:17) '_jsd_bdsc_'],pd,tmp_time)
	    %fplot(gradt,mask,fran(1),fran(2),'pjet',[IMAGE_DIR fname(15:17) '_bz_'],pd,tmp_time)
%fplot(tmp_full,mask,ran(1)-.5,ran(2)+.5,'fdcolor',[FULL_IMAGE_DIR fname(15:17) '_jsd_bdsc_'],pd,tmp_time)
fplot(buff_sst,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR3 'jsd_bdsc_'],pd,tmp_time,'sst')
fplot(psst,mask,ran(1),ran(2),'fdcolor',[PMASK_IMAGE_DIR 'jsd_bdsc_'],pd,tmp_time,'sst')
fplot(psst,mask,ran(1),ran(2)+1.5,'fdcolor',[PMASK_IMAGE_DIR 'jsd_bdsc_'],pd,tmp_time,'sst')
%fplot(psst,mask,tmran(1),tmran(2),'fdcolor',[PMASK_IMAGE_DIR 'jsd_bdsc_'],pd,tmp_time,'sst')
fplot(tmp_sst2,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR2 'jsd_bdsc_'],pd,tmp_time,'sst')
fplot(tmp_sst,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR 'jsd_bdsc_'],pd,tmp_time,'sst')
%fplot(tmp_sst2,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR3 'jsd_bdsc_'],pd,tmp_time,'sst')
%fplot(tmp_sst,mask,tmran(1),tmran(2),'fdcolor',[IMAGE_DIR 'jsd_bdsc_'],pd,tmp_time,'sst')
%fplot(tmp_sst,mask,tmran(1),tmran(2),'fdcolor',[IMAGE_DIR fname(15:17) '_jsd_bdsc_'],pd,tmp_time)
fplot(gradt,mask,fran(1),fran(2),'pjet',['jsd_bz_'],pd,tmp_time,'sst')


end
end