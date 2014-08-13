function grid_qscat_region(minyear,maxyear,minday,maxday,beg_head)

global QSCAT_ORBIT_FILE_DIR	  
global GRID_SWATH_DATA_OUTPUT_DIR
global SSMI_ICE_FILE_DIR
global GRIDX GRIDY
global NX_GRID NY_GRID
global SSMI_SAT_IDENTIFIER
global SSMI_DATA_VERSION
global ICE_THRESHOLD
global SL
global SOS_ALL_THRESHOLD
global ICLASS_THRESHOLD
global IRAIN_SCAT_THRESHOLD
global RAD_RAIN_THRESHOLD
global MIN_DIFF_THRESHOLD
global ICE_GRIDX ICE_GRIDY
global MATLAB_VERSION
global RADIAL_SPAN
global ECHO_FP
global NPTS_SPAN_THRESHOLD NPTS_HALFSPAN_THRESHOLD
global NPTS_NORTH NPTS_SOUTH NPTS_EAST NPTS_WEST
global MAX_WSPD MAX_STRM
global DX_OVERLAP
global ICLASS_INT_THRESHOLD
global QSCAT_GCM_DIR_DIFF_THRESHOLD
global BEG_HEAD
global ICLASS

set_grid_qscat_params

echo_fp = ECHO_FP;
if isempty(BEG_HEAD),
  BEG_HEAD = '';
end

minlon = GRIDX(1);
maxlon = GRIDX(end);
minlat = GRIDY(1);
maxlat = GRIDY(end);

%----------------------------------------------------------------------
% Print all the global parameter settings to the screen
%----------------------------------------------------------------------

fprintf(echo_fp,'\n-------------------------------------------------------\n')
fprintf(echo_fp,'\n Parameter settings used by GRID_QSCAT_REGION.M: \n')
fprintf(echo_fp,'\n  Directory information: ')
fprintf(echo_fp,'\n   QSCAT_ORBIT_FILE_DIR       = %s ',QSCAT_ORBIT_FILE_DIR)
fprintf(echo_fp,'\n   GRID_SWATH_DATA_OUTPUT_DIR = %s ',GRID_SWATH_DATA_OUTPUT_DIR)
if ~isempty(SSMI_ICE_FILE_DIR),
fprintf(echo_fp,'\n   SSMI_ICE_FILE_DIR          = %s ',SSMI_ICE_FILE_DIR)
else,
fprintf(echo_fp,'\n   SSMI_ICE_FILE_DIR          = %s ','none specified')
end
fprintf(echo_fp,'\n  Grid information: ')
fprintf(echo_fp,'\n   GRIDX(min) = %6.3f ',minlon)
fprintf(echo_fp,'\n   GRIDX(max) = %6.3f ',maxlon)
fprintf(echo_fp,'\n   GRIDY(min) = %6.3f ',minlat)
fprintf(echo_fp,'\n   GRIDY(max) = %6.3f ',maxlat)
fprintf(echo_fp,'\n   NX_GRID    = %u ',NX_GRID)
fprintf(echo_fp,'\n   NY_GRID    = %u ',NY_GRID)
fprintf(echo_fp,'\n   ICE_GRIDX(min) = %6.3f ',ICE_GRIDX(1))
fprintf(echo_fp,'\n   ICE_GRIDX(max) = %6.3f ',ICE_GRIDX(end))
fprintf(echo_fp,'\n   ICE_GRIDY(min) = %6.3f ',ICE_GRIDY(1))
fprintf(echo_fp,'\n   ICE_GRIDY(max) = %6.3f ',ICE_GRIDY(end))
fprintf(echo_fp,'\n   DX_OVERLAP     = %6.3f ',DX_OVERLAP)
fprintf(echo_fp,'\n  Processing information: ') 
fprintf(echo_fp,'\n   ICE_THRESHOLD           = %6.3f ',ICE_THRESHOLD)
fprintf(echo_fp,'\n   SOS_ALL_THRESHOLD       = %6.3f ',SOS_ALL_THRESHOLD)
fprintf(echo_fp,'\n   ICLASS_THRESHOLD        = %u '   ,ICLASS_THRESHOLD)
fprintf(echo_fp,'\n   IRAIN_SCAT_THRESHOLD    = %u '   ,IRAIN_SCAT_THRESHOLD)
fprintf(echo_fp,'\n   ICLASS_INT_THRESHOLD    = %6.3f ',ICLASS_INT_THRESHOLD)
fprintf(echo_fp,'\n   RAD_RAIN_THRESHOLD      = %6.3f ',RAD_RAIN_THRESHOLD)
fprintf(echo_fp,'\n   MIN_DIFF_THRESHOLD      = %u '   ,MIN_DIFF_THRESHOLD)
fprintf(echo_fp,'\n   RADIAL_SPAN (meters)    = %u '   ,RADIAL_SPAN)
fprintf(echo_fp,'\n   NPTS_SPAN_THRESHOLD     = %u '   ,NPTS_SPAN_THRESHOLD)
fprintf(echo_fp,'\n   NPTS_HALFSPAN_THRESHOLD = %u '   ,NPTS_HALFSPAN_THRESHOLD)
fprintf(echo_fp,'\n   NPTS_NORTH              = %u '   ,NPTS_NORTH)
fprintf(echo_fp,'\n   NPTS_SOUTH              = %u '   ,NPTS_SOUTH)
fprintf(echo_fp,'\n   NPTS_EAST               = %u '   ,NPTS_EAST)
fprintf(echo_fp,'\n   NPTS_WEST               = %u '   ,NPTS_WEST)
fprintf(echo_fp,'\n   MAX_WSPD                = %u '   ,MAX_WSPD)
fprintf(echo_fp,'\n   MAX_STRM                = %4.2f '   ,MAX_STRM)
if ~isempty(SSMI_ICE_FILE_DIR),
fprintf(echo_fp,'\n  SSMI Ice Field information: ')
fprintf(echo_fp,'\n   SSMI_SAT_IDENTIFIER  = %s ',SSMI_SAT_IDENTIFIER)
fprintf(echo_fp,'\n   SSMI_DATA_VERSION    = %s ',SSMI_DATA_VERSION)
end
fprintf(echo_fp,'\n  Platform-dependent information: ')
fprintf(echo_fp,'\n   SL = ''%s'' ',SL)
fprintf(echo_fp,'\n   MATLAB_VERSION = %6.3f ',MATLAB_VERSION)
fprintf(echo_fp,'\n-------------------------------------------------------\n')

