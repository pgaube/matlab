%
clear all
fname='mdt/uv/dt_ref_global_merged_madt_uv_20000105_20000105_20100503.nc';
pp=1;
ssh_id = netcdf.open([fname], 'NC_NOWRITE');
% Determine the dimensions of the domain
mlat = netcdf.getVar(ssh_id,netcdf.inqVarID(ssh_id,'NbLatitudes'));
mlon = netcdf.getVar(ssh_id,netcdf.inqVarID(ssh_id,'NbLongitudes'));
load ~/data/eddy/V5/mat/AVISO_25_W_2455483.mat lat lon

tmp=dir('mdt/h/*.nc');

%[mean_u,mean_v]=deal(zeros(length(mlat),length(mlon)));

for m=3:length(tmp)
    display(['loading file ',num2str(m),' of ',num2str(length(tmp)-3)])
    fname=num2str(getfield(tmp,{m},'name'));
    yea=str2num(fname(29:32));
    mon=str2num(fname(33:34));
    day=str2num(fname(35:36));
    jday=date2jd(yea,mon,day)+.5;
    tt = ncread(['mdt/h/',fname],'Grid_0001');
   
    %u = ncread(['mdt/',fname],'Grid_0001');
    %v = ncread(['mdt/',fname],'Grid_0002');
    mdt=interp2(mlon,mlat,tt,lon,lat,'linear');
    
    %{
figure(1)
    clf
    pmap(lon,lat,mdt)
    caxis([-120 150])
    title(fname)
    drawnow
    %}
    eval(['save -append ~/data/eddy/V5/mat/AVISO_25_W_',num2str(jday),'.mat mdt'])
    clear tt
end
return


mean_u(mean_u==0)=nan;
mean_v(mean_v==0)=nan;

%interp to schlax grid
load ~/data/eddy/V5/mat/AVISO_25_W_2455483.mat lat lon
u=interp2(mlon,mlat,mean_u,lon,lat,'linear');
v=interp2(mlon,mlat,mean_v,lon,lat,'linear');

spd=sqrt(u.^2+v.^2);
figure(1)
clf
pmap(lon,lat,spd);caxis([0 40]);

save mean_totat_geovel lat lon u v
%}
load mean_totat_geovel
st=10;
%streamline(lon,lat,u,v,lon(1:st:end,1:st:end),lat(1:st:end,1:st:end));
figure(1)
clf
spd=sqrt(u.^2+v.^2);
pmap(lon,lat,spd);
[xx,yy]=m_ll2xy(lon,lat);
[verts averts] = streamslice(xx,yy,u,v,10); 
%pcolor(lon,lat,spd);shading flat;axis image
caxis([0 20])
hold on
h=streamline([verts averts]);
set(h,'color','k','linewidth',1)
print -dpng -r300 test
!open test.png