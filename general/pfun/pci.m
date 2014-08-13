function ci=pci(varargin)
%%%%
%function ci=pci(varargin)
%computes the confidence interval of the mean
%INPUTS
% if nargin==1, input is the data
% if nargin==2,
%   ci=pci(n,std)

if nargin==1
    data=single(varargin{1});
    data=data(:);
    n=length(data);
    s=pstd(data);
elseif nargin==2
    n=single(varargin{1});
    s=single(varargin{2});
    
else
    error('to many inputs')
end

ci=abs(s.*tinv((.1)/2,n-1)./sqrt(n));