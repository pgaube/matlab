function y = interpnan(x,bound)
% function y = interpnan(x,{bound})
% replaces NaNs in vector v w/interpolated ones
% - y is the new, interpolated, vector
% - if bound==0, beginning and ending NaN's are left alone
% - if bound==1, beginning and ending NaN's are replaced nearest good values
% - if bound==2, beginning and ending NaN's are replaced by assuming
%	data to be periodic
% - if bound==3, beginning and ending NaN's are cut
%
% copyright (c) S.C.Kennan (20Feb92,05feb1997)

if ~exist('bound'), bound = 0; end
if bound==0,
	sam = 0;
	per = 0;
	cut = 0;
    elseif bound==1,
	sam = 1;
	per = 0;
	cut = 0;
    elseif bound==2,
	sam = 0;
	per = 1;
	cut = 0;
    elseif bound==3,
	sam = 0;
	per = 0;
	cut = 1;
    end

begcut = 0;
endcut = 0;

x = x(:);
M = length(x);

if per,
	x = [x;x;x];
    end

N = length(x);
t = 1:N;

if isnan(x(N)),
	endbad = 1;
	last = max(find(~isnan(x)));
	if cut,
		x(last+1:N) = [];
		t(last+1:N) = [];
	    else,
		x(last+1:N) = x(last)*ones(N-last,1);
	    end
    else, endbad = 0;
    end

if isnan(x(1)),
	begbad = 1;
	first = min(find(~isnan(x)));
	if cut,
		x(1:first-1) = [];
		t(1:first-1) = [];
	    else,
		x(1:first-1) = x(first)*ones(first-1,1);
	    end
    else, begbad = 0;
    end

I = find(isnan(x));
xx = x;
tt = t;
xx(I) = [];
tt(I) = [];
y = interp1(tt,xx,t);

if per,
	y(1:M) = [];
	y(M+1:2*M) = [];
    else,
	if (begbad & ~sam & ~cut),
		y(1:first-1) = NaN*ones(first-1,1);
	    end
	if (endbad & ~sam & ~cut),
		y(last+1:N) = NaN*ones(N-last,1);
	    end
    end

y = y(:);
