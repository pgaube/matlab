% COLEDIT
%
% COLEDIT is an interactive editor to create colormaps
% COLEDIT writes colormap m-files which afterwards can be called in the
% usual way. Existing colormap m-files written by COLEDIT can be loaded
% as well as ASCII arrays of rgb-values.

% version 1.0		last change 18.03.1998

% G.Krahmann, Paris, Jan 1998
%
% please send any comments, bug-reports or suggestions to
% e-mail: krahmann@lodyc.jussieu.fr

% define global variables
global mh ph ih WriteColName ColEditR ColEditG ColEditB ColEditAx ColMap
global MousePos ActiveCol PtAct ColEditVersion ReadColName ExMaps CL Deb
global Intvers

% set coledit version number
ColEditVersion = '1.0';
ColEditDate = '1998/03/18';

% get Matlab version
vers=version;
Intvers=eval(vers(1));

% create main figure/display
figure
set(gcf,'position',[10,10,600,450],'numbertitle','off',...
	'menubar','none',...
	'name','COLORMAP EDITOR','pointer','crosshair')

% make a title page
if Intvers==4
  if exist('coledit.bmp')
    [x,cmap]=loadbmp('coledit.bmp');
    axes('position',[0,0,1,1]);
    image(x);
    set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'tickdir','out')
    colormap(cmap)
    text(540,422,['version ',ColEditVersion],'fontsize',8);
    text(540,432,ColEditDate,'fontsize',8);
    text(540,442,[setstr(169),' G.Krahmann'],'fontsize',8);
    pause(2)
    set(gca,'visible','off')
    delete(gca)                      
  end
elseif Intvers==5
  if exist('coledit.pcx')
    eval('warning off')
    [x]=imread('coledit.pcx');
    eval('warning on')
    axes('position',[0,0,1,1]);
    image(double(x)/255);
    set(gca,'xcolor',[0 0 0],'ycolor',[0 0 0],'tickdir','out')
    text(540,422,['version ',ColEditVersion],'fontsize',8);
    text(540,432,ColEditDate,'fontsize',8);
    text(540,442,'\copyright G.Krahmann','fontsize',8);
    clear x
    pause(3)
    set(gca,'visible','off')
    delete(gca)                      
  end
end

% set defaults
set(0,'defaultuicontrolbackgroundcolor',[0.6 0.6 0.6]);
if Intvers==4
  set(0,'defaultuicontrolinterruptible','yes');
  set(0,'defaultfigureinterruptible','yes');
  set(0,'defaultaxesinterruptible','yes');
elseif Intvers==5
  set(0,'defaultuicontrolinterruptible','on');
  set(0,'defaultfigureinterruptible','on');
  set(0,'defaultaxesinterruptible','on');
end

% debug on (1) or off (0)  controls messages
Deb = 0;

% set internal length of colormap
CL = 100;


% create axes
ColEditAx(1) = axes('position',[0.3,0.59,0.65,0.21]);	% red
ColEditAx(2) = axes('position',[0.3,0.32,0.65,0.21]);	% green
ColEditAx(3) = axes('position',[0.3,0.05,0.65,0.21]);	% blue
ColEditAx(4) = axes('position',[0.3,0.84,0.65,0.14]);	% colormap

% initialize plots and colormap
ColEditR =[0 0;1 1];
ColEditG =[0 0;1 1];
ColEditB =[0 0;1 1];
colcontrols('initialize');
colcontrols('loadjet');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create uicontrols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0 = 10;
y0 = 10;
xw = 140;
yw = 440;