%----------------------------------------------------------------------
% Get orbit information for the selected time period
%----------------------------------------------------------------------

[sel_orbit_num, sel_orbit_year, sel_orbit_day] = ...
                sel_qscat_orbit(minyear, maxyear, minday, maxday);

%+lwa needed to get ice fields at monthly intervals
sel_orbit_datevec = datenum(sel_orbit_year,1,sel_orbit_day);
date_vector = datevec(sel_orbit_datevec);
sel_orbit_mon = date_vector(:,2);
%-lwa

N = length(sel_orbit_num);

num_not_loaded = 0;

fprintf('\n')

%----------------------------------------------------------------------
% Initialize output matrices
%----------------------------------------------------------------------

[ grid_wspd, grid_dwspddx, grid_dwspddy, ...
  grid_strm, grid_dstrmdx, grid_dstrmdy, ...
  grid_u, grid_dudx, grid_dudy, ...
  grid_v, grid_dvdx, grid_dvdy, ...
  grid_ustr, grid_dustrdx, grid_dustrdy, ...
  grid_vstr, grid_dvstrdx, grid_dvstrdy ] = deal([]);

%----------------------------------------------------------------------
% Start looping over all the orbits within the specified time period
%----------------------------------------------------------------------

saved_icefile = [];

for i=1:N

   fprintf('\r|  Orbit# %05u of %05u | \r',sel_orbit_num(i),sel_orbit_num(N))
   %progress_bar(i,N)

   %----------------------------------------------------------------------
   % Find out which orbit subdirectory data is needed from
   %----------------------------------------------------------------------

   tmpndir = int(sel_orbit_num(i)/1000)*1000;
   
   orbit_sub_dir = [num2str(tmpndir,'%05u'),'to', ...
                    num2str(tmpndir+999,'%05u'),SL];
   
   %----------------------------------------------------------------------
   % Load the orbit data
   %----------------------------------------------------------------------

   datafileg = [QSCAT_ORBIT_FILE_DIR,'winvec_', ...
				    num2str(sel_orbit_num(i),'%05u'),'_v03.gz'];
   datafile = [QSCAT_ORBIT_FILE_DIR,'winvec_', ...
				   num2str(sel_orbit_num(i),'%05u'),'_v03'];

