set(0,'DefaultFigureVisible','off')
clear all
close all
global DATA_DIR
global HOME_DIR
global IMAGE_DIR
global HDF_DIR
global MAT_DIR
global d
global s
global jd
global ran
global fran
global cran
global gran
global pd
global minlon
global maxlon
global minlat
global maxlat


set_fish_1_delay
cd(DATA_DIR)

xvec = [minlon maxlon];
yvec = [minlat maxlat];


if d<10
	base_dir = [num2str(s(1)) '/00' num2str(d)]
elseif d<100
	base_dir = [num2str(s(1)) '/0' num2str(d)]
else
	base_dir = [num2str(s(1)) '/' num2str(d)]
end

fobj = ftp('podaac.jpl.nasa.gov');
pasv(fobj);
cd(fobj,'/allData/ghrsst/data/L4/GLOB/UKMO/OSTIA/');
cd(fobj,base_dir)
mget(fobj,'*GLOB-v01-fv02-OSTIA.nc.bz2')
!bunzip2 *
tmp=dir('*.nc');
fname=num2str(getfield(tmp,{1},'name'));
lat=nc_varget([DATA_DIR fname],'lat');
lon=nc_varget([DATA_DIR fname],'lon');
sst=nc_varget([DATA_DIR fname],'analysed_sst');
sst=((sst-272.15)*(9/5))+31;
r=find(lat>=minlat & lat<=maxlat);
c=find(lon>=minlon & lon<=maxlon);



ghrsst=sst;
ghrlat=lat;
ghrlon=lon;
lat=lat(r);
lon=lon(c);
sst=sst(r,c);
[lon,lat]=meshgrid(lon,lat);
sst=fillnans(sst);
sst=griddata(lon,lat,sst,mlon,mlat,'CUBIC');
sst=sst.*mask;
bulk_temp=sst;
lon=mlon;
lat=mlat;
save([MAT_DIR,'pgSoCal_ghrsst',num2str(s(1)) num2str(d)],'ghr*','lat','lon','r','c','sst')

%now make ran
figure(100)
pcolor(sst)
ran=round(caxis.*10)./10;

[r,c]=imap(30+(5/6),32+(5/6),-118-(4/6),-116-(4/6),mlat,mlon);
clf
figure(100)
pcolor(sst(r,c))
ran2=round(caxis.*10)./10;
ran2=ran;

%adj
ran(1)=ran(1)-adjt_down;
ran(2)=ran(2)+adjt_up;
ran2(1)=ran2(1)-adjt_down-1;
ran2(2)=ran2(2)+adjt_up-1;
ran
ran2
save([HOME_DIR '/fishran'],'ran','ran2','bulk_temp')
tmp_fplot(sst,mask,ran(1)-1,ran(2)+1,'fdcolor',[L0_IMAGE_DIR 'bdsc_'],pd,['0102a'],'sst')
%fplot(sst,mask,ran(1)+adjt_down,ran(2)-adjt_up,'fdcolor',[IMAGE_DIR 'bdsc_'],pd,['0102a'],'sst')


!rm -r *

cd(HOME_DIR)