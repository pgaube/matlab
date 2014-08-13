function [month,day,year] = jul2date(julday,year0)

days(1) = 31;
days(3) = 31;
days(5) = 31;
days(7) = 31;
days(8) = 31;
days(10) = 31;
days(12) = 31;
days(2) = 28;
days(4) = 30;
days(6) = 30;
days(9) = 30;
days(11) = 30;

year = year0;
if (julday > 0),
	DAYS = 365;
	if (mod(year,4)==0),
		DAYS = DAYS + 1;
		end
	while (julday > DAYS),
		julday = julday - DAYS;
		year = year + 1;
		DAYS = 365;
		if (mod(year,4)==0),
			DAYS = DAYS + 1;
			end
		end
	if (mod(year,4)==0),
		days(2) = days(2) + 1;
		end
	month = 1;
	while (julday > days(month)),
		julday = julday - days(month);
		month = month + 1;
		end
	day = julday;
else,
	year = year - 1;
        DAYS = -365;
        while (julday < (DAYS+1)),
                julday = julday - DAYS;
                year = year - 1;
                DAYS = -365;
		if (mod(year,4)==0),
			DAYS = DAYS - 1;
			end
		end
	if (mod(year,4)==0),
		days(2) = days(2) + 1;
		end
        month = 12;
        while (julday < -1*days(month)),
                julday = julday + days(month);
                month = month - 1;
		end
        day = days(month);
        while (julday < 0),
                julday = julday + 1;
                day = day - 1;
		end
	end