if exist(datafileg)~0;
eval(['gunzip ' datafileg]);
end   ;
   
   data = get_qscat_orbit_v03(datafile);
   
   %----------------------------------------------------------------------
   % Check to see that data was properly loaded
   %----------------------------------------------------------------------
  
   if ~isstruct(data),        
   
      warnstring = ['Orbit file: ',datafile,' missing or did not load properly.'];
      
      warning(warnstring)     
   
      num_not_loaded = num_not_loaded+1;
      
   else,
            
      %--------------------------------------------------------------------
      % Convert single precision lat/lon of obs to double precision
      %--------------------------------------------------------------------
            
      orbit_lon = double(data.lon);
      orbit_lat = double(data.lat);

      %-------------------------------------------------------------------
      % Find out if orbit has data within the desired spatial bounds.
      %-------------------------------------------------------------------
      
      
      if any(orbit_lon(:) <= maxlon & orbit_lon(:) >= minlon) & ...
         any(orbit_lat(:) <= maxlat & orbit_lat(:) >= minlat),
	 
         %
         % Remove radiometer rain values that were recorded
         % after +/- MIN_DIFF_THRESHOLD of QSCAT observation time
         %
         
         orbit_rad_rain = double(data.rad_rain);
         orbit_rad_rain(abs(double(data.min_diff))>=MIN_DIFF_THRESHOLD) = 0;
         %orbit_rad_rain(orbit_rad_rain>25.39) = 0;
         orbit_rad_rain(isnan(orbit_rad_rain)) = 0;

         % Remove directional ambiguities from the swath data

         angle = double(data.dir_smooth - data.dir_gcm);
         i1 = find(angle > 180);
         i2 = find(angle < -180);
         angle(i1) = angle(i1) - 360;
         angle(i2) = angle(i2) + 360;

         wspd = double(data.wind_smooth);
         
         angle(wspd<1) = 0;

%	     good_quality_index = ...
%            (double(data.iclass) >= ICLASS_THRESHOLD & ...
%             permute(min(double(data.sos_all),[],1),[2 3 1])   ... 
%                                    <= SOS_ALL_THRESHOLD & ...
%             orbit_rad_rain          <= RAD_RAIN_THRESHOLD & ...
%             double(data.irain_scat) ~= IRAIN_SCAT_THRESHOLD) == 1;
	     good_quality_index = ...
             (permute(min(double(data.sos_all),[],1),[2 3 1])   ... 
                                                 <= SOS_ALL_THRESHOLD & ...
              orbit_rad_rain <= RAD_RAIN_THRESHOLD & ...
              double(data.irain_scat) ~= IRAIN_SCAT_THRESHOLD) == 1 & ...
              (abs(angle) < QSCAT_GCM_DIR_DIFF_THRESHOLD);
	 
         %keyboard

         % Keep the ICLASS variable to pass onto the loess routine
         
         ICLASS = double(data.iclass(good_quality_index));
         
         % Retain only good quality data

	     orbit_wspd = wspd(good_quality_index);
         orbit_wdir = deg2rad(90-double(data.dir_smooth(good_quality_index)));
         orbit_lon  = orbit_lon(good_quality_index);
         orbit_lat  = orbit_lat(good_quality_index);

         %-------------------------------------------------------------
         %+lwa 1/8/2008
	     % Interpolate ice onto the swath grid and then remove ice
	     % from the swath
         % 8/30/2008 added option to bypass ice removal by setting
         %           SSMI_ICE_FILE_DIR = []; in SET_GRID_QSCAT_PARAMS
         % 8/30/2008 combined ice removal with missing number removal and
         %           moved the stress computation step after this
	     
         if ~isempty(SSMI_ICE_FILE_DIR),

            icefile = [SSMI_ICE_FILE_DIR, ...
                       SSMI_SAT_IDENTIFIER,'_', ...
                       num2str(sel_orbit_year(i),'%4u'), ...
                       num2str(sel_orbit_mon(i),'%02u'), ...
                       SSMI_DATA_VERSION];
            
            if exist(icefile)==0,
               error(['GRID_QSCAT_REGION: This file does not exist: ',icefile])
            end

            if ~strcmp(icefile,saved_icefile),
               ssmi = rdssmi_averaged_v5(icefile,1,1);
               ssmi.ice(isnan(ssmi.ice)) = 0;
               ssmi.ice = [ssmi.ice(:,end-1:end) ssmi.ice ssmi.ice(:,1:2)];
            end   
   
            
            %%%%%%%%
            %%%%%%%%
            % uncomment to get rid of ice masking PG 1/13/2011
            ssmi.ice=zeros(size(ssmi.ice));
            %%%%%%%%
            %%%%%%%%
            
            saved_icefile = icefile;
            
            ICE = interp2([ICE_GRIDX(end-1:end)-360 ICE_GRIDX ICE_GRIDX(1:2)+360], ...
                           ICE_GRIDY,ssmi.ice, ...
                          orbit_lon,orbit_lat,'linear');

	        not_ice = (ICE + isnan(orbit_lon+orbit_lat+orbit_wspd+orbit_wdir+ICLASS) ...
                      <= ICE_THRESHOLD);
                  %~isnan(orbit_lon+orbit_lat+orbit_wspd+orbit_wdir+ICLASS);

            orbit_wspd = orbit_wspd(not_ice); 
            orbit_wdir = orbit_wdir(not_ice);
            orbit_lon  = orbit_lon(not_ice); 
            orbit_lat  = orbit_lat(not_ice);
            ICLASS     = ICLASS(not_ice);

         end
