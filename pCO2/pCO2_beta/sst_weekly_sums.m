% 
% Creates a file for each week of new Reynolds data that contains both weekly 
% sums and weekly sums of squares.
% From Eric Beals with additions by Jenny Rolling.
% June 27, 2007.
%


% The Wednesday-centered data

start = datenum( '27-May-2007' );
stop  = datenum( '01-Jun-2007' );

for day = start:7:stop

% a 2-dim array with the sum 

  sst_sum = get_sst( day ); 
  for h = 1:6
    sst_sum = sst_sum + get_sst( day+h );
  end

% a 2-dim array with the sum of the squares

  sst_squares = (get_sst( day ) ).^2;
  for h = 1:6
    sst_squares = sst_squares + ( get_sst( day+h ) ).^2;
  end

  d = datevec(day + 3);
  yyyy = d(1);
  mm = d(2);
  dd = d(3);

  save_file = [ 'scratch/newsst_week_' datestr(day+3,8) '_' num2str(yyyy)...
   '-' num2str(mm) '-' num2str(dd) ];

  save( save_file, 'sst_sum', 'sst_squares' );

  clear

end    