function test_nc_varget( )


fprintf ( 1, 'NC_VARGET:  starting test suite...\n' );


%run_nc3_tests;
run_nc3_java_tests;
run_nc4_java_tests;
run_opendap_tests;
run_http_tests;
test_hdf5_backend;

return



function run_opendap_tests()
	test_readOpendapVariable;

	% Regression
	test_regressionErrorMsgBadUrl;

return

function run_http_tests()
	if getpref('SNCTOOLS','USE_JAVA',false) && getpref('SNCTOOLS','TEST_HTTP',false)
		fprintf('\tRunning http/java tests...\n' );
		test_readHttpVariable;
		test_readHttpVariableGivenJavaNcid;
	else
		fprintf('\tHTTP testing filtered out where USE_JAVA and TEST_HTTP preferences not both set.\n');
	end
return

function run_nc3_tests()
	fprintf('\tRunning local netcdf-3 tests...\n' );
	ncfile = 'testdata/varget.nc';
	run_local_tests(ncfile);
return

function run_nc3_java_tests()
	switch version('-release') 
		case {'2008a', '2007b', '2007a', '2006b', '2006a', '14', '13', '12' }
			;
		otherwise
			fprintf ( '\tnc3 java backend testing filtered out where the release is 2008b or higher.\n' );
			return
	end

	if ~getpref('SNCTOOLS','USE_JAVA',false)
		fprintf ( '\tnc3 java backend testing filtered out on configurations where SNCTOOLS ''USE_JAVA'' prefererence is false.\n' );
		return
	end
	fprintf('\tRunning local netcdf-3 tests with java...\n' );
	ncfile = 'testdata/varget.nc';
	run_local_tests(ncfile);
return

function run_nc4_java_tests()
% netcdf-4 testing with java is allowed on 2008b and below.  In 2009a and higher, we default to
% using the matlab HDF5 interface.
	switch version('-release') 
		case {'2008b', '2008a', '2007b', '2007a', '2006b', '2006a', '14', '13', '12' }
			;
		otherwise
			fprintf ( '\tnc4 java backend testing filtered out where the release is 2009a or higher.\n' );
			return
	end

	if ~getpref('SNCTOOLS','USE_JAVA',false)
		fprintf ( '\tnc4 java backend testing filtered out on configurations where SNCTOOLS ''USE_JAVA'' prefererence is false.\n' );
		return
	end
	fprintf('\tRunning local netcdf-4 tests with java...\n' );
	ncfile = 'testdata/varget4.nc';
	run_local_tests(ncfile);

	ncfile = 'testdata/tst_pres_temp_4D_netcdf4.nc' ;
	% Partial Retrievals
	test_readSingleValueFromNc4File(ncfile );
	test_readFullFloatVariableNc4(ncfile);

return

function test_hdf5_backend()
% 2008b HDF5 is not capable of reading netcdf-4 files
	switch version('-release') 
		case {'2008b', '2008a', '2007b', '2007a', '2006b', '2006a', '14', '13', '12' }
			fprintf ( '\tnc4 hdf5 backend testing filtered out where the release is 2008b or below.\n' );
			return
	end

	if ~getpref('SNCTOOLS','USE_NC4HDF5',false)
		fprintf ( '\tnc4hdf5 backend testing filtered out where SNCTOOLS ''USE_NC4HDF5'' prefererence is false.\n' );
		return
	end
	fprintf('\tRunning local netcdf-4 tests with hdf5 backend...\n' );
	ncfile = 'testdata/varget4.nc';
	run_local_tests(ncfile);
return


function run_local_tests(ncfile)

test_readSingleValueFrom1dVariable ( ncfile );
test_readSingleValueFrom2dVariable ( ncfile );
test_read2x2hyperslabFrom2dVariable ( ncfile );

test_readFullSingletonVariable ( ncfile );
test_readFullDoublePrecisionVariable ( ncfile );

test_readStridedVariable ( ncfile );
regression_NegSize(ncfile);
test_scaling(ncfile);

test_missing_value(ncfile);
return



function test_readOpendapVariable ()
if getpref('SNCTOOLS','TEST_OPENDAP',false)
    url = 'http://motherlode.ucar.edu:8080/thredds/dodsC/satellite/CTP/SUPER-NATIONAL_1km/20090730/SUPER-NATIONAL_1km_CTP_20090730_2000.gini';
    fprintf ( 1, 'Testing remote URL access %s...\n', url );
    w = nc_varget ( url, 'y', [0], [1] );
