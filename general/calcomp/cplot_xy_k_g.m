function cplot_xy_r_b_stt(x,ya,yc,out_file)

% Set up paths, adjust for your machine
%

func_path = '/Volumes/matlab/calcomp/cplot_xy_k_g.f'; 

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
func_tmp_path = [work_path,'tmp_xy.f'];
func_edit_path = [work_path,'cplot_xy_r_b_strm.f'];
orig_path=pwd;

%
% Set filenames and such
%

x_in = [work_path,'x_in.txt'];
ya_in = [work_path,'ya_in.txt'];
yc_in = [work_path,'yc_in.txt'];



%
% Change NaNs to 1e35
%

ya=double(fillnans(ya));

yc=double(fillnans(yc));

%
% Write data as ascii
%

eval(['save -ascii ' x_in ' x'])
eval(['save -ascii ' ya_in ' ya'])
eval(['save -ascii ' yc_in ' yc'])

%
% Now copy FORTRAN routing, edit and compile and execute filtering
%

eval(['!cp ' func_path  ' ' func_tmp_path]);
cd(work_path)	
!f90 tmp_xy.f /usr/local/dplot/dplot.a /usr/local/calcomp/calcomp.a /usr/local/complot/complot.a
!./a.out
!open 001.ps
%eval(['!cp 001.ps ', out_file, '.ps'])
cd(orig_path)
%eval(['!rm -R ',work_path])