%landmask

[m,n,p]=size(tSST);
mask = ones(m,n)


for i = 1:m
for j = 1:n
	k = length(find(isnan(tSST(i,j,:))))
	if k==p;
	mask(i,j) = 0;
	end
end
end

