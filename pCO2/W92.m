K_W92av_cm_s = nan(length(wind_squared(:,1,1)),length(wind_squared(1,:,1)),length(wind_squared(1,1,:)));

for m = 1:length(wind_squared(:,1,1))
    for n = 1:length(wind_squared(1,:,1))
        for p = 1:length(wind_squared(1,1,:))
            
            S(m,n,p) = 2073.1 - 125.62*(sst(m,n,p)) + ...
                    3.6276*((sst(m,n,p))^2) - ...
                    0.043219*((sst(m,n,p)^3));  %Schmidt number based on a least squares fit to 
                                                         %temp (C) from
                                                         %Jahne et al 1987b
                                                         
            K_W92av_cm_s(m,n,p) = (0.39*wind_squared(m,n,p)*((S(m,n,p)/660)^-.5)); % Dependance of flux on average windspeed 
            
        end
    end
end


