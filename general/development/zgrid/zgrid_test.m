
clear all
load /Volumes/matlab/matlab/global/trans_samp/TRANS_W_2452459.mat

ssh=double(ssh_sample(:,:,20));
sst=double(amsre_sample(:,:,20));
lat=double(lat_sample(:,:,20));
lon=double(lon_sample(:,:,20));
x=x_index(20);
y=y_index(20);
save test1 ssh sst lat lon x y

ssh=double(ssh_sample(:,:,30));
sst=double(amsre_sample(:,:,30));
lat=double(lat_sample(:,:,30));
lon=double(lon_sample(:,:,30));
x=x_index(30);
y=y_index(30);
save test2 ssh sst lat lon x y

clear

load test1

dist = sqrt(((lon-x).*(111.1*cosd(lat))).^2+((lat-y).*111.1).^2);

dist_x = sqrt(((lon-x).*(111.1*cosd(lat))).^2); %in km
dist_y = sqrt(((lat-y).*111.1).^2);


mask=nan(size(dist));
mask(dist<=200)=1;


L=100
dist_xi = (dist_x./L);
dist_yi=(dist_y./L);
disti=(dist./L);


xi=cat(2,[5:-.1:0],[.1:.1:5]);
xi=ones(length(xi),1)*xi;
yi=xi';


%fin_yi=griddata(dist_xi,dist_yi,dist_yi,xi,yi);
%fin_xi=griddata(dist_xi,dist_yi,dist_xi,xi,yi);
fin_ssh = griddata(dist_xi,dist_yi,ssh,xi,yi,'nearest');

figure(1)
subplot(221)
pcolor(ssh);shading flat

subplot(222)
pcolor(fin_ssh);shading flat


load test2

dist = sqrt(((lon-x).*(111.1*cosd(lat))).^2+((lat-y).*111.1).^2);

dist_x = sqrt(((lon-x).*(111.1*cosd(lat))).^2); %in km
dist_y = sqrt(((lat-y).*111.1).^2);


mask=nan(size(dist));
mask(dist<=200)=1;


L=100
dist_xi = (dist_x./L);
dist_yi=(dist_y./L);
disti=(dist./L);


%fin_yi=griddata(dist_xi,dist_yi,dist_yi,xi,yi);
%fin_xi=griddata(dist_xi,dist_yi,dist_xi,xi,yi);
fin_ssh = griddata(dist_xi,dist_yi,ssh,xi,yi);

subplot(223)
pcolor(ssh);shading flat

subplot(224)
pcolor(fin_ssh);shading flat




