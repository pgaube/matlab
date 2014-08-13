%this routine will load Schlax's masks, ssh and calculate u,v and crl

pp = '/matlab/data/UPD/'
sp = '/matlab/data/UPD/mat/'

%Set range of dates


startyear = 2002;
startmonth = 10;
startday = 02;

endyear = 2005;
endmonth = 09;
endday = 28;


%make lat lon



%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:7:endjd];
[year,month,day]=jd2jdate(jdays);

%make maticies

%ii=find(jdays==2452879)
for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   Reading %08u \r',calday(m))
	ssh_file = [pp 'ssh/aviso_' num2str(calday(m)) '.20x10_hp'];
	mask_file = [pp 'eddies/eddspd_090906.' num2str(calday(m))];
	[mtmp,mlon]=read_mask(mask_file);
	save_file = [sp 'UPD_25_W_' num2str(jdays(m))];
	
	[ssh,lon,lat]=read_ssh(ssh_file);
	tmp = ssh*nan;
	for m=1:length(lon)
		c=find(mlon==lon(m));
		if length(c)>1               
			ii=find(~isnan(mtmp(:,c(1))));
			tmp(ii,m)=mtmp(ii,c(1));
			ii=find(~isnan(mtmp(:,c(2))));
			tmp(ii,m)=mtmp(ii,c(2));
		else
			ii=find(~isnan(mtmp(:,c)));   
			tmp(ii,m)=mtmp(ii,c);   
		end
	end


	
	idmask=tmp;
	tmp(~isnan(tmp))=1;
	mask=tmp;
	[lon,lat]=meshgrid(lon,lat);
	[u,v]=geostro(lon,lat,ssh./100,.25);
	crl = dfdx(lat,v,.25)-dfdy(u,.25);
	
	eval(['save ' save_file ' u v crl ssh mask idmask lon lat'])
	
	
end

fprintf('\n')


function [year, month, day, hour, minute, second] = jd2jdate(jday)
%JD2JDATE Julian day number to Julian calendar date.
%
%   [YEAR, MONTH, DAY, HOUR, MINUTE, SECOND] = JD2JDATE(JDAY) returns the
%   Julian calendar date (year, month, day, hour, minute, and second)
%   corresponding to the Julian day number JDAY.
%
%   Start of the JD (Julian day) count is from 0 at 12 noon 1 JAN -4712
%   (4713 BC), Julian proleptic calendar.  Note that this day count conforms
%   with the astronomical convention starting the day at noon, in contrast
%   with the civil practice where the day starts with midnight.
%
%   Astronomers have used the Julian period to assign a unique number to
%   every day since 1 January 4713 BC.  This is the so-called Julian Day
%   (JD). JD 0 designates the 24 hours from noon UTC on 1 January 4713 BC
%   (Julian calendar) to noon UTC on 2 January 4713 BC.

