%Calculates the Z-Score of a matrax containing NaN data points. This will create an equal size matrix
%of Z-Scores.  i.e  each data cell will be transformed into a Z-Score based off of that image
%function [Z] = zscore(x)
%Copyright Peter Gaube September 18 2006

function [Z]  = zscore(x)

[M,N,P] = size(x);

Z=nan*ones(M,N,P);
dim = M*N;

data = reshape(x,dim,P);
f = ~isnan(data);
i = find(isnan(data));
data(i) = 0;
bar = sum(data,1)./sum(f,1); 
shapebar = ones(dim,1)*bar;
mbar = reshape(shapebar,M,N,P);
Z = x-mbar;