% frame around controls
fh(7) = uicontrol('style','frame','position',[x0-5 y0-5 xw yw],...
	'backgroundcolor',[0.2 0.2 0.2]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% close COLEDIT %%%%%%%%%%%%%%%%%%%%%%%%%%%
oset = y0;
% frame around close
fh(1) = uicontrol('style','frame','position',[ x0 oset xw-10 30],...
	'backgroundcolor',[0.5 0.5 0.5]);

% close-control
mh(1) = uicontrol('style','push','position',[x0+5 oset+5 xw-20 20],...
	'string','close','callback','close(gcf)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% help window %%%%%%%%%%%%%%%%%%%%%%%%%%
oset = y0+35;
% frame around close
fh(6) = uicontrol('style','frame','position',[x0 oset xw-10 30],...
	'backgroundcolor',[0.5 0.5 0.5]);

% close-control
mh(14) = uicontrol('style','push','position',[x0+5 oset+5 xw-20 20],...
	'string','help','callback','colcontrols(''help'')');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% load m-file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
oset = y0+70;
% frame around load
fh(2) = uicontrol('style','frame','position',[x0 oset xw-10 80],...
	'backgroundcolor',[0.5 0.5 0.5]);

% load colormap
mh(2) = uicontrol('style','push','position',[x0+5 oset+5 xw-20 20],...
	'string','load file',...
	'callback',['colcontrols(''loadmap'');']);

% lookfor existing maps
colcontrols('checkmaps');
mh(9) = uicontrol('style','popupmenu','position',[x0+5 oset+30 xw-20 20],...
	'string',ExMaps);

mh(13) = uicontrol('style','text','position',[x0+5 oset+55 xw-20 20],...
	'string','import m-file',...
	'backgroundcolor',[0.5,0.5,0.5]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% control mouse-activity %%%%%%%%%%%%%%%%%%%
oset = y0+325;
% frame around mouse control
fh(3) = uicontrol('style','frame','position',[x0 oset xw-10 105],...
	'backgroundcolor',[0.5 0.5 0.5]);

% add/remove/change point radio-1
mh(3) = uicontrol('style','radio','position',[x0+5 oset+5 xw-20 20],...
	'string','add pt',...
	'value',0,...
	'callback',['',...
		    'set(mh(3),''value'',1);',...
	            'set(mh(4),''value'',0);',...
	            'set(mh(5),''value'',0);',...
		    'PtAct = 1;']);

% add/remove/change point radio-2
mh(4) = uicontrol('style','radio','position',[x0+5 oset+30 xw-20 20],...
	'string','remove pt',...
	'value',0,...
	'callback',['',...
		    'set(mh(3),''value'',0);',...
	            'set(mh(4),''value'',1);',...
	            'set(mh(5),''value'',0);',...
		    'PtAct = 2;']);

% add/remove/change point radio-3
PtAct = 3;
mh(5) = uicontrol('style','radio','position',[x0+5 oset+55 xw-20 20],...
	'string','change pt',...
	'value',1,...
	'callback',['',...
		    'set(mh(3),''value'',0);',...
	            'set(mh(4),''value'',0);',...
	            'set(mh(5),''value'',1);',...
		    'PtAct = 3;']);

mh(14) = uicontrol('style','text','position',[x0+5 oset+80 xw-20 20],...
	'string','mouse-action','backgroundcolor',[0.5 0.5 0.5]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% write new m-file %%%%%%%%%%%%%%%%%%%%%%%
oset = y0+155;
% frame around write control
fh(4) = uicontrol('style','frame','position',[x0 oset xw-10 80],...
	'backgroundcolor',[0.5 0.5 0.5]);

% name new colormap
dummy = 'noname';
count = 1;
WriteColName = [dummy,int2str(count)];
while exist([WriteColName,'.m'])==2
  count = count+1;
  WriteColName = [dummy,int2str(count)];
end
mh(6) = uicontrol('style','edit','position',[x0+5 oset+30 xw-20 20],...
	'string',[WriteColName],'backgroundcolor',[0.7,0.7,0.7]);

mh(7) = uicontrol('style','text','position',[x0+5 oset+55 xw-20 20],...
	'string','export m-file','backgroundcolor',[0.5 0.5 0.5]);

% write colormap m-file
mh(8) = uicontrol('style','push','position',[x0+5 oset+5 xw-20 20],...
	'string','write m-file',...
	'callback','colcontrols(''writecheck'');');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% import RGB-array %%%%%%%%%%%%%%%%%%%%%%%%
oset = y0+240;
% frame around import control
fh(5) = uicontrol('style','frame','position',[x0 oset xw-10 80],...
	'backgroundcolor',[0.5 0.5 0.5]);

% load RGB file colormap
mh(10) = uicontrol('style','push','position',[x0+5 oset+5 xw-20 20],...
	'string','load file',...
	'callback',['colcontrols(''importmap'');']);

% name RGB file
mh(11) = uicontrol('style','edit','position',[x0+5 oset+30 xw-20 20],...
	'string','-','backgroundcolor',[0.7,0.7,0.7]);

mh(12) = uicontrol('style','text','position',[x0+5 oset+55 xw-20 20],...
	'string','import RGB-array',...
	'backgroundcolor',[0.5,0.5,0.5]);

