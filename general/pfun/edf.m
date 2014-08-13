function [n_star]= edf(ts,METHOD)
%function [n_star]= edf(ts,'METHOD')
%
%EDF.m calculates the Effective Degrees of Freedom for estimating the
%Sample Variance.  
%
%Input:
%ts=Time series data.  If 'STATISTIC' is 'cov', ts must be a [nxm] matrix
%with n observations of m variables.
%METHOD =   'var'=Variance
%            'cov'=Covariance
%            'pdf'=PDF method
%            'art'=Articial Skill Method

%Output:
%Nstar = The Effective Degrees of Freedom

if length(ts(1,:))>1
    good=find(~isnan(ts(:,1)) & ~isnan(ts(:,2)));
else
    good=find(~isnan(ts));
end
N=length(ts(good));
lag = [-N:N];
trunc=find(lag>-0.8*N & lag<0.8*N);
lag=lag(trunc);
p = find(lag(2:length(lag)-1));


switch METHOD
        case {'var'}
          acors_x = pcor(ts(:,1),ts(:,1),lag);
          n_star = N/(sum(((N-abs(lag(p)))/N).*(acors_x(p).^2)));
         
        case {'cov'}
          acors_x = pcor(ts(:,1),ts(:,1),lag);
          acors_y = pcor(ts(:,2),ts(:,2),lag);
          ccors_p = pcor(ts(:,1),ts(:,2),lag);
          ccors_n = pcor(ts(:,1),ts(:,2),-lag);
          n_star = N/sum(((N-abs(lag(p)))/N).*...
                         ((acors_x(p).*acors_y(p))+...
                          (ccors_p(p).*ccors_n(p))));
        case {'pdf'}
              M=1;
              ag = [0:N];
              upper=ag(find(ag>0.6*N & ag<0.8*N));
              lower=-upper;
              lower=fliplr(lower);
              [rho_up,sig,n_up]=pcor(ts(:,1),ts(:,1),upper);
              [rho_low,sig,n_low]=pcor(ts(:,1),ts(:,1),lower);
              A1 = (1/(2*length(upper)))*sum((rho_up.^2./(1-rho_up.^2))+...
                                   (rho_low.^2./(1-rho_low.^2)));
              A2 = (1/(2*length(upper)))*sum(((n_up.*(rho_up.^2./...
                                   (1-rho_up.^2)))+(n_low.*(rho_low.^2./...
                                   (1- rho_low.^2)))));
              n_star = N*((M+(M+3)*A1)/A2); 
        case {'art'}
              M=1;
              ag = [0:N];
              upper=ag(find(ag>0.6*N & ag<0.8*N));
              lower=-upper;
              lower=fliplr(lower);
              [rho_up,sig,n_up]=pcor(ts(:,1),ts(:,1),upper);
              [rho_low,sig,n_low]=pcor(ts(:,1),ts(:,1),lower);
              A = (1/(2*length(upper)))*sum((rho_up.^2.*n_up)+...
                                            (rho_low.^2.*n_low));
              n_star = N*(M/A);

end

