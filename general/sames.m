function [index] = sames(x,y)
% function [index] = sames(X,Y)
% returns vectors containing the indices
% of y of values found in x.
%
% PGaube(29aug2008)

m = length(x);
index=nan(size(y));

n=1;
for i=1:m,
    K = find(y==x(i));
    if any(K)
    index(n:n-1+length(K))=K;
    n=n+length(K);
    end
end
index(isnan(index))=[];
index=unique(index);

