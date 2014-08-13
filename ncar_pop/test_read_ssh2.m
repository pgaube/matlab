clear all
close all
load chelle.pal

pop_path='/glade/scratch/mclong/hi-res-eco/g.e11.G.T62_t12.eco.002/ocn/hist/';

dir_list=dir([pop_path 'g.e11.G.T62_t12.eco.002.pop.h.0*nc']);
fname=[pop_path getfield(dir_list(1),'name')];
tmp=nc.read(fname,'TLAT');
lat=squeeze(tmp.var.TLAT);
lat=[lat(:,1101:end) lat(:,1:1100)];
tmp=nc.read(fname,'TLONG');
lon=squeeze(tmp.var.TLONG);
lon=[lon(:,1101:end) lon(:,1:1100)];
[r,c]=imap(-50,50,0,360,lat,lon);
tlon=lon(r,c);
tlat=lat(r,c);

tmp=nc.read(fname,'HT');
depth=squeeze(tmp.var.HT);
depth=[depth(:,1101:end) depth(:,1:1100)];
depth=depth(r,c);
mask=nan*depth;
mask(depth>100)=1;

for m=1:length(dir_list)
    fname=[pop_path getfield(dir_list(m),'name')]
    tmp=nc.read(fname,'SSH');
    rr=squeeze(tmp.var.SSH);
    ssh=[rr(:,1101:end) rr(:,1:1100)];
    ssh=ssh(r,c);
    figure(1)
    set(gcf,'renderer','painters')
    set(gcf,'Visible','off')
    pcolor(tlon,tlat,ssh.*mask);caxis([-80 80]);colormap(chelle);shading flat;axis image
    title(fname)
    colorbar
    eval(['print -dpng -r300 SSH_',num2str(m),'.png'])
    
    tmp=nc.read(fname,'spChl')
    rr=squeeze(tmp.var.spChl(1,:,:,:));
    tt=squeeze(nansum(rr,1));
    chl=[tt(:,1101:end) tt(:,1:1100)];
    chl=chl(r,c);
    min(tt(:))
    max(tt(:))
    clf
    pcolor(tlon,tlat,chl);caxis('auto');colormap(chelle);shading flat;axis image
    title(fname)
    colorbar
    eval(['print -dpng -r300 CHL_',num2str(m),'.png'])
end