%keyboard
         %-------------------------------------------------------------
	     % Compute the wind stress magnitude and components
	     %-------------------------------------------------------------

         ax = cos(orbit_wdir);
         ay = sin(orbit_wdir);

         orbit_u    = orbit_wspd.*ax;
         orbit_v    = orbit_wspd.*ay;

	     orbit_strm = wind2stress(orbit_wspd);

         orbit_ustr = orbit_strm.*ax;
         orbit_vstr = orbit_strm.*ay;

         %-------------------------------------------------------------
	     % Interpolate data onto grid, also calculating the appropriate
	     % derivatives.
	     %-------------------------------------------------------------

	 
         [ grid_wspd, grid_dwspddx, grid_dwspddy, ...
           grid_strm, grid_dstrmdx, grid_dstrmdy, ...
	       grid_u, grid_dudx, grid_dudy, ...
	       grid_v, grid_dvdx, grid_dvdy, ...
	       grid_ustr, grid_dustrdx, grid_dustrdy, ...
	       grid_vstr, grid_dvstrdx, grid_dvstrdy ] = ...
	                           int_qscat_swath( ...
                                    orbit_lon, ...
				                    orbit_lat, ...
				                    orbit_wspd, ...
				                    orbit_strm, ...
				                    orbit_u, ...
				                    orbit_v, ...
					                orbit_ustr, ...
					                orbit_vstr);
	       	 
      end
      
      %keyboard
      
      woutfile = [GRID_SWATH_DATA_OUTPUT_DIR,BEG_HEAD, ...
                  num2str(sel_orbit_num(i),'%05u')];
      
      write_grid_qscat_region(grid_wspd, grid_dwspddx, grid_dwspddy, ...
                              grid_strm, grid_dstrmdx, grid_dstrmdy, ...
	                          grid_u, grid_dudx, grid_dudy, ...
	                          grid_v, grid_dvdx, grid_dvdy, ...
	                          grid_ustr, grid_dustrdx, grid_dustrdy, ...
	                          grid_vstr, grid_dvstrdx, grid_dvstrdy, ...
		                      woutfile)     

   end

end

return

%--------------------------------------------------------------------------


if 0,

%+lwa 1/30/08 found a cleaner way to do this...             
   if 0,
   if tmpndir >= 10000,   
      orbit_sub_dir = [num2str(tmpndir),'to',num2str(tmpndir+999),SL];
   elseif tmpndir < 10000 & tmpndir >= 1000,   
      orbit_sub_dir = ['0',num2str(tmpndir),'to0',num2str(tmpndir+999),SL];      
   elseif tmpndir < 1000,
      %lwa 1/30/08 orbit_sub_dir = ['00',num2str(tmpndir),'to00',num2str(tmpndir+999),SL];
      orbit_sub_dir = ['00000to00999',SL];
   end
   end
   %-lwa

fp = fopen([QSCAT_ORBIT_FILE_DIR,'qscat_info.txt']);

a = fscanf(fp,'%56c');
all_orbit_info = reshape(a,56,length(a)/56)';
all_orbit_info = all_orbit_info(:,1:54);
fclose(fp);
clear a
all_orbit_year = str2num(all_orbit_info(:,15:18));
all_orbit_day = str2num(all_orbit_info(:,20:22));
all_orbit_num = str2num(all_orbit_info(:,1:6));

%+lwa 2/11/08
% error here with selecting all_orbit_day
sel_orbit_index = all_orbit_year >= minyear & all_orbit_year <= maxyear & ...
                  all_orbit_day >= minday & all_orbit_day <= maxday; 
%-lwa

sel_orbit_num = all_orbit_num(sel_orbit_index);

sel_orbit_day = all_orbit_day(sel_orbit_index);
sel_orbit_year = all_orbit_year(sel_orbit_index);




%+lwa 2/27/06 Change to more stringent conditions
%	 good_quality_index = data.irain_scat ~= 1 & ...
%                              data.iclass > 0 & ...
%                permute(min(double(data.sos_all),[],1),[2 3 1]) <= 3.5;
%-lwa	 

%if 0,| double(data.rad_rain) ~= 125.4)

            %permute(min(double(data.sos_all),[],1),[2 3 1])   ... 
            %                        <= SOS_ALL_THRESHOLD;
            %  orbit_rad_rain          <= RAD_RAIN_THRESHOLD   & ...
            %  double(data.irain_scat) ~= IRAIN_SCAT_THRESHOLD & ...            

        % %end

%keyboard

%+lwa 6/29/06 Boneheaded mistake
%         good_quality_index(11:65,:) = data.iclass(11:65,:) >= 2;
%+lwa 1/8/08 removed this
%         good_quality_index(11:65,:) = good_quality_index(11:65,:) & ...
%	                               data.iclass(11:65,:) >= 2;
%-lwa
%-lwa

end

