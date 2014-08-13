function [sst]=read_rss_mwir_sst(file_name)

% This function reads RSS Microwave MWIR OI SST files
% RSS MWIR OI SST files must be unzipped before reading
%
% Input argument: file_name = file path and name of data file to read
%
% The function returns: 
% sst = a 4096 by 2048 array (~9km earth grid) of SST 
%
% RSS MW OI SST files contain single byte values which must be decoded to obtain meaningful geophysical data
%
% Valid SST byte values (0 - 250) must be scaled and offset.
% Byte values (251 - 255) have special meanings:
%      251 = missing data
%      252 = sea ice
%      253 = missing data
%      254 = missing data
%      255 = land mass
%
% for a detailed desription see: http://www.remss.com/sst and click Description
%
% questions should be addressed to RSS support:
% http://www.remss.com/support

centigrade_scale  =  0.15;
centigrade_offset = -3.0;


if ~exist(file_name)
    ['FILE NOT FOUND: ' file_name]
    sst=[];
    return;
end;

fid = fopen(file_name, 'r');
sst = fread(fid, [4096 2048], 'uchar');
fclose(fid);
good = find(sst <= 250);
sst(good) = (sst(good) * centigrade_scale) + centigrade_offset;
  
return;