%   Sources:  - http://tycho.usno.navy.mil/mjd.html
%             - The Calendar FAQ (http://www.faqs.org)

%   Author:      Peter J. Acklam
%   Time-stamp:  2002-05-24 15:24:45 +0200
%   E-mail:      pjacklam@online.no
%   URL:         http://home.online.no/~pjacklam

   nargsin = nargin;
   error(nargchk(1, 1, nargsin));

   ijday = floor(jday);                 % integer part
   fjday = jday - ijday;                % fraction part

   second = 86400 * fjday;
   hour   = floor(second / 3600);         % get number of hours
   second = second - 3600 * hour;         % remove the hours
   minute = floor(second / 60);           % get number of minutes
   second = second - 60 * minute;         % remove the minutes
   hour   = hour + 12;                  % Julian days start at noon

   % The following algorithm is from the Calendar FAQ.

   b = 0;
   c = ijday + 32082+13;

   d = floor((4 * c + 3) / 1461);
   e = c - floor((1461 * d) / 4);
   m = floor((5 * e + 2) / 153);

   day   = e - floor((153 * m + 2) / 5) + 1;
   month = m + 3 - 12 * floor(m / 10);
   year  = b * 100 + d - 4800 + floor(m / 10);


function julday = julian(month,day,year,year0)
%julday = julian(month,day,year,year0)

days(1) = 31;
days(2) = 28;
days(3) = 31;
days(4) = 30;
days(5) = 31;
days(6) = 30;
days(7) = 31;
days(8) = 31;
days(9) = 30;
days(10) = 31;
days(11) = 30;
days(12) = 31;

if ~exist('year0'),
	year0 = year;
	end
julday = 0;
if (year>=year0)
	for i=year0:year-1,
		julday = julday + 365;
		if (mod(i,4)==0),
			julday = julday + 1;
			end
		end
else,
	for i=year0-1:-1:year,
		julday = julday - 365;
		end
	if (mod(i,4)==0),
		julday = julday - 1;
		end
	end
if (mod(year,4)==0),
	days(2) = days(2) + 1;
	end
for i=1:month-1,
	julday = julday + days(i);
	end
julday = julday + day;


function jd = date2jd(varargin)
%DATE2JD Julian day number from Gregorian date.
%
%   JD = DATE2JD(YEAR, MONTH, DAY, HOUR, MINUTE, SECOND) returns the Julian
%   day number of the given date (Gregorian calendar) plus a fractional part
%   depending on the time of day.
%
%   Any missing MONTH or DAY will be replaced by ones.  Any missing HOUR,
%   MINUTE or SECOND will be replaced by zeros.
%
%   If no date is specified, the current date and time is used.
%
%   Start of the JD (Julian day) count is from 0 at 12 noon 1 January -4712
%   (4713 BC), Julian proleptic calendar.  Note that this day count conforms
%   with the astronomical convention starting the day at noon, in contrast
%   with the civil practice where the day starts with midnight.
%
%   Astronomers have used the Julian period to assign a unique number to
%   every day since 1 January 4713 BC.  This is the so-called Julian Day
%   (JD).  JD 0 designates the 24 hours from noon UTC on 1 January 4713 BC
%   (Julian proleptic calendar) to noon UTC on 2 January 4713 BC.

%   Sources:  - http://tycho.usno.navy.mil/mjd.html
%             - The Calendar FAQ (http://www.faqs.org)

%   Author:      Peter J. Acklam
%   Time-stamp:  2002-05-24 13:30:06 +0200
%   E-mail:      pjacklam@online.no
%   URL:         http://home.online.no/~pjacklam

   nargsin = nargin;
   error(nargchk(0, 6, nargsin));
   if nargsin
      argv = {1 1 1 0 0 0};
      argv(1:nargsin) = varargin;
   else
      argv = num2cell(clock);
   end
   [year, month, day, hour, minute, second] = deal(argv{:});

   % The following algorithm is a modified version of the one found in the
   % Calendar FAQ.

   a = floor((14 - month)/12);
   y = year + 4800 - a;
   m = month + 12*a - 3;

   % For a date in the Gregorian calendar:
   jd = day + floor((153*m + 2)/5) ...
        + y*365 + floor(y/4) - floor(y/100) + floor(y/400) - 32045 ...
        + ( second + 60*minute + 3600*(hour - 12) )/86400;
        
        
function [u,v]=geostro(lon,lat,ssh,space);
%
%
% Function to calculate the geostrophic velocity from altimeter SSH fields.
% Inputs
% lon = [m,1] in degree
% lat = [1,n] in degree
% ssh= must be in meters!  [m,n]
%
% Outputs
% u = Zonal velocity compoent [m,n]
% v = Meridional velocity compoent [m,n]

ff=f_cor(lat);
g = 9.81; %ms^-2


u = (-g./ff).*dfdy(ssh,space);
v = (g./ff).*dfdx(lat,ssh,space);

function fy = dfdy(f,space)
% function fy = dfdy(f,space)
%Uses centered differance
%Standard output is in units per meter
% space = spacing between grid points (for example 1/4 degree: space=.25)

dy=111.11e3.*space;
fy = finitediff(f,dy);



function fx = dfdx(lat,f,space)
% function fx = dfdx(lat,f,space)
%Uses centered differance
%Standard output is in units per meter
% space = spacing between grid points (for example 1/4 degree: space=.25)

for m=1:length(lat(:,1))
    dx=111.11e3*cosd(lat(m,1)).*space;
    fx(m,:) = finitediff(f(m,:),dx);
end





function varargout = finitediff(y,x,varargin)
% function dydx = finitediff(y,x,{'method',bc})
% function [dydx,xx] = finitediff(y,x,'frst')
% function [dydx,dydx_err] = finitediff(y,x,y_err,{x_err,'error','method',bc})
% function [dydx,dydx_err,xx] = finitediff(y,x,y_err,{x_err,'error'},'frst')
%
% first difference estimate and error of dy/dx from y = y(x)
% calculates along 1st non-singleton dimension of x
%	(ie: if x has m rows, derivative is taken along rows of y)
% returns dy/dx, error in dy/dx, and (1st diff. only) xx (new coordinates)
% INPUT arguments (required):
%	x : data coordinates
%		if size(x)==[1 1] then x is the coordinate spacing
%	y : a function of x [y = y(x)]
% INPUT arguments (optional):
% 	y_err : error in y (default: errors not calculated)
% 	x_err : error in x (default=0)
%		(note that as x_err approaches the grid spacing the errors
%		obtained using the stochastic method get very large!)
%	'error' : method for propogating errors (default='prop')
%		'prop' : std. propogation of errors formulae
%		'rand' : stochastic trials
%	trials : number of stochastic trials (default=1e4) {error='rand' only}
%	'method' : finite difference technique (default='cent')
%		'cent' : centered difference
%		'frst' : first difference
%	bc : cst. boundary condition {method='cent' only}
% OUTPUT arguments (required):
%	dydx : dy/dx (derivative of y w.r.t. x)
% OUTPUT arguments (optional):
%	dydx_err : error in dy/dx (y_err must be input)
%	xx : new data coordinates for derivative {method='frst' only}
%
% if x is a number, y can be any size, ie:
%	if size(x) = [1 1], size(y) = [m 1], [1 n], [m n], [m n p], ...
% if x has 1 non-singleton dimension, y must have that dimension matching, ie:
%	if size(x) = [m 1], size(y) = [m 1], [m n], [m n p], [m 1 p], ...
%	if size(x) = [1 n], size(y) = [1 n], [m n], [m n p], [1 n p], ...
%	if size(x) = [1 1 p], size(y) = [1 1 p], [m 1 p], [1 n p], [m n p] ...
% x n-d, y must have 1st n-dimensions matching, ie:
%	if size(x) = [m 1], size(y) = [m 1], [m n], [m n p] ...
%	if size(x) = [m n], size(y) = [m n], [m n p], ...
%	if size(x) = [m n p], size(y) = [m n p], [m n p q], ...
%
% x_err & y_err must have fewer dimensions than x & y (respectively)
% the common dimensions with (x,y) must be same size, ie:
%	if size(x) = [m n p], size(x_err) = [1 1], [m 1], [m n], [m n p]
%
% copyright (C) S.C.Kennan 1 April 2004
% copyright (C) S.C.Kennan 17 June 2004 (can use 1st difference on edges)

%-----------------------------------------
% check optional inputs and assign values
%-----------------------------------------
% possibilities
METHODS = [{'cent'},{'frst'}];
ERRORS = [{'prop'},{'rand'}];
% defaults
METHOD = METHODS(1); METHOD = METHOD{:};
ERROR = ERRORS(1); ERROR = ERROR{:};
% get optional inputs
NARG = length(varargin);
YE = false;	XE = false;	DIF = false;	ERR = false;	RAND = false;
MC = false;	BC = false;	FRST = false;	INVALID = false;
for i=1:NARG,	ARG = varargin{i};
	if BC,	INVALID = true; end
	if	isnumeric(ARG),
		if DIF,	if ~FRST,	bc = ARG; BC = true;
			else,		INVALID = true; end
		else,	if (MC | (ERR & ~RAND)), INVALID = true;
			elseif RAND,	trials = ARG; MC = true;
			elseif ~YE,	ye = ARG; YE = true;
			elseif ~XE,	xe = ARG; XE = true;
			end
		end
	elseif	ischar(ARG),
		if (~DIF & sum(strcmp(METHODS,ARG))),
			METHOD = ARG;	DIF = true; 
			if strcmp(METHOD,METHODS(2)),	FRST = true; end
		elseif (YE & sum(strcmp(ERRORS,ARG))),
			ERROR = ARG;	ERR = true;
			if strcmp(ERROR,ERRORS(2)),	RAND = true; end
		else	INVALID = true;	end
	end
	if INVALID, error('invalid input'); end
end
% if error data was given
if YE, ERR = true; if ~XE, XE = true; xe = 0; end; 
	if ~MC, MC = true; trials = 1e4; end; end

% dimensions/sizes
xsize = size(x);	xdims = length(xsize);
ysize = size(y);	ydims = length(ysize);
if (xdims==2 & length(x)==1),	xdims = 0; end
if (xdims==2 & min(xsize)==1),	xdims = 1; end
if (ydims==2 & length(y)==1),	ydims = 0; end
if (ydims==2 & min(ysize)==1),	ydims = 1; end
% if dimensions of x > dimensions y
if (xdims>ydims), error('x dimensions > y dimensions'); end
% y must have be at least 1d
if (ydims<1), error('y must be a vector or matrix'); end
%  error dimensions/sizes
if ERR, xesize = size(xe);	xedims = length(xesize);
	yesize = size(ye);	yedims = length(yesize);
	if (xedims==2 & length(xe)==1),		xedims = 0; end
	if (xedims==2 & min(xesize)==1),	xedims = 1; end
	if (yedims==2 & length(ye)==1),		yedims = 0; end
	if (yedims==2 & min(yesize)==1),	yedims = 1; end
	% if dimensions of xe > dimensions x or y
	if (xedims>xdims), error('x_err dimensions > x dimensions'); end
	if (xedims>ydims), error('x_err dimensions > y dimensions'); end
	% if dimensions of ye > dimensions y
	if (yedims>ydims), error('y_err dimensions > y dimensions'); end
	% make ye,xe have same dimensions as y,x
	xe = matchdim(xe,x);
	ye = matchdim(ye,y);
end

% special case, x is 1x1 (xdims==0) (and xe also)
if (xdims==0), % derivative is taken along 1st non-singleton y-dimension
	xshft = 0;
	[y,yshft] = shiftdim(y);
	if ERR, ye = shiftdim(y,yshft); end
	dx = x;
else, % derivative is taken along 1st non-singleton x-dimension
	[x,xshft] = shiftdim(x);
	xsize = size(x);	xdims = length(xsize);	
	[dummy,yshft] = shiftdim(y);
	y = shiftdim(y,xshft);
	if ERR, ye = shiftdim(ye,xshft);
		xe = shiftdim(xe,xshft);
	end
	if FRST,% calculate new coord. now before x changes
		xxsize = xsize;
		xxsize(1) = xxsize(1) - 1;
		xx = (x(2:xsize(1),:) + x(1:xsize(1)-1,:))/2;
		xx = shiftdim(reshape(xx,xxsize),-xshft);
	end
end
% redo sizes and dims
ysize = size(y);	ydims = length(ysize);
if (xdims==2 & min(xsize)==1),	xdims = 1; end
if (ydims==2 & min(ysize)==1),	ydims = 1; end
if (xdims>0),
	% if first xdims dimensions of y don't match x, can't do it
	if (sum(ysize(1:xdims)==xsize)~=xdims), error('x & y do not match');
	end
	% if x & y have different dimensions, make x same as y
	x = matchdim(x,y);
	if ERR, xe = matchdim(xe,y); end
end

% if doing stochastic trials, make the trials now
if RAND,% make "trials" randn errors for ea. data
	Ye = (ye(:)*ones(1,trials)).*randn(prod(ysize),trials);
	% add errors to data (have xtra dimension for trials)
	Y = reshape(y(:)*ones(1,trials) + Ye,[ysize,trials]);
	% careful with coordinates - prevent randn from making error too large
	R = randn(prod(ysize),trials); I = find(abs(R)>=1);
	while length(I)>0, R(I) = randn(length(I),1); I = find(abs(R)>=1); end
	if xdims==0, 
		X = reshape(x*ones(prod(ysize),trials) + ...
		(xe*ones(prod(ysize),trials)).*R,[ysize,trials]);
	else,	X = reshape(x(:)*ones(1,trials) + ...
		(xe(:)*ones(1,trials)).*R,[ysize,trials]);
	end
end

%----------------------------------------------------------
% differences are taken along 1st non-singleton x-dimension
% the other dimensions get concatenated into columns
%----------------------------------------------------------
if FRST,% first difference
	if xdims>0, dx = x(2:ysize(1),:) - x(1:ysize(1)-1,:); end
	dy = y(2:ysize(1),:) - y(1:ysize(1)-1,:);
	if RAND,
		dX = (X(2:ysize(1),:) - X(1:ysize(1)-1,:))/2;
		dY = (Y(2:ysize(1),:) - Y(1:ysize(1)-1,:))/2;
	elseif ERR,
		if xdims> 0, xe = (xe(2:ysize(1),:) + xe(1:ysize(1)-1,:))/2;
		end
		dye2 = ye(2:ysize(1),:).^2 + ye(1:ysize(1)-1,:).^2;
	end
	ysize(1) = ysize(1) - 1;
else,	% centered difference
	if xdims>0, dx = [ ...
		x(2,:)			- x(1,:)                ; ...
               	(x(3:ysize(1),:)	- x(1:ysize(1)-2,:))/2  ; ...
               	x(ysize(1),:)		- x(ysize(1)-1,:)       ];
	end
	dy = [	y(2,:)			- y(1,:)                ; ...
               	(y(3:ysize(1),:)	- y(1:ysize(1)-2,:))/2  ; ...
               	y(ysize(1),:)		- y(ysize(1)-1,:)       ];
	if ~BC,	%  use 1st diff. to fill in edges
		tmp = y([2,2:ysize(1)],:) - y([1,1:ysize(1)-1],:);
		I = find(isnan(dy)); if length(I)>0, dy(I) = tmp(I); end
		tmp = y([2:ysize(1),ysize(1)],:) - ...
			y([1:ysize(1)-1,ysize(1)-1],:);
		I = find(isnan(dy)); if length(I)>0, dy(I) = tmp(I); end
	end
	if RAND, dX = [ ...
		X(2,:)			- X(1,:)                ; ...
               	(X(3:ysize(1),:)	- X(1:ysize(1)-2,:))/2  ; ...
               	X(ysize(1),:)		- X(ysize(1)-1,:)       ];
		dY = [ ...
		Y(2,:)			- Y(1,:)                ; ...
               	(Y(3:ysize(1),:)	- Y(1:ysize(1)-2,:))/2  ; ...
               	Y(ysize(1),:)		- Y(ysize(1)-1,:)       ];
		if ~BC,	%  use 1st diff. to fill in edges
			tmp = (Y([2,2:ysize(1)],:) - Y([1,1:ysize(1)-1],:))/2;
			I = find(isnan(dY)); if length(I)>0, dY(I) = tmp(I); end
			tmp = (Y([2:ysize(1),ysize(1)],:) - ...
				Y([1:ysize(1)-1,ysize(1)-1],:))/2;
			I = find(isnan(dY)); if length(I)>0, dY(I) = tmp(I); end
		end
	elseif ERR, dye2 = [ ... % propogation of errors
		ye(2,:).^2		+ ye(1,:).^2		; ...
               	(ye(3:ysize(1),:).^2	+ ye(1:ysize(1)-2,:).^2)/4; ...
               	ye(ysize(1),:).^2	+ ye(ysize(1)-1,:).^2	];
		if ~BC,	%  use 1st diff. to fill in edges
			tmp = ye([2,2:ysize(1)],:).^2 + ...
				ye([1,1:ysize(1)-1],:).^2;
			I = find(isnan(ye)); if length(I)>0, ye(I) = tmp(I); end
			tmp = ye([2:ysize(1),ysize(1)],:).^2 + ...
				ye([1:ysize(1)-1,ysize(1)-1],:).^2;
			I = find(isnan(ye)); if length(I)>0, ye(I) = tmp(I); end
		end
	end
end

% derivative
yx = dy./dx;
if RAND, % reshape so 3rd dim is trials, then take stdev. along 3rd dim
yxe = std(reshape(dY./dX,[ysize(1),prod(ysize)/ysize(1),trials]),0,3);
elseif ERR, yxe = sqrt(dye2 + 2*((yx.*xe).^2))./dx;
end

% boundary condition
if BC,	yx(1,:) = bc*yx(1,:); yx(ysize(1),:) = bc*yx(ysize(1),:);
	if ERR,	yxe(1,:) = bc*yxe(1,:);
		yxe(ysize(1),:) = bc*yxe(ysize(1),:);
	end
end

% put back to original size
yx = reshape(yx,ysize);
if ERR, yxe = reshape(yxe,ysize); end

% use shift to put back any leading singleton dimensions
%if FRST, xx = shiftdim(xx,-xshft); end
if (yshft==xshft),
	yx = shiftdim(yx,-xshft);
	if ERR, yxe = shiftdim(yxe,-xshft); end
% if y didn't have same no. of leading singleton dimensions
else,	yx = shiftdim(yx,ydims-xshft);	% like a transpose
	yx = shiftdim(yx,-yshft);	% put the leading dims back
	if ERR,	yxe = shiftdim(yxe,ydims-xshft);
		yxe = shiftdim(yxe,-yshft);
	end
end

varargout{1} = yx;
if ERR,	varargout{2} = yxe; end
if (FRST & xdims>0), 
	if ERR, varargout{3} = xx; else, varargout{2} = xx; end; 
end

function [ssh,lon,lat] = read_ssh(filename)
% This function read ssh files from schlax.  They are binary with machine format little-endian

fid=fopen(filename,'r','l');
skip=fread(fid,1,'float');
data=fread(fid,[1440,640],'float=>single')';
data(data>1e35)=nan;
ssh=data;
fclose(fid);
j=[1:640];
i=[1:1440];
dy=.25;
dx=.25;
lat= -80+dy/2+(j-1)*dy;
lon= 0+dx/2+(i-1)*dx;

function [mask,lon,lat,ntot,nneg,nx,ny] = read_mask(filename)
% This function read ssh mask files from schlax.  They are binary with machine format little-endian

fid=fopen(filename,'r','l');
skip=fread(fid,1,'int32');
ntot=fread(fid,1,'int32');
nneg=fread(fid,1,'int32');
nx=fread(fid,1,'int32');
ny=fread(fid,1,'int32');
skip=fread(fid,1,'int32');
skip=fread(fid,1,'int32');
data=fread(fid,[1560,640],'int16')';
test = fread(fid','int16');
data(data==0)=nan;
mask=data;
fclose(fid);
j=[1:640];
i=[1:1560];
dy=.25;
dx=.25;
lat= -80+dy/2+(j-1)*dy;
lon= 259+dx/2+(i-1)*dx;
lon=lon-360;
lon(lon<0)=lon(lon<0)+360;

