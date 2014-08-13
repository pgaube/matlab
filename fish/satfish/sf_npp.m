function sf_npp(region,rname)


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
global NPP_DARA_DIR
global NPP_DATA_ARC

set_satfish_1_delay
load(region)
maxlat=max(mlat(:));
minlat=min(mlat(:));
maxlon=max(mlon(:));
minlon=min(mlon(:));

cd(NPP_DATA_DIR)
!rm *

fobj = ftp('oceans.gsfc.nasa.gov');
pasv(fobj);
% cd(fobj,'/subscriptions/1382');
cd(fobj,'/VIIRS/XM/gaube/2263');
if d<10
    fnameg = ['V' num2str(s(1)) '00' num2str(d) '*L2*hdf'];
elseif d<100
    fnameg = ['V' num2str(s(1)) '0' num2str(d) '*L2*hdf'];
else
    fnameg = ['V' num2str(s(1)) num2str(d) '*L2*hdf'];
end
mget(fobj,fnameg)
close(fobj);

tmp=dir('V*NPP*');

CHL = nan(length(mlat(:,1)),length(mlon(1,:)),length(tmp(:,1)));
fCHL=CHL;
CHL = nan(length(mlat(:,1)),length(mlon(1,:)),length(tmp(:,1)));
fCHL=CHL;


for m=1:length(tmp)
	fname=num2str(getfield(tmp,{m},'name'));
	%if ~exist([NPP_DATA_ARC fname])
	eval(['!cp ' fname ' ' NPP_DATA_ARC]) 
	if fname(23:24)=='OC'
		type='OCEAN COLOR'
		chl = double(hdfread([NPP_DATA_DIR,fname],...
			'chlor_a','Index',{[1 1],[1 1],[]}));
		
		l2_flags=hdfread([NPP_DATA_DIR,fname],...
		'l2_flags','Index',{[1 1],[1 1],[]});
		l2_flags = uint32(2^31 + double(l2_flags)); % first, we need to get a form
		l2_flags = bitset(l2_flags,32,~bitget(l2_flags,32)); % we can use with bitget	

		lat = double(hdfread([NPP_DATA_DIR,fname],...
		'latitude','Index',{[1 1],[1 1],[]}));	
		lon = double(hdfread([NPP_DATA_DIR,fname],...
		'longitude','Index',{[1 1],[1 1],[]}));	
		time(m,:)=str2num(char(fname(9:12)));		
		
        %clearn up duplicate vlaues
        [C,IA,IC]=unique(lat);
        lat=lat(IA);
        lon=lon(IA);
        chl=chl(IA);
        l2_flags=l2_flags(IA);
        
        [C,IA,IC]=unique(lon);
        lat=lat(IA);
        lon=lon(IA);
        chl=chl(IA);
        l2_flags=l2_flags(IA);
      
      
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
            figure(1)
            clf
            pcolor(lon,lat,double(real(log10(chl))));caxis([cran(1) cran(2)]);shading flat;axis image
            eval(['print -dpng -r300 ',CLOUD_IMAGE_DIR,fname,'.png'])
			CHL(:,:,m) = griddata(lon,lat,full_chl,mlon,mlat,'linear');
			end
		end	
	%end
end
m

[s(2),s(3),s(1)]=jul2date(str2num(fname(6:8)),str2num(fname(2:5)));
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

chl=nanmean(log10(CHL),3);

tt=num2str(time(end,:))



sc=find(~isnan(chl));
perc=length(sc)./length(find(~isnan(mask(:))));

sfplot(chl,mask,cran(1),cran(2),'fdcolor',[CLOUD_IMAGE_DIR rname '_chl_'],pd,tt,'chl')

cd(HOME_DIR)