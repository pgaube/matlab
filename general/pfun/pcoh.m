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

x = varargin{1};
y = varargin{2};
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
figure(102)
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

