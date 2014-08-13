%calculates the gas transfer velocity based off of the W92 and H06 squared dependance of flux on
%windspeed and WM99 cubic using dependance of flux on
%windspeed



K_W92_660 = nan(length(lat),length(lon),length(time));
K_H06_lo_600 = nan(length(lat),length(lon),length(time));
K_H06_hi_600 = nan(length(lat),length(lon),length(time));
K_WM99_660 = nan(length(lat),length(lon),length(time));
Kbar_W92_660 = nan(length(lat),length(lon));
Kbar_H06_lo_600 =  nan(length(lat),length(lon));
Kbar_H06_hi_600 =  nan(length(lat),length(lon));
Kbar_WM99_660 =  nan(length(lat),length(lon));

for m = 1:length(lat)
    for n = 1:length(lon)
        for p = 1:length(time)
                                     
        K_W92_660(m,n,p) = (0.39*wind_squared(m,n,p));                               %Dependance of flux on average windspeed 
                                                                                    %based off of Wannikoff 1992 (cm/y)    
        
        K_H06_lo_600(m,n,p) = (0.247*wind_squared(m,n,p));                          %Dependance of flux on windspeed 
                                                                                    %based off of Ho et al 2006(cm/y)
        
        K_H06_hi_600(m,n,p) = (0.285*wind_squared(m,n,p));                          %Dependance of flux on windspeed 
                                                                                    %based off of Ho et al 2006(cm/y)
      
        K_WM99_660(m,n,p) = (1.09*wind(m,n,p) - (0.333*wind_squared(m,n,p)) + ...       %Dependance of flux on windspeed based off of 
                    (0.078*wind_cubed(m,n,p)));                                         %Wannikoff and MagGillis 1999 (cm/y)
                                                                                    
        Kbar_W92_660(m,n) = sum(K_W92_660(m,n,:),3)/12;
        Kbar_H06_lo_600(m,n) = sum(K_H06_lo_600(m,n,:),3)/12;
        Kbar_H06_hi_600(m,n) = sum(K_H06_hi_600(m,n,:),3)/12;
        Kbar_WM99_660(m,n) = sum(K_WM99_660(m,n,:),3)/12;
        
        end
    end
end


clear S m n p