%removes data from Hovmoller plot data with in x degrees from the coast

x = 5; %how many degrres from the coast do you want to remove the data?

cut=x*2; % multiply by 2 for data gridded on 0.5 deg longitude.  adjust as necisary to mach your grid
cut_mask=mask;


    for n = 1:length(mask(1,:))
        if isnan(mask(:,n))
            cut_mask(:,n-cut:n) = nan;
            cut_mask(:,n:n+cut) = nan;
        end
    end

