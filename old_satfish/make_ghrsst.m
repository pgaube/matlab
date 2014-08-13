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


set_nb
mask=fliplr(mask);
mlon=fliplr(mlon);
s=datevec(date);
jd=date2jd(s(1),s(2),s(3))+.5;
[s(1),s(2),s(3)]=jd2jdate(jd-1);
d=julian(s(2),s(3),s(1),s(1));

cd(DATA_DIR)

xvec = [minlon maxlon];
yvec = [minlat maxlat];


load([FISH_DIR,'/mat/pgSoCal_ghrsst',num2str(s(1)) num2str(d)],'ghr*')

r=find(ghrlat>=minlat & ghrlat<=maxlat);
c=find(ghrlon>=minlon & ghrlon<=maxlon);

lat=ghrlat(r);
lon=ghrlon(c);
sst=ghrsst(r,c);
[lon,lat]=meshgrid(lon,lat);
sst=fillnans(sst);
sst=griddata(lon,lat,sst,mlon,mlat,'linear');
sst=sst.*mask;
bulk_temp=sst;
lon=mlon;
lat=mlat;
save([MAT_DIR,'nb_ghrsst_',num2str(s(1)) num2str(d)],'lat','lon','r','c','sst')

%now make ran
figure(100)
pcolor(sst)
ran=round(caxis.*10)./10;
%adj
ran(1)=ran(1)-adjt_down;
ran(2)=ran(2)+adjt_up;
save([HOME_DIR '/fishran'],'ran','bulk_temp')
fplot(sst,mask,ran(1)+adjt_down,ran(2)-adjt_up,'fdcolor',[L0_IMAGE_DIR 'bdsc_'],pd,['0102a'],'sst')
fplot(sst,mask,ran(1)+adjt_down,ran(2)-adjt_up,'fdcolor',[IMAGE_DIR 'bdsc_'],pd,['0102a'],'sst')


!rm -r *

cd(HOME_DIR)