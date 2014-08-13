% This set of routines find the mixed layer depth (MLD) of Argo profiles.  
% This routine controls everything; it loads the data, cycles through all 
% of the Argo profiles, and saves the output. These routines require the 
% MATLAB SEAWATER toolbox.  They also require the M_MAP toolbox to plot 
% maps of the MLDs and use MATLAB netcdf calls to load Argo data. 

clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    EDIT SECTION  - Edit this section to tailor your environment

dirname = ('./argoprofiles/');  % path to profile directories
floatlist = ('*0*');  % floats to process - ''floatlist = ('*0*');'' will process all the floats
yesplot = 0;  % 1 if plots of each profile and the profile's possible MLDs are desired

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Assemble the names of the floats to use 
dstruct = dir([dirname floatlist]); 
fnames = fieldnames(dstruct);
dcell = struct2cell(dstruct);   % (4 X nfiles)
floatnames =  dcell(1,:)';

% Initialize output array
mldinfo = ones(26,1);
            
% Start a loop for each float
for jj = 1:length(floatnames)
    clear floatnumber profilenames
    
    % Assemble the profiles in the float's folder
    floatnumber = char(floatnames(jj))
    dstruct = dir([dirname floatnumber '/profiles/*.nc']);
    fnames = fieldnames(dstruct);
    dcell = struct2cell(dstruct);   % (4 X nfiles)
    profilenames =  dcell(1,:)';
    
    % Cycle through all of the profiles for a given float and calculate the
    % MLD for each profile 
    n = length(profilenames);
    for ii = 1:n
        clear profilenumber pdate plat plon pres temp sal pden
        
        % The current profile
        profilenumber = char(profilenames(ii));
        name = [dirname floatnumber '/profiles/' profilenumber];
        
        % Load the profile's netcdf data and perform a few simple quality
        % control checks.  If the profile is bad, reject is set to 1, and 
        % the output variables are set to 9999. Otherwise, findmld.m 
        % calculates the output variables. 
        loadargo

        mldindex = ii;
        if reject == 0
            date(mldindex) = pdate;
            lat(mldindex) = plat;
            lon(mldindex) = plon;
            
            % Find the MLD of the profile.  findmld.m needs 'temp,' 'pres,'
            % and 'sal' fields, as well as 'mldindex.'  The profile fields
            % are single column arrays.  'mldindex' is a number 
            % signifying the current profile in the float record.
            findmld
        else
            % Output variables for bad profiles
            date(mldindex) = pdate;
            lat(mldindex) = plat;
            lon(mldindex) = plon;
            mixedtp(mldindex) = 9999;
            mixedt_ta(mldindex) = 9999; 
            mixedt_sa(mldindex) = 9999; 
            mixedt_da(mldindex) = 9999; 
            mixedsp(mldindex) = 9999;
            mixeddp(mldindex) = 9999;
            mixedd_ta(mldindex) = 9999; 
            mixedd_sa(mldindex) = 9999;
            mixedd_da(mldindex) = 9999;
            mldepthptmpp(mldindex) = 9999; 
            mldepthptmp_ta(mldindex) = 9999;
            mldepthptmp_sa(mldindex) = 9999;
            mldepthptmp_da(mldindex) = 9999;
            mldepthdensp(mldindex) = 9999;
            mldepthdens_ta(mldindex) = 9999;
            mldepthdens_sa(mldindex) = 9999;
            mldepthdens_da(mldindex) = 9999;
            gtmldp(mldindex) = 9999;
            gdmldp(mldindex) = 9999;
            tanalysis(mldindex) = 9999;
            sanalysis(mldindex) = 9999;
            danalysis(mldindex) = 9999;
        end
    end
    
    % Save MLD information for each float 
    [addn] = length(mixedt_ta);
    add(1,1:addn) = eval(floatnumber)*ones(1,addn); %float id number
    add(2,1:addn) = date;                           %profile date
    add(3,1:addn) = lat;                            %profile latitude
    add(4,1:addn) = lon;                            %profile longitude
    add(5,1:addn) = mixedtp;                        %mixed layer depth from temperature algorithm
    add(6,1:addn) = mixedt_ta;                      %mixed layer average temperature using temperature algorithm mld
    add(7,1:addn) = mixedt_sa;                      %mixed layer average salinity using temperature algorithm mld
    add(8,1:addn) = mixedt_da;                      %mixed layer average potential density using temperature algorithm mld 
    add(9,1:addn) = mixedsp;                        %mixed layer depth from salinity algorithm
    add(10,1:addn) = mixeddp;                       %mixed layer depth from density algorithm
    add(11,1:addn) = mixedd_ta;                     %mixed layer average temperature using density algorithm mld
    add(12,1:addn) = mixedd_sa;                     %mixed layer average salinity using density algorithm mld
    add(13,1:addn) = mixedd_da;                     %mixed layer average potential density using density algorithm mld
    add(14,1:addn) = mldepthptmpp;                  %mixed layer depth from temperature threshold method
    add(15,1:addn) = mldepthptmp_ta;                %mixed layer average temperature using temperature threshold mld
    add(16,1:addn) = mldepthptmp_sa;                %mixed layer average salinity using temperature threshold mld
    add(17,1:addn) = mldepthptmp_da;                %mixed layer average potential density using temperature threshold mld
    add(18,1:addn) = mldepthdensp;                  %mixed layer depth from density threshold method
    add(19,1:addn) = mldepthdens_ta;                %mixed layer average temperature using density threshold mld
    add(20,1:addn) = mldepthdens_sa;                %mixed layer average salinity using density threshold mld
    add(21,1:addn) = mldepthdens_da;                %mixed layer average potential density using density threshold mld
    add(22,1:addn) = gtmldp;                        %mixed layer depth from temperature gradient method
    add(23,1:addn) = gdmldp;                        %mixed layer depth from density gradient method
    add(24,1:addn) = tanalysis;                     %records where the algorithm selects the temperature MLD
    add(25,1:addn) = sanalysis;                     %records where the algorithm selects the salinity MLD
    add(26,1:addn) = danalysis;                     %records where the algorithm selects the potential density MLD
    
    % Add the MLD information for the current float onto the MLD
    % information for all of the floats
    mldinfo = [mldinfo add];
  
    clear addn add date lat lon
    clear mixedtp mixedsp mldepthdensp mldepthptmpp mixeddp mixedd_ta mixedd_sa mixedd_da
    clear mixedt_ta mldepthdens_ta mixedt_sa mldepthdens_sa mixedt_da mldepthdens_da
    clear mldepthptmp_ta mldepthptmp_sa mldepthptmp_da

    clear gtmldp gdmldp tanalysis sanalysis danalysis
    clear floatm floatn
end

% Cut out the first initialization column of mldinfo and transpose it into
% an array more conducive to ascii output
mldinfo = mldinfo(:,2:end);   
mldinfo = mldinfo';
save('mldinfo.mat','mldinfo')

% Mapping prompt.  M_MAP is required to plot the map. 
plotresponse = input('mldinfo.mat saved.  Do you want to plot a map of mixed layer depths? (Y/N)','s');
if strncmpi(plotresponse,'y',1)==1
    mapmld
end
