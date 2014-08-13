
clear all
load /Volumes/matlab/matlab/global/trans_samp/TRANS_W_2452459.mat

for m=1:1084

[tz,tx,ty]=d_zgrid(double(lon_sample(:,:,m)), ...
				 double(lat_sample(:,:,m)), ...
				 double(x_index(m)), ...
				 double(y_index(m)), ...
				 double(ssh_sample(:,:,m)), ...
				 double(efold_index(m)));
figure(1)
clf
subplot(121)
pcolor(double(lon_sample(:,:,m)),double(lat_sample(:,:,m)),double(ssh_sample(:,:,m)));shading flat
hold on
contour(tx,ty,tz,'k');
subplot(122)
pcolor(tz);shading flat
drawnow
%eval(['print -dpng frame_',num2str(m)])

end
