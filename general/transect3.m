function [transect1,transect2,transect3,points]=transect(data1,data2,data3,n,cmin,cmax)
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
pcolor(double(data1))
shading flat
axis equal
caxis([cmin cmax])
load rwp.pal
colormap(rwp)

%cross hairs
cent=length((data1(:,1))+1)/2;
line([0 length(data1(1,:))],[cent cent],'color','k')
line([cent cent],[0 length(data1(:,1))],'color','k')

[sx,sy]=size(data1);
[r1,r2]=ginput(2);
points=[linspace(r1(1),r1(2),n);linspace(r2(1),r2(2),n)];
transect1=double(interp2([1:sx],[1:sy],data1,points(1,:),points(2,:),'cubic'));
transect2=double(interp2([1:sx],[1:sy],data2,points(1,:),points(2,:),'cubic'));
transect3=double(interp2([1:sx],[1:sy],data3,points(1,:),points(2,:),'cubic'));

hold on
plot(points(1,:),points(2,:),'k')
subplot(212)
plotyy([1:100],transect1,[1:100],transect2)



