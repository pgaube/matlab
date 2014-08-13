
function [F,A,v,D,Err,p] = eof_svd(X, bad, toler)

% compute the EOFs from the covariance matrix of a data set 
% with (potentially) missing data.
%
% [F,A,v,D,Err,p] = eof_svd(X, bad, toler)
%
% input
%    X, the data matrix, M columns (grid location), N rows (time)
%    bad is the user specified value (e.g., NaN) of missing data
%           on input.  On return, any estimates of the amplitude
%           time series that exceed 100*toler are set to bad.
%    toler  defines acceptable upper limit of expected
%           square error in percent
%
% output
%    F is the eigenvectors (loadings), normalized to have mean
%         square of 1 over the M grid points.
%    A are the EOF amplitude time series, normalized to be compatible
%         with renormalized eigenvectors.
%    D is the eigenvalues of the orthonormal (i.e., non-renormalized)
%         eigenvectors.
%    Err is the expected percent square error at each time for each
%         of the EOF amplitude time series estimates.  Err is zero
%         if there are no missing data.
%    v is variance accounted for in each mode
%    p is the local percent of varaince accounted for by each mode

[N,M] = size(X);
warning('off','all')
% get the correlation matrix-- more difficult due to missing data
R = zeros(M,M);
for i = 1:M
fprintf('doing %d of %d\n', i,M)
   for j = i:M
       [ptmp,rtmp,ntmp]=pcor(X(:,i),X(:,j),0);
       %[ltmp, rtmp, ptmp, ntmp] = cross_corr(X(:,i), X(:,j), 0, bad);
       R(i,j) = rtmp;
       R(j,i) = rtmp;
   end
end

% Decompose into singular matrices:
% F are orthonormal eigen vectors
fprintf('Performing SVD')
[W,D,F] = svd(R);

% get variance for each mode
D = diag(D);

%get the vartiance accounted for by each EOF
v= ((D./sum(D).*100));

% amplitude functions
% find times where there are no missing grid points
not_missing = zeros(N,1);
for i = 1:N
  if isnan(bad)
   if (sum(~isnan(X(i,:)))==M)
       not_missing(i)=1;
   end
  else
   if (sum(X(i,:)~=bad)==M)
       not_missing(i)=1;
   end
  end
end

% easy for case of no missing data
A = zeros(N,M);
Err = zeros(N,M);
found_id = find(not_missing==1);
A(found_id,:) = X(found_id,:)*F;

% not easy for the case of missing grid points at a particular time
missing_id = find(not_missing==0);
NM = length(missing_id);

% do each of these times with the Davis 1977 fix
for i = 1:NM
   t = missing_id(i);
   %fprintf('doing %d of %d of missing\r', i, NM);
  if isnan(bad) % check for missing values is different for NaNs
   missing_gid = find(isnan(X(t,:)));
   found_gid = find(~isnan(X(t,:)));
  else
   missing_gid = find(X(t,:)==bad);
   found_gid = find(X(t,:)~=bad);
  end
% estimate gamma (the sum over the missing gridpoints)
   G = zeros(M,M);
   for j = 1:M
       for k = j:M % use symmetry trick
           G(j,k) = sum(F(missing_gid,j).*F(missing_gid,k));
           G(k,j) = G(j,k);
       end
    end

% do each mode now
   for j = 1:M

% H is a handy vector, needed below
       H = 0;
       for k = 1:M
           if (k~=j)
               H = H + D(k)*(G(j,k)^2);
           end
       end

       beta = (1-G(j,j)) * D(j);
       beta = beta/( D(j)*((1-G(j,j))^2) +  H);

% and the estimate of the amplitude
       A(t,j) = beta*sum(F(found_gid,j).*X(t,found_gid)');

% the error of this estimate is expected to be
% look carefully and see that this is variance [units]
       Err(t,j) = (beta*beta*H) + D(j)*( (1+beta*(G(j,j)-1))^2 );

% normalize by eigen value
% now, it will be non-dimensional
		Err(t,j) = Err(t,j)/D(j);
% check if Err exceeds the upper limit definded by toler
       if Err(t,j)*100>toler
       A(t,j) = bad;
       end

   end % loop j over M
end % loop i over N

%Calculate p, the local fraction of variance explained by each EOF(F) at
%each grid point

for m=1:length(F(1,:))
    p(:,m) = ((F(:,m)).^2.*A(m))./A(m);
end

f = find(isnan(A)==1);
A1 = A;
A1(f) = 0;
a_curl = sum((A1.*A1))/length(A(:,1));
d_curl = a_curl*(F.*F);

%calculate pk for all points, all EOFs
for l = 1:length(F(:,1))
pk(:,l) = a_curl(l)*(F(:,l).*F(:,l))./d_curl';
end

%normalize so that each point m has 100%
for l=1:length(p(1,:))
p(l,:) = pk(l,:)*100/sum(pk(l,:));
end


% now fix up so mean square of F are 1
% that is F'*F' = M I, the identity matrix
F = F*sqrt(M); 
A = A/sqrt(M);

