function varargout=readf(fid,fmtStr,n)
% function out=readf(fid,varargin)
%  Catches string fid's
if isnumeric(fid)
 [varargout{1:n}]=textscan(fid,fmtStr);
elseif ischar(fid)
 [varargout{1:n}]=strread(fid,fmtStr);
end
end

