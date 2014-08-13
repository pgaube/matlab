function [cmap] = ceelodie(maplength);
% ColEdit function [cmap] = ceelodie(maplength);
%
% colormap m-file written by ColEdit
% version 0.1.0 on 25-Feb-98
%
% input  :	[maplength]	[64]	- colormap length
%
% output :	cmap			- colormap RGB-value array
 
% set red points
r = [ [];...
    [0 1];...
    [1 1];...
    [] ];
 
% set green points
g = [ [];...
    [0 0];...
    [0.1746 1];...
    [0.5079 1];...
    [0.6825 0.3204];...
    [1 0.4466];...
    [] ];
 
% set blue points
b = [ [];...
    [0 0];...
    [0.3333 0];...
    [0.5079 1];...
    [0.8413 1];...
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
