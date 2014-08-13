function cplot_yy_r_b(ya,yc,yya,yyc,ymin,ymax,ytic,yymin,yymax,yytic,yyndec,ylab,yylab,out_file)


func_path = '/Volumes/matlab/calcomp/cplot_yy_r_b.f'; 
start_work_path = '/Volumes/matlab/calcomp/work/';

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

ya_in = [work_path,'ya_in.txt'];
yc_in = [work_path,'yc_in.txt'];
yya_in = [work_path,'yya_in.txt'];
yyc_in = [work_path,'yyc_in.txt'];



%
% Change NaNs to 1e35
%

ya=double(ya);
fl=find(isnan(ya));
ya(fl)=1e35;

yc=double(yc);
fl=find(isnan(yc));
yc(fl)=1e35;

yya=double(yya);
fl=find(isnan(yya));
yya(fl)=1e35;

yyc=double(yyc);
fl=find(isnan(yyc));
yyc(fl)=1e35;

%
% Write data as ascii
%

eval(['save -ascii ' ya_in ' ya'])
eval(['save -ascii ' yc_in ' yc'])
eval(['save -ascii ' yya_in ' yya'])
eval(['save -ascii ' yyc_in ' yyc'])

%
% Now copy FORTRAN routing, edit and compile and execute filtering
%

eval(['!cp ' func_path  ' ' func_tmp_path]);
cd(work_path)	

eval(['!sed ' char(39) 's/call number(xin+.1,yyy,.1,y,0.,3)/call number(xin+.1,yyy,.1,y,0.,', num2str(yyndec)...
		')/' char(39) ' ' func_tmp_path ' > tmp1.f']);
eval(['!sed ' char(39) 's/parameter (ymin = -.6, ymax = .6, ytic = .1)/parameter (ymin = ',...
		num2str(ymin), ', ymax = ', num2str(ymax), ', ytic = ', num2str(ytic), ')/' char(39) ' tmp1.f > tmp2.f']);
eval(['!sed ' char(39) 's/parameter (yymin = -.01, yymax = .01, yytic = .1)/parameter (yymin = ',...
		num2str(yymin), ', yymax = ', num2str(yymax), ', yytic = ', num2str(yytic), ')/' char(39) ' tmp2.f > tmp.f']);
eval(['!sed ' char(39) 's/call symbol(-1.2,(yin/2)-.05,.1,' char(39) 'deg c' char(39) ...
	',0.,5)/call symbol(-1.2,(yin/2)-.05,.1,' char(39) 'test' char(39) ',0.,5)/' char(39) ' tmp3.f > tmp.f']);
%eval(['!sed ' char(39) 's/call symbol(xin+.7,(yin/2)-.05,.1,' char(39) 'N m^-2' char(39) ...
%	',0.,6)/call symbol(xin+.7,(yin/2)-.05,.1,' char(39) yylab char(39) ',0.,' num2str(length(yylab)) ')/' ...
%	 char(39) ' tmp4.f > tmp.f']);

!f90 tmp.f /usr/local/dplot/dplot.a /usr/local/calcomp/calcomp.a /usr/local/complot/complot.a
!./a.out
eval(['!cp 001.ps ', out_file, '.ps'])
cd(orig_path)
eval(['!open ', out_file, '.ps'])
eval(['!rm -R ',work_path])