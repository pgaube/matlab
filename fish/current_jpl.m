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


set_fish_2_delay
cd(DATA_DIR)
!rm -r *JPL_OUROCEAN*
xvec = [minlon maxlon];
yvec = [minlat maxlat];


if d<10
	base_dir = [num2str(s(1)) '/00' num2str(d)]
elseif d<100
	base_dir = [num2str(s(1)) '/0' num2str(d)]
else
	base_dir = [num2str(s(1)) '/' num2str(d)]
end

fobj = ftp('podaac-ftp.jpl.nasa.gov');
pasv(fobj);
cd(fobj,'/OceanTemperature/ghrsst/data/L4/GLOB/JPL_OUROCEAN/G1SST/');
cd(fobj,base_dir)
mget(fobj,'*JPL_OUROCEAN-L4UHfnd-GLOB-v01-fv01_0-G1SST.nc.bz2')
!bunzip2 *
tmp=dir('*.nc');
fname=num2str(getfield(tmp,{1},'name'));

ncid=netcdf.open([DATA_DIR fname], 'NC_NOWRITE');
lat=double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lat')));
lon=double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lon')));
r=find(lat>=minlat & lat<=maxlat);
c=find(lon>=minlon & lon<=maxlon);
sst=double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'analysed_sst'),[c(1) r(1) 1-1],[length(c) length(r) 1]));

%{
lat=nc_varget([DATA_DIR fname],'lat');
lon=nc_varget([DATA_DIR fname],'lon');
time=nc_varget([DATA_DIR fname],'time');
r=find(lat>=minlat & lat<=maxlat);
c=find(lon>=minlon & lon<=maxlon);
sst=netcdf.getvar([DATA_DIR fname],'analysed_sst',[c(1) r(1) 1],[length(c) length(r) 1]);
%}
sst(sst<-1000)=nan;
sst=.01*((double(sst')-273.15)*(9/5))+31;

%adjust
sst=sst+5;
lat=lat(r);
lon=lon(c);
ghrsst=sst;
ghrlat=lat;
ghrlon=lon;
[lon,lat]=meshgrid(lon,lat);
sst=fillnans(sst);
sst=griddata(lon,lat,sst,mlon,mlat,'CUBIC');
sst=sst.*mask;
bulk_temp=sst;
lon=mlon;
lat=mlat;
%save([MAT_DIR,'pgSoCal_ghrsst',num2str(s(1)) num2str(d)],'ghr*','lat','lon','r','c','sst')

tmp_fplot(sst,mask,ran(1)-1,ran(2)+1,'fdcolor',[IMAGE_DIR 'bdsc_'],pd,['0103a'],'sst')
%tmp_fplot(sst,mask,ran(1)-1,ran(2)-3,'fdcolor',[L0_IMAGE_DIR 'bdsc_'],pd,['0102a'],'sst')
%fplot(sst,mask,ran(1)+adjt_down,ran(2)-adjt_up,'fdcolor',[IMAGE_DIR 'bdsc_'],pd,['0102a'],'sst')


!rm -r *

cd(HOME_DIR)