function cplot_comps(data,minc,maxc,out_file)

% Set up paths, adjust for your machine
%

func_path = '/Volumes/matlab/calcomp/comps_chelle.f'; 

start_work_path = '/Volumes/matlab/calcomp/work/';%Create this
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
func_tmp_path = [work_path,'tmp_comps.f'];
func_edit_path = [work_path,'comps.f'];
orig_path=pwd;

%
% Set filenames and such
%

dat_in = [work_path,'dat_in.txt'];


%
% Change NaNs to 1e35
%
[nx,ny]=size(data);
data=flipud(double(data));
fl=find(isnan(data));
data(fl)=1e35;

%
% Write data as ascii
%

eval(['save -ascii ' dat_in ' data'])

%
% Now copy FORTRAN routing, edit and compile and execute filtering
%

eval(['!cp ' func_path  ' ' func_tmp_path]);
cd(work_path)
eval(['!sed ' char(39) 's/parameter (ncols = 41, nrows = 41, rl = -.5, rh = .5)/parameter ( ncols = '...
		,num2str(nx),', nrows = ', num2str(ny), ', rl = ', num2str(minc),', rh = ', num2str(maxc) ' )/' char(39) ' ' func_tmp_path ' > tmp.f']);
		

!f90 tmp.f /usr/local/calcomp/calcomp.a /usr/local/complot/complot.a
!./a.out
eval(['!cp 001.ps ', out_file, '.ps'])
cd(orig_path)
%eval(['!open ', out_file, '.ps'])
eval(['!rm -R ',work_path])