function []=colaction(action)
% function []=colaction(action)
%
% perform actions for COLEDIT
%
% action	'loadmap'	- load colormap
%        	'loadjet'	- load colormap jet
%		'update'	- update new colormap
%		'initialize'	- initialize plots
%		'writecheck'	- check if colormap-mfile already exists
%		'writefile'	- write a colormap-mfile (internal usage)
%		'readfile'	- read a colormap-mfile
%		'checkmaps'	- look for existing maps
%		'importmap'	- import a RGB array
%		'getmouse_r'	- get mouse input for red
%		'getmouse_g'	- get mouse input for green
%		'getmouse_b'	- get mouse input for blue
%		'evalmouse'	- evaluate mouse input (internal usage)
%		'applymouse'	- apply mouse input (internal usage)
%		'help'		- display help
%
% version 1.0		last change 03.03.1998

% G.Krahmann  Paris  Jan 1998
% Modified for MS_Windows operating system (Matlab 5.x only)
% Iram Weinstein Washington DC Feb 1999

% set global variables
global mh ph ih ColEditR ColEditG ColEditB ColEditAx ColMap CL Deb
global MousePos ActiveCol PtAct WriteColName ColEditVersion ReadColName ExMaps
global Intvers

home = [matlabroot,'\colmaps'];
if strcmp(action,'loadjet')		% load colormap JET
   ColEditR = [      0   0;...
         0.375   0;...
         0.625   1;...
         0.875   1;...
         1 0.5];
   ColEditG = [      0 0;...
         0.125 0;...
         0.375 1;...
         0.625 1;...
         0.875 0;...
         1 0];
   ColEditB = [      0 0.5;...
         0.125   1;...
         0.375   1;...
         0.625   0;...
         1   0];
   ActiveCol = 'rgb';
   colcontrols('update');
   
