function Y = interp2nan(X,row,col)
% function Y = interp2nan(X,row,col)
% - interpolates within rows and columns seperately,
%   using "interpnan.m", and then averages the results.
% - row:  when 0, bounding NaN's are left for ea. row,
%	  when 1, bounding NaN's are replaced using nearest good in row
%	  when 2, bounding NaN's are replaced using periodic rows
% - col:  when 0, bounding NaN's are left for ea. col.,
%	  when 1, bounding NaN's are replaced using nearest good in col
%	  when 2, bounding NaN's are replaced using periodic cols
%
% copyright (c) S.C.Kennan (01nov19996),(05feb1997)

[m,n] = size(X);
Y = X;
C = NaN*ones(m,n);
R = NaN*ones(m,n);

%  interpolate within rows
for i=1:m,
	if (sum(isnan(X(i,:))) & sum(isnan(X(i,:)))<=n/2),
		R(i,:) = (interpnan(X(i,:),row))';
	    else
		R(i,:) = X(i,:);
	    end
    end

%  interpolate within cols
for i=1:n,
	if (sum(isnan(X(:,i))) & sum(isnan(X(:,i)))<=m/2),
		C(:,i) = interpnan((X(:,i))',col);
	    else
		C(:,i) = X(:,i);
	    end
    end

I = find(isnan(X));  Y(I) = (R(I)+C(I))/2;
I = find(isnan(X) & isnan(R) & ~isnan(C));  Y(I) = C(I);
I = find(isnan(X) & isnan(C) & ~isnan(R));  Y(I) = R(I);
