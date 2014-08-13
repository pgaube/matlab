function [S,f,CI] = ppsd(varargin)

%function [S,f,CI] = ppsd(y,dt,df,WIN,zero_pad)
% Calculates the sample Power Spectral Density of time series y.  Creates
% a loglog plot of the sample PSD with an errorbar
%
% Input:
% y   the time series, must not contain missing data
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
% S the sample PSD if y
% CI the confidence interval of S
%

y = varargin{1};
dt = varargin{2};
df = varargin{3};
WIN = varargin{4};

if nargin == 5
    zero_pad = varargin{5};
end


%make y row vector
if length(y(1,:))==1
	y=y';
end

N=length(y);
M=N;
n=[0:N-1];
m=[-(M/2):(M/2-1)];
tn=n.*dt; %Obs times
f=m./(M*dt); %Fourier Freq


%window and remove mean
switch WIN
	case('tri')
		mu=pmean(y);
		va=pvar(y);
		tap = 1 - ((2.*abs(m))./N); %triangle window
		yn=(y-mu).*tap;
		vn=pvar(yn);

	case('rec')
		mu=pmean(y);
		yn=(y-mu);
		va=1;
		vn=1;


	case('end')
		va=pvar(y);
		mu=pmean(y);
		sl = ((y(length(y))-y(1))/(length(y)));
		b = y(1);
		lin = (sl*n)+b;
		yn=(y-mu)-lin;
		vn=pvar(yn);
		va=1;
		vn=1;
		
	case('prepost')
		yn(1)=0;
		for m=2:length(y)
			yn(m)=y(m)-y(m-1);
		end
	
		va=1;
		vn=1;
		
	case('prepost2')
		for m=2:length(y)
			yb(m-1)=y(m)-y(m-1);
		end
		for m=2:length(yb)
			yn(m-1)=yb(m)-yb(m-1);
		end
		
		M=length(yn);
		m=[-(M/2):(M/2-1)];
		f=m./(M*dt); %Fourier Freq

		va=1;
		vn=1;	
		
end

%preform fft,center on zero and calculate sample PSD
if nargin == 5
    Y=fft(yn,zero_pad);
else
    Y=fft(yn);
end

	Y=cat(2,Y(ceil((length(Y)/2))+1:length(Y)),Y(1:ceil(length(Y)/2)));

s = Y.*conj(Y)*(1/N)*dt;
s = s.*(va/vn);  %boost var to account for tapers

% Now make 1-sided, since we will ignore the 0 and Nyquist freq., we don't care if y is even or odd
ii=find(f>=1/(N*dt) & f< 1/(2*dt));
S=real(2*s(ii)); %multiply by 2 to preserve variance
f=f(ii);

% add back anything that was taken out
switch WIN
	case('prepost')
	hh=2*(1-cos(2*pi*f*dt));
	S=S./hh;
	
	case('preposts')
	hh=2*(1-cos(2*pi*f*dt));
	S=S./hh;
	S=S./hh;
end

% Band Average
if df~=2
p=1;
L=df/2;
for m=1:L:length(S)-L
Sba(p) = pmean(S(m:m+(L-1)));
if rem(L,2)==0
	fba(p) = pmean([f(m+(L/2)-1) f(m+(L/2))]);
else
	fba(p) = f(m+(L-1)/2);
end
p=p+1;
end
S=Sba;
f=fba;
end

% calculate confidence intervals
a=.05;
qhi=chi2inv(a/2,df);
qlo=chi2inv(1-(a/2),df);
CI(1)=df/qlo;
CI(2)=df/qhi;




%
%Now plot, default figure number is 101
figure(101)
clf
loglog(f,S,'k')
title('Sample Power Spectral Density')
xlabel('untis of time^2/cycle per unit time')
ylabel('untis^2/cycle per unit time')
%axis([1e-5 1 1e-7 1e7])
hold on
errorbar(1e-3,1e2,1e2*CI(1),1e2*CI(2),'k.')
text(10^-4.3,1e-1,{['df = ',num2str(df)],['N = ',num2str(N)],['dt = ',num2str(dt)],['method ',WIN]})
hold off
%}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function v=pvar(x)

p=~isnan(x);
y=x(p);
v = pmean(y.^2)-pmean(y)^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function mean = pmean(x)

p=~isnan(x);
y=x(p);
mean=sum(y)/length(y);

