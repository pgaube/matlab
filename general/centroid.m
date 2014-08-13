function [x,y] = centroid(B)
% Find the centroid of ans object.  B must by 2-d


B(find(~isnan(B)))=1;
B(find(isnan(B)))=0;
siz = sum(sum(B>0));
B = double(B);
Bx = B .* ( ones(size(B,1),1) * [1:size(B,2)] );
By = B .* ( [1:size(B,1)]' * ones(1,size(B,2)) );
x = sum(sum(Bx)) / siz;
y = sum(sum(By)) / siz;
