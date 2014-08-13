% clear all
% close all
% load chelle.pal
% 
% 
% pop_path='/glade/scratch/mclong/hi-res-eco/g.e11.G.T62_t12.eco.002/ocn/hist/';
% dir_list=dir([pop_path 'g.e11.G.T62_t12.eco.002.pop.h.0*nc']);
% jdays=1:5:5*length(dir_list)
% fname=[pop_path getfield(dir_list(1),'name')];
% tmp=nc.read(fname,'TLAT');
% lat=squeeze(tmp.var.TLAT);
% lat=[lat(:,1101:end) lat(:,1:1100)];
% tmp=nc.read(fname,'TLONG');
% lon=squeeze(tmp.var.TLONG);
% lon=[lon(:,1101:end) lon(:,1:1100)];
% 
% tlon = geoloc2grid(lat,lon,lon,.25);
% tlat = geoloc2grid(lat,lon,lat,.25);
% 
% tmp=nc.read(fname,'HT');
% depth=squeeze(tmp.var.HT);
% depth=[depth(:,1101:end) depth(:,1:1100)];
% depth=geoloc2grid(lat,lon,depth,.25);
% mask=nan*depth;
% mask(depth>100)=1;

% CHL=nan(length(tlat(:,1)),length(tlon(1,:)),length(dir_list));

for m=1:length(dir_list)
    fname=[pop_path getfield(dir_list(m),'name')]
    tmp=nc.read(fname,'spC');
    rr1=squeeze(tmp.var.spC);
    tmp=nc.read(fname,'diatC');
    rr2=squeeze(tmp.var.diatC);
    tmp=nc.read(fname,'diazC');
    rr3=squeeze(tmp.var.diazC);
    ssh=rr1+rr2+rr3;
    ssh=squeeze(nansum(ssh,1));
    chl=geoloc2grid(lat,lon,[ssh(:,1101:end) ssh(:,1:1100)],.25).*mask;
    %get rid of nans in tlat, tlon SSH

	chl(end-3:end,:)=[];
    chl(1:2,:)=[];
    save(['/glade/u/home/pgaube/mat/POP_5D_25km_',num2str(jdays(m))],'-append','chl')
   
end

