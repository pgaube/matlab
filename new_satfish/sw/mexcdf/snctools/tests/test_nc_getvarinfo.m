function test_nc_getvarinfo ( )

fprintf ( 'NC_GETVARINFO:  starting test suite...\n' );
run_local_tests;
run_http_tests;
return



function run_local_tests()

fprintf('\tRunning local tests.\n');
test_noInputs;
test_tooFewInputs;
test_tooManyInput;
test_fileIsNotNetcdfFile;
test_varIsNotNetcdfVariable;
test_fileIsNumeric_varIsChar;
test_fileIsChar_varIsNumeric;

test_limitedVariable;
test_unlimitedVariable;
test_unlimitedVariableWithOneAttribute;

return





function run_http_tests()
	% These tests are regular URLs, not OPeNDAP URLs.
	if ~ ( getpref ( 'SNCTOOLS', 'USE_JAVA', false ) )
		fprintf('=tjava http backend testing filtered out when SNCTOOLS ''USE_JAVA'' preference is false.\n');
		return
	end
	if ~ ( getpref ( 'SNCTOOLS', 'TEST_REMOTE', false ) )
		fprintf('\tjava http backend testing filtered out when SNCTOOLS ''TEST_REMOTE'' preference is false.\n');
		return
	end
	fprintf('\tRunning http/java tests.\n');
	test_fileIsHttpUrl_varIsChar;
	test_fileIsJavaNcid_varIsChar;
return






function test_noInputs ( )
ncfile = 'testdata/full.nc';

try
	nb = nc_getvarinfo;
	msg = sprintf ( '%s:  succeeded when it should have failed.\n', mfilename );
	error ( msg );
end

return






function test_tooFewInputs ( )
ncfile = 'testdata/full.nc';

try
	nb = nc_getvarinfo ( ncfile );
	msg = sprintf ( '%s:  succeeded when it should have failed.\n', mfilename );
	error ( msg );
end

return





function test_tooManyInput ( )
ncfile = 'testdata/full.nc';
try
	nb = nc_getvarinfo ( ncfile, 't1' );
	msg = sprintf ( '%s:  succeeded when it should have failed.\n', mfilename );
	error ( msg );
catch
	;
end

return





function test_fileIsNotNetcdfFile ( )

ncfile = 'testdata/full.nc';
try
	nb = nc_getvarinfo ( 'iamnotarealfilenoreally', 't1' );
	msg = sprintf ( '%s:   succeeded when it should have failed.\n', mfilename  );
	error ( msg );
end

return






function populate_ncfile ( ncfile );

%
% make all the variable definitions.
nc_add_dimension ( ncfile, 'ocean_time', 0 );
nc_add_dimension ( ncfile, 'x', 2 );
nc_add_dimension ( ncfile, 'y', 6 );

clear varstruct;
varstruct.Name = 'x';
varstruct.Nctype = 'double';
varstruct.Dimension = { 'x' };
nc_addvar ( ncfile, varstruct );

clear varstruct;
varstruct.Name = 'ocean_time';
varstruct.Nctype = 'double';
varstruct.Dimension = { 'ocean_time' };
nc_addvar ( ncfile, varstruct );

clear varstruct;
varstruct.Name = 't1';
varstruct.Nctype = 'double';
varstruct.Dimension = { 'ocean_time' };
nc_addvar ( ncfile, varstruct );

clear varstruct;
varstruct.Name = 't2';
varstruct.Nctype = 'double';
varstruct.Dimension = { 'ocean_time' };
varstruct.Attribute(1).Name = 'test_att';
varstruct.Attribute(1).Value = 'dud';
nc_addvar ( ncfile, varstruct );

clear varstruct;
varstruct.Name = 't3';
varstruct.Nctype = 'double';
varstruct.Dimension = { 'ocean_time' };
nc_addvar ( ncfile, varstruct );

clear varstruct;
varstruct.Name = 'y';
varstruct.Nctype = 'double';
varstruct.Dimension = [];
nc_addvar ( ncfile, varstruct );

clear varstruct;
varstruct.Name = 'z';
varstruct.Nctype = 'double';
varstruct.Dimension = { 'y', 'x' };
nc_addvar ( ncfile, varstruct );

clear varstruct;
varstruct.Name = 'c';
varstruct.Nctype = 'char';
varstruct.Dimension = { 'ocean_time' };
nc_addvar ( ncfile, varstruct );

return











function test_varIsNotNetcdfVariable ( )

ncfile = 'testdata/full.nc';
try
	nb = nc_getvarinfo ( ncfile, 't5' );
	msg = sprintf ( '%s:  succeeded when it should have failed.\n', mfilename );
	error ( msg );
end
return









function test_fileIsNumeric_varIsChar ( )
ncfile = 'testdata/full.nc';
try
	nb = nc_getvarinfo ( 0, 't1' );
	msg = sprintf ( '%s:  succeeded when it should have failed.\n', mfilename );
	error ( msg );
