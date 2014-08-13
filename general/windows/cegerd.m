function [cmap] = cegerd(maplength);
% ColEdit function [cmap] = cegerd(maplength);
%
% colormap m-file written by ColEdit
% version 1.0 on 01-Apr-1998
%
% input  :	[maplength]	[64]	- colormap length
%
% output :	cmap			- colormap RGB-value array
 
% set red points
r = [ [];...
    [0 0.98936];...
    [0.3175 0.097087];...
    [0.4921 1];...
    [0.5079 1];...
    [0.6417 0.233];...
    [0.7721 0.86408];...
    [1 1];...
    [] ];
 
% set green points
g = [ [];...
    [0 0.28723];...
    [0.3333 0.4854];...
    [0.4921 1];...
    [0.8413 0.8932];...
    [1 0.18447];...
    [] ];
 
% set blue points
b = [ [];...
    [0 0.3301];...
    [0.1587 0.6408];...
    [0.5079 1];...
    [0.6825 0.33981];...
    [1 0.16505];...
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
