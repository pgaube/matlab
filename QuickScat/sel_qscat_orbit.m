function [sel_orbit_num, ...
          sel_orbit_year, ...
	      sel_orbit_day] = sel_qscat_orbit(minyear, ...
	                                       maxyear, ...
					                       minday, ...
					                       maxday);

%global QSCAT_ORBIT_FILE_DIR
global QSCAT_ORBIT_INFO_FILE
	  
%set_grid_qscat_params

%qdir = '/home/dingo/usr11/loneill/qscat_fields/orbits/';

%
% Open file with times of orbit equatorial crossings. Information taken
% from the SSMI website.
%

fp = fopen(QSCAT_ORBIT_INFO_FILE,'r');
a = fscanf(fp,'%56c');
fclose(fp);

all_orbit_info = reshape(a,56,length(a)/56)'; % used to be 55
all_orbit_info = all_orbit_info(:,1:54);
clear a

all_orbit_year = str2num(all_orbit_info(:,15:18));
all_orbit_day  = str2num(all_orbit_info(:,20:22));
all_orbit_num  = str2num(all_orbit_info(:,1:6));

nyears = maxyear - minyear;

if nyears == 0,

   sel_orbit_index = all_orbit_year >= minyear & all_orbit_year <= maxyear & ...
                     all_orbit_day  >= minday  & all_orbit_day  <= maxday; 

   sel_orbit_year = all_orbit_year(sel_orbit_index);
   sel_orbit_day = all_orbit_day(sel_orbit_index);
   sel_orbit_num = all_orbit_num(sel_orbit_index);

else,

   k = nyears;
   years = minyear:maxyear;
   
   while 1,
   
      kk = nyears-k+1;
      
      if k==nyears,
      
         sel_orbit_index = all_orbit_year == years(kk) & ...
                           all_orbit_day >= minday & all_orbit_day <= 366;

         sel_orbit_year = all_orbit_year(sel_orbit_index);
         sel_orbit_day = all_orbit_day(sel_orbit_index);
         sel_orbit_num = all_orbit_num(sel_orbit_index);

      elseif k<nyears & k~=0,
      
         sel_orbit_index = all_orbit_year == years(kk) & ...
                           all_orbit_day >= 0 & all_orbit_day <= 366;

	     sel_orbit_year = cat(1,sel_orbit_year,all_orbit_year(sel_orbit_index));
         sel_orbit_day = cat(1,sel_orbit_day,all_orbit_day(sel_orbit_index));
         sel_orbit_num = cat(1,sel_orbit_num,all_orbit_num(sel_orbit_index));
	 
      elseif k==0,
      
         sel_orbit_index = all_orbit_year == years(kk) & ...
                           all_orbit_day >= 0 & all_orbit_day <= maxday;

         sel_orbit_year = cat(1,sel_orbit_year,all_orbit_year(sel_orbit_index));
         sel_orbit_day = cat(1,sel_orbit_day,all_orbit_day(sel_orbit_index));
         sel_orbit_num = cat(1,sel_orbit_num,all_orbit_num(sel_orbit_index));
          
	     break
	 
      end
      
      k=k-1;
      
   end
end

return