end
return



function test_fileIsJavaNcid_varIsChar ( )

import ucar.nc2.dods.*     
import ucar.nc2.*          

url = 'http://rocky.umeoce.maine.edu/GoMPOM/cdfs/gomoos.20070723.cdf';
jncid = NetcdfFile.open(url);

try
	nb = nc_getvarinfo ( jncid, 'w' );
	msg = sprintf ( '%s:  succeeded when it should have failed.\n', mfilename );
	error ( msg );
end
return




function test_fileIsHttpUrl_varIsChar ( )

import ucar.nc2.dods.*     
import ucar.nc2.*          

url = 'http://rocky.umeoce.maine.edu/GoMPOM/cdfs/gomoos.20070723.cdf';

try
	nb = nc_getvarinfo ( url, 'w' );
	error ( 'succeeded when it should have failed.' );
end
return




function test_fileIsChar_varIsNumeric ( )
ncfile = 'testdata/full.nc';
try
	nb = nc_getvarinfo ( ncfile, 0 );
	msg = sprintf ( '%s:  succeeded when it should have failed.\n', mfilename );
	error ( msg );
end
return




function test_limitedVariable ( )
ncfile = 'testdata/getlast.nc';
v = nc_getvarinfo ( ncfile, 'x' );

if ~strcmp(v.Name, 'x' )
	msg = sprintf ( '%s:  Name was not correct.\n', mfilename  );
	error ( msg );
end
if (v.Nctype~=6 )
	msg = sprintf ( '%s:  Nctype was not correct.\n', mfilename  );
	error ( msg );
end
if (v.Unlimited~=0 )
	msg = sprintf ( '%s:  Unlimited was not correct.\n', mfilename  );
	error ( msg );
end
if (length(v.Dimension)~=1 )
	msg = sprintf ( '%s:  Dimension was not correct.\n', mfilename  );
	error ( msg );
end
if ( ~strcmp(v.Dimension{1},'x') )
	msg = sprintf ( '%s:  Dimension was not correct.\n', mfilename  );
	error ( msg );
end
if (v.Size~=2 )
	msg = sprintf ( '%s:  Size was not correct.\n', mfilename  );
	error ( msg );
end
if (numel(v.Size)~=1 )
	msg = sprintf ( '%s:  Rank was not correct.\n', mfilename  );
	error ( msg );
end
if (length(v.Attribute)~=0 )
	msg = sprintf ( '%s:  Attribute was not correct.\n', mfilename  );
	error ( msg );
end

return





function test_unlimitedVariable ( )
ncfile = 'testdata/getlast.nc';

v = nc_getvarinfo ( ncfile, 't1' );

if ~strcmp(v.Name, 't1' )
	msg = sprintf ( '%s:  Name was not correct.\n', mfilename  );
	error ( msg );
end
if (v.Nctype~=6 )
	msg = sprintf ( '%s:  Nctype was not correct.\n', mfilename  );
	error ( msg );
end
if (v.Unlimited~=1 )
	msg = sprintf ( '%s:  Unlimited was not correct.\n', mfilename  );
	error ( msg );
end
if (length(v.Dimension)~=1 )
	msg = sprintf ( '%s:  Dimension was not correct.\n', mfilename  );
	error ( msg );
end
if (v.Size~=10 )
	msg = sprintf ( '%s:  Size was not correct.\n', mfilename  );
	error ( msg );
end
if (numel(v.Size)~=1 )
	msg = sprintf ( '%s:  Rank was not correct.\n', mfilename  );
	error ( msg );
end
if (length(v.Attribute)~=0 )
	msg = sprintf ( '%s:  Attribute was not correct.\n', mfilename  );
	error ( msg );
end

return







function test_unlimitedVariableWithOneAttribute ( )

ncfile = 'testdata/getlast.nc';
v = nc_getvarinfo ( ncfile, 't4' );

if ~strcmp(v.Name, 't4' )
	msg = sprintf ( '%s:  Name was not correct.\n', mfilename  );
	error ( msg );
end
if (v.Nctype~=6 )
	msg = sprintf ( '%s:  Nctype was not correct.\n', mfilename  );
	error ( msg );
end
if (v.Unlimited~=1 )
	msg = sprintf ( '%s:  Unlimited was not correct.\n', mfilename  );
	error ( msg );
end
if (length(v.Dimension)~=2 )
	msg = sprintf ( '%s:  Dimension was not correct.\n', mfilename  );
	error ( msg );
end
if (numel(v.Size)~=2 )
	msg = sprintf ( '%s:  Rank was not correct.\n', mfilename  );
	error ( msg );
end
if (length(v.Attribute)~=1 )
	msg = sprintf ( '%s:  Attribute was not correct.\n', mfilename  );
	error ( msg );
end

return

