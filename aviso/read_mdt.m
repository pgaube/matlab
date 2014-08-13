%{
clear all
fname='mdt/dt_ref_global_merged_madt_uv_20000105_20000105_20100503.nc';
pp=1;
ssh_id = netcdf.open([fname], 'NC_NOWRITE');
% Determine the dimensions of the domain
mlat = netcdf.getVar(ssh_id,netcdf.inqVarID(ssh_id,'NbLatitudes'));
mlon = netcdf.getVar(ssh_id,netcdf.inqVarID(ssh_id,'NbLongitudes'));

tmp=dir('mdt/*.nc');

[mean_u,mean_v]=deal(zeros(length(mlat),length(mlon)));

for m=3:length(tmp)
    fname=num2str(getfield(tmp,{m},'name'));
    m
    u = ncread(['mdt/',fname],'Grid_0001');
    v = ncread(['mdt/',fname],'Grid_0002');
    mean_u=nansum(cat(3,pp*mean_u,u),3)./(pp+1);
    mean_v=nansum(cat(3,pp*mean_v,v),3)./(pp+1);
    pp=pp+1;
    
    %{
    spd=sqrt(mean_u.^2+mean_v.^2);
    figure(1)
    clf
    pmap(mlon,mlat,spd);caxis([0 40]);
    %}
    clear u v
end
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