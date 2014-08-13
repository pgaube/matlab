%function [Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(x,y,Lags)
%
%Copyright Peter Gaube 4/28/2008
%
%x,y,Lag must be 1d arrays
%Input
%data1 = input data that is not to be lagged
%data2 = input data that is lagged before/after data1.  If calculating
%        lagged auto correlation, data1=data2.  
%Lags =  Lags, can be an [nx1] array of positive or negative integers
%        If lag < 0, data1 laggs data2.  If lag is time, as lag increases, data2 catches data1, 
%		 or high Cor at lag >0, data1 occured before data2.
%
%Outputs
%Cor = Correlation between Data1 and Data2 at all lags. Size(Cor) = Size(lag)  
%Sig = 95% Significance level of the correlation.  This assumes N>=30
%      allowing the assymtotic assumption to be made.  The assymtotic assumption
%      allows the Student-t distribution to be approximated by a Gaussian
%      Distribution. Size(Sig) = Size(lag)
%Covar = Covariance of Data1 and Data2, Size(Covar) = Size(lag).

function [Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(varargin)

data1 = varargin{1};
data2 = varargin{2};

%%%%%PG Feb-20-2014  Added following lines to fix issue when two data sets
%%%%%have a shit-ton of nan's, was resulting in Cor>1.

data1(find(isnan(data2)))=nan;
data2(find(isnan(data1)))=nan;

%Check to see of laged, or just lag=0
if nargin == 2
Lags=0;
else
Lags = varargin{3};
end

%Check to see if dim(x)=dim(y).

%Preallocate space to save time
Cor=repmat(length(Lags),1);
Covar=repmat(length(Lags),1);
N=repmat(length(Lags),1);
Sig=repmat(length(Lags),1);


%check if auto or cross correlation
ii=find(~isnan(data1) & ~isnan(data2));
if  data1(ii)==data2(ii) %then auto-correlation 
    METHOD = 'auto';
else METHOD = 'cross';
end

switch METHOD
    case {'auto'}
      for p=1:length(Lags)
        if Lags(p)>=0;
            lag=Lags(p)+1; %adds 1 to lag because matlab syntax is index 
                           %of first element of an array is equal to 1, 
                           %not zero.  
                           % k = abs(lag:length(data2));
        else
            lag = Lags(p)-1;
        end
        XX = repmat([1:(length(data1)-(abs(lag)-1))],1);
        YY = repmat([1:(length(data1)-(abs(lag)-1))],1);
        k = [abs(lag):length(data2)];
        %First calculate the 95% significance limits
          Sig(p) = 1.96/sqrt(length(k));
        %assign x variables to data1, x is not lagged
          Xbar(p) = pmean(data1([1:(length(data1)-(abs(lag)-1))]));
          sdX(p) = pstd(data1([1:(length(data1)-(abs(lag)-1))]));
          XX = data1([1:(length(data1)-(abs(lag)-1))])-Xbar(p);

        %assign y variables to data2, which is lagged
          Ybar(p) = pmean(data2([k]));
          sdY(p) = pstd(data2([k]));
          YY = data2([k])-Ybar(p);

        %Calculate covariance of X and Y
          Covar(p) = pmean(XX.*YY);
          N(p) = length(~isnan(XX.*YY));
        
        %calculate correlation of X and Y
          Cor(p) = Covar(p)./(sdX(p)*sdY(p));
      end

    case {'cross'}
      for p=1:length(Lags)
        if Lags(p)>=0;
            lag=Lags(p)+1; %adds 1 to lag because matlab syntax is index 
                           %of first element of an array is equal to 1, 
                           %not zero.  
                           %k = abs(lag:length(data2));
        
            k = abs(lag):length(data2);
            %First calculate the 95% significance limits
              Sig(p) =1.96/sqrt(length(k));
            %assign x variables to data1, x is not lagged
              Xbar(p) = pmean(data1(1:(length(data1)-(abs(lag)-1))));
              sdX(p) = pstd(data1(1:(length(data1)-(abs(lag)-1))));
              XX = data1(1:(length(data1)-(abs(lag)-1)))-Xbar(p);

            %assign y variables to data2, which is lagged
              Ybar(p) = pmean(data2(k));
              sdY(p) = pstd(data2(k));
              YY = data2(k)-Ybar(p);
        else
            lag = Lags(p)-1;
                
            k = [abs(lag):length(data2)];
            %First calculate the 95% significance limits
              Sig(p) =1.96/sqrt(length(k));
            %assign x variables to data1, x is not lagged
              Xbar(p) = pmean(data2(1:(length(data2)-(abs(lag)-1))));
              sdX(p) = pstd(data2(1:(length(data2)-(abs(lag)-1))));
              XX = data2(1:(length(data2)-(abs(lag)-1)))-Xbar(p);

            %assign y variables to data2, which is lagged
              Ybar(p) = pmean(data1(k));
              sdY(p) = pstd(data1(k));
              YY = data1(k)-Ybar(p);
        end
        %Calculate covariance of X and Y
          Covar(p) = pmean(XX.*YY);
          N(p) = length(~isnan(XX.*YY));

        %calculate correlation of X and Y
          Cor(p) = Covar(p)./(sdX(p)*sdY(p));

      end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here are the sub function called in pcor.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mean = pmean(x)
x=x(:);
p=~isnan(x);
y=x(p);
mean=sum(y)/length(y);

function sd=pstd(x)

sd=sqrt(pvar(x));

function v=pvar(x)
x=x(:);
p=~isnan(x);
y=x(p);
v = pmean(y.^2)-pmean(y)^2;
