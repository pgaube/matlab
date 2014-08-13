clear all
close all
load chelle.pal

pop_path='/glade/scratch/mclong/hi-res-eco/g.e11.G.T62_t12.eco.004/ocn/hist/';

dir_list=dir([pop_path 'g.e11.G.T62_t12.eco.004.pop.h.0*nc']);
jdays=1:5:5*length(dir_list)
fname=[pop_path getfield(dir_list(1),'name')];
tmp=nc.read(fname,'TLAT');
lat=squeeze(tmp.var.TLAT);
lat=[lat(:,1101:end) lat(:,1:1100)];
tmp=nc.read(fname,'TLONG');
lon=squeeze(tmp.var.TLONG);
lon=[lon(:,1101:end) lon(:,1:1100)];

tlon = geoloc2grid(lat,lon,lon,.25);
tlat = geoloc2grid(lat,lon,lat,.25);

tmp=nc.read(fname,'HT');
depth=squeeze(tmp.var.HT);
depth=[depth(:,1101:end) depth(:,1:1100)];
depth=geoloc2grid(lat,lon,depth,.25);
mask=nan*depth;
mask(depth>100)=1;

SSH=nan(length(tlat(:,1)),length(tlon(1,:)),length(dir_list));

for m=1:length(dir_list)
    fname=[pop_path getfield(dir_list(m),'name')]
    tmp=nc.read(fname,'SSH');
    rr=squeeze(tmp.var.SSH);
    ssh=geoloc2grid(lat,lon,[rr(:,1101:end) rr(:,1:1100)],.25);
    
    figure(1)
    set(gcf,'renderer','painters')
    set(gcf,'Visible','off')
    pcolor(tlon,tlat,ssh.*mask);caxis([-80 80]);colormap(chelle);shading flat;axis image
    title(fname)
    colorbar
    eval(['print -dpng -r300 figs/SSH_',num2str(m),'.png'])
    
    save(['/glade/u/home/pgaube/mat/POP_5D_25km_',num2str(jdays(m))],'-append','ssh')
   
end

