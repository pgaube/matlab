function s = sigma(p,t,s)
% function s = sigma(p,t,s)

[m,n] = size(t);

s = ones(m,n)./eos80(p,t,s) - 1000;
