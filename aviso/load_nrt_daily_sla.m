%
clear all
fname='sla/nrt/nrt_global_merged_msla_h_20140506_20140506_20140506.nc';
pp=1;
ssh_id = netcdf.open([fname], 'NC_NOWRITE');
% Determine the dimensions of the domain
mlat = netcdf.getVar(ssh_id,netcdf.inqVarID(ssh_id,'NbLatitudes'));
mlon = netcdf.getVar(ssh_id,netcdf.inqVarID(ssh_id,'NbLongitudes'));
load ~/data/eddy/V5/mat/AVISO_25_W_2455483.mat lat lon
tmp=dir('sla/nrt/nrt_global_merged_msla_h_2014*.nc');

%[mean_u,mean_v]=deal(zeros(length(mlat),length(mlon)));

for m=1:length(tmp)
    display(['loading file ',num2str(m),' of ',num2str(length(tmp)-3)])
    fname=num2str(getfield(tmp,{m},'name'))
    yea=str2num(fname(26:29))
    mon=str2num(fname(30:31))
    day=str2num(fname(32:33))
    jday=date2jd(yea,mon,day)+.5
    tt = ncread(['sla/nrt/',fname],'Grid_0001');
   
    %u = ncread(['mdt/',fname],'Grid_0001');
    %v = ncread(['mdt/',fname],'Grid_0002');
    total_ssh=interp2(mlon,mlat,tt,lon,lat,'linear');
    ssh=total_ssh-smooth2d_loess(total_ssh,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
    
    figure(1)
    clf
    pmap(lon,lat,total_ssh)
    caxis([-50 50])
    title(fname)
    drawnow
    
    eval(['save ~/data/aviso/mat/AVISO_25_NRT_',num2str(jday),' lon lat total_ssh ssh'])
    clear tt
end
