function trms_bar = tiwi(lat,lon,data)

%function x = tiwi(lat,lon,data)
%Caclulates the TIW Index based on the root mean squared value of the data in the following region
%
%			North Region
%			   11
%		 250		280
%			    9
%
%			South Region
%			  -0.5
%		200			250
%			   -4

%Select North Region
c=find(lat>=0 & lat<=3.5); 
r=find(lon>=200 & lon<=250);

T1 = data(c,r,:);

%Select South Region
%c=find(lat>=-4 & lat<=0.5); 
%r=find(lon>=200 & lon<=250);

%T2 = data(c,r,:);

%Combine two regions

%T = cat(1,T1,T2);
T=T1;

for k = 1:length(T(1,1,:))
	
	t = T(:,:,k);
	i = find(~isnan(t));
	x = t(i);
	tbar = mean(x(:));
	tprime = t-tbar;
	tprime2 = tprime.^2;
	xprime2 = tprime2(i);
	tprime2bar = mean(xprime2(:));
	trms_bar(k) = sqrt(tprime2bar);

end

		