function [cmap] = naomap4(maplength);
% ColEdit function [cmap] = naomap4(maplength);
%
% colormap m-file written by ColEdit
% version 1.0 on 05-Mar-1999
%
% input  :	[maplength]	[64]	- colormap length
%
% output :	cmap			- colormap RGB-value array
 
% set red points
r = [ [];...
    [0 0];...
    [0.18863 0.25];...
    [0.375 0.58333];...
    [0.48 0.95238];...
    [0.52 1];...
    [0.625 1];...
    [0.875 1];...
    [1 0.5];...
    [] ];
 
% set green points
g = [ [];...
    [0 0];...
    [0.125 0];...
    [0.26357 0.7619];...
    [0.375 0.97619];...
    [0.52 1];...
    [0.60982 0.91667];...
    [0.74419 0.75];...
    [0.875 0.35714];...
    [1 0];...
    [] ];
 
% set blue points
b = [ [];...
    [0 0.47619];...
    [0.125 1];...
    [0.52 1];...
    [0.625 0.41667];...
    [0.71318 0.02381];...
    [1 0];...
    [] ];
% ColEditInfoEnd
 
% get colormap length
if nargin==1 
  if length(maplength)==1
    if maplength<1
      maplength = 64;
    elseif maplength>256
      maplength = 256;
    elseif isinf(maplength)
      maplength = 64;
    elseif isnan(maplength)
      maplength = 64;
    end
  end
else
  maplength = 64;
end
 
% interpolate colormap
np = linspace(0,1,maplength);
rr = interp1(r(:,1),r(:,2),np,'linear');
gg = interp1(g(:,1),g(:,2),np,'linear');
bb = interp1(b(:,1),b(:,2),np,'linear');
 
% compose colormap
cmap = [rr(:),gg(:),bb(:)];
