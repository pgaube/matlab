set(0,'DefaultFigureVisible','off')
clear all
close all
global DATA_DIR
global HOME_DIR
global AQUA_DATA_DIR
global IMAGE_DIR
global HDF_DIR
global MAT_DIR
global COMP_MAT_DIR
global d
global s
global jd
global ran
global fran
global cran
global pd
global minlon
global maxlon
global minlat
global maxlat


set_fish_1_delay

%check for image
tt=dir(['~/fish//fd_web_images_arc/chl_*',pd,'*']);
%if length(tt)>0
%error('aqua image found')
%return
%end



cd(AQUA_DATA_DIR)
!rm *
%set up constants
slope=0.005; inter=0;

%ftp data from OceanColor
fobj = ftp('oceans.gsfc.nasa.gov');
pasv(fobj);
cd(fobj,'/MODISA/XM/gaube/1583/');
if d<10
	fnameg = ['A' num2str(s(1)) '00' num2str(d) '*L2*.hdf']
elseif d<100
	fnameg = ['A' num2str(s(1)) '0' num2str(d) '*L2*hdf']
else
	fnameg = ['A' num2str(s(1)) num2str(d) '*L2*hdf']
end

mget(fobj,fnameg)
close(fobj);
download='compleated'

tmp=dir('*hdf');
CHL = nan(length(mlat(:,1)),length(mlon(1,:)),length(tmp(:,1)));
SST = CHL;

