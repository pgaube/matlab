function [gama,theta,f,CIc,CIp,lag] = pcoh(varargin)

%function [gama,theta,f,CIc,CIp,lag] = pcoh(x,y,dt,df,WIN,zero_pad)

% Calculates the cohearnce squared and phase from sample Cross Power
% Spectral Density of the time series x and y.  Creates a  double paneled
% figured of the coherance with 95% CI and phase for significant coherane
% squared values as 95% errorbars.
% 
%
% Input:
% x   the first time series, must not contain missing data
% y   the second time series which will lag the first for positive values
%     of theta, must not contain missing data and have the same N \delta
%     t as x.
% dt  the sample interval
% df  the requested degress of freedom for the spectral estimates.  Must
%     be a multiple of N/(df/2-1)
% 'win'  the sample window or de-trending methode to be used to calculate
%     the sample PSD estimates
%       options:
%       'rec' rectangle
%       'tri' triangle or Barttlet
%       'trib' triangle but with power boosting
%       'prepost' pre-whiten using first-differance filter and post-color
%                 the spectrum.
% zero_pad  zero pads the time series to the specifed record length
%
% Output:
% gama   the coherance squared
% theta  phase of coherance in degrees
% Clc    the 95% CI for coherance squared
% Clp    the 95% CI fo phase
%

x = fillnans(varargin{1});
y = fillnans(varargin{2});
dt = varargin{3};
df = varargin{4};
WIN = varargin{5};

if nargin == 6
    zero_pad = varargin{6};
end


%make x and y row vector
if length(y(1,:))==1
	y=y';
        x=x';
end

N=length(x);
if N~=length(y)
    warning('PCOH>M: length(x) ~= length(y)')
end    

M=N;
n=[0:N-1];
m=[-(M/2):(M/2-1)];
tn=n.*dt; %Obs times
f=m./(M*dt); %Fourier Freq


%window and remove mean
switch WIN
	case('tri')
		mux=pmean(x);
                muy=pmean(y);
		tap = 1 - ((2.*abs(m))./N); %triangle window
		xn=(x-mux).*tap;
                yn=(y-muy).*tap;
		

	case('rec')
                mux=pmean(x);
                muy=pmean(y);
                xn=(x-mux);
                yn=(y-muy);


	case('end')
                mux=pmean(x);
                muy=pmean(y);
                slx = ((x(length(x))-x(1))/(length(x)));
                sly = ((y(length(y))-y(1))/(length(y)));
				bx = x(1);
				bt = y(1);	
				linx = (slx*n)+bx;
				liny = (sly*n)+by;
				xn=(x-mux)-linx;
				yn=(y-muy)-liny;
		
	case('prepost')
		for m=2:length(y)
			xn(m)=x(m)-x(m-1);
			yn(m)=y(m)-y(m-1);
		end
	
end

%preform fft,center on zero and calculate sample PSD
if nargin == 6
	X=fft(xn,zero_pad);
        Y=fft(yn,zero_pad);
else
    X=fft(xn);
    Y=fft(yn);
end

	X=cat(2,X(ceil((length(X)/2))+1:length(X)),X(1:ceil(length(X)/2)));
	Y=cat(2,Y(ceil((length(Y)/2))+1:length(Y)),Y(1:ceil(length(Y)/2)));


%calculate sample PSD

sx  = X.*conj(X)*(1/N)*dt;
sy  = Y.*conj(Y)*(1/N)*dt;
sxy = Y.*conj(X)*(1/N)*dt;


% Band Average
if df~=2
p=1;
L=df/2;
for m=1:L:length(sx)-L
	Sxba(p) = pmean(sx(m:m+(L-1)));
	Syba(p) = pmean(sy(m:m+(L-1)));
	Sxyba(p) = pmean(sxy(m:m+(L-1)));
if rem(L,2)==0
	fba(p) = pmean([f(m+(L/2)-1) f(m+(L/2))]);
else
	fba(p) = f(m+(L-1)/2);
end
p=p+1;
end
sx=Sxba;
sy=Syba;
sxy=Sxyba;
f=fba;
end





gama=(conj(sxy).*sxy)./real(sx.*sy);
theta=atan2(imag(sxy),real(sxy));

%since xa nd y are assumed real, get rid of negative freq
ii=find(f<0);
gama(ii)=[];
theta(ii)=[];
f(ii)=[];



