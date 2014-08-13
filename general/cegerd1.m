function [cmap] = cegerd1(maplength);
% ColEdit function [cmap] = cegerd1(maplength);
%
% colormap m-file written by ColEdit
% version 1.0 on 15-Oct-1998
%
% input  :	[maplength]	[64]	- colormap length
%
% output :	cmap			- colormap RGB-value array
 
% set red points
r = [ [];...
    [0 0.14894];...
    [0.39487 0.095745];...
    [0.4641 0.87234];...
    [0.4921 1];...
    [1 1];...
    [] ];
 
% set green points
g = [ [];...
    [0 0.003673];...
    [0.3333 0.98936];...
    [0.4921 1];...
    [0.63077 0.97872];...
    [0.8413 0.68085];...
    [1 0.18447];...
    [] ];
 
% set blue points
b = [ [];...
    [0 0.59574];...
    [0.40256 0.18085];...
    [0.5079 1];...
    [0.61795 0.074468];...
    [1 0.06383];...
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
