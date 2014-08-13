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
global cran
global pd
global minlon
global maxlon
global minlat
global maxlat


set_fish_1_delay
%set_fish

cd(DATA_DIR)

%set up constants and grid
slope=0.005; inter=0;
%lat = 30:0.00899928:35;
%lon = -121:0.00899928:-116;
lat = minlat:0.01:maxlat;
lon = minlon:0.01:maxlon;
[lngFnl,latFnl] = meshgrid(lon,lat);

%ftp data from OceanColor
fobj = ftp('oceans.gsfc.nasa.gov');
pasv(fobj);
cd(fobj,'/MODIST/XM/gaube/1582/');
if d<10
	fnameg = ['T' num2str(s(1)) '00' num2str(d) '*L2*.hdf'];
elseif d<100
	fnameg = ['T' num2str(s(1)) '0' num2str(d) '*L2*hdf'];
else
	fnameg = ['T' num2str(s(1)) num2str(d) '*L2*hdf'];
end

mget(fobj,fnameg)
close(fobj);
eval(['!cp *.hdf ' HDF_DIR]);


tmp=dir('*hdf');
SST = nan(length(mlat(:,1)),length(mlon(1,:)),length(tmp(:,1))-3);



for m=1:length(tmp)
	fname=num2str(getfield(tmp,{m},'name'));
	sst = double(hdfread([DATA_DIR,fname],...
		'sst','Index',{[1 1],[1 1],[]}));	
	sst=slope*sst;		
	l2_flags=hdfread([DATA_DIR,fname],...
		'l2_flags','Index',{[1 1],[1 1],[]});
	l2_flags = uint32(2^31 + double(l2_flags)); % first, we need to get a form
	l2_flags = bitset(l2_flags,32,~bitget(l2_flags,32)); % we can use with bitget	

	clat = double(hdfread([DATA_DIR,fname],...
		'latitude','Index',{[1 1],[1 1],[]}));	
	clon = double(hdfread([DATA_DIR,fname],...
		'longitude','Index',{[1 1],[1 1],[]}));	
	lat=interp2(clat,[1:(length(clat(1,:))-1)/length(chl(1,:)):length(clat(1,:))-(length(clat(1,:))-1)/length(chl(1,:))]',1:length(chl(:,1)),'linear');
				
	lon=interp2(clon,[1:(length(clon(1,:))-1)/length(chl(1,:)):length(clon(1,:))-(length(clon(1,:))-1)/length(chl(1,:))]',1:length(chl(:,1)),'linear');
				
	time(m,:)=str2num(fname(9:12));			
	
	% Use default flags from the OceanColor SeaDas processing notes. For the
	% Level 2 SST imagery the only flags to use are LAND, SSTWARN and SSTFAIL
	% (bits 2, 28 and 29).
	dfltBits = [2 28 29];
	for jBit = 1:length(dfltBits)
		flag = bitget(l2_flags,dfltBits(jBit));
		sst(flag == 1) = NaN; clear flag
	end
	%now grid
	SST(:,:,m) = griddata(lon,lat,(sst.*(9/5))+32,mlon,mlat,'linear');
	
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
	ty=SST(:,:,m)-bulk_temp;
	offset=nanmedian(ty(:));
	%plot each pass
	fplot(SST(:,:,m)+offset,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
end

lon=mlon;
lat=mlat;

sst=nanmean(SST,3);
big_sst=sst;
smask=nan*sst;
smask(~isnan(sst))=1;
sm_sst=smoothn(big_sst,3).*smask;
gradt=sqrt(dfdx(lat,sm_sst,.003).^2+dfdy(sm_sst,.003).^2);



ty=big_sst-bulk_temp;
offset=nanmedian(ty(:));

save([MAT_DIR,'pgSoCal_modist_',num2str(s(1)) num2str(d)],'big_sst')



cd(HOME_DIR)

	
figure(1)
clf
pcolor(big_sst+offset)
tmran=round(10*caxis)./10

tt=time(1);
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

fplot(big_sst+offset,mask,ran(1),ran(2),'fdcolor',[L0_IMAGE_DIR 'bdsc_'],pd,tt,'sst')
fplot(big_sst+offset,mask,tmran(1),tmran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
fplot(big_sst+offset,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
fplot(gradt,mask,fran(1),fran(2),'pjet',[IMAGE_DIR 'mot_bz_'],pd,tt,'sst')
