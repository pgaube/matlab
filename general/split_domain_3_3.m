M=3;
N=3;


for m=1:M
for n=1:N
if m==1
    r=1:m*(length(lat(:,1))/M);
else
    r=((m-1)*(length(lat(:,1)))/M)+1:m*(length(lat(:,1)))/M;
end
eval(['R' num2str(m) '=r;']);
clear r

if n==1
    c=1:n*(length(lon(1,:))/N);
else
    c=((n-1)*(length(lon(1,:)))/N)+1:n*(length(lon(1,:)))/N;
end
eval(['C' num2str(n) '=c;']);
clear c
end
end

locx=1;
locy=1;
for m = 1:M
   for n = 1:N
    eval(['r' num2str(locx) '=R' num2str(m) ';'])
    locx=locx+1;
    eval(['c' num2str(locy) '=C' num2str(n) ';'])
    locy=locy+1;
    end
end

clear m n locx locy C* R*