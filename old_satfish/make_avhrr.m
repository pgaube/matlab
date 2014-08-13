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

%get data from bettong
cd(AVHRR_HDF_DIR)
eval(['!cp *_fd.hdf ' AVHRR_CUR_DIR])
!rm *
cd(AVHRR_CUR_DIR)


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
sst2=sst.*cmask2;

%remove cloud adjacent point
buff_sst=buffnan(sst,4);
sm_sst=smoothn(sst,3).*cmask;
gr_mask=nan*sm_sst;
gr_mask(~isnan(sst))=1;
gradt=sqrt(dfdx(lat,sm_sst,.01).^2+dfdy(sm_sst,.01).^2).*gr_mask;

tmp_sst=griddata(lon,lat,sst,mlon,mlat,'linear');
buff_sst=griddata(lon,lat,buff_sst,mlon,mlat,'linear');
tmp_sst2=griddata(lon,lat,sst2,mlon,mlat,'linear');
tmp_sci=griddata(lon,lat,sci_sst,mlon,mlat,'linear');
fake_cloud=griddata(lon,lat,cloud,mlon,mlat,'linear');
tmp_full=griddata(lon,lat,full_sst,mlon,mlat,'linear');
gradt=griddata(lon,lat,gradt,mlon,mlat,'linear');
tmp_sst=tmp_sst.*mask;
tmp_sst2=tmp_sst2.*mask;
tmp_sci=tmp_sci.*mask;
tmp_full=tmp_full.*mask;
buff_sst=buff_sst.*mask;
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
pmask=nan*tmp_full;
pmask((tmp_full+offset)>min(ran)+1.7)=1;
psst=tmp_full.*pmask;
tt=str2num(fname(10:13))-100;

%test to see if any covarage
st=find(~isnan(tmp_sst));
per=length(st)./length(find(~isnan(mask(:))));
	
ti=prctile(tmp_sst(:)+offset,[1 99]);
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

save([COMP_MAT_DIR,'pgSoCal_avhrr_',num2str(s(1)) num2str(d) '_' num2str(tt)])



fplot(fake_cloud,mask,0,50,'pgray',[CLOUD_IMAGE_DIR 'sccd_'],pd,tmp_time,'cloud')

if per>=.1 & length(zt)<=100 
		new_fplot(buff_sst,mask,ran(1),ran(2),'fdcolor',[AUTO_IMAGE_DIR 'nbj_fsst_'],pd,tmp_time,'sst')
		%fplot(tmp_sci,mask,ran(1),ran(2),'fdcolor',[L0_IMAGE_DIR 'bdsc_'],pd,tmp_time,'sst')
		%fplot(psst+offset,mask,ran(1),ran(2),'fdcolor',[L0_IMAGE_DIR fname(15:17) '_bdsc_'],pd,tmp_time)
	else
		%fplot(tmp_sst+offset,mask,ran(1),ran(2),'fdcolor',[L0_IMAGE_DIR fname(15:17) '_bdsc_'],pd,tmp_time)
	    %fplot(gradt,mask,fran(1),fran(2),'pjet',[IMAGE_DIR fname(15:17) '_bz_'],pd,tmp_time)
end
%fplot(tmp_full,mask,ran(1)-.5,ran(2)+.5,'fdcolor',[FULL_IMAGE_DIR fname(15:17) '_bdsc_'],pd,tmp_time)
fplot(tmp_full,mask,ran(1),ran(2),'fdcolor',[FULL_IMAGE_DIR 'bdsc_'],pd,tmp_time,'sst')
%fplot(tmp_full,mask,tmran(1),tmran(2),'fdcolor',[FULL_IMAGE_DIR fname(15:17) '_bdsc_'],pd,tmp_time)
fplot(psst,mask,ran(1),ran(2),'fdcolor',[PMASK_IMAGE_DIR 'bdsc_'],pd,tmp_time,'sst')
%fplot(psst,mask,tmran(1),tmran(2),'fdcolor',[PMASK_IMAGE_DIR 'bdsc_'],pd,tmp_time,'sst')
fplot(tmp_sst2+offset,mask,ran(1)+adjt_down,ran(2)-adjt_up,'fdcolor',[IMAGE_DIR2 'bdsc_'],pd,tmp_time,'sst')
fplot(tmp_sst2,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR2 'bdsc_'],pd,tmp_time,'sst')
fplot(tmp_sst,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tmp_time,'sst')
%fplot(tmp_sst2,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR3 'bdsc_'],pd,tmp_time,'sst')
%fplot(tmp_sst,mask,tmran(1),tmran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tmp_time,'sst')
fplot(tmp_sci,mask,ran(1),ran(2),'fdcolor',[MASK_IMAGE_DIR 'bdsc_'],pd,tmp_time,'sst')
fplot(tmp_sci,mask,tmran(1),tmran(2),'fdcolor',[MASK_IMAGE_DIR 'bdsc_'],pd,tmp_time,'sst')
%fplot(tmp_sst,mask,tmran(1),tmran(2),'fdcolor',[IMAGE_DIR fname(15:17) '_bdsc_'],pd,tmp_time)
fplot(gradt,mask,fran(1),fran(2),'pjet',[IMAGE_DIR fname(15:17) '_bz_'],pd,tmp_time,'sst')


