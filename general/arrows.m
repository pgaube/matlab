function h=arrows(x,y,l,az,varargin)
%ARROWS  Generalised 2-D arrows plot
%
%       ARROWS(X,Y,L,AZ) draws an arrow on current axis from position X,Y with 
%       length L, oriented with azimuth AZ (in degree, AZ = 0 means an arrow 
%       pointing to positive Y-axis direction, rotating clockwise).
%       
%       X and Y can be scalars or matrix. In the last case, any or both L and
%       AZ can be scalars or matrix of the same size as X and Y.
%
%       ARROWS(...,SHAPE) uses relative ratios SHAPE = [HEADW,HEADL,HEADI,LINEW]
%       to adjust head width HEADW, head length HEADL, head inside length HEADI,
%       and segment line width LINEW for an arrow length of 1 (default is 
%       SHAPE = [1,0.25,0.25,0.5]).
%
%       ARROWS(...,'param1',value1,'param2',value2,...) specifies any
%       additionnal properties of the Patch using standard parameter/value
%       pairs, like 'FaceColor','EdgeColor','LineWidth', ...
%
%	H=ARROWS(...) returns graphic's handle of patches.
%
%       Examples:
%
%         arrows(0,0,1,45,'FaceColor','none','LineWidth',3)
%
%	  arrows(1,0,1,0,[.2,.4,.2,.02])
%
%	  [xx,yy] = meshgrid(1:10);
%	  arrows(xx,yy,rand(size(xx)),360*rand(size(xx)))
%
%
%	Notes:
%
%	  Arrow shape supposes an equal aspect ratio (axis equal).
%
%	  Equivalent of quiver(x,y,u,v,0) command is obtained with:
%	    [th,l] = cart2pol(u,v);
%	    arrows(x,y,l,90 - th*180/pi)
%
%       See also PATCH, QUIVER.
%
%       Author: Francois Beauducel <beauducel@ipgp.fr>
%	Created: 1995-02-03
%	Updated: 2012-06-30

%	Copyright (c) 1995-2012, François Beauducel, covered by BSD License.
%	All rights reserved.
%
%	Redistribution and use in source and binary forms, with or without 
%	modification, are permitted provided that the following conditions are 
%	met:
%
%	   * Redistributions of source code must retain the above copyright 
%	     notice, this list of conditions and the following disclaimer.
%	   * Redistributions in binary form must reproduce the above copyright 
%	     notice, this list of conditions and the following disclaimer in 
%	     the documentation and/or other materials provided with the distribution
%	                           
%	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
%	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
%	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
%	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
%	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
%	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
%	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
%	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
%	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
%	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
%	POSSIBILITY OF SUCH DAMAGE.

if nargin < 4
	error('Not enough input arguments.')
end

if ~isnumeric(x) | ~isnumeric(y) | ~isnumeric(l) | ~isnumeric(az)
	error('X,Y,L and AZ must be numeric.')
end

if nargin > 4 & isnumeric(varargin{1})
	s = varargin{1};
	if numel(s) ~= 4
		error('SHAPE argument must be a 4-scalar vector.')
	end
	varargin = varargin(2:end);
else
	s = [1 .25 .25 .5];
end

% converts AZ in degrees to radians
az = az*pi/180;

% this adjusts head drawing for HEADI = 0 and LINEW > 0
s(3) = max(s(3),s(4)*s(2)/s(1));

m = 8; % length of arrow points (see fx vector below)

% to manage matrix arguments, needs to duplicate values
if numel(x) > 1
	x = repmat(x(:)',[m,1]);
end

if numel(y) > 1
	y = repmat(y(:)',[m,1]);
end

if numel(l) > 1
	l = repmat(l(:)',[m,1]);
end

if numel(az) > 1
	az = repmat(az(:)',[m,1]);
end

n = max([size(x,2) size(y,2) size(l,2) size(az,2)]);	% max size of arguments

fx = repmat([s(4)*[.5 -.5 -.5] s(1)*[-.5 0 .5] s(4)*[.5 .5]]',[1,n]);
fy = repmat([0 0 (1 - s(3)) (1 - s(2)) 1 (1 - s(2)) (1 - s(3)) 0]',[1,n]);

% the beauty of this script: a single patch command to draw all the arrows !
hh = patch(-fx.*l.*cos(az) + fy.*l.*sin(az) + x,fx.*l.*sin(az) + fy.*l.*cos(az) + y,'k',varargin{:});

if nargout > 0
	h = hh;
end

