function retrieval_method = snc_read_backend(ncfile)

v = version('-release');
switch ( v )
    case { '11', '12', '13', '14', '2006a', '2006b', '2007a', '2007b', '2008a' }
        tmw_gt_r2008a = false;
    otherwise
        tmw_gt_r2008a = true;
end

switch ( v )
    case { '11', '12', '13', '14', '2006a', '2006b', '2007a', '2007b', '2008a', '2008b' }
        tmw_gt_r2008b = false;
    otherwise
        tmw_gt_r2008b = true;
end

% Check for this early.
use_java = getpref('SNCTOOLS','USE_JAVA',false);
if isa(ncfile,'ucar.nc2.NetcdfFile') && use_java
    retrieval_method = 'java';
	return
end

file_is_nc4 = exist(ncfile,'file') && isnc4(ncfile);
file_is_nc3 = exist(ncfile,'file') && isnc3(ncfile);

if tmw_gt_r2008b && file_is_nc4
    % Use native HDF5 for all local NC4 files when the version = R2009a
    retrieval_method = 'hdf5';
elseif tmw_gt_r2008a && file_is_nc3
    % Use TMW for all local NC3 files when the version >= R2008b
    retrieval_method = 'tmw';
elseif file_is_nc3
    % Local NC3 files should rely on mexnc when the version <= R2008a
    retrieval_method = 'mexnc';
elseif use_java 
    % Can be a URL or NC4 file
    retrieval_method = 'java';
elseif file_is_nc4
    % NC4 file where we have <=2008b and java is not an option.
    % Try to use the community mex-file.
    retrieval_method = 'mexnc';
elseif ~isempty(regexp(ncfile,'https*://'))
    % a URL when java is not enabled.  Use mexnc
    retrieval_method = 'mexnc';
else
    error('SNCTOOLS:unknownBackendSituation', ...
      'Could not determine which backend to use with %s.', ...
       ncfile );
end

return



