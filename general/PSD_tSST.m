%Caclulates the PDF base from tSST data at the following location:
%
LAT = 4
LON = 250

%select data
i = find(lat==LAT);
j = find(lon==LON);
x = tSST(i,j,:);
x = x(:);

% Check records 
figure(1)
plot(x)
title('Raw data')
xlabel('Day')
print -dpsc tester.ps
!open tester.ps
clf

%Clear NaN
i = find(~isnan(x));
x=x(i);


%Calculate PSD wising pwelch
[Pxx,F]=pwelch(x);
loglog(F,Pxx)
title('Power Spec Density of tSST at lat = 4 and Lon = 250;')
xlabel('Freq')
ylabel('Energy')
print -dpsc tester.ps
!open tester.ps
clf
