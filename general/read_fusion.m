function [sst]=read_fusion(atype,lyr,varargin)

% you need to add this file, jul2dy.m, and read_rss_oisst.m to your matlab path

%%%  ATTENTION: edit directory please
root_directory='your drive:\your directory\';

version_string = 'v02';

%atype='tmi'
%atype='amsre'
%atype='tmi_amsre'

sub_directory = atype;  % this assumes you have put files in subdirectories according to instrument type

% lyr = year
% varargin = you can have various arguments to this function
% your options are to ask for the file by [day of year] or [month, day of month]
% For example, you can read May 19, 2004 SST in either of the following ways:

%[sst]=read_fusion('tmi_amsre',2004,140);
%[sst]=read_fusion('tmi_amsre',2004,05,19);


varargin=cat(2,varargin{:});
isv=size(varargin,2);
if isv==1
    idyjl=varargin(1);
else
    im=varargin(1);
    id=varargin(2);
    [idyjl]=dy2jul(lyr,im,id); 
end;



syr=num2str(lyr,'%4.4i');sdyj=num2str(idyjl,'%3.3i');

% look for a final version
filename=strcat(root_directory,sub_directory,'\',atype,'.fusion.',syr,'.',sdyj,'.',version_string);

if ~exist(filename) % if no final version, look for a near real time (interim) version
    filename=strcat(root_directory,sub_directory,'\',atype,'.fusion.',syr,'.',sdyj,'.rt');
end;

if ~exist(filename)
    ['FILE NOT FOUND: ' filename]
    sst=[];return;
end;

filename

sst = read_rss_oisst_v2(filename);