if length(tmp)>0
for m=1:length(tmp)
	fname=num2str(getfield(tmp,{m},'name'));
	chl = double(hdfread([AQUA_DATA_DIR,fname],...
		'chlor_a','Index',{[1 1],[1 1],[]}));
	sst = double(hdfread([AQUA_DATA_DIR,fname],...
		'sst','Index',{[1 1],[1 1],[]}));	
	sst=slope*sst;		
	l2_flags=hdfread([AQUA_DATA_DIR,fname],...
		'l2_flags','Index',{[1 1],[1 1],[]});
	l2_flags = uint32(2^31 + double(l2_flags)); % first, we need to get a form
	l2_flags = bitset(l2_flags,32,~bitget(l2_flags,32)); % we can use with bitget	

	clat = double(hdfread([AQUA_DATA_DIR,fname],...
		'latitude','Index',{[1 1],[1 1],[]}));	
	clon = double(hdfread([AQUA_DATA_DIR,fname],...
		'longitude','Index',{[1 1],[1 1],[]}));	
	lat=interp2(clat,[1:(length(clat(1,:))-1)/length(chl(1,:)):length(clat(1,:))-(length(clat(1,:))-1)/length(chl(1,:))]',1:length(chl(:,1)),'linear');
				
	lon=interp2(clon,[1:(length(clon(1,:))-1)/length(chl(1,:)):length(clon(1,:))-(length(clon(1,:))-1)/length(chl(1,:))]',1:length(chl(:,1)),'linear');
				
	time(m,:)=str2num(fname(9:12));			
	
	%first save full fields
	full_chl=chl;
	full_sst=sst;
	
	% Use default flags from the OceanColor SeaDas processing notes. For the
	% Level 2 CHL imagery.
	%dfltBits = [1 2 4 5 6 9 10 11 13 15 16 17 20 22 23 26];
	%might need to use 4
	dfltBits = [1 2 4 10];
	for jBit = 1:length(dfltBits)
		flag = bitget(l2_flags,dfltBits(jBit));
		chl(flag == 1) = NaN; clear flag
	end
	chl(chl<0)=nan;
	% Use default flags from the OceanColor SeaDas processing notes. For the
	% Level 2 SST imagery the only flags to use are LAND, SSTWARN and SSTFAIL
	% (bits 2, 28 and 29).
	sst2=sst;
	dfltBits = [2 28 29];
	for jBit = 1:length(dfltBits)
		flag = bitget(l2_flags,dfltBits(jBit));
		sst(flag == 1) = NaN; clear flag
	end
	dfltBits = [2 29];
	%dfltBits = [1 2 4 10];

	for jBit = 1:length(dfltBits)
		flag = bitget(l2_flags,dfltBits(jBit));
		sst2(flag == 1) = NaN; clear flag
	end
	%subset data for FD domain
	[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
	if length(r)>0 & length(c)>0
		lat=lat(r,c);
		lon=lon(r,c);
		sst=sst(r,c);
		sst2=sst2(r,c);
		chl=chl(r,c);
		tt=griddata(mlon,mlat,mpass_land_mask,lon,lat);
		
		%do pmask
		pmask=nan*sst2;
		pmask((sst2.*(9/5))+31>min(ran)+3)=1;
		psst=sst2.*pmask;
		buffing_nans='started'
		psst=buffnan_rad(psst,5);
		psst(tt==1)=sst2(tt==1);
		%now grid
		interpilated='started'
		pass_chl = griddata(lon,lat,log10(chl),mlon,mlat,'linear');
		pass_sst = griddata(lon,lat,(sst.*(9/5))+31,mlon,mlat,'linear');
		pass_sst2 = griddata(lon,lat,(psst.*(9/5))+31,mlon,mlat,'linear');
		
		%Now check to see if adjacent grains
		tt=time(m);
		if tt./100<12
			tt=[num2str(tt) 'a'];
		else
			tt=tt-1200;
			if tt<1000
				tt=['0' num2str(tt) 'p'];
			else
				tt=[num2str(tt) 'p'];
			end	
		end	
	
		ty=pass_sst-bulk_temp;
		offset=nanmedian(ty(:));
		%plot each pass
		fplot(pass_chl,mask,cran(1),cran(2),'fdcolor',[IMAGE_DIR 'chl_bdsc_'],pd,tt,'chl')
		fplot(pass_sst,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR3 'bdsc_'],pd,tt,'sst')
		fplot(pass_sst2,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
	
		
		
		CHL(:,:,m) = pass_chl;
		SST(:,:,m) = pass_sst2;
	end
	
end



sst=nanmean(SST,3);
%smask=nan*sst;
%smask(~isnan(sst))=1;
%sm_sst=smoothn(sst,3).*smask;
%gradt=sqrt(dfdx(mlat,sm_sst,.01).^2+dfdy(sm_sst,.01).^2);

chl=nanmean(CHL,3);
lon=mlon;
lat=mlat;





cd(HOME_DIR)

	
figure(1)
clf
pcolor(sst)
tmran=round(10*caxis)./10;

time=time(end)-300;
if time./100<12
	if tt<1000
		tt=['0' num2str(tt) 'a'];
	else
		tt=[num2str(tt) 'a'];
	end	
else
	tt=time-1200;
	if tt<1000
		tt=['0' num2str(tt) 'p'];
	else
		tt=[num2str(tt) 'p'];
	end	
end	

st=find(~isnan(sst));
pert=length(st)./length(find(~isnan(mask(:))));

sc=find(~isnan(chl));
perc=length(sc)./length(find(~isnan(mask(:))));

fplot(sst,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
fplot(chl,mask,cran(1),cran(2),'fdcolor',[IMAGE_DIR 'chl_bdsc_'],pd,tt,'chl')
%fplot(big_sst+offset,mask,ran(1),ran(2),'fdcolor',[L0_IMAGE_DIR 'bdsc_'],pd,tt,'sst')
%fplot(gradt,mask,fran(1),fran(2),'pjet',[IMAGE_DIR 'moa_bz_'],pd,tt,'sst')

%
if perc>=.03
	%fplot(chl,mask,cran(1),cran(2),'fdcolor',[L0_IMAGE_DIR 'chl_bdsc_'],pd,tt,'chl')
end	
%{
if pert>=.03
	fplot(sst,mask,ran(1),ran(2),'fdcolor',[L0_IMAGE_DIR 'bdsc_'],pd,tt,'sst')
end
%}
end
save([MAT_DIR,'pgSoCal_modisa_',num2str(s(1)) num2str(d)],'SST','CHL','per*','tt','pd')
