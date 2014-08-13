load forgaube

% %   Name         Size                 Bytes  Class     Attributes
% % 
% %   OW1        251x361x4            2899552  double              
% %   OW2        251x361x4            2899552  double              
% %   VORT       251x361x4            2899552  double              
% %   gridx        1x251                 2008  double              
% %   gridy        1x361                 2888  double   
% %   
% %

[gridx,gridy]=meshgrid(gridx,gridy); %need to have x and y as 2D arrays for tracking routine

[r,c]=imap(1680,1750,-200,-120,gridy,gridx); %subset domain for Ata's rip eddies

figure(1)
clf
pcolor(gridx(r,c),gridy(r,c),OW2(c,r,3)');shading flat;axis image
caxis([-.01 .01])
colorbar
hold on
contour(gridx(r,c),gridy(r,c),OW2(c,r,3)',[-.01:.001:-.001],'k');

clear ow
%make subset OW array
for m=1:4
    ow(:,:,m)=OW2(c,r,m)';
end


eddies=track_eddies_OW(gridx(r,c),gridy(r,c),[1:4],ow,1,-.0001,-.0001,-1);


