function [transect,points]=transect(data,n,cmin,cmax)
%
%function tt=transect
%
% Take a sample of the data plotted in the current figure (a transect).  Input is provided by ginput,
% so make sure that you have the figure you want to sample up front.
%
% INPUT
% data = the data you want to take a transect of [m,n]
% n = number of points in the transect -OPTIONAL- (default = 100)
% cmin, cmax = color axis range

if nargin==1
	n=100;
end	

figure(102)
clf
subplot(211)
pcolor(double(data))
shading flat
axis equal
caxis([cmin cmax])
load rwp.pal
colormap(rwp)
grid on
set(gca,'XMinorGrid','on','YMinorGrid','on')
axis equal

%cross hairs
cent=length((data(:,1))+1)/2;
line([0 length(data(1,:))],[cent cent],'color','k')
line([cent cent],[0 length(data(:,1))],'color','k')


[sx,sy]=size(data);
[r1,r2]=ginput(2);
points=[linspace(r1(1),r1(2),n);linspace(r2(1),r2(2),n)];
transect=double(interp2([1:sx],[1:sy],data,points(1,:),points(2,:),'cubic'));

hold on
plot(points(1,:),points(2,:),'k')
subplot(212)
plot(transect)


