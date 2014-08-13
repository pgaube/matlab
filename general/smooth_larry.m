function [ar2] = smooth_larry(data,lon,lat,rade);

jm=length(lon(1,:));
im=length(lat(:,1));
mask=zeros(size(data));
mask(~isnan(data))=1;
ar0=data;
ar0(isnan(data))=0;
is=1;ie=im;js=1;je=jm;
radmax=2.5*rade;


% generic 2-D smoother, Version 7d2
% Larry Anderson, WHOI

% input:
%    ar0(1:im,1:jm) = array to be smoothed
%    mask(1:im,1:jm) = land mask (1=water, 0=land)
%    rade = e-folding scale (in points)
%           rade does not need to be an integer
%    radmax = max radius (in points)
%           the smoother tapers to exactly zero at radmax
%           best to use 2.5*rade >= radmax >= 2*rade
%    is,ie,js,je = start and end indices of the subdomain to be smoothed
% output:
%    ar2(1:im,1:jm) = smoothed array

% this version assumes the input file does not have NaNs

% corrected version of smoothgen7c
% as version 7b but smooths a subdomain of the array

% this version does add masked weight to the center weight,
% so area integrals are conserved near coasts

% if apply on Area*T, (and afterwards divide by Area), this conserves the 
%   area-weighted average in the interior

% note: this has to be done with a radius in grid points (not km)
%  for the stencil to remain the same, and thus conserve

% 1st create the stencil

rad1=floor(radmax);
radp1 = rad1 + 1;
rad2p1 = 2*rad1 + 1;  % maximum width of filter in grid points
rad2=radmax*radmax;

% gaussian
del2=rade*rade;
facx=exp(-rad2/del2); 
for i=1:radp1; dx2=(radp1-i)*(radp1-i); ii=rad2p1-i+1; for j=1:radp1;
  dr2 = dx2 + (radp1-j)*(radp1-j); jj=rad2p1-j+1;
  w(i,j) = max(0, exp(-dr2/del2)-facx); 
  w(ii,j) = w(i,j); w(i,jj) = w(i,j); w(ii,jj) = w(i,j);
end; end;

sumw=sum(sum(w)); % sum of the weights
w=w/sumw;         % normalize so that the sum of the weights is 1.0

% apply smoother; compute value at (i,j)

ar2(1:im,1:jm)=ar0; % set non-smoothed areas
for j=js:je;
  jsabs=max(1,j-rad1); jeabs=min(jm,j+rad1);
  jsrel=jsabs-j+radp1; jerel=jeabs-j+radp1;
  for i=is:ie;
    if mask(i,j) == 0,
      ar2(i,j) = 0;
    else
      isabs=max(1,i-rad1); ieabs=min(im,i+rad1);
      isrel=isabs-i+radp1; ierel=ieabs-i+radp1;
      w2(isrel:ierel,jsrel:jerel) = mask(isabs:ieabs,jsabs:jeabs).*...
                                w(isrel:ierel,jsrel:jerel);
      w2(radp1,radp1) = w2(radp1,radp1) + ...
                  1 - sum(sum(w2(isrel:ierel,jsrel:jerel))); % add to center
      w2(isrel:ierel,jsrel:jerel) = ar0(isabs:ieabs,jsabs:jeabs).*...
                                    w2(isrel:ierel,jsrel:jerel);     % W*T
      ar2(i,j)= sum(sum(w2(isrel:ierel,jsrel:jerel)));
    end
end; end;
ar2(mask==0)=nan;
