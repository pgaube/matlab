% This subroutine uses MATLAB netcdf calls to load the Argo data.  It is called
% by get_mld.m

% Open the file 'name'
f = netcdf(name, 'nowrite');

% Extract the position and date
x = f{'LATITUDE'};
plat = x(:);
x = f{'LONGITUDE'};
plon = x(:);
x = f{'JULD'};
pdate = x(:); %days since 1950-01-01 00:00:00 UTC 
pdate = pdate+datenum(1950,1,1,0,0,0);

% The adjusted temperature, salinity, and pressure profiles.  These have 
% values of 99999 if the profile has not been adjusted.  
x = f{'PRES_ADJUSTED'};
presa = x(:)';
x = f{'TEMP_ADJUSTED'};
tempa = x(:)';
x = f{'PSAL_ADJUSTED'};
sala = x(:)'; 

% The original temperature, salinity, and pressure profiles  
x = f{'PRES'};
pres = x(:)';
x = f{'TEMP'};
temp = x(:)';
x = f{'PSAL'};
sal = x(:)'; 

close(f)

% Check if the adjusted profiles are valid, and, if so, use them as
% the temperature, salinity, and pressure profiles  
if presa(1)<99999
    pres = presa;
    sal = sala;
    temp = tempa;
end
clear presa sala tempa

% Perform a few simple quality control checks; if any profiles are missing 
%values, cut the profiles beneath the missing values  
reject = 0;
if any(temp == 99999)
    k(1) = min(find(temp==99999));
    if k(1) < 5
        reject = 1;
    else
       temp = temp(1:(k(1)-1));
       sal = sal(1:(k(1)-1));
       pres = pres(1:(k(1)-1));
    end
end
if any(sal == 99999)
    k(2) = min(find(sal==99999));
    if k(2) < 5 
        reject = 1;
    else 
       temp = temp(1:(k(2)-1));
       sal = sal(1:(k(2)-1));
       pres = pres(1:(k(2)-1));                
    end
end
if any(pres == 99999)
    k(3) = min(find(pres==99999));
    if k(3) < 5
        reject = 1;
    else
       temp = temp(1:(k(3)-1));
       sal = sal(1:(k(3)-1));
       pres = pres(1:(k(3)-1));               
    end
end

% Reject profiles with less than 5 depth measurements, or with faulty
% pressure measurements
if length(pres)<5
   reject = 1;
end
if pres(min(find(pres>0)))>20
    reject = 1;
end
if sum(pres)==0
    reject = 1;
end