else
	fprintf('\tOPeNDAP testing filtered out where TEST_OPENDAP preference is set to false.\n');
end
return

function test_readHttpVariable ()
    url = 'http://coast-enviro.er.usgs.gov/models/share/balop.nc';
    w = nc_varget ( url, 'el' );
return


function test_readHttpVariableGivenJavaNcid ()
	import ucar.nc2.dods.*     
	import ucar.nc2.*          
                           
    url = 'http://coast-enviro.er.usgs.gov/models/share/balop.nc';
	jncid = NetcdfFile.open(url);
    w = nc_varget ( url, 'el' );
	close(jncid);
return



%==============================================================================
function test_regressionErrorMsgBadUrl ()
% Regression test.  If the URL is wrong, then the error message must give the
% name of the wrong url.   01-04-2007
% 
if getpref('SNCTOOLS','USE_JAVA',false) && getpref('SNCTOOLS','TEST_REMOTE',false)
    url = 'http://doesntexits:8080/thredds/dodsC/nexrad/composite/1km/agg';
    try
        w = nc_varget ( url, 'y', [0], [1] );
    catch
        [msg,id] = lasterr;
        if ~strcmp(id, 'SNCTOOLS:nc_varget_java:fileOpenFailure')
            error ( 'Error id ''%s'' was not expected.', id );
        end
        if ~findstr(msg, url)
            error ( 'Error message did not contain the incorrect url.');
        end
    end
end
return







function test_readSingleValueFrom1dVariable ( ncfile )

expData = 1.2;
actData = nc_varget ( ncfile, 'test_1D', 1, 1 );

ddiff = abs(expData - actData);
if any( find(ddiff > eps) )
    msg = sprintf ( 'input data ~= output data.' );
    error ( msg );
end

return








function test_readSingleValueFrom2dVariable ( ncfile )

expData = [1.5];
actData = nc_varget ( ncfile, 'test_2D', [2 2], [1 1] );

ddiff = abs(expData - actData);
if any( find(ddiff > eps) )
    msg = sprintf ( '%s:  input data ~= output data.\n', mfilename );
    error ( msg );
end

return




function test_read2x2hyperslabFrom2dVariable ( ncfile )

expData = [1.5 2.1; 1.6 2.2];
if getpref('SNCTOOLS','PRESERVE_FVD',false)
    expData = expData';
end
actData = nc_varget ( ncfile, 'test_2D', [2 2], [2 2] );

if ndims(actData) ~= 2
    error ( 'rank of output data was not correct' );
end
if numel(actData) ~= 4
    error ( 'rank of output data was not correct' );
end
ddiff = abs(expData(:) - actData(:));
if any( find(ddiff > eps) )
    error ( 'input data ~= output data ' );
end

return







%--------------------------------------------------------------------------
function test_readSingleValueFromNc4File_backend_neutral ( actData )

expData = 30;
if ndims(actData) ~= 2
    error ( 'rank of output data was not correct' );
end
if numel(actData) ~= 1
    error ( 'size of output data was not correct' );
end
ddiff = abs(expData(:) - actData(:));
if any( find(ddiff > eps) )
    error ( 'input data ~= output data ' );
end

return



%--------------------------------------------------------------------
function test_readSingleValueFromNc4File ( ncfile )

switch ( version('-release') )
    case { '14', '2006a', '2006b', '2007a', '2007b', '2008a' }
        try 
            actData = nc_varget ( ncfile, 'latitude', 1, 1 );
        catch
            [emsg,eid] = lasterr;
			switch(eid)
			case 'MATLAB:Java:GenericException'
                fprintf ( 1, 'Could not read a NC4 file with java, you need >= version 4.0 of toolsUI installed.\n' );
                return
			case 'SNCTOOLS:NC_VARGET:MEXNC:OPEN'
				fprintf ( 1, '\n\n\n' );
                fprintf ( 1, 'Could not read a NC4 file with mexnc, you would need to compile the netcdf library version >= version 4.0 (no, I won''t do that for you).\n' );
				fprintf ( 1, '\n\n\n' );
				pause(3);
                return
            otherwise
                error(eid,emsg);
            end


        end
    otherwise % assume >= R2008b
	    actData = test_readSingleValueFromNc4File_tmw(ncfile);
