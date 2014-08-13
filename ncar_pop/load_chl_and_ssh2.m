clear all
close all
load chelle.pal

pop_path=' /glade/scratch/mclong/hi-res-eco/g.e11.G.T62_t12.eco.006/ocn/hist/';
% pop_path='/glade/scratch/mclong/hi-res-eco/g.e11.G.T62_t12.eco.004/ocn/hist/';
dir_list=dir([pop_path '*.h.*nc']);
whos dir_list
return
jdays=1:5:5*length(dir_list);

fname=[pop_path getfield(dir_list(1),'name')];
tmp=nc.read(fname,'TLAT');
lat=squeeze(tmp.var.TLAT);
lat=[lat(:,1101:end) lat(:,1:1100)];
tmp=nc.read(fname,'TLONG');
lon=squeeze(tmp.var.TLONG);
lon=[lon(:,1101:end) lon(:,1:1100)];

tlon = geoloc2grid(lat,lon,lon,.25);
tlat = geoloc2grid(lat,lon,lat,.25);
%get rid of nans in tlat, tlon SSH
    tlat(end-3:end,:)=[];
    tlon(end-3:end,:)=[];
    
    tlat(1:2,:)=[];
    tlon(1:2,:)=[];
    
    
tmp=nc.read(fname,'HT');
depth=squeeze(tmp.var.HT);
depth=[depth(:,1101:end) depth(:,1:1100)];
depth=geoloc2grid(lat,lon,depth,.25);
mask=nan*depth;
mask(depth>100)=1;


for m=1:length(dir_list)
    fname=[pop_path getfield(dir_list(m),'name')]
    tmp=nc.read(fname,'spChl');
    rr1=squeeze(tmp.var.spChl);
    tmp=nc.read(fname,'diatChl');
    rr2=squeeze(tmp.var.diatChl);
    tmp=nc.read(fname,'diazChl');
    rr3=squeeze(tmp.var.diazChl);
    rchl=rr1+rr2+rr3;
    
    rchl=squeeze(nansum(rchl,1));
    chl=geoloc2grid(lat,lon,[rchl(:,1101:end) rchl(:,1:1100)],.25).*mask;
    %get rid of nans in tlat, tlon SSH
    chl(end-3:end,:)=[];
    chl(1:2,:)=[];

    tmp=nc.read(fname,'SSH');
    rr=squeeze(tmp.var.SSH);
    ssh=geoloc2grid(lat,lon,[rr(:,1101:end) rr(:,1:1100)],.25);
    %get rid of nans in tlat, tlon SSH
    ssh(end-3:end,:)=[];
    ssh(1:2,:)=[];
    
    
    save(['/glade/u/home/pgaube/mat/POP_BEC_APR_1_2014_',num2str(jdays(m))],'ssh','chl','tlat','tlon','jdays','mask')
   
end

