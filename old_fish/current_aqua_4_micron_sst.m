set(0,'DefaultFigureVisible','off')
clear all
close all
global AQUA_DATA_ARC
global TERRA_DATA_ARC
global AQUA_DATA_DIR
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

tmp=dir('A*SST4.*');
SST = nan(length(mlat(:,1)),length(mlon(1,:)),length(tmp(:,1)));



for m=1:length(tmp)
	fname=num2str(getfield(tmp,{m},'name'));
	%if ~exist([AQUA_DATA_ARC fname])
	eval(['!cp ' fname ' ' AQUA_DATA_ARC]) 
	eval(['!rm ' fname])
	eval(['!/usr/local/bin/wget http://oceandata.sci.gsfc.nasa.gov/cgi/getfile/' fname])
	%eval(['!cp ' fname  ' ' HDF_DIR]);
	eval(['!bunzip2 ' fname])
	
	if fname(23:26)=='SST4'
		TYPE='SST4'
		sst = double(hdfread([AQUA_DATA_DIR,fname(1:25)],...
			'/sst','Index',{[1 1],[1 1],[]}));	
		sst=slope*sst;
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
		full_sst=sst;
	
		% Use default flags from the OceanColor SeaDas processing notes. For the
		% Level 2 SST imagery the only flags to use are LAND, SSTWARN and SSTFAIL
		% (bits 2, 28 and 29).
		dfltBits = [2 28 29];
		for jBit = 1:length(dfltBits)
			flag = bitget(l2_flags,dfltBits(jBit));
			sst(flag == 1) = NaN; clear flag
		end
		[r,c]=imap(minlat-4,maxlat+4,minlon-4,maxlon+4,lat,lon);
		if length(r)>0 & length(c)>0
			lat=lat(r,c);
			lon=lon(r,c);
			sst=sst(r,c);
			%{
			%do pmask
			pmask=nan*sst;
			pmask((sst.*(9/5))+31>min(ran)+3)=1;
			sst=sst.*pmask;
			buffing_nans='started'
			sst=buffnan_rad(sst,5);
			sst(tt==1)=sst(tt==1);
			%}
			interpalation='started'
			SST(:,:,m) = griddata(lon,lat,sst,mlon,mlat,'linear');
		end	
		%
	end	
end

sst=max(SST,[],3);



save([MAT_DIR,'pgSoCal_modisa_4_micron_sst_',num2str(s(1)) num2str(d)])

for m=1:length(SST(1,1,:))
	tt=time(m,:)-800
	if tt./100<12
		if tt<1000
			tt=['0' num2str(tt) 'a'];
		else
			tt=[num2str(tt) 'a'];
		end	
	else
		tt=tt-1200;
		if tt<100
			tt=['00' num2str(tt) 'p'];
		elseif tt<1000
			tt=['0' num2str(tt) 'p'];
		else
			tt=[num2str(tt) 'p'];
		end	
	end	
	tt
	fplot((9/5)*squeeze(SST(:,:,m))+31,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
end

tt=time(end,:)-800
if tt./100<12
	if tt<1000
		tt=['0' num2str(tt) 'a'];
	else
		tt=[num2str(tt) 'a'];
	end	
else
	tt=tt-1200;
	if tt<100
		tt=['12' num2str(tt) 'p'];
	elseif tt<1000
		tt=['0' num2str(tt) 'p'];
	else
		tt=[num2str(tt) 'p'];
	end	
end	


st=find(~isnan(sst));
pert=length(st)./length(find(~isnan(mask(:))));

fplot((9/5)*sst+31,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
fplot((9/5)*sst+31,mask,ran2(1),ran2(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
fplot((9/5)*sst+31,mask,ran(1),ran(2)-1,'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')



cd(HOME_DIR)