% calculate confidence intervals
a=.05;
CIc=finv(1-a,2,df-2)/(((df-2)/2)+finv(1-a,2,df-2));
CIp=real(asind(sqrt((2*(1-gama).*finv(1-a,2,df-2))./((df-2).*gama))));

% now find significant vales of theta
ii=find(gama<CIc);
theta(ii)=nan;
CIp(ii)=nan;

%now convert phase to lag

lag=(theta)./((2*pi)*f);

%
%plot
figure(103)
clf
subplot(211)
plot(f,gama,'k')
hold on
scatter(f,gama,'k.')
line([0 max(f)],[CIc CIc],'color','k','linestyle','--')
title('Squared Sample Coherance')
ylabel('squared sample coherance')
xlabel('freq cycles per unit time')

subplot(212)
errorbar(f,theta,CIp,'k.');
title('Phase of Squared Sample Coherance')
ylabel('deg')
xlabel('freq cycles per unit time')
axis([0 max(f) -120 120])
text(0,-100,'positive value corresopnd to y leading x')
line([0 max(f)],[0 0],'color','k')
%

function Y = fillnans(varargin)
% FILLNANS replaces all NaNs in array using inverse-distance weighting.
%
% Y = FILLNANS(X) replaces all NaNs in the vector or array X by
% inverse-distance weighted interpolation:
%                       Y = sum(X/D^3)/sum(1/D^3)
% where D is the distance (in pixels) from the NaN node to all non-NaN
% values X. Values farther from a known non-NaN value will tend toward the
% average of all the values.
%
% Y = FILLNANS(...,'power',p) uses a power of p in the weighting
% function. The higer the value of p, the stronger the weighting.
%
% Y = FILLNANS(...,'radius',d) only used pixels < d pixels away in
% for weighted averaging.
%
% NOTE: Use in conjunction with INVDISTGRID to grid and interpolate x,y,z
% data.
%
% See also INPAINT_NANS
%
% Ian M. Howat, Applied Physics Lab, University of Washington
% ihowat@apl.washington.edu Ian M. Howat
% Version 1: 05-Jul-2007 17:28:57
%   Revision 1: 16-Jul-2007 17:47:43
%       Added increment expression to waitbar to reduce number of times its
%       called. Provided by John D'Errico.
%   Revision 2: 16-Jul-2007 18:40:34
%       Added radius option and 'option',value varargin parser.
%   Revision 3: 18-Jul-2007 10:25:23
%       Adopted several code efficiency revisions made by Urs, including
%       removing the waitbar.

%parse input and set defualts:
X = varargin{1}; %input array
Y = X; %output array
n = 2; %weighting power
d = 0; %distance cut-off radius (0= all pixels, no cut-off)
if nargin > 1 && nargin < 6
    for k=2:2:length(varargin)
        if isnumeric(varargin{k}) || ~isnumeric(varargin{k+1})
            error('Input arguments must be in ''option'',value form.')
        end
        switch lower(varargin{k})	% (Urs:less error prone)
            case 'power'
                n = varargin{k+1};
            case 'radius'
                d = varargin{k+1};
            otherwise
                error(['Unrecognized input argument: ',varargin{k}])
        end
    end
elseif nargin >= 6
    error('Too many input arguments')
end

%(Urs:use ISNAN()/NOT() once only)
ix=isnan(X);
[rn,cn]=find(ix);   %row,col of nans
ix=~ix;
[r,c]=find(ix);     %row,col of non-nans
ind=find(ix);       %index of non-nans

%Break distance-finding loops into with cut-off and without cut-off
%versions. The cutoff conditional statement adds time
%if cut-off values near the max pixel distance are used.

if d %distance cut-off loop
    d=d.^2;				% (Urs:allows first step without SQRT())
    for k = 1:length(rn)
        D = (rn(k)-r).^2+(cn(k)-c).^2;	% (Urs:no SQRT() here)
        Dd = D < d;
        if sum(Dd) ~= 0
            D=1./sqrt(D(Dd)).^n; %(Urs: Compute once only for valid <D>s)
            Y(rn(k),cn(k)) = sum(X(ind(Dd)).*D)./ sum(D);
        end
    end
else %no distance cut-off loop
    for k = 1:length(rn)
        D = 1./(sqrt((rn(k)-r).^2+(cn(k)-c).^2)).^n;% (Urs:compute once only)
        Y(rn(k),cn(k)) = sum(X(ind).*D)./sum(D);
    end
end

function mean = pmean(x)
warning('OFF','all')
x=x(:);
p=~isnan(x);
y=x(p);
mean=sum(y)/length(y);
warning('ON','all')