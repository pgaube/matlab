function cplot_seasonal_cycle(data1,data2,data3,minc,maxc,tic,lab,title,out_file)

% Set up paths, adjust for your machine
%

func_path = '/matlab/calcomp/seasonal_cycle.f'; 

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
dat3_in = [work_path,'dat3_in.txt'];

data1=flipud(double(data1));
fl=find(isnan(data1));
data1(fl)=1e35;

data2=flipud(double(data2));
fl=find(isnan(data2));
data2(fl)=1e35;

data3=flipud(double(data3));
fl=find(isnan(data3));
data3(fl)=1e35;

%
% Write data as ascii
%

eval(['save -ascii ' dat1_in ' data1'])
eval(['save -ascii ' dat2_in ' data2'])
eval(['save -ascii ' dat3_in ' data3'])


%
% Now copy FORTRAN routing, edit and compile and execute filtering
%

eval(['!cp ' func_path  ' ' func_tmp_path]);
cd(work_path)
eval(['!sed ' char(39) 's/ymin=20/ymin=' num2str(minc) '/' char(39) ' ' func_tmp_path ' > tmp11.f'])
eval(['!sed ' char(39) 's/ymax=80/ymax=' num2str(maxc) '/' char(39) ' tmp11.f > tmp22.f'])
eval(['!sed ' char(39) 's/poc1/' num2str(minc) '/' char(39) ' tmp22.f > tmp33.f'])
eval(['!sed ' char(39) 's/tic=40/tic=' num2str(tic) '/' char(39) ' tmp33.f > tmp44.f'])
eval(['!sed ' char(39) 's/poc2/' num2str(tic) '/' char(39) ' tmp44.f > tmp55.f'])
eval(['!sed ' char(39) 's/shit/' lab '/' char(39) ' tmp55.f > tmp66.f'])
eval(['!sed ' char(39) 's/title/' title '/' char(39) ' tmp66.f > tmp77.f'])
eval(['!sed ' char(39) 's/969/' num2str(length(title)) '/' char(39) ' tmp77.f > tmp88.f'])
eval(['!sed ' char(39) 's/666/' num2str(length(lab)) '/' char(39) ' tmp88.f > tmp99.f'])
eval(['!sed ' char(39) 's/poc3/' num2str(maxc) '/' char(39) ' tmp99.f > tmp01.f'])
eval(['!sed ' char(39) 's/404/' num2str(length(tic)+3) '/' char(39) ' tmp01.f > tmp02.f'])
eval(['!sed ' char(39) 's/505/' num2str(length(maxc)+3) '/' char(39) ' tmp02.f > tmp03.f'])
eval(['!sed ' char(39) 's/303/' num2str(length(minc)+3) '/' char(39) ' tmp03.f > tmp.f'])
!f90 tmp.f $dplot $calcomp $complot
!./a.out
eval(['!cp 001.ps ', out_file, '.eps'])
cd(orig_path)
%eval(['!open ', out_file, '.eps'])
eval(['!rm -R ',work_path])