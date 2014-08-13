function [smoothed_data] = loess2d(data,SPANX,SPANY,dx,dy)
%
%function [smoothed_data] = smooth2d_f(DATA,SPANX,SPANY,dx,dy)
%
% Uses MATLAB to send data to the FORTRAN90 loess2d.f filter routine
% Must use loess2d.f supplied by Peter Gaube, or else it might not
% compile correctly
% Tested on ABSOFT FORTRAN90, and be adapted to other compliers
% Edit line starting with the following command bellow
%    '!f90 -O -w -o'
% to match your complier (i.e gnuf90, etc....)
%
% Data must be 1D or 2D, use in for loop if 3D
%
%
% INPUTS
%       DATA =  what ever you want to filter, will be converted into
%               column vector and treated at 1D or 2D.  The x and y 
%               grid are then calculated from the input data.
%
%      SPANX =  Zonal span of the filter, in the same units as the
%               grid that DATA is on.
%
%      SPANY =  Meridional span of the filter, in the same units as
%               the grid that DATA is on
%
% OUTPUS
%      SMOOTHED_DATA
%



% Set up paths, adjust for your machine
%

func_path = '/Volumes/matlab/fortran/smoothers/loess2d_fill.f'; %where you
                                                           %keep
                                                           %loess2d.f

start_work_path = '/Volumes/matlab/fortran/smoothers/work/';%Create this
                                                            %directory to
                                                            %work in,
                                                            %will be
                                                            %cleared at
                                                            %the end of
                                                            %each filter
                                                            %cycle

%
% The next few lines create a tmp directory to copy data and compile code
% in.  This allows you to run multiple filters at once
%

tt=clock;
td=[num2str(tt(4)),'_',num2str(tt(5)),'_',num2str(tt(6))];
mkdir(start_work_path,td);
work_path = [start_work_path,td,'/'];
func_tmp_path = [work_path,'tmp_loess2d.f'];
func_edit_path = [work_path,'loess2d.f'];
orig_path=pwd;

%
% Set filenames and such
%

dat_in = [work_path,'dat_in.txt'];
[M,N,P] = size(data);
data=double(data(:));

%
% Change NaNs to 1e35
%

fl=find(isnan(data));
data(fl)=1e35;

%
% Write data as ascii
%

eval(['save ' dat_in ' data -ascii -double'])

%
% Now copy FORTRAN routing, edit and compile and execute filtering
%

eval(['!cp ' func_path  ' ' func_tmp_path]);
cd(work_path)

eval(['!sed ' char(39) 's/parameter (maxx=117,maxy=241)/parameter ( maxx = '...
	   num2str(M) ', maxy = ' num2str(N) ' )/' char(39) ' ' func_tmp_path ' > tmp.f']);

if rem(SPANX,round(SPANX))==0
eval(['!sed ' char(39) 's/span_x = 10.0/span_y = ' num2str(SPANX) ...
	  '. /' char(39) ' tmp.f > tmp2.f']);
else
eval(['!sed ' char(39) 's/span_x = 10.0/span_y = ' num2str(SPANX) ...
          ' /' char(39) ' tmp.f > tmp2.f']);
end
	 
if rem(SPANY,round(SPANY))==0
eval(['!sed ' char(39) 's/span_y = 10.0/span_x = ' num2str(SPANY) ...
          '. /' char(39) ' tmp2.f > tmp3.f']);
else
eval(['!sed ' char(39) 's/span_y = 10.0/span_x = ' num2str(SPANY) ...
          ' /' char(39) ' tmp2.f > tmp3.f']);
end

if rem(dx,round(dx))==0
eval(['!sed ' char(39) 's/dx_grid = 0.25/dx_grid = ' num2str(dx) ...
	  '. /' char(39) ' tmp3.f > tmp4.f']);	 
else
eval(['!sed ' char(39) 's/dx_grid = 0.25/dx_grid = ' num2str(dx) ...
          ' /' char(39) ' tmp3.f > tmp4.f']);
end

if rem(dy,round(dy))==0
eval(['!sed ' char(39) 's/dy_grid = 0.25/dy_grid = ' num2str(dy) ...
          '. /' char(39) ' tmp4.f > ' func_edit_path]);
else
eval(['!sed ' char(39) 's/dy_grid = 0.25/dy_grid = ' num2str(dy) ...
          ' /' char(39) ' tmp4.f > ' func_edit_path]);
end


!f90 -O -w -o tmp_loess2d loess2d.f
!./tmp_loess2d < dat_in.txt > dat_out.txt

%
% Now load filtered data back into MATLAB and reshape
%

load dat_out.txt
fl=find(dat_out>=1e35);
dat_out(fl)=nan;

smoothed_data=reshape(dat_out,M,N);


%
% Go back to where you came from and clean up
%

cd(start_work_path)
eval(['!rm -R ',work_path])
cd(orig_path)