end

if ~isempty(actData) 
	test_readSingleValueFromNc4File_backend_neutral(actData);
end
    
return








%--------------------------------------------------------------------
function test_readFullSingletonVariable ( ncfile )


expData = 3.14159;
actData = nc_varget ( ncfile, 'test_singleton' );

ddiff = abs(expData - actData);
if any( find(ddiff > eps) )
    error ( 'input data ~= output data.\n'  );
end

return



function test_readFullDoublePrecisionVariable ( ncfile )


expData = [1:24];
expData = reshape(expData,6,4) / 10;

if getpref('SNCTOOLS','PRESERVE_FVD',false)
    expData = expData';
end

actData = nc_varget ( ncfile, 'test_2D' );

ddiff = abs(expData - actData);
if any( find(ddiff > eps) )
    error ( 'input data ~= output data.\n'  );
end

return




%---------------------------------------------------------------------------
function test_readFullFloatVariable_backend_neutral ( actData )

expData = [25 30 35 40 45 50];

if ndims(actData) ~= 2
    error ( 'rank of output data was not correct' );
end
if numel(actData) ~= 6
    error ( 'rank of output data was not correct' );
end
ddiff = abs(expData(:) - actData(:));
if any( find(ddiff > eps) )
    error ( 'input data ~= output data ' );
end

return



function test_readFullFloatVariableNc4 ( ncfile )

if snctools_use_java
    switch ( version('-release') )
        case { 'R14', '2006a', '2006b', '2007a', '2007b', '2008a' }
            try 
                actData = nc_varget ( ncfile, 'latitude' );
            catch
                [emsg,eid] = lasterr;
                if strcmp(eid,'MATLAB:Java:GenericException')
                    fprintf ('\tCould not read an NC4 file, make sure you have >= version 4.0 of toolsUI installed.\n' );
                    return
                else
                    error(eid,emsg);
                end


            end
        otherwise % assume >= R2008b
			actData = test_readFullFloatVariableNc4_tmw ( ncfile )
    end
    
    test_readFullFloatVariable_backend_neutral (actData);
    
end
return







function test_readStridedVariable ( ncfile )

expData = [1:24];
expData = reshape(expData,6,4) / 10;
expData = expData(1:2:3,1:2:3);
if getpref('SNCTOOLS','PRESERVE_FVD',false)
    expData = expData';
end

actData = nc_varget ( ncfile, 'test_2D', [0 0], [2 2], [2 2] );

ddiff = abs(expData - actData);
if any( find(ddiff > eps) )
    error ( 'input data ~= output data.\n'  );
end

return





%--------------------------------------------------------------------
function regression_NegSize ( ncfile )

expData = [1:24];
expData = reshape(expData,6,4) / 10;
sz = size(expData);
sz(2) = -1;
if getpref('SNCTOOLS','PRESERVE_FVD',false)
    expData = expData';
	sz = fliplr(sz);
end

actData = nc_varget ( ncfile, 'test_2D', [0 0], sz );

ddiff = abs(expData - actData);
if any( find(ddiff > eps) )
    error ( 'input data ~= output data.\n'  );
end

return


function test_missing_value(ncfile)
% The last value should be nan.
expData = NaN;
actData = nc_varget ( ncfile, 'sst_mv' );

if ~isa(actData,'double')
    error ( 'short data was not converted to double');
end

if ~isnan( actData(end) )
    error ( 'missing value not converted to nan.\n'  );
end

return

function test_scaling ( ncfile )

expData = [32 32 32 32; 50 50 50 50; 68 68 68 68; ...
           86 86 86 86; 104 104 104 104; 122 122 122 122];
expData = reshape(expData,6,4);
sz = size(expData);
sz(2) = -1;
if getpref('SNCTOOLS','PRESERVE_FVD',false)
    expData = expData';
	sz = fliplr(sz);
end

actData = nc_varget ( ncfile, 'temp' );

if ~isa(actData,'double')
    error ( 'short data was not converted to double');
end
ddiff = abs(expData - actData);
if any( find(ddiff > eps) )
    error ( 'input data ~= output data.\n'  );
end

return


