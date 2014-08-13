function [filtered_x] = filter_median(SPAN,x)
  %[filtered_x] = filter_median(SPAN,x)
  %median filter that replaces each value of x with the median of
  %SPAN nearest observations. Will replace NaNs with median value
  %SPAN nearest observations.  Errors will occur of a gap of size
  %SPAN is encountered.
  %
  %Input
  %n = number of standard deviation from the mean
  %x = data (Can contain Nan's, must be a [1 m] array)
  %
  %Output
  %filtered_x = vector size(x) where each value is the median of +/- (SPAN-1)/2

hw = (SPAN-1)/2;
%Index data
p=length(x);
m = ((hw+1):p-(hw+1))

%create filltered_x
filtered_x = nan(size(x));

%calculate medians and replace data
for b = 1:length(m)
    filtered_x(m(b)) = nanmedian(x(m(b)-hw:m(b)+hw));
end



