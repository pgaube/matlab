%calculates the gas transfer velocity based off of the W92 and H06 squared dependance of flux on
%windspeed and WM99 cubic using dependance of flux on
%windspeed


S = nan(length(lat),length(lon),length(time));
K_W92 = nan(length(lat),length(lon),length(time));
K_H06_lo = nan(length(lat),length(lon),length(time));
K_H06_hi = nan(length(lat),length(lon),length(time));
K_Wm99 = nan(length(lat),length(lon),length(time));


for m = 1:length(lat)
    for n = 1:length(lon)
        for p = 1:length(time)
        
        S(m,n,p) = 2073.1 - 125.62*(sst(m,n,p)) + ...                               %Schmidt number based on a least squares fit to 
                    3.6276*((sst(m,n,p))^2) - ...                                   temp (C) from Jahne et al 1987b
                    0.043219*((sst(m,n,p)^3));                                      
                                                         
        K_W92(m,n,p) = (0.39*wind_squared(m,n,p))*((S(m,n,p)/660)^-.5);             %Dependance of flux on average windspeed 
                                                                                    %based off of Wannikoff 1992 (cm/y)    
        
        K_H06_lo(m,n,p) = (0.247*wind_squared(m,n,p))*((S(m,n,p)/600)^-.5);    %Dependance of flux on windspeed 
                                                                                    %based off of Ho et al 2006(cm/y)
        
        K_H06_hi(m,n,p) = (0.285*wind_squared(m,n,p))*((S(m,n,p)/600)^-.5);    %Dependance of flux on windspeed 
                                                                                    %based off of Ho et al 2006(cm/y)
      
        K_WM99(m,n,p) = (1.09*wind(m,n,p) - (0.333*wind_squared(m,n,p)) + ...       %Dependance of flux on windspeed based off of 
                    (0.078*wind_cubed(m,n,p)))*((S(m,n,p)/660)^-.5);               %Wannikoff and MagGillis 1999 (cm/y)
                                                                                    
      
        
        end
    end
end


clear S m n p