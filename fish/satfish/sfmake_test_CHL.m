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

cd ~/fish/satfish/aqua_data/arc

%set up constants
slope=0.005; inter=0;
fname='A20103332010335.L3b_3D_4km_CHL.main'

		chl = double(hdfread([fname],...
			'chlor_a','Index',{[1 1],[1 1],[]}));
		return
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