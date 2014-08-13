function [anom_sign,anom_mag] = anom_sign(data)

%check for all nans
ii=~isnan(data);
if sum(ii)<1
	anom_sign=nan;
	anom_mag=nan;
	return
end

anom_mag=pmean(data);
maxx=max(data(:));
minn=min(data(:));
stdd=pstd(data(:));

cc=(length(data(:,1))+1)/2;

[ymaxx,xmaxx]=find(data==maxx);
[yminn,xminn]=find(data==minn);


rmaxx = sqrt((xmaxx-cc)^2+(ymaxx-cc)^2);
rminn = sqrt((xminn-cc)^2+(yminn-cc)^2);

if anom_mag>0 & abs(maxx)>abs(minn) & rmaxx<rminn
anom_sign = 3;
elseif anom_mag>0 & abs(maxx)>abs(minn)
anom_sign = 2;
elseif anom_mag>0
anom_sign = 1;
elseif anom_mag<0 & abs(maxx)<abs(minn) & rmaxx>rminn
anom_sign = -3;
elseif anom_mag<0 & abs(maxx)<abs(minn)
anom_sign = -2;
elseif anom_mag<0
anom_sign = -1;
end

