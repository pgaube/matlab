set_nb
mlat=flipud(mlat);
mask=flipud(mask);
d=[332,336,340,342,344];

AQUA_DATA_DIR=DATA_DIR;

%set up constants and grid
slope=0.005; inter=0;
%lat = 30:0.00899928:35;
%lon = -121:0.00899928:-116;
lat = minlat:0.01:maxlat;
lon = minlon:0.01:maxlon;
[lngFnl,latFnl] = meshgrid(lon,lat);
cd(AQUA_DATA_DIR)
!rm *

for m=[5]%:length(d)
%ftp data from OceanColor
fobj = ftp('oceans.gsfc.nasa.gov');
pasv(fobj);
cd(fobj,'/MODISA/XM/gaube/1583/');
if d<10
	fnameg = ['A' num2str(s(1)) '00' num2str(d(m)) '*L2*.hdf']
elseif d<100
	fnameg = ['A' num2str(s(1)) '0' num2str(d(m)) '*L2*hdf']
else
	fnameg = ['A' num2str(s(1)) num2str(d(m)) '*L2*hdf']
end

mget(fobj,fnameg)
close(fobj);


tmp=dir('*hdf');
chl = nan(length(lat),length(lon),length(tmp(:,1))-3);
CHL = chl;
SST = CHL;

if length(tmp)>0
for m=1:length(tmp)
	fname=num2str(getfield(tmp,{m},'name'));
	chl = double(hdfread([AQUA_DATA_DIR,fname],...
		'chlor_a','Index',{[1 1],[1 1],[]}));		
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
	
	CHL(:,:,m) = griddata(lon,lat,log10(chl),lngFnl,latFnl,'linear');
	
	
end

lat=latFnl;
lon=lngFnl;

chl=griddata(lon,lat,nanmean(CHL,3),mlon,mlat,'linear');
lon=mlon;
lat=mlat;

cd(HOME_DIR)
new_fplot(fliplr(chl),fliplr(mask),cran(1),cran(2),'fdcolor',[ '~/Desktop/stuff_for_india/NB/moa_chl_'],['10120',num2str(m)],'1932','chl')
end
end

