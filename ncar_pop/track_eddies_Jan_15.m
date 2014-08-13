clear all
%make SSH data
dir_list=dir(['/glade/u/home/pgaube/mat/POP_5D_25km_*'])
jdays=1:5:5*length(dir_list);

slat=[-69.875:.25:69.875];
slon=[.125:.25:359.875];

SSH=nan(length(slat),length(slon),length(jdays));

[slon,slat]=meshgrid(slon,slat);

for m=1:length(dir_list)
    fname=['/glade/u/home/pgaube/mat/',getfield(dir_list(1),'name')];
    load(fname,'tlon','tlat','ssh')
    
    %get rid of nans in tlat, tlon SSH
    tlat(end-3:end,:)=[];
    tlon(end-3:end,:)=[];
    ssh(end-3:end,:)=[];
    
    tlat(1:2,:)=[];
    tlon(1:2,:)=[];
    ssh(1:2,:)=[];
    
    SSH(:,:,m)=griddata(tlon,tlat,ssh,slon,slat);
    clear ssh
end

save gridded_ssh_jan_15
