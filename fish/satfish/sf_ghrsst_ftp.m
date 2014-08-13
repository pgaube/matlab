function sf_ghrsst_ftp(region,rname)

set(0,'DefaultFigureVisible','off')
%clear all



set_satfish_1_delay
load(region)
maxlat=max(mlat(:));
minlat=min(mlat(:));
maxlon=max(mlon(:));
minlon=min(mlon(:))



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
%pasv(fobj);
cd(fobj,'/allData/ghrsst/data/L4/GLOB/UKMO/OSTIA/');
cd(fobj,base_dir)
mget(fobj,'*GLOB-v01-fv02-OSTIA.nc.bz2')
!bunzip2 *
tmp=dir('*.nc');
fname=num2str(getfield(tmp,{1},'name'))
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
save([MAT_DIR,rname,'_ghrsst',num2str(s(1)) num2str(d)],'ghr*','lat','lon','r','c','sst')

%now make ran
 if region=='mask/ca1_mask'
    [r,c]=imap(minlat+2,maxlat-2,minlon-3,maxlon+8,lat,lon);
 else
     r=1:length(lat(:,1));
     c=1:length(lon(1,:));
 end

figure(100)
pcolor(sst(r,c));shading flat
ran=round(caxis.*10)./10;

%{
[r,c]=imap(30+(5/6),32+(5/6),-118-(4/6),-116-(4/6),mlat,mlon);
clf
figure(100)
pcolor(sst(r,c))
ran2=round(caxis.*10)./10;
%}

%adj
%ran(1)=ran(1)-adjt_down;
%ran(2)=ran(2)+adjt_up;
cd([HOME_DIR '/satfish'])
set_satfish
[s(2),s(3),s(1)]=jul2date(d,s(1));
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


save([HOME_DIR '/' rname '_fishran'],'ran','bulk_temp')
sfplot(sst,mask,ran(1),ran(2),'fdcolor',[CA1_IMAGE_DIR rname '_fsst_'],pd,['0102'],'sst')

cd(DATA_DIR)
!rm -r *


%%%Now plot all the subregions
mmlon=mlon;
mmlat=mlat;
sst=fillnans(sst);
if region=='mask/ca1_mask'
    for nsub=2%:6
        rname=['ca',num2str(nsub)]
        outdir=[HOME_DIR,'ca',num2str(nsub),'_out'];
        load([HOME_DIR,'/satfish/mask/ca',num2str(nsub),'_mask'])
        
        dsst=griddata(mmlon,mmlat,sst,mlon,mlat,'CUBIC');
        whos sst mask
        dsst=dsst.*mask;
        figure(100)
        pcolor(dsst(r,c));shading flat
        ran=round(caxis.*10)./10;
        save([HOME_DIR '/' rname '_fishran'],'ran')
        sfplot(dsst,mask,ran(1),ran(2),'fdcolor',[outdir rname '_fsst_'],pd,['0102'],'sst')
    end
end


cd(HOME_DIR)