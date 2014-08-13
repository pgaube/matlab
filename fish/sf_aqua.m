%function sf_aqua(region)
region='sc_sf_mask'

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

set_satfish_1_delay
load(region)
maxlat=max(mlat(:));
minlat=min(mlat(:));
maxlon=max(mlon(:));
minlon=min(mlon(:));

cd(AQUA_DATA_DIR)
!rm *
%set up constants
slope=0.005; inter=0;

%ftp data from OceanColor
fobj = ftp('oceans.gsfc.nasa.gov');
pasv(fobj);
cd(fobj,'/subscriptions/1022');
if d<10
	fnameg = ['A' num2str(s(1)) '00' num2str(d) '*L2*.bz2'];
elseif d<100
	fnameg = ['A' num2str(s(1)) '0' num2str(d) '*L2*bz2'];
else
	fnameg = ['A' num2str(s(1)) num2str(d) '*L2*bz2'];
end

mget(fobj,fnameg)
close(fobj);

tmp=dir('A*OC*');
CHL = nan(length(mlat(:,1)),length(mlon(1,:)),length(tmp(:,1)));
fCHL=CHL;


for m=1:length(tmp)
	fname=num2str(getfield(tmp,{m},'name'));
	%if ~exist([AQUA_DATA_ARC fname])
	eval(['!cp ' fname ' ' AQUA_DATA_ARC]) 
	eval(['!rm ' fname])
	eval(['!/usr/local/bin/wget http://oceandata.sci.gsfc.nasa.gov/cgi/getfile/' fname])
	%eval(['!cp ' fname  ' ' HDF_DIR]);
	eval(['!bunzip2 ' fname])
	if fname(23:24)=='OC'
		type='OCEAN COLOR'
		chl = double(hdfread([AQUA_DATA_DIR,fname(1:25)],...
			'chlor_a','Index',{[1 1],[1 1],[]}));
		
		l2_flags=hdfread([AQUA_DATA_DIR,fname(1:25)],...
		'l2_flags','Index',{[1 1],[1 1],[]});
		l2_flags = uint32(2^31 + double(l2_flags)); % first, we need to get a form
		l2_flags = bitset(l2_flags,32,~bitget(l2_flags,32)); % we can use with bitget	

		lat = double(hdfread([AQUA_DATA_DIR,fname(1:25)],...
		'latitude','Index',{[1 1],[1 1],[]}));	
		lon = double(hdfread([AQUA_DATA_DIR,fname(1:25)],...
		'longitude','Index',{[1 1],[1 1],[]}));	
		time(m,:)=str2num(char(fname(9:12)));		
		
		%first save full fields
		full_chl=chl;
		
		% Use default flags from the OceanColor SeaDas processing notes. For the
		% Level 2 CHL imagery.
		%dfltBits = [1 2 4  5 6 9 10 11 13 15 16 17 20 22 23 26];
		%might need to use 4
	    dfltBits = [1 2 4 10];
		for jBit = 1:length(dfltBits)
			flag = bitget(l2_flags,dfltBits(jBit));
			chl(flag == 1) = NaN; clear flag
		end	
		[r,c]=imap(minlat-4,maxlat+4,minlon-4,maxlon+4,lat,lon);
		if length(r)>0 & length(c)>0
			lat=lat(r,c);
			lon=lon(r,c);
			chl=chl(r,c);
			full_chl=full_chl(r,c);
			interpalation='started'
			CHL(:,:,m) = griddata(lon,lat,chl,mlon,mlat,'nearest');
			%fCHL(:,:,m) = griddata(lon,lat,full_chl,mlon,mlat,'linear');
			end
		end	
	%end
end
m


chl=nanmean(log10(CHL),3);

tt=num2str(time(end,:)-800)



sc=find(~isnan(chl));
perc=length(sc)./length(find(~isnan(mask(:))));

sfplot(chl,mask,cran(1),cran(2),'fdcolor',[CLOUD_IMAGE_DIR rname 't_chl_'],pd,tt,'chl')

cd(HOME_DIR)