end

%
%composite image
tmp=dir([COMP_MAT_DIR,'pgSoCal_avhrr_',num2str(s(1)) num2str(d),'*']);
SCI=nan(length(mask(:,1)),length(mask(1,:)),length(tmp));
SST=SCI;
MST=SST;
OBS=SCI;
ASC=SCI;
PST=SCI;
for m=1:length(tmp)
	fname=[COMP_MAT_DIR,num2str(getfield(tmp,{m},'name'))];
	load(fname,'zt','per','tmp_sst','tmp_sci')
	OBS(:,:,m)=tmp_sst;
	ASC(:,:,m)=tmp_sci;
	if length(zt)<=100
		load(fname,'tmp_sci','tmp_sst2','tmp_sst','buff_sst')
		SCI(:,:,m)=tmp_sci;
		SST(:,:,m)=tmp_sst2;
		MST(:,:,m)=buff_sst;
		PST(:,:,m)=psst;
	else
		length(zt);
	end	
end

comp_time=datevec(now);
if comp_time(4)<=12
	if comp_time(4)<10 & comp_time(5)<10
		tmp_time=['0',num2str(comp_time(4)),'0',num2str(comp_time(5)),'a'];
	elseif comp_time(4)<10 & comp_time(5)>10
		tmp_time=['0',num2str(comp_time(4)),num2str(comp_time(5)),'a'];	
	elseif comp_time(4)>10 & comp_time(5)>10
		tmp_time=[num2str(comp_time(4)),num2str(comp_time(5)),'a'];	
	elseif comp_time(4)>10 & comp_time(5)<10
		tmp_time=[num2str(comp_time(4)),'0',num2str(comp_time(5)),'a'];		
	end
else
	if comp_time(4)<22 & comp_time(5)<10
		tmp_time=['0',num2str(comp_time(4)-12),'0',num2str(comp_time(5)),'p'];
	elseif comp_time(4)<22 & comp_time(5)>10
		tmp_time=['0',num2str(comp_time(4)-12),num2str(comp_time(5)),'p'];	
	elseif comp_time(4)>22 & comp_time(5)<10
		tmp_time=[num2str(comp_time(4)-12),'0',num2str(comp_time(5)),'p'];	
	elseif comp_time(4)>22 & comp_time(5)>10	
		tmp_time=[num2str(comp_time(4)-12),num2str(comp_time(5)),'p'];	
	end
end	
fplot(nanmean(MST,3),mask,ran(1),ran(2),'fdcolor',[COMP_IMG_DIR '1d_buff_bdsc_'],pd,tmp_time,'sst')
fplot(nanmean(SCI,3),mask,ran(1),ran(2),'fdcolor',[COMP_IMG_DIR '1d_sci_bdsc_'],pd,tmp_time,'sst')
fplot(nanmean(OBS,3),mask,ran(1),ran(2),'fdcolor',[COMP_IMG_DIR '1d_all_bdsc_'],pd,tmp_time,'sst')
fplot(nanmean(SST,3),mask,ran(1),ran(2),'fdcolor',[COMP_IMG_DIR '1d_center_bdsc_'],pd,tmp_time,'sst')
fplot(nanmean(ASC,3),mask,ran(1),ran(2),'fdcolor',[COMP_IMG_DIR '1d_all_sci_bdsc_'],pd,tmp_time,'sst')

fplot(max(MST,[],3),mask,ran(1),ran(2),'fdcolor',[COMP_IMG_DIR '1d_max_buff_bdsc_'],pd,tmp_time,'sst')
fplot(max(PST,[],3),mask,ran(1),ran(2),'fdcolor',[COMP_IMG_DIR '1d_max_pgmask_bdsc_'],pd,tmp_time,'sst')
fplot(max(SCI,[],3),mask,ran(1),ran(2),'fdcolor',[COMP_IMG_DIR '1d_max_sci_bdsc_'],pd,tmp_time,'sst')
fplot(max(OBS,[],3),mask,ran(1),ran(2),'fdcolor',[COMP_IMG_DIR '1d_max_all_bdsc_'],pd,tmp_time,'sst')
fplot(max(SST,[],3),mask,ran(1),ran(2),'fdcolor',[COMP_IMG_DIR '1d_max_center_bdsc_'],pd,tmp_time,'sst')


%
end

cd(AVHRR_CUR_DIR)
!rm *
cd(HOME_DIR)	
