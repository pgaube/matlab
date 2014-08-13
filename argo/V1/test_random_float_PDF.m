% a test to see if argo floats randomly seeded in a global domain, then subsampled and colocated with randomly
% distributed eddies of random size (radial scales) have the same probability densit function, per unit area, 
% as observed floats within real eddies.

%start out making random float profile locations, distibuted between 60N,60S, 0E-360E
a=-60;
b=60;
n=500000; %about this many argo profiles
plat = a + (b-a).*randn(n,1);

a=0;
b=360;
plon = a + (b-a).*randn(n,1);

%next make random eddy locations
a=-60;
b=60;
n=10000; %about this many eddies in a few years of data
elat = a + (b-a).*randn(n,1);

a=0;
b=360;
elon = a + (b-a).*randn(n,1);

%random eddy radi
a=60; %km
b=120; %km
scale = a + (b-a).*rand(n,1);
%scale=100;
dist=nan*plat;

for m=1:500000
	dist_y=elat-plat(m);
	dist_x=elon-plon(m);
	dist(m) = min(sqrt((111.11*cosd(plat(m))*dist_x./scale).^2+(111.11*dist_y./scale).^2)); %dist in units of eddy radial scale
	%dist(m) = min(sqrt(dist_x.^2+dist_y.^2)); 
	%dist(m) = min(abs(100*dist_x));
end

rbins=0:.25:5; %radial binns by which we will construct the histogram
areas=2*pi*rbins.^2;
an_area=nan*rbins;
an_area(1:end-1)=areas(2:end)-areas(1:end-1); %this is the area of the annulus defined as 
											%having the inner radius of rbins(n-1) and 
											%outer radius of rbins(n)
											
%make count of float distance per radial bin (rbins), 
for m=1:length(rbins)-1
	n(m)=length(find(dist>=rbins(m) & dist<rbins(m+1)));
end

%and nomalize count by area (an_area)
norm_n=n./an_area(1:end-1);

figure(1)
clf
stairs(rbins(1:end-1),100*norm_n./nansum(norm_n),'k','linewidth',2)
hold on
stairs(rbins(1:end-1),100*n./nansum(n),'k--','linewidth',2)
legend('# per unit area of annulus','#')
title('PDF of random ARGO float profiles as a function of scaled distance from random eddies    ')
ylabel('%')
xlabel('eddy scales')
niceplot
print -dpng -r300 random_float_histo





	


