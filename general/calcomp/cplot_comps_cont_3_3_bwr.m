function cplot_comps_cont_3_3(data1,data2,minc,maxc,dz,mincc,maxcc,out_file)

% Set up paths, adjust for your machine
%

func_path = '/matlab/calcomp/comps_cont_3_3_bwr.f'; 

start_work_path = '/matlab/calcomp/work/';%Create this
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

dat1_in = [work_path,'dat1_in.txt'];
dat2_in = [work_path,'dat2_in.txt'];

[nx,ny]=size(data1);
tt=mincc:dz:maxcc;
nlev=length(tt);
%
% Change NaNs to 1e35
%

data1=flipud(double(data1));
fl=find(isnan(data1));
data1(fl)=1e35;

data2=flipud(double(data2));
fl=find(isnan(data2));
data2(fl)=1e35;

%
% Write data as ascii
%

eval(['save -ascii ' dat1_in ' data1'])
eval(['save -ascii ' dat2_in ' data2'])


%
% Now copy FORTRAN routing, edit and compile and execute filtering
%

eval(['!cp ' func_path  ' ' func_tmp_path]);
cd(work_path)
eval(['!sed ' char(39) 's/parameter ( ncols = 41, nrows = 41, rl = -.5, rh = .5)/parameter ( ncols = '...
		,num2str(nx),', nrows = ', num2str(ny), ', rl = ', num2str(minc),', rh = ', num2str(maxc) ')/' char(39) ' ' func_tmp_path ' > tmp11.f']);


eval(['!sed ' char(39) 's/nlev = 1/nlev = ' num2str(nlev) '/' char(39) ' tmp11.f > tmp22.f']);
eval(['!sed ' char(39) 's/dz = 0.25/dz = ' num2str(dz) '/' char(39) ' tmp22.f > tmp33.f']);
eval(['!sed ' char(39) 's/parameter ( mincc=-5, maxcc=-5)/parameter ( mincc=' num2str(mincc) ', maxcc=' num2str(dz) ')/' char(39) ' tmp33.f > tmp.f']);

!f90 tmp.f $dplot $calcomp $complot
!./a.out
eval(['!cp 001.ps ', out_file, '.eps'])
cd(orig_path)
eval(['!open ', out_file, '.eps'])
eval(['!rm -R ',work_path])