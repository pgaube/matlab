function pprof(varargin)

%pprof(x,z,sz,cdata)
	 
load rwp.pal

x = double(varargin{1});
z = double(varargin{2});
type = 'l';
if nargin >2
	sz = single(varargin{3});
	cdata=double(varargin{4});
	type = 's';
end

switch type
	case{'l'}
	plot(x,-z,'color','k')
	case{'s'}
	scatter(x,-z,sz,cdata,'filled')
end

daspect([1 100 1])
line([0 0],[min(-z) max(-z)],'color','k')
colormap(rwp)


