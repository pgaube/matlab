function sf_aqua(region,rname)


set(0,'DefaultFigureVisible','off')
close all

set_satfish
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
	fnameg = ['A' num2str(s(1)) '00' num2str(d) '*L2*OC.bz2'];
elseif d<100
	fnameg = ['A' num2str(s(1)) '0' num2str(d) '*L2*OC.bz2'];
else
	fnameg = ['A' num2str(s(1)) num2str(d) '*L2*OC.bz2'];
end

mget(fobj,fnameg)
close(fobj);

tmp=dir('A*OC*');
CHL = nan(length(mlat(:,1)),length(mlon(1,:)),length(tmp(:,1)));
fCHL=CHL;


for m=1:length(tmp)
	fname=num2str(getfield(tmp,{m},'name'));
	if ~exist([AQUA_DATA_ARC fname])
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
	end
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

sfplot(chl,mask,cran(1),cran(2),'fdcolor',[CA1_IMAGE_DIR rname '_chl_'],pd,tt,'chl')

cd(HOME_DIR)