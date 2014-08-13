%
% Creates array of weekly averages for new Reynolds data
% Jenny Rolling
% June 29, 2007
%

clear all

% Sunday-centered weeks:

sun_start = datenum( '1-Sep-1999' );
sun_stop  = datenum( '31-Aug-2006' );

d = datevec(sun_start + 3);
yyyy = d(1);
mm = d(2);
dd = d(3);

name = [ 'scratch/newsst_week_' datestr(sun_start+3,8) '_' num2str(yyyy)...
   '-' num2str(mm) '-' num2str(dd) '.mat' ];

eval(['!gunzip -c ' name '.gz>' name])

load(name, 'sst_sum')

sst_mean = sst_sum./7;


for day = (sun_start + 7):7:sun_stop

   d = datevec(day + 3);
   yyyy = d(1);
   mm = d(2);
   dd = d(3);

   name = [ 'scratch/newsst_week_' datestr(day+3,8) '_' num2str(yyyy)...
   '-' num2str(mm) '-' num2str(dd) '.mat' ];

   load(name, 'sst_sum')

   next_mean = sst_sum./7;

   sst_mean = cat(3, sst_mean, next_mean);

   clear sst_sum 

end

% Wednesday-centered weeks:

wed_start = datenum( '24-Dec-1989' );
wed_stop  = datenum( '30-May-2007' );

for day = wed_start:7:wed_stop

   d = datevec(day + 3);
   yyyy = d(1);
   mm = d(2);
   dd = d(3);

   name = [ 'scratch/newsst_week_' datestr(day+3,8) '_' num2str(yyyy)...
   '-' num2str(mm) '-' num2str(dd) '.mat' ];

   load(name, 'sst_sum')

   next__mean = sst_sum./7;

   sst_mean = cat(3, sst_mean, next_mean);

   clear sst_sum 

end
