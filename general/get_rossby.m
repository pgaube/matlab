function [r,c]=get_rossby(mlon,mlat)
%[r,c]=get_rossby(mlon,mlat)
%return rossby radius (km) and phase speed (cm s^{-1})
load /matlab/matlab/general/rossby_radius
tc=c;

[mr,mc]=imap(min(mlat(:))-1,max(mlat(:))+1,min(mlon(:))-1,max(mlon(:))+1,lat,lon);
tr=r_d(mr,mc);
r=nanmean(tr(:));
tc=c(mr,mc);
c=nanmean(tc(:));