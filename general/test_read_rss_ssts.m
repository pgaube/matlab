
% This program calls the routines to read Microwave OI SST products  or Microwave-IR SST products
% available from RSS
%
% Change the file_name below to point to your data file
% comment out that which you don't need
%
% Questions should be addressed to RSS support: 
% http://www.remss.com/support


% CHANGE to your directory and file (UNZIPPED):  currently set to OI verification data file
file_name = 'your drive:\your directory\tmi_amsre.fusion.2004.140.v02';
sst = read_rss_oisst_v2(file_name);
sst(770:775,474:478)'



% CHANGE to your directory and file (UNZIPPED):  currently set to MW-IR verification data file
file_name = 'your drive:\your directory\mw_ir.fusion.2006.345.v01';
sst = read_rss_mwir_sst(file_name);
sst(990:975,674:678)'


