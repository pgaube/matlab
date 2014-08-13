x=-500e3:1e3:500e3;  %500 km grid
% L=100e3./sqrt(2);  %E-folding scale of Gaussin based on a radius of 100 km
area_ma=27336;

r_ma=sqrt(area_ma./pi)

L=1e3*r_ma;  %E-folding scale of Gaussin based on a radius of 100 km
A=381; %depth of eddy in meters
[X,Y]=meshgrid(x,x);
dist=sqrt(X.^2+Y.^2);

h=A*exp(-dist.^2./2/L^2);

figure(1)
clf
plot(x,h(501,:))
line([L L],[0 500],'color','k')
line([-L -L],[0 500],'color','k')

title(['h = A exp(-r^2/2/L^2), L=',num2str(.001*L),' km, A=',num2str(A),' m'])
figure(2)
clf
surf(X,Y,-h);shading flat;colorbar

% volume_of_eddy=sum(sum(sum(h,1),2))
volume_of_eddy=2*pi*A*L*L

vo_in_km=volume_of_eddy./1000^3

num_of_pools=volume_of_eddy./2500


%%figure out number of eddies
load ~/data/eddy/V5/global_tracks_v5

uweek=length(unique(track_jday))
num_per_week=length(id)./uweek



% Lc=sqrt(2)*L
% area_cyl=pi*Lc^2*A
