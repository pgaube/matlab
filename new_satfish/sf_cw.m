function sf_cw(region,rname)

% set(0,'DefaultFigureVisible','off')
%clear all



set_satfish
load(region)
load([HOME_DIR '/' rname '_fishran'])

maxlat=max(mlat(:));
minlat=min(mlat(:));
maxlon=max(mlon(:));
minlon=min(mlon(:));


cd(CW_DIR)




xvec = [minlon maxlon];
yvec = [minlat maxlat];

vo = [datenum(s(1),s(2),s(3)) datenum(s(1),s(2),s(3))];
v1 = [datenum(s(1),s(2),s(3)) datenum(s(1),s(2),s(3)+1)];


[sstn nlon nlat ntime] = xtracto_3D_bdap(xvec,yvec,v1,'TATsstnhday');
[sstd dlon dlat dtime] = xtracto_3D_bdap(xvec,yvec,v1,'TATsstdhday');


%first do night
if ndims(sstn)>2
    for m=1:length(sstn(:,1,1,1))
        [lon,lat]=meshgrid(nlon,nlat);
        smask=nan*squeeze(sstn(m,:,:,:));
        smask(~isnan(squeeze(sstn(m,:,:,:))))=1;
        sm_sstn=smoothn(squeeze(sstn(m,:,:,:)),3).*smask;
        gradtn=sqrt(dfdx(lat,sm_sstn,.01).^2+dfdy(sm_sstn,.01).^2);
        
        tmp_sstn=griddata(lon,lat,squeeze(sstn(m,:,:,:)),mlon,mlat,'linear');
        gradtn=griddata(lon,lat,gradtn,mlon,mlat,'linear');
        tmp_sstn=tmp_sstn.*mask;
        gradtn=gradtn.*mask;
        
        lon=mlon;
        lat=mlat;
        tmp_time=datestr(ntime(m));
        tt=num2str([tmp_time(13:14) tmp_time(16:17)]);
        sst=tmp_sstn.*(9/5)+32;

        sfplot(sst,mask,ran(1),ran(2),'fdcolor',[CA1_IMAGE_DIR rname '_bdsc_'],pd,tt,'sst')
        
    end
end
cd(HOME_DIR)
end