elseif strcmp(action,'initialize')	% initialize RGB plots and colormap plot
   % Red
   axes(ColEditAx(1))
   ph(1) = plot(ColEditR(:,1),ColEditR(:,2),'r-');
   hold on
   ph(2) = plot(ColEditR(:,1),ColEditR(:,2),'r.','markersize',15);
   set(gca,'xtick',[0,0.25,0.5,0.75,1],'xgrid','on',...
      'ylim',[0,1],...
      'buttondownfcn','colcontrols(''getmouse_r'');');
   hold off
   
   % Green
   axes(ColEditAx(2))
   ph(3) = plot(ColEditG(:,1),ColEditG(:,2),'g-');
   hold on
   ph(4) = plot(ColEditG(:,1),ColEditG(:,2),'g.','markersize',15);
   set(gca,'xtick',[0,0.25,0.5,0.75,1],'xgrid','on',...
      'ylim',[0,1],...
      'buttondownfcn','colcontrols(''getmouse_g'');');
   hold off
   
   % Blue
   axes(ColEditAx(3))
   ph(5) = plot(ColEditB(:,1),ColEditB(:,2),'b-');
   hold on
   ph(6) = plot(ColEditB(:,1),ColEditB(:,2),'b.','markersize',15);
   set(gca,'xtick',[0,0.25,0.5,0.75,1],'xgrid','on',...
      'ylim',[0,1],...
      'buttondownfcn','colcontrols(''getmouse_b'');');
   hold off
   
   % colormap
   axes(ColEditAx(4));
   dummy = linspace(0,1,CL)'*ones(1,2);
   pcolor(dummy(:,1),[0,1],dummy');
   shading flat
   set(gca,'xtick',[0,0.25,0.5,0.75,1],'ytick',[],...
      'tickdir','out','xlim',[0,1],'ylim',[0,1])
   
elseif strcmp(action,'loadmap')		% load a colormap
   if get(mh(9),'value')==1
      colcontrols('loadjet');
   else
      ReadColName = deblank(ExMaps(get(mh(9),'value'),:));
      colcontrols('readfile');  
   end  
   
elseif strcmp(action,'update')		% update colormap and colormap-points
   if ~isempty(findstr(ActiveCol,'r'))
      set(ph(1),'xdata',ColEditR(:,1),'ydata',ColEditR(:,2));
      set(ph(2),'xdata',ColEditR(:,1),'ydata',ColEditR(:,2));
      set(ColEditAx(1),'buttondownfcn','colcontrols(''getmouse_r'');');
   end
   if ~isempty(findstr(ActiveCol,'g'))
      set(ph(3),'xdata',ColEditG(:,1),'ydata',ColEditG(:,2));
      set(ph(4),'xdata',ColEditG(:,1),'ydata',ColEditG(:,2));
      set(ColEditAx(2),'buttondownfcn','colcontrols(''getmouse_g'');');
   end
   if ~isempty(findstr(ActiveCol,'b'))
      set(ph(5),'xdata',ColEditB(:,1),'ydata',ColEditB(:,2));
      set(ph(6),'xdata',ColEditB(:,1),'ydata',ColEditB(:,2));
      set(ColEditAx(3),'buttondownfcn','colcontrols(''getmouse_b'');');
   end
   r = interp1(ColEditR(:,1),ColEditR(:,2),linspace(0,1,CL),'linear');
   g = interp1(ColEditG(:,1),ColEditG(:,2),linspace(0,1,CL),'linear');
   b = interp1(ColEditB(:,1),ColEditB(:,2),linspace(0,1,CL),'linear');
   ColMap = [r(:),g(:),b(:)];
   colormap(ColMap);
   
elseif strcmp(action,'writecheck')		% check for existing file
   WriteColName = get(mh(6),'string'); 
   fullname = [WriteColName,'.m'];
   if exist([home,'\',fullname])==2
      ih(1) = uicontrol('style','frame','position',[120 145 360 105],...
         'backgroundcolor',[0.6,0.6,0.6]);
      ih(2) = uicontrol('style','text','position',[125 225 350 20],...
         'string',['colormap m-file'],...
         'horizontalalignment','center');
      ih(3) = uicontrol('style','text','position',[125 200 350 20],...
         'string',[home,'\',fullname],...
         'horizontalalignment','center');
      ih(4) = uicontrol('style','text','position',[125 175 350 20],...
         'string',[' already exists'],...
         'horizontalalignment','center');
      ih(5) = uicontrol('style','push','position',[200 150  70 20],...
         'string','overwrite',...
         'callback','colcontrols(''writefile'');delete(ih);');
      ih(6) = uicontrol('style','push','position',[330 150  70 20],...
         'string','quit writing','interruptible','off',...
         'callback','global ih;delete(ih);clear global ih;');
   else
      colcontrols('writefile');
   end
   
elseif strcmp(action,'writefile')		% write a colormap m-file
   
   fullname = [WriteColName,'.m'];
   fid = fopen([home,'\',fullname],'wt');
   fprintf( fid, '%s\n',['function [cmap] = ',WriteColName,'(maplength);']);
   fprintf( fid, '%s\n',['% ColEdit function [cmap] = ',WriteColName,...
         '(maplength);']);
   fprintf( fid, '%s\n',['%']);
   fprintf( fid, '%s\n',['% colormap m-file written by ColEdit']);
   fprintf( fid, '%s\n',['% version ',ColEditVersion,' on ',date]);
   fprintf( fid, '%s\n',['%']);
   fprintf( fid, '%s\n',['% input  :	[maplength]	[64]	- colormap',...
         ' length']);
   fprintf( fid, '%s\n',['%']);
   fprintf( fid, '%s\n',['% output :	cmap			- colormap',...
         ' RGB-value array']);
   fprintf( fid, '%s\n',[' ']);
   fprintf( fid, '%s\n',['% set red points']);
   fprintf( fid, '%s\n',['r = [ [];...']);
   for n=1:size(ColEditR,1)
      fprintf( fid, '%s\n',['    [',num2str(ColEditR(n,1)),' ',...
            num2str(ColEditR(n,2)),'];...']);
   end
   fprintf( fid, '%s\n',['    [] ];']);
   fprintf( fid, '%s\n',[' ']);
   fprintf( fid, '%s\n',['% set green points']);
   fprintf( fid, '%s\n',['g = [ [];...']);
   for n=1:size(ColEditG,1)
      fprintf( fid, '%s\n',['    [',num2str(ColEditG(n,1)),' ',...
            num2str(ColEditG(n,2)),'];...']);
   end
   fprintf( fid, '%s\n',['    [] ];']);
   fprintf( fid, '%s\n',[' ']);
   fprintf( fid, '%s\n',['% set blue points']);
   fprintf( fid, '%s\n',['b = [ [];...']);
   for n=1:size(ColEditB,1)
      fprintf( fid, '%s\n',['    [',num2str(ColEditB(n,1)),' ',...
            num2str(ColEditB(n,2)),'];...']);
   end
   fprintf( fid, '%s\n',['    [] ];']);
   fprintf( fid, '%s\n',['% ColEditInfoEnd']);
   fprintf( fid, '%s\n',[' ']);
   fprintf( fid, '%s\n',['% get colormap length']);
   fprintf( fid, '%s\n',['if nargin==1 ']);
   fprintf( fid, '%s\n',['  if length(maplength)==1']);
   fprintf( fid, '%s\n',['    if maplength<1']);
   fprintf( fid, '%s\n',['      maplength = 64;']);
   fprintf( fid, '%s\n',['    elseif maplength>256']);
   fprintf( fid, '%s\n',['      maplength = 256;']);
   fprintf( fid, '%s\n',['    elseif isinf(maplength)']);
   fprintf( fid, '%s\n',['      maplength = 64;']);
   fprintf( fid, '%s\n',['    elseif isnan(maplength)']);
   fprintf( fid, '%s\n',['      maplength = 64;']);
   fprintf( fid, '%s\n',['    end']);
   fprintf( fid, '%s\n',['  end']);
   fprintf( fid, '%s\n',['else']);
   fprintf( fid, '%s\n',['  maplength = 64;']);
   fprintf( fid, '%s\n',['end']);
   fprintf( fid, '%s\n',[' ']);
   fprintf( fid, '%s\n',['% interpolate colormap']);
   fprintf( fid, '%s\n',['np = linspace(0,1,maplength);']);
   fprintf( fid, '%s\n',['rr = interp1(r(:,1),r(:,2),np,''linear'');']);
   fprintf( fid, '%s\n',['gg = interp1(g(:,1),g(:,2),np,''linear'');']);
   fprintf( fid, '%s\n',['bb = interp1(b(:,1),b(:,2),np,''linear'');']);
   fprintf( fid, '%s\n',[' ']);
   fprintf( fid, '%s\n',['% compose colormap']);
   fprintf( fid, '%s\n',['cmap = [rr(:),gg(:),bb(:)];']);
   fclose(fid);
   
elseif strcmp(action,'readfile')		% read a colormap m-file 
   fullname = [home,'\',ReadColName,'.m'];
   if exist(fullname)~=2
      disp(['Colormap file ',fullname,' does not exist !'])
      return
   end
   fid = fopen(fullname,'rt');
   cont = 1;
   getcol = '';
   ColEditR = [];
   ColEditG = [];
   ColEditB = [];
   while cont==1
      li = fgetl(fid);
      if ~isempty(findstr(li,'set red points'))
         getcol = 'r';
      elseif ~isempty(findstr(li,'set green points'))
         getcol = 'g';
      elseif ~isempty(findstr(li,'set blue points'))
         getcol = 'b';
      elseif ~isempty(findstr(li,'ColEditInfoEnd'))
         colcontrols('update');
         cont = 0;
         break
      end
      if findstr(li,'    [')
         if strcmp(getcol,'r')
            ColEditR = [ColEditR; sscanf(li(6:length(li)),'%f')']; 
         elseif strcmp(getcol,'g')
            ColEditG = [ColEditG; sscanf(li(6:length(li)),'%f')']; 
         elseif strcmp(getcol,'b')
            ColEditB = [ColEditB; sscanf(li(6:length(li)),'%f')']; 
         end
      end
   end
   fclose(fid);
   ActiveCol = 'rgb';
   colcontrols('update');
   
elseif strcmp(action,'checkmaps')		% look for existing maps
   ExMaps = 'def-jet';
   if ~exist([home,'\dummyfile.m'])
      disp(' ')
      disp(['ColEdit: making directory ',home,' to save colormaps'])
      disp(' ')
      mkdir(matlabroot,'colmaps')
      dummy = 1;
      eval(['save ',home,'\dummyfile.m dummy -ascii'])
   end
   mf = dir(home);
   for k=1:size(mf,1),
      t1=mf(k).name;
      if length(t1)>2,
         if t1(end-1:end)=='.m',
            t1=t1(1:end-2);
            if ~isempty(t1) & ~strcmp(t1,'dummyfile') & ~strcmp(t1,'coledit') &...
                  ~strcmp(t1,'colcontrols')
               ExMaps = str2mat(ExMaps,t1);
            end
         end
      end
   end
   
elseif strcmp(action,'importmap')		% import a RGB array
   fullname = get(mh(11),'string');
   eval(['load ',fullname ' -ascii'])
   fullname = strtok(fullname,'.');
   eval(['ColEditR = ',fullname,'(:,1);'])
   eval(['ColEditG = ',fullname,'(:,2);'])
   eval(['ColEditB = ',fullname,'(:,3);'])
   ColEditR = [ linspace(0,1,length(ColEditR))' ColEditR];
   ColEditG = [ linspace(0,1,length(ColEditG))' ColEditG];
   ColEditB = [ linspace(0,1,length(ColEditB))' ColEditB];
   ActiveCol = 'rgb';
   colcontrols('update');
   
elseif strcmp(action,'getmouse_r')		% get mouse input for red
   axes(ColEditAx(1));
   ActiveCol = 'r';
   colcontrols('evalmouse');
   if MousePos(1)>=0 & MousePos(1)<=1 & MousePos(2)>=0 & MousePos(2)<=1
      colcontrols('applymouse');
   end
   
elseif strcmp(action,'getmouse_g')		% get mouse input for green
   axes(ColEditAx(2));
   ActiveCol = 'g';
   colcontrols('evalmouse');
   if MousePos(1)>0 & MousePos(1)<1 & MousePos(2)>0 & MousePos(2)<1
      colcontrols('applymouse');
   end
   
elseif strcmp(action,'getmouse_b')		% get mouse input for blue
   axes(ColEditAx(3));
   ActiveCol = 'b';
   colcontrols('evalmouse');
   if MousePos(1)>0 & MousePos(1)<1 & MousePos(2)>0 & MousePos(2)<1
      colcontrols('applymouse');
   end
   
elseif strcmp(action,'evalmouse')		% evaluate mouse input
   % taken from ginput.m
   ll = size(ColMap,1);
   norm_rect = get(gca,'Position');
   scrn_pt = get(0, 'PointerLocation');
   set(gcf,'units','pixels');
   loc = get(gcf, 'Position');
   set(gcf,'units','normalized');
   pt = [scrn_pt(1) - loc(1), scrn_pt(2) - loc(2)];
   ax_rect = [fix(norm_rect(1)*loc(3)),fix(norm_rect(2)*loc(4)),...
         fix(norm_rect(3)*loc(3)),fix(norm_rect(4)*loc(4))];
   pt(1) = (pt(1) - ax_rect(1))/ax_rect(3);
   pt(2) = (pt(2) - ax_rect(2))/ax_rect(4);
   MousePos = pt;
   if Deb == 1
      disp(['active color : ',ActiveCol])
      disp(MousePos)
      disp(' ')
   end
   
elseif strcmp(action,'applymouse')		% apply mouse input
   if strcmp(ActiveCol,'r')
      colpts = ColEditR; 
   elseif strcmp(ActiveCol,'g')
      colpts = ColEditG; 
   elseif strcmp(ActiveCol,'b')
      colpts = ColEditB; 
   else
      disp('COLCONTROL ERROR: can not evaluate ActiveCol')
   end
   x = MousePos(1);
   y = MousePos(2);
   if PtAct == 1 
      colpts = [colpts;[x,y]];
      [dummy,ind] = sort(colpts(:,1));
      colpts = colpts(ind,:);
   elseif PtAct ==2
      savepts = colpts([1,size(colpts,1)],:);
      colpts = colpts(2:size(colpts,1)-1,:);
      if ~isempty(colpts)
         distpt = (x-colpts(:,1)).^2/(0.23/0.55)^2 + (y-colpts(:,2)).^2;
         [dummy,ind] = min(distpt);
         colpts(ind,:) = [nan,nan];
         good = find(~isnan(colpts(:,1)));
         if ~isempty(colpts)
            colpts = colpts(good,:);
            colpts = [savepts(1,:);colpts;savepts(2,:)];
         else
            colpts = savepts;
         end
      else
         colpts = savepts;
      end
   elseif PtAct==3
      distpt = (x-colpts(:,1)).^2/(0.23/0.55)^2 + (y-colpts(:,2)).^2;
      [dummy,ind] = min(distpt);
      colpts(ind,2) = y;
   end
   if strcmp(ActiveCol,'r')
      ColEditR = colpts; 
   elseif strcmp(ActiveCol,'g')
      ColEditG = colpts; 
   elseif strcmp(ActiveCol,'b')
      ColEditB = colpts; 
   end
   colcontrols('update');
   
elseif strcmp(action,'help')		% display help window
   ih(1) = uicontrol('style','frame','position',[120 20 360 410],...
      'backgroundcolor',[0.6,0.6,0.6]);
   ih(2) = uicontrol('style','text','position',[125 405 350 20],...
      'string',['mouse-action:'],...
      'horizontalalignment','left');
   ih(3) = uicontrol('style','text','position',[135 385 340 20],...
      'string',['control activity after mouse-click on RGB-graphs'],...
      'horizontalalignment','left');
   ih(4) = uicontrol('style','text','position',[135 365 340 20],...
      'string',['change, remove or add a point'],...
      'horizontalalignment','left');
   ih(5) = uicontrol('style','text','position',[125 335 350 20],...
      'string',['import RGB-array:'],...
      'horizontalalignment','left');
   ih(6) = uicontrol('style','text','position',[135 315 340 20],...
      'string',['insert name of a ASCII-file containing RGB-values'],...
      'horizontalalignment','left');
   ih(7) = uicontrol('style','text','position',[135 295 340 20],...
      'string',['in 3 columns'],...
      'horizontalalignment','left');
   ih(8) = uicontrol('style','text','position',[125 265 350 20],...
      'string',['export m-file:'],...
      'horizontalalignment','left');
   ih(9) = uicontrol('style','text','position',[135 245 340 20],...
      'string',['export the current RGB-values into'],...
      'horizontalalignment','left');
   ih(10) = uicontrol('style','text','position',[135 225 340 20],...
      'string',['the given m-file'],...
      'horizontalalignment','left');
   ih(11) = uicontrol('style','text','position',[125 195 350 20],...
      'string',['import m-file:'],...
      'horizontalalignment','left');
   ih(12) = uicontrol('style','text','position',[135 175 340 20],...
      'string',['import previously saved m-file'],...
      'horizontalalignment','left');
   ih(13) = uicontrol('style','text','position',[135 155 340 20],...
      'string',['chose from the given list'],...
      'horizontalalignment','left');
   ih(14) = uicontrol('style','text','position',[125 125 350 20],...
      'string',['help:'],...
      'horizontalalignment','left');
   ih(15) = uicontrol('style','text','position',[135 105 340 20],...
      'string',['display this window'],...
      'horizontalalignment','left');
   ih(16) = uicontrol('style','text','position',[125 75 350 20],...
      'string',['close:'],...
      'horizontalalignment','left');
   ih(17) = uicontrol('style','text','position',[135 55 340 20],...
      'string',['quit COLORMAP EDITOR'],...
      'horizontalalignment','left');
   ih(18) = uicontrol('style','push','position',[250 25  100 20],...
      'string','close window',...
      'interruptible','no',...
      'callback','global ih;delete(ih);clear global ih;');
   
end
