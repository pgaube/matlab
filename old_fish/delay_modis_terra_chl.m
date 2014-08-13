set(0,'DefaultFigureVisible','off')
clear all
close all
global DATA_DIR
global TERRA_DATA_DIR
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


set_fish
%{
%check for image
tt=dir(['~/fish//imagesc/terra_*',pd,'*']);
if length(tt)>0
error('terra image found')
return
end
%}

cd(TERRA_DATA_DIR)
!rm *
%set up constants and grid
slope=0.005; inter=0;
%lat = 30:0.00899928:35;
%lon = -121:0.00899928:-116;
lat = minlat:0.008:maxlat;
lon = minlon:0.008:maxlon;
[lngFnl,latFnl] = meshgrid(lon,lat);


%ftp data from OceanColor
fobj = ftp('oceans.gsfc.nasa.gov');
pasv(fobj);
cd(fobj,'/MODIST/XM/gaube/1582/');
if d<10
	fnameg = ['T' num2str(s(1)) '00' num2str(d) '*L2*.hdf']
elseif d<100
	fnameg = ['T' num2str(s(1)) '0' num2str(d) '*L2*hdf']
else
	fnameg = ['T' num2str(s(1)) num2str(d) '*L2*hdf']
end

mget(fobj,fnameg)
close(fobj);


tmp=dir('T*hdf');
chl = nan(length(lat),length(lon),length(tmp(:,1))-3);
CHL = chl;

if length(tmp)>0
for m=1:length(tmp)
	fname=num2str(getfield(tmp,{m},'name'));
	chl = double(hdfread([TERRA_DATA_DIR,fname],...
		'chlor_a','Index',{[1 1],[1 1],[]}));
		
	l2_flags=hdfread([TERRA_DATA_DIR,fname],...
		'l2_flags','Index',{[1 1],[1 1],[]});
	l2_flags = uint32(2^31 + double(l2_flags)); % first, we need to get a form
	l2_flags = bitset(l2_flags,32,~bitget(l2_flags,32)); % we can use with bitget	

	clat = double(hdfread([TERRA_DATA_DIR,fname],...
		'latitude','Index',{[1 1],[1 1],[]}));	
	clon = double(hdfread([TERRA_DATA_DIR,fname],...
		'longitude','Index',{[1 1],[1 1],[]}));	
	lat=interp2(clat,[1:(length(clat(1,:))-1)/length(chl(1,:)):length(clat(1,:))-(length(clat(1,:))-1)/length(chl(1,:))]',1:length(chl(:,1)),'linear');
				
	lon=interp2(clon,[1:(length(clon(1,:))-1)/length(chl(1,:)):length(clon(1,:))-(length(clon(1,:))-1)/length(chl(1,:))]',1:length(chl(:,1)),'linear');
				
	time(m,:)=str2num(fname(9:12));
	
	
	%first save full fields
	full_chl=chl;
	
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
	
	%now grid
	pass_chl = griddata(lon,lat,log10(chl),mlon,mlat,'linear');

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
	
	CHL(:,:,m) = griddata(lon,lat,log10(chl),lngFnl,latFnl,'linear');
	
	
end


lat=latFnl;
lon=lngFnl;

chl=griddata(lon,lat,nanmean(CHL,3),mlon,mlat,'linear');
lon=mlon;
lat=mlat;


save([MAT_DIR,'pgSoCal_modist_',num2str(s(1)) num2str(d)],'chl','CHL')



cd(HOME_DIR)

time=time(end)-800;
if time./100<12
	if tt<1000
		tt=['0' num2str(tt-300) 'a'];
	else
		tt=[num2str(tt-300) 'a'];
	end	
else
	tt=time-1200;
	if tt<1000
		tt=['0' num2str(tt-300) 'p'];
	else
		tt=[num2str(tt-300) 'p'];
	end	
end	

sc=find(~isnan(chl));
perc=length(sc)./length(find(~isnan(mask(:))));
fplot(chl,mask,cran(1),cran(2),'fdcolor',[IMAGE_DIR 'terra_chl_bdsc_'],pd,tt,'chl')

if perc>=.03
	%fplot(chl,mask,cran(1),cran(2),'fdcolor',[L0_IMAGE_DIR 'chl_bdsc_'],pd,tt,'chl')
end	


%}
end