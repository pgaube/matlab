function julday = julian(month,day,year,year0)
%julday = julian(month,day,year,year0)

days(1) = 31;
days(2) = 28;
days(3) = 31;
days(4) = 30;
days(5) = 31;
days(6) = 30;
days(7) = 31;
days(8) = 31;
days(9) = 30;
days(10) = 31;
days(11) = 30;
days(12) = 31;

if ~exist('year0'),
	year0 = year;
	end
julday = 0;
if (year>=year0)
	for i=year0:year-1,
		julday = julday + 365;
		if (mod(i,4)==0),
			julday = julday + 1;
			end
		end
else,
	for i=year0-1:-1:year,
		julday = julday - 365;
		end
	if (mod(i,4)==0),
		julday = julday - 1;
		end
	end
if (mod(year,4)==0),
	days(2) = days(2) + 1;
	end
for i=1:month-1,
	julday = julday + days(i);
	end
julday = julday + day;
