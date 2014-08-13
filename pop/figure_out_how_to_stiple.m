Lon = (-179:1:180)'; %# comment for formatting'
Lat = -90:1:90;
data = randn(length(Lon),length(Lat)); % generate random data
mask = randi(2,size(data))-1; % generate a random mask (zeros and ones)
point_matrix = randi(4,size(data)-1)==4; % random (logical) matrix
[r c]=find(point_matrix==1); %# get the coordinates of the ones
figure(3);
hold on;
% save a handle to the surface object created by pcolor
h=pcolor(repmat(Lon ,1,length(Lat)),repmat(Lat,length(Lon),1),data) % set properties of that surface: use mask as alphadata for transparency % and set 'facealpha' property to 'flat', and turn off edges (optional)
set(h,'alphadata',mask,'facealpha','flat','edgecolor','none'); % overlay black dots on the center of the randomly chosen tiles
plot(r-179.5,c-89.5,'.k')