%calculates the CO2-flux based off of the W92 squared dependance of flux on
%windspeed using QuicSCAT squared climatology winds


S = nan(length(lat),length(lon),length(time));
Area = nan(length(lat),length(lon),length(time));
K_W92av_cm_s = nan(length(lat),length(lon),length(time));
K_W92av = nan(length(lat),length(lon),length(time));
F_W92av = nan(length(lat),length(lon),length(time));
Flux_W92av = nan(length(lat),length(lon),length(time));
A = nan(length(lat),length(lon),length(time));
D = nan(length(lat),length(lon),length(time));
Fbar_W92av = nan(length(lat),length(lon));

my=111.11e3*4; %converts degree of latitdue into meters
mx=(111.11e3*cos(lat*pi/180))*5;  %converts degree of logitude into meters

a = -58.0931;  %use for (mol/l*atm)
b = 90.5069;
c = 22.2940;
d = 0.027766;
e = -0.025888;
f = 0.0050578;

for m = 1:length(lat)
    for n = 1:length(lon)
        for p = 1:length(time)
        
        S(m,n,p) = 2073.1 - 125.62*(sst(m,n,p)) + ...
                    3.6276*((sst(m,n,p))^2) - ...
                    0.043219*((sst(m,n,p)^3));  %Schmidt number based on a least squares fit to 
                                                         %temp (C) from Jahne et al 1987b
            
        A(m,n,p) = exp(a + (b * (100/(sst(m,n,p)+273.15))) + ...  %Solubility of CO2 in Sea water based off of Weiss 1974 (mol/l*atm)
                    (c * (log((sst(m,n,p)+273.15)/100))) + ...
                    (sal(m,n,p)*(d + (e * ((sst(m,n,p)+273.15)/100)) + ...
                    ((f * ((sst(m,n,p)+273.15)/100)^2)))));   
                
        D(m,n,p) = delta_pCO2(m,n,p)*(10^-6); %Delta pCO2 sea-air (atm)
        
        K_W92av_cm_s(m,n,p) = (0.39*wind_squared(m,n,p)*((S(m,n,p)/660)^-.5)); % Dependance of flux on average windspeed 
        
        K_W92av(m,n,p) = (0.39*wind_squared(m,n,p)*((S(m,n,p)/660)^-.5))*(24*365.25); % Dependance of flux on average windspeed 
                                                                            %based off of Wannikoff 1992(cm/y) 
        F_W92av(m,n,p) = K_W92av(m,n,p) * A(m,n,p) * D(m,n,p);
      
        Fbar_W92av(m,n) = sum(F_W92av(m,n,:),3); 
                       
        Area(m,n) = mx(m)*my;
        
        Flux_W92av(m,n,p) = F_W92av(m,n,p)*(12.011*Area(m,n));
        
        end
    end
end


i = find(~isnan(Flux_W92av(:)));
xW92av=Flux_W92av(i);
Flux_total_W92av = sum(xW92av(:))/10^15%flux in pgC/y or giga tons C/y

clear A D F F_H06 F_W92 Fbar Fbar_H06 F_W92 Fbar_taka Flux_H06 Flux_taka Flux_W92 K_H06 K_W92 S a b c d e f i xW92av Fbar_W92 m mDIM mx my n p


