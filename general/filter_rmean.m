function newy=filter_rmean(y,half_span);

%function newy=filter_rmean(y,half_span);
%Running mean filter

M = length(y);

for m=1:M
   if m<half_span+1
       lo = 1;
   else
       lo = m-half_span;
   end
   
   if m>M-half_span-1
       hi = M;
   else
       hi = m+half_span;
   end
   newy(m) = pmean(y(lo:hi));
end
