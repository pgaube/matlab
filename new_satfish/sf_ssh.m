
function sf_ssh(region,rname)

set(0,'DefaultFigureVisible','off')
close all


set_satfish_3_delay
load(region)
load([HOME_DIR '/' rname '_fishran'])
mlon=180+(180+mlon);

maxlat=max(mlat(:));
minlat=min(mlat(:));
maxlon=max(mlon(:));
minlon=min(mlon(:));

cd(SSH_DIR)

if d<10
    fname = ['ssha_global_wrt_mean_',num2str(s(1)) '00' num2str(d) '.nc'];
elseif d<100
    fname = ['ssha_global_wrt_mean_',num2str(s(1)) '0' num2str(d) '.nc'];
else
    fname = ['ssha_global_wrt_mean_',num2str(s(1)) num2str(d) '.nc'];
end
fobj = ftp('eddy.colorado.edu','pgaube','Vg3aMd');
% pasv(fobj)
eval(['cd(fobj,' char(39) '/ssh/realtime/data_grd/Global/' num2str(s(1)) char(39) ')'])
mget(fobj,fname)
close(fobj)
lat=nc_varget([SSH_DIR fname],'lat');
lon=nc_varget([SSH_DIR fname],'lon');
ssh=nc_varget([SSH_DIR fname],'ssh');

[lon,lat]=meshgrid(lon,lat);
[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
[u,v]=geostro(lon,lat,ssh,.25);


ssh_mask=nan*ssh;
ssh_mask(~isnan(ssh))=1;
u=buffnan_neighbor(u,ssh_mask,2);
v=buffnan_neighbor(v,ssh_mask,2);

ssh=smoothn(ssh,10);

pssh=griddata(lon,lat,ssh,mlon,mlat,'linear').*mask;

lon=lon(r,c);
lat=lat(r,c);
u=u(r,c);
v=v(r,c);

if s(2)<10 & s(3)<10
    pd=[num2str(s(1)-2000) '0' num2str(s(2)) '0' num2str(s(3))];
elseif s(2)>=10 & s(3)<10
    pd=[num2str(s(1)-2000) num2str(s(2)) '0' num2str(s(3))];
elseif s(2)<10 & s(3)>=10
    pd=[num2str(s(1)-2000) '0' num2str(s(2)) num2str(s(3))];
else
    pd=[num2str(s(1)-2000) num2str(s(2)) num2str(s(3))];
end

if region=='~/satfish/mask/ca1_mask'
    sfplot(pssh,mask,-7,7,'fdcolor',[CA1_IMAGE_DIR rname '_ssh_'],pd,'2000','sst')
elseif region=='~/satfish/mask/wa1_mask'
    sfplot(pssh,mask,-7,7,'fdcolor',[CA1_IMAGE_DIR rname '_ssh_'],pd,'2000','sst')
elseif region=='~/satfish/mask/ne1_mask'
    sfplot(pssh,mask,-40,40,'fdcolor',[CA1_AUTO_IMAGE_DIR rname '_ssh_'],pd,'2000','ssh')
    sfplot_quiver(u,v,lon,lat,[CA1_AUTO_IMAGE_DIR rname '_cur_'],pd,'2300')
end

% save([MAT_DIR,rname,'_ssh_',num2str(s(1)) num2str(d)],'ssh','pssh','pu','pv','u','v')
eval(['!rm ',fname])
cd(HOME_DIR)
