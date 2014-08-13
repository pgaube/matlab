function [S,f,k,CI] = ppsd2d(varargin)

%function [S,f,k,CI] = ppsd2d(y,dt,dx)
% Calculates the sample Power Spectral Density of time series y.  Creates
% a loglog plot of the sample PSD with an errorbar
%
% Input:
% y   the input matrix, y = [time,space] and must not contain missing data
% dt  the sample time interval
% dx  the sample space interval
% df  the requested degress of freedom for the spectral estimates.  Must
%     be a multiple of N/(df/2-1)

% Output:
% S the sample PSD if y
% CI the confidence interval of S
%

y = varargin{1};
dt = varargin{2};
dx = varargin{3};
zf=length(y(:,1));
zk=length(y(1,:));


y=fillnans(y);

N=length(y(:,1));
M=N;
n=[0:N-1];
m=[0:N-1]/N;
tn=n.*dt; %Obs times
f=dt/2*m; %Fourier Freq

B=length(y(1,:));
D=B;
b=[0:B-1];
d=[0:N-1]/N
tb=b.*dx; %Obs locs
k=dx/2*d; %Fourier wave numbers

%k=fliplr(k);
[k,f]=meshgrid(k,f);


%window and remove mean

mu=pmean(y(:));
va=pvar(y(:));
tap=1;
yn=(y-mu).*tap;
vn=pvar(yn);


%preform fft,center on zero and calculate sample PSD
Y=fft2(yn,zf,zk);
s = real(Y.*conj(Y)).*(1/N)*dt.*(1/B)*dx;
S = s.*(va/vn);
S=S(1:N/2+1,1:B/2+1)
S = fftshift(s);
f=fftshift(f);
k=fftshift(k);


r=find(f(:,1)==0);
c=find(k(1,:)==0);

%S(r,:)=nan;
%S(:,c)=nan;


%{
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
%}



%{
%Now plot, default figure number is 101
figure(101)
clf
loglog(f,S,'k')
title('Sample Power Spectral Density')
xlabel('untis of time^2/cycle per unit time')
ylabel('untis^2/cycle per unit time')
axis([1e-5 1 1e-7 1e7])
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

