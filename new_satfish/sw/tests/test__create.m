function test__create ( ncfile )
% TEST__CREATE:
%
% Tests run are open with
% Test 1:   nc_clobber_mode.  Check the initial file size.
% Test 2:   nc_noclobber_mode
% Test 3:   clobber and share and 64 bit offset
% Test 4:  share mode.  Should also clobber it.
% Test 5:  share | 64bit_offset
% Test 6:  64 bit offset.  Should also clobber it.
% Test 7:  noclobber mode.  Should not succeed because the file exists..
% Test 8:  only one input, should not succeed
% Test 9:  Filename is empty
%
% Basically the tests are the same as those for CREATE except we are
% using _CREATE instead.
%
% The _CREATE routine really isn't necesary anymore in NetCDF-4.  This
% is for backwards compatibility only.


test_001 ( ncfile );
test_002 ( ncfile );
test_003 ( ncfile );
test_004 ( ncfile );
test_005 ( ncfile );
test_006 ( ncfile );
%test_007 ( ncfile );
test_008 ( ncfile );
test_009 ( ncfile );

fprintf ( '_CREATE succeeded.\n' );



function test_001 ( ncfile )

[chunksize,ncid, status] = mexnc ( '_create', ncfile, nc_clobber_mode, 5000 );
if ( status ~= 0 )
	error ( mexnc('strerror',status) );
end

d = dir ( ncfile );
if d.bytes ~= 5000
	error ( 'initialsize not honored.\n' );
end
status = mexnc ( 'close', ncid );
if ( status ~= 0 )
	error ( 'CLOSE failed with nc_clobber_mode' );
end

return




function test_002 ( ncfile )

mode = bitor ( nc_clobber_mode, nc_share_mode );
[chunksize, ncid, status] = mexnc ( '_create', ncfile, mode, 5000 );
if ( status ~= 0 )
	error ( mexnc('strerror',status) );
end
status = mexnc ( 'close', ncid );
if ( status < 0 )
	error ( 'CLOSE failed with nc_clobber_mode | nc_share_mode' );
end

return



function test_003 ( ncfile )

mode = bitor ( nc_clobber_mode, nc_share_mode );
mode = bitor ( mode, nc_64bit_offset_mode );
[chunksize, ncid, status] = mexnc ( '_create', ncfile, mode, 5000 );
if ( status ~= 0 )
	error ( mexnc('strerror',status) );
end
status = mexnc ( 'close', ncid );
if ( status < 0 )
	error ( 'CLOSE failed with nc_clobber_mode | nc_share_mode | nc_64bit_offset_mode' );
end

return



function test_004 ( ncfile )

[chunksize, ncid, status] = mexnc ( '_create', ncfile, nc_share_mode, 5000 );
if ( status ~= 0 )
	error ( mexnc('strerror',status) );
end
status = mexnc ( 'close', ncid );
if ( status < 0 )
	error ( 'CLOSE failed with nc_share_mode' );
end

return






function test_005 ( ncfile )

mode = bitor ( nc_share_mode, nc_64bit_offset_mode );
[chunksize, ncid, status] = mexnc ( '_create', ncfile, mode, 5000 );
if ( status ~= 0 )
	error ( mexnc('strerror',status) );
end
status = mexnc ( 'close', ncid );
if ( status < 0 )
	error ( 'CLOSE failed with nc_share_mode | nc_64bit_offset_mode' );
end



function test_006 ( ncfile )
[chunksize, ncid, status] = mexnc ( '_create', ncfile, nc_64bit_offset_mode, 5000 );
if ( status ~= 0 )
	error ( mexnc('strerror',status) );
end
status = mexnc ( 'close', ncid );
if ( status < 0 )
	error ( 'CLOSE failed with nc_64bit_offset_mode' );
end


function test_007 ( ncfile )
[chunksize, ncid, status] = mexnc ( '_create', ncfile, nc_noclobber_mode, 5000 );
if ( status == 0 )
	error ( 'succeeded when it should have failed' );
end


function test_008 ( ncfile )
%
% Test 8:  only one input, should not succeed.  Throws an exception, 
%          because there are way too few arguments.
testid = 'Test 8';
try
	[chunksize, ncid, status] = mexnc ( '_create' );
catch	
	return
end

error ( 'succeeded when it should have failed' );




function test_009 ( ncfile )
%
% Test 9:  Filename is empty
[chunksize, ncid, status] = mexnc ( '_create', '', nc_clobber_mode, 5000 );
if status == 0
	error ( 'succeeded when it should have failed\n' );
end






